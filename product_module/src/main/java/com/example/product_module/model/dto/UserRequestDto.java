package com.example.product_module.model.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserRequestDto {

    private String userName;

    private String email;

    private String password;
}