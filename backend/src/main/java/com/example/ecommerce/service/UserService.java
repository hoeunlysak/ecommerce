package com.example.ecommerce.service;

import com.example.ecommerce.entity.UserEntity;
import com.example.ecommerce.repository.UserRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class UserService {
    private final UserRepository repository;

    public UserService(UserRepository repository) {
        this.repository = repository;
    }

    public List<UserEntity> findAll() {
        return repository.findAll();
    }

    public Optional<UserEntity> findById(Long id) {
        return repository.findById(id);
    }

    public UserEntity save(UserEntity entity) {
        return repository.save(entity);
    }

    public void deleteById(Long id) {
        repository.deleteById(id);
    }
}
