package com.example.ecommerce.service;

import com.example.ecommerce.entity.OrderEntity;
import com.example.ecommerce.repository.OrderRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class OrderService {
    private final OrderRepository repository;

    public OrderService(OrderRepository repository) {
        this.repository = repository;
    }

    public List<OrderEntity> findAll() {
        return repository.findAll();
    }

    public Optional<OrderEntity> findById(Long id) {
        return repository.findById(id);
    }

    public OrderEntity save(OrderEntity entity) {
        return repository.save(entity);
    }

    public void deleteById(Long id) {
        repository.deleteById(id);
    }
}
