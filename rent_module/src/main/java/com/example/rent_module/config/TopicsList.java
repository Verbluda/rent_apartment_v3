package com.example.rent_module.config;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum TopicsList {

    PRODUCT_TOPIC ("productTopic"),
    TEST_TOPIC ("testTopic");

    private String topicName;
}
