package com.MainApp.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.MainApp.Entity.Notice;
import com.MainApp.Service.NoticeService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


@Controller
public class NoticeCreateUpdateDelete {

    @Autowired
    NoticeService nService;

    @RequestMapping("/notice")
    public String showNotice(Model model, HttpServletRequest req) {

        HttpSession session = req.getSession();
        String adminName = (String) session.getAttribute("atoken");

        if (adminName == null) 
        {
            return "redirect:/Login";
        }

        List<Notice> ln = nService.getNotices(adminName); // admin-specific
        model.addAttribute("ln", ln);

        return "Notice";
    }

    @RequestMapping("/add-notice")
    public String handleAddNotice(@ModelAttribute Notice n, HttpServletRequest req) {

        HttpSession session = req.getSession();
        String adminName = (String) session.getAttribute("atoken");

        if (adminName == null) {
            return "redirect:/Login";
        }

        n.setAdminName(adminName); 
        nService.addNotice(n);

        return "redirect:/notice";
    }
    
    
    @RequestMapping("/delete-notice")
	public String handleDeleteNotice(@RequestParam("nid") int nid)
	{
		nService.deleteNotice(nid);
		return "redirect:/notice";
	}
    
    
    @RequestMapping("/user-notice")
    public String userNotices(Model model) {
        List<Notice> list = nService.getallNotices();
        model.addAttribute("ln", list);
        return "user-notices";
    }

    
   
    
    
}

