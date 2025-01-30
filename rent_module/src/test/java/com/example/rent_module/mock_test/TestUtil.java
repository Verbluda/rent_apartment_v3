package com.example.rent_module.mock_test;

import com.example.rent_module.model.dto.geo_coder.ComponentsObject;
import com.example.rent_module.model.dto.geo_coder.GeoCoderResponseDto;
import com.example.rent_module.model.dto.geo_coder.ResultsElem;

import java.util.ArrayList;
import java.util.List;

public class TestUtil {

    public static GeoCoderResponseDto getGeoCoderResultForTest() {
        ComponentsObject componentsObject = new ComponentsObject(null, "Воркута", null);
        ResultsElem resultsElem = new ResultsElem(componentsObject);
        List<ResultsElem> resultsElemList = new ArrayList<>();
        resultsElemList.add(resultsElem);
        return new GeoCoderResponseDto(resultsElemList);
    }
}
