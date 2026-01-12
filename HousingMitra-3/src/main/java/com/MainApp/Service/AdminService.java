package com.MainApp.Service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.MainApp.Entity.Admin;
import com.MainApp.Repository.AdminRepository;
import com.MainApp.Repository.ComplaintRepository;
import com.MainApp.Repository.NoticeRepository;
import com.MainApp.Repository.RequestRepository;
import com.MainApp.Repository.UserRepository;


@Service
public class AdminService {

	@Autowired
	AdminRepository aRepo;
	
	@Autowired
	UserRepository userRepo;
	
	@Autowired
	RequestRepository requestRepo;
	
	@Autowired
    ComplaintRepository complaintRepo;
    
	@Autowired
    NoticeRepository noticeRepo;
	 
	 
	
	boolean flag=false;
	
	public boolean addAdmin(Admin a)
	{
		Optional<Admin> newAdmin = aRepo.findById(a.getName());
		
		if(newAdmin.isEmpty())
		{
			aRepo.save(a);
			
			flag = true;
		}
		else
		{
			flag=false;
		}
		
		
		return flag;
	}
	
	
	String result;
	
	public String checkAdmin(String name,String pass)
	{
		Optional<Admin> oa = aRepo.findByNameAndPass(name, pass);
		
		if(oa.isEmpty())
		{
			result="Invaild Credentials";
		}
		else
		{
			result="exists";
		}
		
		return result;
	}
	
	 public long getTotalUsers() 
	 {
	     return userRepo.count();
	 }
	 
	 public long getPendingRequests() 
	 {
	      return requestRepo.findByStatus("PENDING").size();
	 }
	 
	 public long getPendingComplaints() 
	 {
	      return complaintRepo.findByStatus("PENDING").size();
	 }
	 
	 public long getTotalNotices() 
	 {
	      return noticeRepo.count();
	 }

	
}
