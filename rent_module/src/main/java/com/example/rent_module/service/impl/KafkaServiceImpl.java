package com.example.rent_module.service.impl;

import com.example.rent_module.config.TopicsList;
import com.example.rent_module.service.KafkaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

@Service
public class KafkaServiceImpl implements KafkaService {

    @Autowired
    private KafkaTemplate<String, String> kafkaTemplate;

    @Override
    public void sendToTopic(String message) {
        kafkaTemplate.send(TopicsList.PRODUCT_TOPIC.getTopicName(), "message");
    }
}
