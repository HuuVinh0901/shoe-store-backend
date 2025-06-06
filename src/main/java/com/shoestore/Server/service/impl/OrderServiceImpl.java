package com.shoestore.Server.service.impl;

import com.shoestore.Server.dto.request.*;
import com.shoestore.Server.dto.response.*;
import com.shoestore.Server.entities.*;
import com.shoestore.Server.enums.OrderStatus;
import com.shoestore.Server.enums.PaymentMethod;
import com.shoestore.Server.exception.BadRequestException;
import com.shoestore.Server.exception.NotFoundException;
import com.shoestore.Server.mapper.OrderDetailMapper;
import com.shoestore.Server.mapper.OrderMapper;
import com.shoestore.Server.mapper.OrderStatusHistoryMapper;
import com.shoestore.Server.repositories.*;
import com.shoestore.Server.service.OrderDetailService;
import com.shoestore.Server.service.OrderService;
import com.shoestore.Server.service.PaginationService;
import com.shoestore.Server.service.PaymentService;
import com.shoestore.Server.specifications.OrderSpecification;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {
    private final OrderRepository orderRepository;
    private final OrderMapper orderMapper;
    private final VoucherRepository voucherRepository;
    private final UserRepository userRepository;
    private final PaginationService paginationService;
    private final OrderDetailService orderDetailService;
    private final PaymentService paymentService;
    private final OrderStatusHistoryRepository orderStatusHistoryRepository;
    private final OrderStatusHistoryMapper orderStatusHistoryMapper;
    private final ProductDetailRepository productDetailRepository;
    @Override
    public List<OrderDTO> getAllOrders() {
        log.info("Fetching all orders...");
        List<OrderDTO> orders = orderRepository.findAll()
                .stream()
                .map(orderMapper::toDto)
                .collect(Collectors.toList());
        log.info("Found {} orders", orders.size());
        return orders;
    }

    @Override
    public OrderDTO updateOrderStatus(int orderId, String status) {
        log.info("Updating status for Order ID: {} to {}", orderId, status);

        Optional<Order> optionalOrder = orderRepository.findById(orderId);
        if (optionalOrder.isEmpty()) {
            log.warn("Order with ID {} not found", orderId);
            throw new IllegalArgumentException("Không tìm thấy đơn hàng với ID: " + orderId);
        }

        Order order = optionalOrder.get();

        try {
            OrderStatus newStatus = OrderStatus.valueOf(status.toUpperCase());
            order.setStatus(newStatus);
        } catch (IllegalArgumentException e) {
            log.error("Invalid order status: {}", status);
            throw new IllegalArgumentException("Trạng thái đơn hàng không hợp lệ: " + status);
        }

        orderRepository.save(order);
        log.info("Updated Order ID {} status to {}", orderId, status);

        return orderMapper.toDto(order);
    }


    @Override
    public OrderDTO getOrderById(int orderId) {
        log.info("Fetching order by ID: {}", orderId);
        return orderRepository.findById(orderId)
                .map(orderMapper::toDto)
                .orElseGet(() -> {
                    log.warn("Order with ID {} not found", orderId);
                    return null;
                });
    }

    @Override
    public OrderDTO addOrder(OrderDTO orderDTO) {
        log.info("Adding new order for User ID: {}", orderDTO.getUser().getUserID());
        Order order = orderMapper.toEntity(orderDTO);

        if (orderDTO.getVoucher() != null) {
            log.info("Applying Voucher ID: {}", orderDTO.getVoucher().getVoucherID());
            Voucher voucher = voucherRepository.findById(orderDTO.getVoucher().getVoucherID())
                    .orElseThrow(() -> {
                        log.error("Voucher not found with ID: {}", orderDTO.getVoucher().getVoucherID());
                        return new IllegalArgumentException("Voucher not found");
                    });
            order.setVoucher(voucher);
        }

        User user = userRepository.findById(orderDTO.getUser().getUserID())
                .orElseThrow(() -> {
                    log.error("User not found with ID: {}", orderDTO.getUser().getUserID());
                    return new IllegalArgumentException("User not found");
                });

        order.setUser(user);
        Order savedOrder = orderRepository.save(order);
        log.info("Order added successfully with ID: {}", savedOrder.getOrderID());

        return orderMapper.toDto(savedOrder);
    }

    @Override
    public List<PlacedOrderResponse> getOrderByByUser(int userId) {
        log.info("Fetching orders for User ID: {}", userId);

        return orderRepository.findByUser_UserID(userId)
                .stream()
                .map(order -> {
                    int orderId = order.getOrderID();
                    List<PlacedOrderDetailsResponse> orderDetails = order.getOrderDetails()
                            .stream()
                            .map(orderDetailService::mapToPlacedOrderDetailsResponse)
                            .collect(Collectors.toList());
                    OrderResponse orderResponse = orderMapper.toResponse(order);

                    List<OrderStatusHistoryResponse> canceledHistory = orderStatusHistoryMapper.toListResponse(
                            orderStatusHistoryRepository.findByOrder_OrderIDAndStatus(orderId, OrderStatus.CANCELED)
                    );
                    orderResponse.setStatusHistory(canceledHistory.isEmpty() ? null : canceledHistory);

                    return new PlacedOrderResponse(
                            orderResponse,
                            orderDetails,
                            paymentService.getPaymentByOrderId(orderId)
                    );
                })
                .collect(Collectors.toList());
    }


    @Override
    public OrderDTO getOrderByCode(String code) {
        log.info("Fetching order by code: {}", code);
        Order order = orderRepository.findByCode(code);
        if (order != null) {
            log.info("Order found with code: {}", code);
        } else {
            log.warn("No order found with code: {}", code);
        }
        return order != null ? orderMapper.toDto(order) : null;
    }

    @Override
    public int getOrderQuantityByUserId(int id) {
        log.info("Counting orders for User ID: {}", id);
        int count = orderRepository.countOrdersByUserId(id);
        log.info("User ID {} has {} orders", id, count);
        return count;
    }

    @Override
    public Double getTotalAmountByUserId(int id) {
        log.info("Calculating total order amount for User ID: {}", id);
        Double total = orderRepository.sumTotalAmountByUserId(id);
        log.info("Total order amount for User ID {}: {}", id, total != null ? total : 0.0);
        return total != null ? total : 0.0;
    }

    @Override
    public long getTotalOrdersByDay() {
        LocalDate today = LocalDate.now();
        return orderRepository.countByOrderDate(today);
    }

    @Override
    public long getTotalOrdersByMonth() {
        LocalDate today = LocalDate.now();
        return orderRepository.countByMonthAndYear(today.getMonthValue(), today.getYear());
    }

    @Override
    public long getTotalOrdersByYear() {
        LocalDate today = LocalDate.now();
        return orderRepository.countByYear(today.getYear());
    }

    @Override
    public long getTotalOrders() {
        return orderRepository.count();
    }

    @Override
    public Double getTotalOrderAmount() {
        return orderRepository.sumTotalOrderAmount();
    }

    @Override
    public Double getTotalOrderAmountByDay() {
        LocalDate today = LocalDate.now();
        return orderRepository.sumTotalOrderAmountByDay(today);
    }

    @Override
    public Double getTotalOrderAmountByMonth() {
        LocalDate today = LocalDate.now();
        int month = today.getMonthValue();
        int year = today.getYear();
        return orderRepository.sumTotalOrderAmountByMonth(month, year);
    }

    @Override
    public Double getTotalOrderAmountByYear() {
        int year = LocalDate.now().getYear();
        return orderRepository.sumTotalOrderAmountByYear(year);
    }

    @Override
    public long getCompletedOrders() {
        return orderRepository.countCompletedOrders();
    }

    @Override
    public long getCompletedOrdersByDay() {
        LocalDate today = LocalDate.now();
        return orderRepository.countCompletedOrdersByDay(today);
    }

    @Override
    public long getCompletedOrdersByMonth() {
        LocalDate today = LocalDate.now();
        int month = today.getMonthValue();
        int year = today.getYear();
        return orderRepository.countCompletedOrdersByMonth(month, year);
    }

    @Override
    public long getCompletedOrdersByYear() {
        int year = LocalDate.now().getYear();
        return orderRepository.countCompletedOrdersByYear(year);
    }

    @Override
    public long getCanceledOrders() {
        return orderRepository.countCanceledOrders();
    }

    @Override
    public long getCanceledOrdersByDay() {
        LocalDate today = LocalDate.now();
        return orderRepository.countCanceledOrdersByDay(today);
    }

    @Override
    public long getCanceledOrdersByMonth() {
        LocalDate today = LocalDate.now();
        int month = today.getMonthValue();
        int year = today.getYear();
        return orderRepository.countCanceledOrdersByMonth(month, year);
    }

    @Override
    public long getCanceledOrdersByYear() {
        int year = LocalDate.now().getYear();
        return orderRepository.countCanceledOrdersByYear(year);
    }
    @Override
    public List<OrderDTO> searchOrders(String query) {
        List<Order> orders = orderRepository.searchOrders(query);
        return orders.stream()
                .map(orderMapper::toDto)
                .collect(Collectors.toList());
    }

    @Override
    public PaginationResponse<OrderDTO> getAllOrdersSorted(String sort, int page, int pageSize) {
        Sort sorting;
        if (sort == null) {
            sorting = Sort.unsorted();
        } else {
            switch (sort) {
                case "newest":
                    sorting = Sort.by(Sort.Direction.DESC, "orderDate");
                    break;
                case "oldest":
                    sorting = Sort.by(Sort.Direction.ASC, "orderDate");
                    break;
                case "highestTotal":
                    sorting = Sort.by(Sort.Direction.DESC, "total");
                    break;
                case "lowestTotal":
                    sorting = Sort.by(Sort.Direction.ASC, "total");
                    break;
                default:
                    sorting = Sort.unsorted();
                    break;
            }
        }
        Pageable pageable = paginationService.createPageable(page, pageSize);
        pageable = PageRequest.of(page - 1, pageSize, sorting);
        Page<Order> orderPage = orderRepository.findAll(pageable);
        Page<OrderDTO> orderDtoPage = orderPage.map(orderMapper::toDto);
        return paginationService.paginate(orderDtoPage);
    }

    @Override
    public PaginationResponse<OrderDTO> getAllOrdersPaged(int page, int pageSize) {
        Pageable pageable = paginationService.createPageable(page, pageSize);
        Page<Order> orderPage = orderRepository.findAll(pageable);
        Page<OrderDTO> orderDtoPage = orderPage.map(orderMapper::toDto);
        return paginationService.paginate(orderDtoPage);
    }

    @Override
    public PaginationResponse<OrderDTO> getOrdersByDay(int page, int pageSize) {
        LocalDate today = LocalDate.now();
        Pageable pageable = paginationService.createPageable(page, pageSize);
        Page<Order> orderPage = orderRepository.findByOrderDate(today, pageable);
        Page<OrderDTO> dtoPage = orderPage.map(orderMapper::toDto);
        return paginationService.paginate(dtoPage);
    }

    @Override
    public PaginationResponse<OrderDTO> getOrdersByMonth(int page, int pageSize) {
        LocalDate today = LocalDate.now();
        int month = today.getMonthValue();
        int year = today.getYear();
        Pageable pageable = paginationService.createPageable(page, pageSize);
        Page<Order> orderPage = orderRepository.findByMonthAndYear(month, year, pageable);
        Page<OrderDTO> dtoPage = orderPage.map(orderMapper::toDto);
        return paginationService.paginate(dtoPage);
    }

    @Override
    public PaginationResponse<OrderDTO> getOrdersByYear(int page, int pageSize) {
        int year = LocalDate.now().getYear();
        Pageable pageable = paginationService.createPageable(page, pageSize);
        Page<Order> orderPage = orderRepository.findByYear(year, pageable);
        Page<OrderDTO> dtoPage = orderPage.map(orderMapper::toDto);
        return paginationService.paginate(dtoPage);
    }

    @Override
    public long countOrdersWithPromotions() {
        return orderRepository.countOrdersWithPromotions();
    }

    @Override
    public BigDecimal getRevenueFromPromotions() {
        BigDecimal revenue = orderRepository.getRevenueFromPromotions();
        return revenue != null ? revenue : BigDecimal.ZERO;
    }

    @Override
    public PaginationResponse<OrderResponse> filterOrders(
            String status, String query, LocalDate from, LocalDate to,
            int page, int pageSize, String sort, String mode) {

        LocalDate today = LocalDate.now();
        LocalDate startDate = from;
        LocalDate endDate = to;

        if (mode != null) {
            switch (mode) {
                case "day":
                    startDate = today;
                    endDate = today;
                    break;
                case "month":
                    startDate = today.withDayOfMonth(1);
                    endDate = today;
                    break;
                case "year":
                    startDate = today.withDayOfYear(1);
                    endDate = today;
                    break;
                case "all":
                default:
                    startDate = null;
                    endDate = null;
                    break;
            }
        }

        Sort sorting = switch (sort) {
            case "newest" -> Sort.by(Sort.Direction.DESC, "orderDate");
            case "oldest" -> Sort.by(Sort.Direction.ASC, "orderDate");
            case "highestTotal" -> Sort.by(Sort.Direction.DESC, "total");
            case "lowestTotal" -> Sort.by(Sort.Direction.ASC, "total");
            default -> Sort.by(Sort.Direction.DESC, "orderDate");
        };

        Pageable pageable = PageRequest.of(page - 1, pageSize, sorting);

        Specification<Order> spec = Specification
                .where(OrderSpecification.hasStatus(status))
                .and(OrderSpecification.hasKeyword(query))
                .and(OrderSpecification.hasDateFrom(startDate))
                .and(OrderSpecification.hasDateTo(endDate));

        Page<Order> orders;
        if ("all".equals(mode)) {
            orders = orderRepository.findAll(spec, pageable);
        } else {
            orders = orderRepository.findAll(spec, pageable);
        }

        return paginationService.paginate(orders.map(orderMapper::toResponse));
    }

    @Override
    public OrderStatusHistoryResponse updateOrderStatus(int id, UpdateOrderStatusRequest request) {
        Order order = orderRepository.findById(id)
                .orElseThrow(() -> new NotFoundException("Order not found with id: " + id));

        OrderStatus newStatus;
        try {
            newStatus = OrderStatus.valueOf(request.getStatus());
        } catch (IllegalArgumentException ex) {
            throw new BadRequestException("Invalid order status: " + request.getStatus());
        }
        if (!isValidTransition(order.getStatus(), newStatus)) {
            throw new BadRequestException(
                    "Cannot transition status from " + order.getStatus() + " to " + newStatus);
        }

        User user = userRepository.findById(request.getUserId())
                .orElseThrow(() -> new NotFoundException("User not found with id: " + request.getUserId()));

        order.setStatus(newStatus);
        orderRepository.save(order);

        OrderStatusHistory hist = new OrderStatusHistory();
        hist.setOrder(order);
        hist.setStatus(newStatus);
        hist.setChangedBy(user);

        if (newStatus == OrderStatus.SHIPPED) {
            hist.setTrackingNumber(request.getTrackingNumber());
        } else if (newStatus == OrderStatus.CANCELED) {
            hist.setCancelReason(request.getCancelReason());
        } else if (newStatus == OrderStatus.DELIVERED) {
            hist.setDeliveredAt(LocalDateTime.now());
        }

        hist = orderStatusHistoryRepository.save(hist);

        return OrderStatusHistoryResponse.builder()
                .orderID(order.getOrderID())
                .status(hist.getStatus().name())
                .changedAt(hist.getCreatedAt())
                .trackingNumber(hist.getTrackingNumber())
                .cancelReason(hist.getCancelReason())
                .changedById(user.getUserID())
                .changedByName(user.getName())
                .build();
    }



    private boolean isValidTransition(OrderStatus current, OrderStatus next) {
        return switch (current) {
            case PENDING -> next == OrderStatus.CONFIRMED || next == OrderStatus.CANCELED;
            case CONFIRMED -> next == OrderStatus.PROCESSING || next == OrderStatus.CANCELED;
            case PROCESSING -> next == OrderStatus.SHIPPED || next == OrderStatus.CANCELED;
            case SHIPPED -> next == OrderStatus.DELIVERED;
            case DELIVERED, CANCELED -> false;
        };
    }

    @Override
    public List<OrderStatusHistoryResponse> getOrderHistory(int orderID) {
        return orderStatusHistoryRepository
                .findByOrderOrderIDOrderByCreatedAtAsc(orderID)
                .stream()
                .map(hist -> {
                    User changedBy = hist.getChangedBy();  // lấy user từ history
                    return OrderStatusHistoryResponse.builder()
                            .status(hist.getStatus().name())
                            .changedAt(hist.getCreatedAt())
                            .trackingNumber(hist.getTrackingNumber())
                            .cancelReason(hist.getCancelReason())
                            .changedById(changedBy != null ? changedBy.getUserID() : 0)
                            .changedByName(changedBy != null ? changedBy.getName() : null)
                            .build();
                })
                .collect(Collectors.toList());
    }

    @Override
    public OrderStatusHistoryResponse create(OrderHistoryStatusDTO orderHistoryStatusDTO) {
        Order order = orderRepository.findById(orderHistoryStatusDTO.getOrder().getOrderID())
                .orElseThrow(() -> new NotFoundException("Order not found with id: " + orderHistoryStatusDTO.getOrder().getOrderID()));
        User user = userRepository.findById(orderHistoryStatusDTO.getChangedBy().getUserID())
                .orElseThrow(() -> new NotFoundException("User not found with id: " + orderHistoryStatusDTO.getChangedBy().getUserID()));
        orderHistoryStatusDTO.setOrder(order);
        orderHistoryStatusDTO.setChangedBy(user);
        OrderStatusHistory hist=orderStatusHistoryRepository.save(orderStatusHistoryMapper.toEntity(orderHistoryStatusDTO));
        return OrderStatusHistoryResponse.builder()
                .orderID(hist.getOrder().getOrderID())
                .status(hist.getStatus().name())
                .changedAt(hist.getCreatedAt())
                .trackingNumber(hist.getTrackingNumber())
                .cancelReason(hist.getCancelReason())
                .changedById(hist.getChangedBy().getUserID())
                .changedByName(hist.getChangedBy().getName())
                .build();

    }
    @Transactional
    public void cancelUnpaidVNPayOrders() {
        LocalDateTime now = LocalDateTime.now();
        List<Order> expiredOrders = orderRepository.findByPaymentMethodAndStatusAndOrderDateBefore(
                PaymentMethod.VNPAY,
                OrderStatus.PENDING,
                LocalDate.now()
        );

        for (Order order : expiredOrders) {
            if (order.getOrderDate().atStartOfDay().plusHours(12).isBefore(now)) {
                order.setStatus(OrderStatus.CANCELED);

                OrderStatusHistory history = new OrderStatusHistory();
                history.setOrder(order);
                history.setStatus(OrderStatus.CANCELED);
                history.setCancelReason("Automatically cancel due to overdue VNPay payment");
                history.setDeliveredAt(now);
                history.setChangedBy(null);

                if (order.getStatusHistory() == null) {
                    order.setStatusHistory(new ArrayList<>());
                }
                order.getStatusHistory().add(history);

                orderRepository.save(order);
            }
        }
    }
    @Override
    public Order updateOrderUser(int id, UserDTO userDTO) {
        Order order = orderRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Order not found"));

        if (userDTO != null && userDTO.getUserID() != 0) {
            User user = userRepository.findById(userDTO.getUserID())
                    .orElseThrow(() -> new RuntimeException("User not found"));

            if (userDTO.getName() != null) user.setName(userDTO.getName());
            if (userDTO.getEmail() != null) user.setEmail(userDTO.getEmail());
            if (userDTO.getPhoneNumber() != null) user.setPhoneNumber(userDTO.getPhoneNumber());

            userRepository.save(user);
            order.setUser(user);
        } else {
            order.setUser(null);
        }

        return orderRepository.save(order);
    }

    @Override
    public Order updateOrderShipping(int id, ShippingDTO shippingDTO) {
        Order order = orderRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Order not found"));

        if (shippingDTO != null) {
            order.setShippingAddress(shippingDTO.getShippingAddress());
            order.setShippingMethod(shippingDTO.getShippingMethod());
            order.setTrackingNumber(shippingDTO.getTrackingNumber());
        }

        return orderRepository.save(order);
    }

    @Override
    @Transactional
    public void cancelOrders(OrderCancelRequest orderCancelRequest) {
        Order order = orderRepository.findById(orderCancelRequest.getOrderId())
                .orElseThrow(() -> new NotFoundException("Order not found with id: " + orderCancelRequest.getOrderId()));

        if (!order.getStatus().equals(OrderStatus.PENDING)) {
            log.error("Cannot cancel order ID {} with current status: {}", orderCancelRequest.getOrderId(), order.getStatus());
            throw new BadRequestException("Cannot cancel order with status: " + order.getStatus());
        }

        List<OrderDetail> orderDetails = order.getOrderDetails();
        if (orderDetails == null || orderDetails.isEmpty()) {
            log.warn("No order details found for order ID: {}", orderCancelRequest.getOrderId());
            throw new BadRequestException("No order details found for order ID: " + orderCancelRequest.getOrderId());
        }

        for (OrderDetail detail : orderDetails) {
            ProductDetail productDetail = detail.getProductDetail();
            if (productDetail == null) {
                log.error("ProductDetail is null for OrderDetail ID: {}", detail.getOrderDetailID());
                throw new BadRequestException("ProductDetail not found for OrderDetail ID: " + detail.getOrderDetailID());
            }
            int newStockQuantity = productDetail.getStockQuantity() + detail.getQuantity();
            if (newStockQuantity < 0) {
                log.error("Invalid stock quantity for productDetail ID: {}", productDetail.getProductDetailID());
                throw new BadRequestException("Invalid stock quantity for productDetail ID: " + productDetail.getProductDetailID());
            }
            productDetail.setStockQuantity(newStockQuantity);
            productDetailRepository.save(productDetail);
            log.info("Updated stock quantity for productDetail ID: {} to {}", productDetail.getProductDetailID(), newStockQuantity);

            ProductDetail giftProductDetail = detail.getGiftProductDetail();
            if (giftProductDetail != null && detail.getGiftedQuantity() > 0) {
                int newGiftStockQuantity = giftProductDetail.getStockQuantity() + detail.getGiftedQuantity();
                if (newGiftStockQuantity < 0) {
                    log.error("Invalid stock quantity for giftProductDetail ID: {}", giftProductDetail.getProductDetailID());
                    throw new BadRequestException("Invalid stock quantity for giftProductDetail ID: " + giftProductDetail.getProductDetailID());
                }
                giftProductDetail.setStockQuantity(newGiftStockQuantity);
                productDetailRepository.save(giftProductDetail);
                log.info("Updated stock quantity for giftProductDetail ID: {} to {}", giftProductDetail.getProductDetailID(), newGiftStockQuantity);
            }
        }

        User user = userRepository.findById(orderCancelRequest.getUserId())
                .orElseThrow(() -> new NotFoundException("User not found with id: " + orderCancelRequest.getUserId()));

        order.setStatus(OrderStatus.CANCELED);

        OrderStatusHistory history = new OrderStatusHistory();
        history.setOrder(order);
        history.setStatus(OrderStatus.CANCELED);
        history.setCancelReason(orderCancelRequest.getReason());
        history.setCreatedAt(LocalDateTime.now());
        history.setChangedBy(user);

        if (order.getStatusHistory() == null) {
            order.setStatusHistory(new ArrayList<>());
        }
        order.getStatusHistory().add(history);

        orderRepository.save(order);
        log.info("Order ID {} canceled successfully by user ID: {}", orderCancelRequest.getOrderId(), orderCancelRequest.getUserId());
    }

}
