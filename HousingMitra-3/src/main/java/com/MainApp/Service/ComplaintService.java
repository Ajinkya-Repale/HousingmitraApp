package com.MainApp.Service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.MainApp.Entity.Complaint;
import com.MainApp.Repository.ComplaintRepository;

@Service
public class ComplaintService {

    @Autowired
    private ComplaintRepository cRepo;

    // ================= COMMON =================
    public Complaint addComplaint(Complaint c) {
        return cRepo.save(c);
    }

    public Complaint updateComplaint(Complaint c) {
        return cRepo.save(c);
    }

    public void deleteComplaint(Long id) {
        cRepo.deleteById(id);
    }

    public Optional<Complaint> getComplaintById(Long id) {
        return cRepo.findById(id);
    }

    // ================= USER METHODS =================

    public List<Complaint> getComplaintsByUser(Long userId) {
        return cRepo.findByUserId(userId);
    }

    public List<Complaint> getComplaintsByUserAndStatus(Long userId, String status) {
        return cRepo.findByUserIdAndStatus(userId, status);
    }

    public Page<Complaint> getComplaintsByUser(Long userId, Pageable pageable) {
        return cRepo.findByUserId(userId, pageable);
    }

    public Page<Complaint> getComplaintsByUserAndStatus(Long userId, String status, Pageable pageable) {
        return cRepo.findByUserIdAndStatus(userId, status, pageable);
    }

    // ================= ADMIN METHODS =================

    public List<Complaint> getAllComplaints() {
        return cRepo.findAll();
    }

    public List<Complaint> getComplaintsByStatus(String status) {
        return cRepo.findByStatus(status);
    }

    public Page<Complaint> getAllComplaints(Pageable pageable) {
        return cRepo.findAll(pageable);
    }

    public Page<Complaint> getComplaintsByStatus(String status, Pageable pageable) {
        return cRepo.findByStatus(status, pageable);
    }
}
