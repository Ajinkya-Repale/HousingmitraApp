package com.MainApp.Service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.MainApp.Entity.User;
import com.MainApp.Repository.UserRepository;

@Service
public class UserService {

	@Autowired
	UserRepository uRepo;
	
	boolean flag;
	
	// ================= EXISTING METHOD =================
	public boolean addUser(User u) {
		Optional<User> newUser = uRepo.findById(u.getUserId());
		
		if(newUser.isEmpty()) {
			uRepo.save(u);
			flag=true;
		} else {
			flag=false;
		}
		
		return flag;
	}
	
	// ================= EXISTING METHOD =================
	String result;
	public String checkUser(String userName,String userpass) {
		Optional<User> ou = uRepo.findByUserNameAndUserpass(userName, userpass);
		
		if(ou.isEmpty()) {
			result="Invaild Credentials";
		} else {
			result="exists";
		}
		
		return result;
	}
	
	// ================= EXISTING METHOD =================
	public Optional<User> getUserByuserName(String userName) {
		return uRepo.findByUserName(userName);
	}
	
	// ================= NEW METHODS =================
	
	// Get all users for Manage Members page
	public List<User> getAllUsers() {
		return uRepo.findAll();
	}
	
	// Update user details
	public boolean updateUser(User u) {
		Optional<User> existingUser = uRepo.findById(u.getUserId());
		if(existingUser.isPresent()) {
			User user = existingUser.get();
			user.setUserName(u.getUserName());
			user.setUserEmail(u.getUserEmail());
			user.setUserFlatno(u.getUserFlatno());
			user.setUserPhoneno(u.getUserPhoneno());
			user.setUserFamno(u.getUserFamno());
			user.setUserRole(u.getUserRole());
			uRepo.save(user);
			return true;
		}
		return false;
	}
	
	// Delete user by ID
	public boolean deleteUser(long userId) {
		Optional<User> existingUser = uRepo.findById(userId);
		if(existingUser.isPresent()) {
			uRepo.deleteById(userId);
			return true;
		}
		return false;
	}
}
