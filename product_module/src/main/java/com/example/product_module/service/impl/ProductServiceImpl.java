package com.example.product_module.service.impl;

import com.example.product_module.model.dto.BookingInfoRequestDto;
import com.example.product_module.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.TreeMap;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService {

    private final JdbcTemplate jdbcTemplate;

    public static final LocalDateTime startNewYear = LocalDateTime.of(LocalDateTime.now().getYear(), 12, 31, 0, 0);
    public static final LocalDateTime endNewYear = LocalDateTime.of(LocalDateTime.now().getYear() + 1, 1, 8, 23, 59);

    public static final LocalDateTime startEarlyNewYearBooking = LocalDateTime.of(LocalDateTime.now().getYear(), 1, 9, 0, 0);

    public static final LocalDateTime endEarlyNewYearBooking = LocalDateTime.of(LocalDateTime.now().getYear(), 6, 30, 23, 59);
    @Override
    public String chooseDiscount(BookingInfoRequestDto bookingInfo) {

        TreeMap<Integer, String> availableDiscountIds = new TreeMap<>();
        availableDiscountIds.put(0, "подходящих скидок не найдено");

        LocalDateTime startDate = bookingInfo.getStartDate();
        LocalDateTime endDate = bookingInfo.getEndDate();

        if (startDate.isAfter(startNewYear) && startDate.isBefore(endNewYear) && endDate.isBefore(endNewYear)
                && LocalDateTime.now().isAfter(startEarlyNewYearBooking) && LocalDateTime.now().isBefore(endEarlyNewYearBooking)) {
            String query = "SELECT amount_of_discount FROM product_info WHERE id = 'новогоднее очень раннее бронирование'";
            Integer discount = jdbcTemplate.queryForObject(query, Integer.class);
            availableDiscountIds.put(discount, "новогоднее очень раннее бронирование");
        }

        return availableDiscountIds.get(availableDiscountIds.lastKey());
    }
}
