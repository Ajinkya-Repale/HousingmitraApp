package com.MainApp.Controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.MainApp.Entity.Complaint;
import com.MainApp.Service.ComplaintService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ComplaintController {

    @Autowired
    private ComplaintService cService;

    private final int PAGE_SIZE = 5; // complaints per page

    // ===================== USER =====================

    @GetMapping("/user-complaints")
    public String showUserComplaints(
            @RequestParam(value = "status", required = false) String status,
            @RequestParam(value = "page", defaultValue = "0") int page,
            HttpServletRequest req,
            Model model) {

        HttpSession session = req.getSession();
        Long uid = (Long) session.getAttribute("uid");
        if (uid == null) return "redirect:/Login";

        Pageable pageable = PageRequest.of(page, PAGE_SIZE);
        Page<Complaint> complaintPage;

        if (status != null && !status.isEmpty()) {
            complaintPage = cService.getComplaintsByUserAndStatus(uid, status, pageable);
        } else {
            complaintPage = cService.getComplaintsByUser(uid, pageable);
        }

        model.addAttribute("complaints", complaintPage.getContent());
        model.addAttribute("filter", status);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", complaintPage.getTotalPages());

        return "user-complaints";
    }

    @PostMapping("/user-complaints")
    public String filterUserComplaints(@RequestParam(value = "status", required = false) String status) {
        return "redirect:/user-complaints?status=" + (status != null ? status : "");
    }

    @PostMapping("/submitComplaint")
    public String submitComplaint(@ModelAttribute Complaint complaint, HttpServletRequest req) {
        HttpSession session = req.getSession();
        Long uid = (Long) session.getAttribute("uid");
        if (uid == null) return "redirect:/Login";

        complaint.setUserId(uid);
        complaint.setStatus("Pending");
        cService.addComplaint(complaint);

        return "redirect:/user-complaints";
    }

    @PostMapping("/delete-complaint")
    public String deleteComplaint(@RequestParam("id") Long id) {
        cService.deleteComplaint(id);
        return "redirect:/user-complaints";
    }

    // ================= EDIT COMPLAINT =================
    @PostMapping("/edit-complaint")
    public String editComplaint(@RequestParam("id") Long id,
                                @RequestParam("complaintTitle") String title,
                                @RequestParam("complaintType") String type,
                                @RequestParam("complaintDescription") String desc) {

        Optional<Complaint> opt = cService.getComplaintById(id);
        if (opt.isPresent()) {
            Complaint c = opt.get();
            c.setComplaintTitle(title);
            c.setComplaintType(type);
            c.setComplaintDescription(desc);
            cService.updateComplaint(c);
        }

        return "redirect:/user-complaints";
    }

    // ===================== ADMIN =====================

    @GetMapping("/complaints")
    public String showAllComplaints(
            @RequestParam(value = "status", required = false) String status,
            @RequestParam(value = "page", defaultValue = "0") int page,
            Model model) {

        Pageable pageable = PageRequest.of(page, PAGE_SIZE);
        Page<Complaint> complaintPage;

        if (status != null && !status.isEmpty()) {
            complaintPage = cService.getComplaintsByStatus(status, pageable);
        } else {
            complaintPage = cService.getAllComplaints(pageable);
        }

        model.addAttribute("complaints", complaintPage.getContent());
        model.addAttribute("filter", status);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", complaintPage.getTotalPages());

        return "admin-complaints";
    }

    @PostMapping("/complaints")
    public String filterAdminComplaints(@RequestParam(value = "status", required = false) String status) {
        return "redirect:/complaints?status=" + (status != null ? status : "");
    }

    @PostMapping("/resolve-complaint")
    public String resolveComplaint(@RequestParam("id") Long id) {
        Optional<Complaint> complaintOpt = cService.getComplaintById(id);
        if (complaintOpt.isPresent()) {
            Complaint complaint = complaintOpt.get();
            complaint.setStatus("Resolved");
            cService.updateComplaint(complaint);
        }
        return "redirect:/complaints";
    }

    @PostMapping("/reject-complaint")
    public String rejectComplaint(@RequestParam("id") Long id) {
        Optional<Complaint> complaintOpt = cService.getComplaintById(id);
        if (complaintOpt.isPresent()) {
            Complaint complaint = complaintOpt.get();
            complaint.setStatus("Rejected");
            cService.updateComplaint(complaint);
        }
        return "redirect:/complaints";
    }
}
