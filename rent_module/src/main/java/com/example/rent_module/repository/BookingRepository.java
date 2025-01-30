package com.example.rent_module.repository;

import com.example.rent_module.model.entity.BookingInfoEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDateTime;
import java.util.List;

public interface BookingRepository extends JpaRepository<BookingInfoEntity, Long> {

    @Query(value = "select b from BookingInfoEntity b where ((b.startDate between :startDate and :endDate) " +
            "or (b.endDate between :startDate and :endDate) " +
            "or (:startDate between b.startDate and b.endDate) " +
            "or (:endDate between b.startDate and b.endDate)) " +
            "and b.apartmentEntity.id = :id")
    List<BookingInfoEntity> findIntersectingBooking(LocalDateTime startDate, LocalDateTime endDate, Long id);
}
