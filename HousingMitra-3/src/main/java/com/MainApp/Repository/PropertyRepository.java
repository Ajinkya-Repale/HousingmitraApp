package com.MainApp.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.MainApp.Entity.Property;

@Repository
public interface PropertyRepository extends JpaRepository<Property, Long>{
	
	List<Property> findByUserId(Long userId);

}
