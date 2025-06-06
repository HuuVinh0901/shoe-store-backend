package com.shoestore.Server.service.impl;

import com.shoestore.Server.dto.request.PromotionDTO;
import com.shoestore.Server.dto.response.PaginationResponse;
import com.shoestore.Server.dto.response.PromotionResponse;
import com.shoestore.Server.entities.Category;
import com.shoestore.Server.entities.Promotion;
import com.shoestore.Server.entities.Product;
import com.shoestore.Server.enums.ApplicableTo;
import com.shoestore.Server.enums.PromotionStatus;
import com.shoestore.Server.enums.PromotionType;
import com.shoestore.Server.exception.NotFoundException;
import com.shoestore.Server.mapper.PromotionMapper;
import com.shoestore.Server.repositories.CategoryRepository;
import com.shoestore.Server.repositories.PromotionRepository;
import com.shoestore.Server.repositories.ProductRepository;
import com.shoestore.Server.service.PaginationService;
import com.shoestore.Server.service.PromotionService;
import com.shoestore.Server.specifications.PromotionSpecification;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class PromotionServiceImpl implements PromotionService {

    private final PromotionRepository promotionRepository;
    private final PromotionMapper promotionMapper;
    private final ProductRepository productRepository;
    private final PaginationService paginationService;
    private final CategoryRepository categoryRepository;

    @Override
    public double getDiscountedPrice(int productID) {
        log.info("Calculating discounted price for Product ID: {}", productID);
        Product product = productRepository.findById(productID)
                .orElseThrow(() -> new RuntimeException("Product not found"));
        if(product.getPromotion()==null){
            return product.getPrice();
        }
        Promotion promotion=promotionRepository.findById(product.getPromotion().getPromotionID())
                .orElseThrow(() -> new RuntimeException("Promotion not found"));;
        if (promotion.getStatus() != PromotionStatus.ACTIVE ||
                promotion.getStartDate().isAfter(LocalDateTime.now()) ||
                promotion.getEndDate().isBefore(LocalDateTime.now())) {
            log.info("Promotion is not currently active for Product ID: {}", productID);
            return product.getPrice();
        }
        double originalPrice = product.getPrice();
        double discountedPrice = originalPrice;
        switch (promotion.getType()) {
            case PERCENTAGE -> {
                if (promotion.getDiscountValue() != null) {
                    double discountPercent = promotion.getDiscountValue().doubleValue();
                    discountedPrice -= originalPrice * (discountPercent / 100.0);
                    log.info("Applied {}% discount. New price: {}", discountPercent, discountedPrice);
                }
            }
            case FIXED -> {
                if (promotion.getDiscountValue() != null) {
                    double discountAmount = promotion.getDiscountValue().doubleValue();
                    discountedPrice -= discountAmount;
                    log.info("Applied fixed discount: {}đ. New price: {}", discountAmount, discountedPrice);
                }
            }
            case BUYX,GIFT -> {
                log.info("BUY_X_GET_Y promotion applicable. Handled in cart/order logic.");
                return originalPrice;
            }
            default -> log.warn("Unknown promotion type for Product ID: {}", productID);
        }
        if (promotion.getMaxDiscount() != null) {
            double maxDiscount = promotion.getMaxDiscount().doubleValue();
            double actualDiscount = originalPrice - discountedPrice;
            if (actualDiscount > maxDiscount) {
                discountedPrice = originalPrice - maxDiscount;
                log.info("Max discount {}đ applied. Final price: {}", maxDiscount, discountedPrice);
            }
        }
        return Math.max(discountedPrice, 0.0);
    }

    @Override
    public PromotionResponse getPromotionByProductID(int id) {
        log.info("Fetching promotion for Product ID: {}", id);
        Optional<Promotion> promotionOpt = promotionRepository.findPromotionByProductId(id);
        if (promotionOpt.isPresent() && promotionOpt.get().getStatus().equals(PromotionStatus.ACTIVE)) {
            log.info("Promotion found for Product ID: {}", id);
            return promotionMapper.toResponse(promotionOpt.get());
        } else {
            log.warn("No promotion found for Product ID: {}", id);
            return null;
        }
    }

    @Override
    public PromotionResponse getPromotionById(int id) {
        Promotion promotion = promotionRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Promotion not found with ID: " + id));
        return promotionMapper.toResponse(promotion);
    }

    @Override
    public PaginationResponse<PromotionResponse> getAllPromotions(int page, int size) {
        Pageable pageable = paginationService.createPageable(page, size);
        Page<Promotion> promotionPage = promotionRepository.findAll(pageable);
        return paginationService.paginate(promotionPage.map(promotionMapper::toResponse));
    }

    @Override
    @Transactional
    public PromotionResponse createPromotion(PromotionDTO promotionDTO) {
        log.info("Creating promotion: {}", promotionDTO.getName());

        Promotion promotion = promotionMapper.toEntity(promotionDTO);

        if (promotionDTO.getCategoryIDs() != null && !promotionDTO.getCategoryIDs().isEmpty()) {
            List<Category> categories = new ArrayList<>();
            for (Integer id : promotionDTO.getCategoryIDs()) {
                if (id != null && id != 0) {
                    Category category = categoryRepository.findById(id)
                            .orElseThrow(() -> new NotFoundException("Category not found with ID: " + id));
                    categories.add(category);
                }
            }
            promotion.setCategories(categories);
        } else {
            promotion.setCategories(new ArrayList<>());
        }

        if (promotionDTO.getApplicableProductIDs() != null && !promotionDTO.getApplicableProductIDs().isEmpty()) {
            List<Product> products = new ArrayList<>();
            for (Integer id : promotionDTO.getApplicableProductIDs()) {
                if (id != null && id != 0) {
                    Product product = productRepository.findById(id)
                            .orElseThrow(() -> new NotFoundException("Product not found with ID: " + id));
                    products.add(product);
                }
            }
            promotion.setApplicableProducts(products);
        } else {
            promotion.setApplicableProducts(new ArrayList<>());
        }

        if (promotionDTO.getGiftProductID() != null && promotionDTO.getGiftProductID() != 0) {
            Product giftProduct = productRepository.findById(promotionDTO.getGiftProductID())
                    .orElseThrow(() -> new NotFoundException("Gift Product not found with ID: " + promotionDTO.getGiftProductID()));
            promotion.setGiftProduct(giftProduct);
        } else {
            promotion.setGiftProduct(null);
        }

        Promotion savedPromotion = promotionRepository.save(promotion);
        log.info("Promotion created successfully with ID: {}", savedPromotion.getPromotionID());

        return promotionMapper.toResponse(savedPromotion);
    }

    @Override
    @Transactional
    public PromotionResponse updatePromotion(int id, PromotionDTO promotionDTO) {
        Promotion promotion = promotionRepository.findById(id)
                .orElseThrow(() -> new NotFoundException("Promotion not found with ID: " + id));

        promotionMapper.updateEntityFromDto(promotionDTO, promotion);

        if (promotionDTO.getCategoryIDs() != null && !promotionDTO.getCategoryIDs().isEmpty()) {
            List<Category> categories = new ArrayList<>();
            for (Integer cid : promotionDTO.getCategoryIDs()) {
                if (cid != null && cid != 0) {
                    Category category = categoryRepository.findById(cid)
                            .orElseThrow(() -> new NotFoundException("Category not found with ID: " + cid));
                    categories.add(category);
                }
            }
            promotion.setCategories(categories);
        } else {
            promotion.setCategories(new ArrayList<>());
        }

        if (promotionDTO.getApplicableProductIDs() != null && !promotionDTO.getApplicableProductIDs().isEmpty()) {
            List<Product> products = new ArrayList<>();
            for (Integer pid : promotionDTO.getApplicableProductIDs()) {
                if (pid != null && pid != 0) {
                    Product product = productRepository.findById(pid)
                            .orElseThrow(() -> new NotFoundException("Product not found with ID: " + pid));
                    products.add(product);
                }
            }
            promotion.setApplicableProducts(products);
        } else {
            promotion.setApplicableProducts(new ArrayList<>());
        }

        if (promotionDTO.getGiftProductID() != null && promotionDTO.getGiftProductID() != 0) {
            Product giftProduct = productRepository.findById(promotionDTO.getGiftProductID())
                    .orElseThrow(() -> new NotFoundException("Gift Product not found with ID: " + promotionDTO.getGiftProductID()));
            promotion.setGiftProduct(giftProduct);
        } else {
            promotion.setGiftProduct(null);
        }

        Promotion updatedPromotion = promotionRepository.save(promotion);
        log.info("Promotion updated successfully with ID: {}", updatedPromotion.getPromotionID());

        return promotionMapper.toResponse(updatedPromotion);
    }


    @Override
    @Transactional
    public void deletePromotion(int id) {
        promotionRepository.deleteById(id);
    }

    @Override
    public PaginationResponse<PromotionResponse> searchPromotions(
            PromotionStatus status,
            PromotionType type,
            String name,
            LocalDateTime startDate,
            LocalDateTime endDate,
            int page,
            int pageSize
    ) {
        Specification<Promotion> spec = Specification.where(null);

        if (status != null) {
            spec = spec.and(PromotionSpecification.hasStatus(status));
        }

        if (type != null) {
            spec = spec.and(PromotionSpecification.hasType(type));
        }

        if (name != null && !name.trim().isEmpty()) {
            spec = spec.and(PromotionSpecification.hasName(name));
        }

        if (startDate != null && endDate != null) {
            spec = spec.and(PromotionSpecification.inDateRange(startDate, endDate));
        }

        Pageable pageable = PageRequest.of(page - 1, pageSize);
        Page<Promotion> pagedPromotions = promotionRepository.findAll(spec, pageable);

        List<PromotionResponse> promotionResponses = pagedPromotions.getContent().stream()
                .map(promotionMapper::toResponse)
                .collect(Collectors.toList());

        return new PaginationResponse<>(
                promotionResponses,
                pagedPromotions.getTotalElements(),
                pagedPromotions.getTotalPages(),
                pagedPromotions.getNumber() + 1,
                pagedPromotions.getSize()
        );
    }

    @Override
    public long countUpcomingPromotions() {
        return promotionRepository.countByStatus(PromotionStatus.UPCOMING);
    }

    @Override
    public long countActivePromotions() {
        return promotionRepository.countByStatus(PromotionStatus.ACTIVE);
    }

    private List<Promotion> fetchAppliedPromotions(int productId) {
        log.info("Fetching applied promotions for Product ID: {}", productId);
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new NotFoundException("Product not found with ID: " + productId));

        LocalDateTime now = LocalDateTime.now();
        List<Promotion> appliedPromotions = new ArrayList<>();

        List<Promotion> activePromotions = promotionRepository.findByStatusAndStartDateBeforeAndEndDateAfter(
                PromotionStatus.ACTIVE, now, now);

        for (Promotion promo : activePromotions) {
            if (promo.getApplicableTo() == ApplicableTo.ALL) {
                appliedPromotions.add(promo);
            } else if (promo.getApplicableTo() == ApplicableTo.CATEGORIES) {
                if (promo.getCategories().contains(product.getCategory())) {
                    appliedPromotions.add(promo);
                }
            } else if (promo.getApplicableTo() == ApplicableTo.PRODUCTS) {
                if (promo.getApplicableProducts().contains(product)) {
                    appliedPromotions.add(promo);
                }
            }
        }

        return appliedPromotions;
    }

    @Override
    public List<PromotionResponse> getAppliedPromotionsForProduct(int productId) {
        List<Promotion> appliedPromotions = fetchAppliedPromotions(productId);
        return appliedPromotions.stream()
                .map(promotionMapper::toResponse)
                .collect(Collectors.toList());
    }

    @Override
    public BigDecimal calculateFinalPriceWithPromotions(int productId) {
        log.info("Calculating final price with promotions for Product ID: {}", productId);

        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new NotFoundException("Product not found with ID: " + productId));

        List<Promotion> appliedPromotions = fetchAppliedPromotions(productId);

        BigDecimal originalPrice = BigDecimal.valueOf(product.getPrice());
        BigDecimal finalPrice = originalPrice;

        if (appliedPromotions.isEmpty()) {
            log.info("No active promotions found for Product ID: {}", productId);
            return finalPrice.setScale(2, RoundingMode.HALF_UP);
        }

        // Kiểm tra có promotion không cộng dồn không
        boolean hasNonStackable = appliedPromotions.stream()
                .anyMatch(promo -> promo.getStackable() == null || !promo.getStackable());

        if (hasNonStackable) {
            // Chỉ áp dụng promotion có số tiền giảm lớn nhất (tính trên originalPrice)
            final BigDecimal basePrice = originalPrice;
            Promotion bestPromotion = appliedPromotions.stream()
                    .filter(promo -> promo.getDiscountValue() != null)
                    .max(Comparator.comparing(promo -> calculateDiscountAmount(promo, basePrice)))
                    .orElse(null);

            if (bestPromotion != null) {
                BigDecimal discountAmount = calculateDiscountAmount(bestPromotion, basePrice);
                finalPrice = finalPrice.subtract(discountAmount);
                log.info("Applied best promotion (non-stackable): {} - Discount amount: {}, New price: {}",
                        bestPromotion.getName(), discountAmount, finalPrice);
            }
        } else {
            // Cộng dồn promotions, mỗi promotion áp dụng trên finalPrice hiện tại
            List<Promotion> sortedPromotions;
            {
                // Để dùng được biến trong lambda, cần final/effectively final biến này
                final BigDecimal priceForSort = finalPrice;
                sortedPromotions = appliedPromotions.stream()
                        .filter(promo -> promo.getDiscountValue() != null)
                        .sorted((p1, p2) -> calculateDiscountAmount(p2, priceForSort)
                                .compareTo(calculateDiscountAmount(p1, priceForSort)))
                        .collect(Collectors.toList());
            }

            for (Promotion promo : sortedPromotions) {
                BigDecimal discountAmount = calculateDiscountAmount(promo, finalPrice);
                finalPrice = finalPrice.subtract(discountAmount);
                log.info("Applied stackable promotion: {} - Discount amount: {}, New price: {}",
                        promo.getName(), discountAmount, finalPrice);

                // Nếu đã về 0 thì dừng luôn, không âm giá
                if (finalPrice.compareTo(BigDecimal.ZERO) <= 0) {
                    finalPrice = BigDecimal.ZERO;
                    break;
                }
            }
        }

        finalPrice = finalPrice.max(BigDecimal.ZERO).setScale(2, RoundingMode.HALF_UP);
        log.info("Final price after all promotions for Product ID {}: {}", productId, finalPrice);
        return finalPrice;
    }

    /**
     * Tính số tiền giảm thực tế cho từng promotion dựa vào loại (PERCENTAGE hoặc FIXED)
     */
    private BigDecimal calculateDiscountAmount(Promotion promo, BigDecimal currentPrice) {
        if (promo == null || promo.getDiscountValue() == null || currentPrice == null) {
            return BigDecimal.ZERO;
        }
        String type = promo.getType().name();
        BigDecimal discountValue = promo.getDiscountValue();

        if ("PERCENTAGE".equalsIgnoreCase(type)) {
            // Giới hạn tối đa 100%
            BigDecimal cappedPercent = discountValue.min(BigDecimal.valueOf(100));
            BigDecimal discountRate = cappedPercent.divide(BigDecimal.valueOf(100), 4, RoundingMode.HALF_UP);
            return currentPrice.multiply(discountRate).setScale(2, RoundingMode.HALF_UP);
        } else if ("FIXED".equalsIgnoreCase(type)) {
            // Không giảm quá giá hiện tại
            return discountValue.min(currentPrice).setScale(2, RoundingMode.HALF_UP);
        } else {
            return BigDecimal.ZERO;
        }
    }


    @Override
    public PromotionResponse getPromotionTypeByProductId(int productID) {
        log.info("Fetching promotion info for Product ID: {}", productID);

        Product product = productRepository.findById(productID)
                .orElseThrow(() -> new RuntimeException("Product not found"));
        Promotion promotion = product.getPromotion();
        if (promotion == null ||
                promotion.getStatus() != PromotionStatus.ACTIVE ||
                promotion.getStartDate().isAfter(LocalDateTime.now()) ||
                promotion.getEndDate().isBefore(LocalDateTime.now())) {
            return null;
        }
        return promotionMapper.toResponse(promotion);
    }
}
