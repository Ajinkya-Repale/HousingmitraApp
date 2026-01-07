package com.MainApp.Entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;


@Entity
@Table
public class User {
 
	@Id
	@Column
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	long userId;
	
	@NotBlank
	@Column(nullable = false)
	String userName;
	
	@Column(nullable = false,unique = true)
	String userEmail;
	
	@Column(nullable = false)
	String userFlatno;
	
	@Column(nullable = false,unique = true,length = 10)
	String userPhoneno;
	 
	@Column(nullable = false)
	int userFamno;
	
	@Column
	String userRole;
	
	@Column
	String userpass;

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getUserFlatno() {
		return userFlatno;
	}

	public void setUserFlatno(String userFlatno) {
		this.userFlatno = userFlatno;
	}

	public String getUserPhoneno() {
		return userPhoneno;
	}

	public void setUserPhoneno(String userPhoneno) {
		this.userPhoneno = userPhoneno;
	}

	public int getUserFamno() {
		return userFamno;
	}

	public void setUserFamno(int userFamno) {
		this.userFamno = userFamno;
	}

	public String getUserpass() {
		return userpass;
	}

	public void setUserpass(String userpass) {
		this.userpass = userpass;
	}

	public String getUserRole() {
		return userRole;
	}

	public void setUserRole(String userRole) {
		this.userRole = userRole;
	}
	
	
}
