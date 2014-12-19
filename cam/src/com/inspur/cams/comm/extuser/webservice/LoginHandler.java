package com.inspur.cams.comm.extuser.webservice;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.loushang.ws.AxisFault;
import org.loushang.ws.context.MessageContext;
import org.loushang.ws.engine.Handler;
import org.loushang.ws.handlers.AbstractHandler;
import org.loushang.ws.transport.http.HTTPConstants;

import com.inspur.cams.comm.extuser.data.ComExtUser;
import com.inspur.cams.comm.extuser.util.Constant;

public class LoginHandler extends AbstractHandler
implements Handler{

	public InvocationResponse invoke(MessageContext messageContext) throws AxisFault {
		if("ComExtUserLoginService.ComExtUserLoginService".equals(messageContext.getServiceContext().getName())){
			return Handler.InvocationResponse.CONTINUE;
		}
		HttpServletRequest request = (HttpServletRequest)messageContext.getProperty(HTTPConstants.MC_HTTP_SERVLETREQUEST);
	    HttpSession session = request.getSession(false);
	    if (session == null) {
	      throw new AxisFault("needLogin");
	    }
	    Object o = session.getAttribute(Constant.CAMS_LOGIN_EXTUSER);
	    if ((o == null) || (!(o instanceof ComExtUser))) {
	    	throw new AxisFault("needLogin");
	    }
	   
	    return Handler.InvocationResponse.CONTINUE;
	}

}
