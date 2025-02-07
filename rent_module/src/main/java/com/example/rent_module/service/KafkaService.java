package com.example.rent_module.service;

public interface KafkaService {

    void sendToTopic(String message);
}
