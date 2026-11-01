package com.example.ecommerce.service;

import com.example.ecommerce.entity.CartItemEntity;
import com.example.ecommerce.repository.CartItemRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class CartItemService {
    private final CartItemRepository repository;

    public CartItemService(CartItemRepository repository) {
        this.repository = repository;
    }

    public List<CartItemEntity> findAll() {
        return repository.findAll();
    }

    public Optional<CartItemEntity> findById(Long id) {
        return repository.findById(id);
    }

    public CartItemEntity save(CartItemEntity entity) {
        return repository.save(entity);
    }

    public void deleteById(Long id) {
        repository.deleteById(id);
    }
}
