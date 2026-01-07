package com.MainApp.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.MainApp.Entity.Request;

@Repository
public interface RequestRepository extends JpaRepository<Request, Long> {

    // User – all requests
    List<Request> findByUserId(Long userId);

    // User – filter by status
    List<Request> findByUserIdAndStatus(Long userId, String status);

    // Admin – filter by status
    List<Request> findByStatus(String status);
}
