package com.shoestore.Server.service.impl;

import com.shoestore.Server.dto.request.VoucherDTO;
import com.shoestore.Server.entities.User;
import com.shoestore.Server.entities.Voucher;
import com.shoestore.Server.mapper.VoucherMapper;
import com.shoestore.Server.repositories.UserRepository;
import com.shoestore.Server.repositories.VoucherRepository;
import com.shoestore.Server.service.VoucherService;
import jakarta.persistence.EntityNotFoundException;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@AllArgsConstructor
public class VoucherServiceImpl implements VoucherService {

    private final VoucherRepository voucherRepository;
    private final VoucherMapper voucherMapper;
    private final UserRepository userRepository;

    @Override
    public List<VoucherDTO> getAllVouchers() {
        log.info("Fetching all vouchers from database.");
        List<VoucherDTO> vouchers = voucherRepository.findAll().stream()
                .map(voucherMapper::toDto)
                .collect(Collectors.toList());
        log.info("Found {} vouchers.", vouchers.size());
        return vouchers;
    }

    @Override
    public VoucherDTO getVoucherById(int id) {
        log.info("Fetching voucher with ID: {}", id);
        return voucherRepository.findById(id)
                .map(voucherMapper::toDto)
                .orElseGet(() -> {
                    log.warn("Voucher not found with ID: {}", id);
                    return null;
                });
    }

    @Override
    public void deleteVoucher(int voucherID) {
        log.info("Deleting voucher with ID: {}", voucherID);
        if (voucherRepository.existsById(voucherID)) {
            voucherRepository.deleteById(voucherID);
            log.info("Successfully deleted voucher with ID: {}", voucherID);
        } else {
            log.warn("Cannot delete: Voucher ID {} not found.", voucherID);
        }
    }

    @Override
    public List<VoucherDTO> getEligibleVouchers(int userId, BigDecimal orderValue) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new EntityNotFoundException("User not found with id: " + userId));
        log.info("Fetching eligible vouchers for order value: {}", orderValue);
        List<VoucherDTO> eligibleVouchers = voucherRepository.findByMinOrderValueLessThanEqualAndStatusTrueAndStartDateBeforeAndEndDateAfterAndCustomerGroup(
                        orderValue, LocalDateTime.now(), LocalDateTime.now(),user.getCustomerGroup())
                .stream()
                .map(voucherMapper::toDto)
                .collect(Collectors.toList());
        log.info("Found {} eligible vouchers for order value: {}", eligibleVouchers.size(), orderValue);
        return eligibleVouchers;
    }

    @Override
    public List<VoucherDTO> createVouchers(List<VoucherDTO> voucherDTOList) {
        List<Voucher> vouchers = voucherDTOList.stream()
                .map(voucherMapper::toEntity)
                .collect(Collectors.toList());
        // Validate trùng code nếu muốn
        List<Voucher> saved = voucherRepository.saveAll(vouchers);
        return saved.stream()
                .map(voucherMapper::toDto)
                .collect(Collectors.toList());
    }

}
