package com.MainApp.Service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.MainApp.Entity.Request;
import com.MainApp.Repository.RequestRepository;

@Service
public class RequestService {

    @Autowired
    private RequestRepository reqRepo;

    /* USER SUBMIT REQUEST */
    public boolean addRequest(Request req) {
        // ID is auto-generated, no need to check existence
        reqRepo.save(req);
        return true;
    }

    /* USER – ALL REQUESTS */
    public List<Request> getRequestByUserId(Long userId) {
        return reqRepo.findByUserId(userId);
    }

    /* USER – FILTER BY STATUS */
    public List<Request> getRequestByUserIdAndStatus(Long userId, String status) {
        return reqRepo.findByUserIdAndStatus(userId, status);
    }

    /* ADMIN – ALL REQUESTS */
    public List<Request> getAllRequest() {
        return reqRepo.findAll();
    }

    /* ADMIN – FILTER BY STATUS */
    public List<Request> getRequestByStatus(String status) {
        return reqRepo.findByStatus(status);
    }

    /* ADMIN – ACCEPT / REJECT */
    public void updateRequestStatus(long id, String status) {
        Optional<Request> opt = reqRepo.findById(id);
        if (opt.isPresent()) {
            Request r = opt.get();
            r.setStatus(status);
            reqRepo.save(r);
        }
    }

    /* USER – DELETE REQUEST */
    public void deleteRequest(long id) {
        reqRepo.deleteById(id);
    }
}
