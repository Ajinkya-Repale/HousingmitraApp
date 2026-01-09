package com.MainApp.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.MainApp.Entity.Property;
import com.MainApp.Service.PropertyService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class PropertyController {

    @Autowired
    private PropertyService pService;

    // Display ManageProperty.jsp
    @RequestMapping("/property")
    public String showProperties(Model model, HttpServletRequest req) 
    {
        HttpSession session = req.getSession();
        Long uid = (Long) session.getAttribute("uid");
        if(uid == null) 
        {
            return "redirect:/Login";
    
        }

        List<Property> properties = pService.getPropertiesByUser(uid);
        model.addAttribute("properties", properties);
        return "ManageProperty";
    }

    // Add property
    @PostMapping("/add-property")
    public String addProperty(@ModelAttribute Property p, HttpServletRequest req) 
    {
        HttpSession session = req.getSession();
        Long uid = (Long) session.getAttribute("uid");
        if(uid == null) return "redirect:/Login";

        p.setUserId(uid);
        pService.addProperty(p);
        return "redirect:/property";
    }

    // Edit property
    @PostMapping("/edit-property")
    public String editProperty(@ModelAttribute Property p, HttpServletRequest req) 
    {
        HttpSession session = req.getSession();
        Long uid = (Long) session.getAttribute("uid");
        if(uid == null) return "redirect:/Login";

        p.setUserId(uid);
        pService.updateProperty(p);
        return "redirect:/property";
    }

    // Delete property
    @PostMapping("/delete-property")
    public String deleteProperty(@RequestParam("id") Long id, HttpServletRequest req) 
    {
        HttpSession session = req.getSession();
        Long uid = (Long) session.getAttribute("uid");
        if(uid == null) return "redirect:/Login";

        // Optional: check ownership
        pService.getPropertyById(id).ifPresent(p ->
        {
            if(p.getUserId().equals(uid)) {
                pService.deleteProperty(id);
        }
        });

        return "redirect:/property";
    }
}
