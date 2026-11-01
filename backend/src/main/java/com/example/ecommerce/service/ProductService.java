package com.example.ecommerce.service;

import com.example.ecommerce.entity.ProductEntity;
import com.example.ecommerce.repository.ProductRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class ProductService {
    private final ProductRepository repository;

    public ProductService(ProductRepository repository) {
        this.repository = repository;
    }

    public List<ProductEntity> findAll() {
        return repository.findAll();
    }

    public Optional<ProductEntity> findById(Long id) {
        return repository.findById(id);
    }

    public ProductEntity save(ProductEntity entity) {
        return repository.save(entity);
    }

    public void deleteById(Long id) {
        repository.deleteById(id);
    }
}
