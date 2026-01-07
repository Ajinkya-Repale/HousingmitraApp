package com.MainApp.Repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.MainApp.Entity.Complaint;

@Repository
public interface ComplaintRepository extends JpaRepository<Complaint, Long> {

    // USER
    List<Complaint> findByUserId(Long userId);
    List<Complaint> findByUserIdAndStatus(Long userId, String status);

    Page<Complaint> findByUserId(Long userId, Pageable pageable);
    Page<Complaint> findByUserIdAndStatus(Long userId, String status, Pageable pageable);

    // ADMIN
    List<Complaint> findByStatus(String status);

    Page<Complaint> findAll(Pageable pageable);
    Page<Complaint> findByStatus(String status, Pageable pageable);
}
