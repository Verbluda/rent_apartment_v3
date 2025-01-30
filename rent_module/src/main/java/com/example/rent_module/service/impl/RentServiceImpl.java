package com.example.rent_module.service.impl;

import com.example.rent_module.exception.ApartmentException;
import com.example.rent_module.mapper.RentMapper;
import com.example.rent_module.model.dto.ApartmentRequestDto;
import com.example.rent_module.model.dto.ApartmentResponseDto;
import com.example.rent_module.model.dto.BookingInfoResponseToProductModuleDto;
import com.example.rent_module.model.dto.UserResponseDto;
import com.example.rent_module.model.dto.geo_coder.GeoCoderResponseDto;
import com.example.rent_module.model.dto.weather.WeatherResponseDto;
import com.example.rent_module.model.entity.*;
import com.example.rent_module.repository.AddressRepository;
import com.example.rent_module.repository.ApartmentRepository;
import com.example.rent_module.repository.BookingRepository;
import com.example.rent_module.service.IntegrationService;
import com.example.rent_module.service.RentService;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

import static java.util.Objects.isNull;

@Service
@RequiredArgsConstructor
public class RentServiceImpl implements RentService {

    private final AddressRepository addressRepository;
    private final ApartmentRepository apartmentRepository;

    private final BookingRepository bookingRepository;
    private final RentMapper rentMapper;
    private final IntegrationService integrationService;

    private Logger log = LoggerFactory.getLogger(RentServiceImpl.class);
    public static final String SUCCESSFUL_REGISTRATION_APARTMENT_MESSAGE = "Apartment is successfully registered";
    public static final String SUCCESSFUL_ADDING_PHOTO_MESSAGE = "Photo of apartment is successfully added";
    public static final String NOT_UNIQUE_APARTMENT_MESSAGE = "Apartment already exists";
    public static final String NOT_FOUND_APARTMENT_MESSAGE = "Apartment does not exists";

    @Override
    public String addApartment(ApartmentRequestDto apartRequest) {
        if (addressRepository.findByAddress(apartRequest.getCityValue(), apartRequest.getStreet(), apartRequest.getNumberOfHouse(), apartRequest.getNumberOfApartment()).isPresent()) {
            log.error("EXCEPTION: апартаменты уже существуют");
            throw new ApartmentException(NOT_UNIQUE_APARTMENT_MESSAGE, 700);
        }
        AddressEntity address = rentMapper.apartmentRequestDtoToAddressEntity(apartRequest);
        addressRepository.save(address);
        return SUCCESSFUL_REGISTRATION_APARTMENT_MESSAGE;
    }

    @Override
    public String addPhotoToApartment(Long id, MultipartFile multipartFile) {
        ApartmentEntity apartment = apartmentRepository.findById(id)
                .orElseThrow(() -> new ApartmentException(NOT_FOUND_APARTMENT_MESSAGE));
        try {
            apartment.setPhotoEntity(new PhotoEntity(Base64EncoderDecoder.encode(multipartFile)));
        } catch (IOException e) {
            log.error("EXCEPTION: не удалось добавить фото апартаментов");
            throw new ApartmentException("Проблема с сериализацией фотографии");
        }
        apartmentRepository.save(apartment);
        return SUCCESSFUL_ADDING_PHOTO_MESSAGE;
    }

    @Override
    public ApartmentResponseDto findApartmentById(Long id) {
        ApartmentEntity apartment = apartmentRepository.findById(id)
                .orElseThrow(() -> new ApartmentException(NOT_FOUND_APARTMENT_MESSAGE, 700));
        try {
            return rentMapper.apartmentEntityToApartmentResponseDto(apartment);
        } catch (IOException e) {
            log.error("EXCEPTION: не удалось выгрузить фото апартаментов");
            throw new ApartmentException("Проблема с сериализацией фотографии");
        }
    }

