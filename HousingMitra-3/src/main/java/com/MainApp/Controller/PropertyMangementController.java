package com.MainApp.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PropertyMangementController {

	@RequestMapping("/property")
	public String showProperty()
	{
		return "ManageProperty";
	}
	
}
