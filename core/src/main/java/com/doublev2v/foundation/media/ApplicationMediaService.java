package com.doublev2v.foundation.media;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public class ApplicationMediaService extends LocalMediaService {
	private ServletContext context;

	public ServletContext getContext() {
		return context;
	}
	
	@Autowired
	public void setContext(ServletContext context) {
		this.context = context;
	}
	
	@Override
	public String getBasePath() {
		return context.getRealPath("/");
	}
}
