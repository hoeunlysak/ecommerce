package com.example.ecommerce.service;

import com.example.ecommerce.entity.CategoryEntity;
import com.example.ecommerce.repository.CategoryRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class CategoryService {
    private final CategoryRepository repository;

    public CategoryService(CategoryRepository repository) {
        this.repository = repository;
    }

    public List<CategoryEntity> findAll() {
        return repository.findAll();
    }

    public Optional<CategoryEntity> findById(Long id) {
        return repository.findById(id);
    }

    public CategoryEntity save(CategoryEntity entity) {
        return repository.save(entity);
    }

    public void deleteById(Long id) {
        repository.deleteById(id);
    }
}
