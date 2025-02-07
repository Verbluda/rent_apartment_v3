package com.example.rent_module.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDateTime;

@Getter
@Setter
@ToString
public class BookingInfoResponseToProductModuleDto {

    private LocalDateTime startDate;

    private LocalDateTime endDate;

    private ApartmentResponseDto apartment;
    private UserResponseDto user;


}
