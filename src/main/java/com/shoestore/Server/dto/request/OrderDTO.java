package com.shoestore.Server.dto.request;

import com.shoestore.Server.enums.PaymentMethod;
import jakarta.validation.constraints.*;
import lombok.Data;

import java.time.LocalDate;

@Data
public class OrderDTO {
    private int orderID;

//    @PastOrPresent(message = "Order date cannot be in the future")
    private LocalDate orderDate;

    @NotBlank(message = "Status cannot be blank")
    private String status;

    @NotNull(message = "Total amount cannot be null")
    @PositiveOrZero(message = "Total amount cannot be negative")
    private double total;

    @NotNull(message = "Shipping fee cannot be null")
    @PositiveOrZero(message = "Shipping fee cannot be negative")
    private double feeShip;

    @NotBlank(message = "Order code cannot be blank")
    private String code;

    @NotBlank(message = "Shipping address cannot be blank")
    private String shippingAddress;

    private String shippingMethod;

    private String trackingNumber;

    @NotNull(message = "Payment method cannot be null")
    private PaymentMethod paymentMethod;

    @NotNull(message = "Discount cannot be null")
    @PositiveOrZero(message = "Discount cannot be negative")
    private double voucherDiscount;

    private VoucherDTO voucher;

    private UserDTO user;
}
