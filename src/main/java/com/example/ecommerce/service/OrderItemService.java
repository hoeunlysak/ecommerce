package com.example.ecommerce.service;

import com.example.ecommerce.entity.OrderItemEntity;
import com.example.ecommerce.repository.OrderItemRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class OrderItemService {
    private final OrderItemRepository repository;

    public OrderItemService(OrderItemRepository repository) {
        this.repository = repository;
    }

    public List<OrderItemEntity> findAll() {
        return repository.findAll();
    }

    public Optional<OrderItemEntity> findById(Long id) {
        return repository.findById(id);
    }

    public OrderItemEntity save(OrderItemEntity entity) {
        return repository.save(entity);
    }

    public void deleteById(Long id) {
        repository.deleteById(id);
    }
}
