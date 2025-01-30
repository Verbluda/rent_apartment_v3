package com.example.product_module.controller;

import com.example.product_module.model.TestObjectDto;
import com.example.product_module.model.dto.BookingInfoRequestDto;
import com.example.product_module.repository.TokenRepository;
import com.example.product_module.service.ProductService;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/product")
@RequiredArgsConstructor
@Tag(name = "Product_module", description = "Обработка акций")
public class ProductController {

    private final TokenRepository tokenRepository;

    private final ProductService productservice;

    @PostMapping("/choose_discount")
    public String chooseDiscount(@RequestBody BookingInfoRequestDto bookingInfo) {
//        tokenRepository.findToken(token).orElseThrow(() -> new RuntimeException("Неверный токен"));
        return productservice.chooseDiscount(bookingInfo);
    }

    @GetMapping("/test2")
    public String test2(@RequestParam String text,
                        @RequestHeader String token) {
        tokenRepository.findToken(token).orElseThrow(() -> new RuntimeException("Неверный токен"));
        return "Этот метод из product module c параметром " + text;
    }

    @PostMapping("/test3")
    public String test3(@RequestBody TestObjectDto testObjectDto,
                        @RequestHeader String token) {
        tokenRepository.findToken(token).orElseThrow(() -> new RuntimeException("Неверный токен"));
        return "Этот метод из product module " + testObjectDto.toString();
    }
}

