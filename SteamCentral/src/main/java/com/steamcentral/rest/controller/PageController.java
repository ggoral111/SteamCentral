package com.steamcentral.rest.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class PageController {
	
	@RequestMapping("/")
	public ModelAndView getIndexPage() {
		return new ModelAndView("index");		
	}
	
	@RequestMapping("/login")
	public ModelAndView getLoginPage() {
		return new ModelAndView("login");		
	}
	
	@RequestMapping("/charts")
	public ModelAndView getChartsPage() {
		return new ModelAndView("charts");		
	}
}