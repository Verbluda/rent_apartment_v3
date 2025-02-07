//package com.example.rent_module.service.impl;
//
//import com.example.rent_module.service.KafkaService;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.kafka.core.KafkaTemplate;
//import org.springframework.stereotype.Service;
//
//@Service
//public class KafkaProducerImpl implements KafkaService {
//
//    @Autowired
//    private KafkaTemplate<String, String> template;
//    @Override
//    public void sendToTopic(String message) {
//        template.send("myTopic", message);
//    }
//}
