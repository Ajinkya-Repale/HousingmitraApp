package com.MainApp.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.MainApp.Entity.Request;
import com.MainApp.Service.RequestService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class RequestController {

    @Autowired
    private RequestService rService;

    /* ================= USER REQUESTS ================= */
    // Use POST for filter
    @RequestMapping(value = "/user-requests", method = {RequestMethod.GET, RequestMethod.POST})
    public String showUserRequest(
            @RequestParam(value = "status", required = false) String status,
            HttpServletRequest req,
            Model model) {

        HttpSession s = req.getSession();
        Long uid = (Long) s.getAttribute("uid");

        if (uid == null) {
            return "redirect:/Login";
        }

        List<Request> requestList =
                (status == null || status.equals("ALL"))
                        ? rService.getRequestByUserId(uid)
                        : rService.getRequestByUserIdAndStatus(uid, status);

        model.addAttribute("request", requestList);
        model.addAttribute("status", status != null ? status : "ALL");

        return "user-request";
    }

    /* ================= USER SUBMIT ================= */
    @RequestMapping("/submitRequest")
    public String handleUserRequest(@ModelAttribute Request r, HttpServletRequest req) {

        HttpSession session = req.getSession();
        Long uid = (Long) session.getAttribute("uid");

        if (uid == null) {
            return "redirect:/Login";
        }

        r.setUserId(uid); // status & date auto-set by entity
        rService.addRequest(r);

        return "redirect:/user-requests";
    }

    /* ================= USER DELETE ================= */
    @RequestMapping("/delete-request")
    public String handleDeleteRequest(@RequestParam("Id") long Id) {
        rService.deleteRequest(Id);
        return "redirect:/user-requests";
    }

    /* ================= ADMIN VIEW ================= */
    // Use POST for filter
    @RequestMapping(value = "/request", method = {RequestMethod.GET, RequestMethod.POST})
    public String showRequest(
            @RequestParam(value = "status", required = false) String status,
            Model model) {

        List<Request> requestList =
                (status == null || status.equals("ALL"))
                        ? rService.getAllRequest()
                        : rService.getRequestByStatus(status);

        model.addAttribute("rl", requestList);
        model.addAttribute("status", status != null ? status : "ALL");

        return "Request";
    }

    /* ================= ADMIN ACTIONS ================= */
    @RequestMapping("/accept-request")
    public String acceptRequest(@RequestParam("id") long id) {
        rService.updateRequestStatus(id, "ACCEPTED");
        return "redirect:/request";
    }

    @RequestMapping("/reject-request")
    public String rejectRequest(@RequestParam("id") long id) {
        rService.updateRequestStatus(id, "REJECTED");
        return "redirect:/request";
    }
}
