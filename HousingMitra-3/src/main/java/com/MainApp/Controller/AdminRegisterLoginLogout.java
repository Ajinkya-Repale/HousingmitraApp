package com.MainApp.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.MainApp.Entity.Admin;
import com.MainApp.Entity.User;
import com.MainApp.Service.AdminService;
import com.MainApp.Service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class AdminRegisterLoginLogout {
	
	@Autowired
	AdminService aService;
	
	@Autowired
	UserService uService;
	
	//  EXISTING  methods 
	
	@RequestMapping("/Signup")
	public String showSignup() {
		return "Signup";
	}	
	
	@RequestMapping("/Login")
	public String showLogin() {
		return "Login";
	}
	
	@RequestMapping("/admin-register")
	public String handleAdminRegister(@ModelAttribute Admin a, HttpServletRequest req) {		
		boolean status = aService.addAdmin(a);
		HttpSession s = req.getSession();
		
		if(status) {
			s.setAttribute("msg","Registered Successfully");
		} else {
			s.setAttribute("msg", "Something went wrong");
		}
			 
		return "redirect:/Signup";
	}
	
	@RequestMapping("/admin-login")
	public String handleAdminLogin(@RequestParam ("name") String name,
	                               @RequestParam ("pass") String pass,
	                               HttpServletRequest req) {
	    String res = aService.checkAdmin(name, pass);
	    HttpSession s = req.getSession();
	    
	    if(res.equals("exists")) {
	    	s.setAttribute("atoken", name);
	    	return "redirect:/adminhome";
	    } else {
	    	s.setAttribute("msg", res);
			return "Login";
	    }
	}
	
	@RequestMapping("/adminhome")
	public String showAdminhome(Model model, HttpSession session) 
	{
		String atoken = (String) session.getAttribute("atoken");
		
		if(atoken == null)
		{
			session.setAttribute( "msg" , "Login first to access");
			return "redirect:/Login";
		}
		
		model.addAttribute("totalUsers",aService.getTotalUsers());
		model.addAttribute("pendingRequests",aService.getPendingRequests());
		model.addAttribute("pendingComplaints",aService.getPendingComplaints());
		model.addAttribute("noticeCount",aService.getTotalNotices());
		 
		return "adminhome";
	}
	
	@RequestMapping("/admin-logout")
	public String handleAdminLogout(HttpServletRequest req) {
		HttpSession s = req.getSession();
		s.removeAttribute("atoken");
		s.setAttribute("msg", "logout successfully");
		return "redirect:/Login";
	}
	
	//MANAGE MEMBERS 
	
	@RequestMapping("/manage-members")
	public String manageMembers(Model model, HttpServletRequest req) {
	    HttpSession session = req.getSession();
	    String atoken = (String) session.getAttribute("atoken");
	    if(atoken == null) {
	        session.setAttribute("msg","Login first to access");
	        return "redirect:/Login";
	    }

	    List<User> users = uService.getAllUsers(); 
	    model.addAttribute("users", users);
	    return "ManageMembers"; // JSP page
	}
	
	// ADD USER 
	@RequestMapping("/add-user")
	public String addUser(@ModelAttribute User u, HttpServletRequest req) {
	    HttpSession s = req.getSession();
	    uService.addUser(u);
	    s.setAttribute("msg","User added successfully");
	    return "redirect:/manage-members";
	}
	
	// EDIT USER 
	@RequestMapping("/edit-user")
	public String editUser(@ModelAttribute User u, HttpServletRequest req) {
	    HttpSession s = req.getSession();
	    uService.updateUser(u);
	    s.setAttribute("msg","User updated successfully");
	    return "redirect:/manage-members";
	}
	
	//  DELETE USER (Admin Side view)
	@RequestMapping("/delete-user")
	public String deleteUser(@RequestParam("userId") long userId, HttpServletRequest req) {
	    HttpSession s = req.getSession();
	    uService.deleteUser(userId);
	    s.setAttribute("msg","User deleted successfully");
	    return "redirect:/manage-members";
	}
}
