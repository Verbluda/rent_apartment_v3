package com.example.product_module.service;

import com.example.product_module.model.dto.BookingInfoRequestDto;

public interface ProductService {

    String chooseDiscount(BookingInfoRequestDto bookingInfo);
}
