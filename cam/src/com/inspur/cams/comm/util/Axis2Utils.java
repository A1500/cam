package com.inspur.cams.comm.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.loushang.ws.context.MessageContext;
import org.loushang.ws.transport.http.HTTPConstants;


public class Axis2Utils {
	public static HttpServletRequest getRequest()
	  {
	    MessageContext context = MessageContext.getCurrentMessageContext();
	    HttpServletRequest request = (HttpServletRequest)context
	      .getProperty(HTTPConstants.MC_HTTP_SERVLETREQUEST);
	    return request;
	  }

	  public static String getRemoteIp()
	  {
	    String remoteIp = "IP Unknown";
	    MessageContext context = MessageContext.getCurrentMessageContext();
	    HttpServletRequest request = (HttpServletRequest)context
	      .getProperty(HTTPConstants.MC_HTTP_SERVLETREQUEST);
	    remoteIp = request.getRemoteAddr();
	    return remoteIp;
	  }

	  public static HttpSession getSession()
	  {
	    MessageContext context = MessageContext.getCurrentMessageContext();
	    HttpServletRequest request = (HttpServletRequest)context.getProperty(HTTPConstants.MC_HTTP_SERVLETREQUEST);
	    return request.getSession(true);
	  }

	  public static HttpSession getSession(boolean create)
	  {
	    MessageContext context = MessageContext.getCurrentMessageContext();
	    HttpServletRequest request = (HttpServletRequest)context.getProperty(HTTPConstants.MC_HTTP_SERVLETREQUEST);
	    return request.getSession(create);
	  }

	
}
