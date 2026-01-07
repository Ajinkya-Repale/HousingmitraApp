package com.MainApp.Controller;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.MainApp.Entity.User;
import com.MainApp.Service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class UserRegisterLoginLogout {

	@Autowired
	UserService uService;
	
	
	@RequestMapping("/userhome")
	public String HandleUserHome()
	{
		return "userhome";
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
