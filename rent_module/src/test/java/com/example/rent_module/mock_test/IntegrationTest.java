package com.example.rent_module.mock_test;

import com.example.rent_module.service.IntegrationService;
import com.example.rent_module.service.impl.RentServiceImpl;
import org.junit.runner.RunWith;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;

import static com.example.rent_module.controller.ControllerConstant.FIND_APARTMENT_BY_LOCATION;
import static org.mockito.ArgumentMatchers.anyString;

@SpringBootTest
@AutoConfigureMockMvc
@RunWith(SpringRunner.class)
//@Transactional
//@Testcontainers
public class IntegrationTest {

    public static final String LATITUDE = "latitude";
    public static final String LONGITUDE = "longitude";
    public static final String VALUE = "test_value";
    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private IntegrationService integrationService;

    @Autowired
    private RentServiceImpl rentServiceImpl;

    public void findApartmentByLocationTest() throws Exception {
        Mockito.when(integrationService.findApartmentByLocation(anyString(), anyString())).thenReturn(TestUtil.getGeoCoderResultForTest());
        mockMvc.perform(MockMvcRequestBuilders.get(FIND_APARTMENT_BY_LOCATION)
                .param(LATITUDE, VALUE)
                .param(LONGITUDE, VALUE)
                .characterEncoding("UTF-8")
//                .header("auth-token", TOKEN)
                .contentType(MediaType.APPLICATION_JSON))
                .andExpect(MockMvcResultMatchers.status().isOk());
    }

    public void checkGeoTest() {
        String s = rentServiceImpl.checkGeoResponse(TestUtil.getGeoCoderResultForTest());
    }
}
