package com.example.product_module.model.dto;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class ApartmentRequestDto {

    private String message;
    private int numberOfRoom;
    private boolean isAvailable;
    private double pricePerDay;
    private String cityValue;
    private String street;
    private String numberOfHouse;
    private String numberOfApartment;
    private byte[] photo;
}
