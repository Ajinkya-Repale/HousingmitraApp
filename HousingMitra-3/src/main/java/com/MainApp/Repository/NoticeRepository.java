package com.MainApp.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.MainApp.Entity.Notice;

@Repository
public interface NoticeRepository extends JpaRepository<Notice, Integer>{

    List<Notice> findByAdminName(String aname);
      
	
}
