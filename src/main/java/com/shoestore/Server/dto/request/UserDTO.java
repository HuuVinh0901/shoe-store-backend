package com.shoestore.Server.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Data;

import java.util.Set;

@Data
public class UserDTO {
    private int userID;
    @NotBlank(message = "Tên không được để trống")
    @Size(max = 50, message = "Tên không được vượt quá 100 ký tự")
    private String name;

    @NotBlank(message = "Email không được để trống")
    @Email(message = "Email không hợp lệ")
    private String email;
    @NotBlank(message = "Password không được để trống")
    private String password;

    @NotBlank(message = "Số điện thoại không được để trống")
    @Pattern(regexp = "^\\d{10,15}$", message = "Số điện thoại phải có từ 10 đến 15 chữ số")
    private String phoneNumber;

    @NotBlank(message = "Trạng thái không được để trống")
    private String status;

    @NotBlank(message = "CI không được để trống")
    private String CI;

    @NotNull(message = "Vai trò không được để trống")
    private Set<RoleDTO> roles;

    private String refreshToken;
}
