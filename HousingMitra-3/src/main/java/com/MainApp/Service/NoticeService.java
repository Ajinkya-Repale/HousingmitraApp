package com.MainApp.Service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.MainApp.Entity.Notice;
import com.MainApp.Repository.NoticeRepository;

@Service
public class NoticeService {

	@Autowired
	NoticeRepository nRepo;
	
	boolean flag;
	
	public boolean addNotice(Notice n)
	{
		Optional<Notice> newNotice = nRepo.findById(n.getNid());
		
		if(newNotice.isEmpty())
		{
			nRepo.save(n);
			flag=true;
		}
		else
		{
			flag=false;
		}
		
		return flag;
	}
	
	
	public List<Notice> getNotices(String aname)
	{
		return nRepo.findByAdminName(aname);
	}
	
	public List<Notice> getallNotices()
	{
		return nRepo.findAll();
	}
	
	
	public void deleteNotice(int nid)
	{
		nRepo.deleteById(nid);
	} 
	
	
}
