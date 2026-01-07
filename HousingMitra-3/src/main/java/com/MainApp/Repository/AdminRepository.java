package com.MainApp.Repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.MainApp.Entity.Admin;

@Repository
public interface AdminRepository extends JpaRepository<Admin, String>{

	Optional<Admin> findByNameAndPass(String name,String pass);
}
