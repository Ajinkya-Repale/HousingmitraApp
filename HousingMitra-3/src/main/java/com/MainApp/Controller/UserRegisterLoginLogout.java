package com.MainApp.Controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.MainApp.Entity.Complaint;
import com.MainApp.Entity.Notice;
import com.MainApp.Entity.Property;
import com.MainApp.Entity.Request;
import com.MainApp.Entity.User;
import com.MainApp.Repository.ComplaintRepository;
import com.MainApp.Repository.NoticeRepository;
import com.MainApp.Repository.PropertyRepository;
import com.MainApp.Repository.RequestRepository;
import com.MainApp.Service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class UserRegisterLoginLogout {

	@Autowired
	UserService uService;
	
	 @Autowired
	 PropertyRepository propertyRepo;

	 @Autowired
	 RequestRepository requestRepo;

	 @Autowired
	 ComplaintRepository complaintRepo;

	 @Autowired
	 NoticeRepository noticeRepo;
	
	
	 // USER HOME 
	@RequestMapping("/userhome")
	public String HandleUserHome(HttpServletRequest req) 
	{
	   HttpSession session = req.getSession();
	   String utoken = (String) session.getAttribute("utoken");
	   Long uid = (Long) session.getAttribute("uid");

	    if (utoken != null && uid != null) {

	     //  Properties Booked
	     List<Property> properties = propertyRepo.findByUserId(uid);
	     int propertiesCount = properties.size();

	      //  Pending Requests
	      List<Request> pendingRequests = requestRepo.findByUserIdAndStatus(uid, "PENDING");
	      int pendingRequestsCount = pendingRequests.size();

	      //  Complaints Raised
	      List<Complaint> complaints = complaintRepo.findByUserId(uid);
	      int complaintsCount = complaints.size();

	      //  Notices Received
	      List<Notice> notices = noticeRepo.findAll(); // assuming all notices are for all users
	      int noticesCount = notices.size();

	      // Pass counts to JSP
	      req.setAttribute("propertiesCount", propertiesCount);
	      req.setAttribute("pendingRequestsCount", pendingRequestsCount);
	      req.setAttribute("complaintsCount", complaintsCount);
	      req.setAttribute("noticesCount", noticesCount);

	      return "userhome";

	} 
	else 
	{
	      return "redirect:/Login";
	 }
 }


	
	@RequestMapping("/user-register")
	public String handleUserRegister(@ModelAttribute User u,HttpServletRequest req)
	{
		
		boolean status=uService.addUser(u);
		HttpSession s = req.getSession();
		
		if(status)
		{
			s.setAttribute("msg","Registered Successfully");
		}
		else
		{
			s.setAttribute("msg", "Something went wrong");
		}
		
		return "redirect:/Signup";
	}
	
	
	@RequestMapping("/user-login")
	public String handleUserLogin(@RequestParam ("userName") String name,
		@RequestParam ("userpass") String pass,HttpServletRequest req)
	{
		String res = uService.checkUser(name, pass);
		HttpSession s = req.getSession();
		
		if(res.equals("exists"))
		{
			s.setAttribute("utoken", name);
			
			Optional<User> ou = uService.getUserByuserName(name);
			if(ou.isPresent())
			{
				s.setAttribute("uid", ou.get().getUserId());
			}
			
			
			
			return "redirect:/userhome";
		}
		else
		{
			s.setAttribute("msg", res);
			return "Login";
		}
	}
	
	@RequestMapping("/user-logout") 
	public String handleUserLogout(HttpServletRequest req)
	{
		HttpSession s = req.getSession();
		s.removeAttribute("utoken");
		s.removeAttribute("uid");
		
		s.setAttribute("msg", "logout successfully");
		return "redirect:/Login";
	}
	
	
	
	
	
	
	
}