    @Override
    public List<ApartmentResponseDto> findApartmentByLocation(String latitude, String longitude) {
        try {
            log.info("RentServiceImpl.findApartmentByLocation -> GEO latitude {}, longitude {}", latitude, longitude);
            GeoCoderResponseDto apartmentByLocation = integrationService.findApartmentByLocation(latitude, longitude);
            log.info("RentServiceImpl.findApartmentByLocation <- GEO result GeoCoderResponseDto not null: {}", isNull(apartmentByLocation));
            List<AddressEntity> addressList = addressRepository.findByCity(checkGeoResponse(apartmentByLocation));
            if (addressList.isEmpty()) throw new RuntimeException();
            return addressList.stream()
                    .map(x -> {
                        try {
                            return rentMapper.apartmentEntityToApartmentResponseDto(x.getApartment());
                        } catch (IOException ex) {
                            log.error("EXCEPTION: проблема с обработкой фотографии");
                            throw new RuntimeException(ex);
                        }
                    })
                    .collect(Collectors.toList());
        } catch (Exception ex) {
            log.error("EXCEPTION: проблема с сервисом GEO");
            throw new RuntimeException(ex.getMessage());
        }
    }

    public String checkGeoResponse(GeoCoderResponseDto geoCoderResponseDto) {
        return geoCoderResponseDto.getResultsElemList().get(0).getComponentsObject().getNormalizedCity();
    }

    @Override
    public WeatherResponseDto findWeatherByLocation(String latitude, String longitude) {
        log.info("RentServiceImpl.findWeatherByLocation -> integrationService latitude {}, longitude {}", latitude, longitude);
        WeatherResponseDto weatherByLocation = integrationService.findWeatherByLocation(latitude, longitude);
        log.info("RentServiceImpl.findWeatherByLocation <- integrationService result WeatherResponseDto not null: {}", isNull(weatherByLocation));
        return weatherByLocation;
    }

    @Override
    public ApartmentResponseDto bookApartment(UserEntity user, Long id, LocalDateTime startDate, LocalDateTime endDate) {
        List<BookingInfoEntity> intersectingBooking = bookingRepository.findIntersectingBooking(startDate, endDate, id);
        if (!intersectingBooking.isEmpty()) {
            log.error("EXCEPTION: апартаменты недоступны для бронирования");
            throw new ApartmentException("Apartments are not available for booking");
        }

        ApartmentEntity apartment = apartmentRepository.findById(id).orElseThrow(() -> new ApartmentException("Apartments are not available for booking"));
        BookingInfoEntity bookingInfo = rentMapper.prepareBookingInfoEntityFromParams(startDate, endDate, apartment, user);
        bookingRepository.save(bookingInfo);

        try {
            ApartmentResponseDto apartmentResponseDto = rentMapper.apartmentEntityToApartmentResponseDto(apartment);
            apartmentResponseDto.setPhoto(null);
            apartmentResponseDto.setMessage("The apartment is booked from " + startDate.toLocalDate() + " to " + endDate.toLocalDate());

            UserResponseDto userResponseDto = rentMapper.userEntityToUserResponseDto(user);

            BookingInfoResponseToProductModuleDto response = rentMapper.createResponseToProductModuleDto(startDate, endDate, userResponseDto, apartmentResponseDto);
            //пока не заполняется стоимость, надо считать количество дней и умножать на цену за сутки, это афтермэппинг?
            log.info("RentServiceImpl.bookApartment -> integrationService BookingInfoResponseToProductModuleDto {}", response);
            String discountId = integrationService.findDiscountForBooking(response);
            log.info("RentServiceImpl.bookApartment <- integrationService result discountId as String not null: {}", isNull(discountId));
            System.out.println("вы получаете скидку: " + discountId);
            //заполнить полученную скидку, надо передавать в ответ?
            return apartmentResponseDto;
        } catch (IOException e) {
            log.error("EXCEPTION: системная ошибка");
            throw new RuntimeException("System error, try the operation again");
        }
        // в течение суток вышлем инфу
    }

//    private String parsInfoFromGeo(String locationInfo) {
//        ObjectMapper objectMapper = new ObjectMapper();
//        try {
//            JsonNode jsonNode = objectMapper.readTree(locationInfo);
//            String city = jsonNode.get("results").get(0).get("components").get("_normalized_city").asText();
//        } catch (JsonProcessingException e) {
//            throw new RuntimeException("Ошибка обработки запроса от GeoCoder");
//        }
//        return "";
//    }
}
