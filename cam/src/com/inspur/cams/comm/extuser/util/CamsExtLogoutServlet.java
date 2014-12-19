package com.inspur.cams.comm.extuser.util;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 外部单位注销登录Servlet
 * @author shgtch
 * @date 2011-4-3
 */
public class CamsExtLogoutServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	public void init() throws ServletException {
		
	}
	
	public void service(ServletRequest req, ServletResponse resp)
		throws ServletException, IOException {
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) resp;
		String contextPath = request.getContextPath();
		String loginType = request.getParameter("loginType");
		try {
			HttpSession session = request.getSession(true);
			session.removeAttribute(Constant.CAMS_LOGIN_EXTUSER);
			if (Constant.PATH_FLAG_MBALANCE.equals(loginType)) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_MBALANCE);
			} else if (Constant.PATH_FLAG_ESUREY.equals(loginType)) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_ESUREY);
			} else if (Constant.PATH_FLAG_SOM.equals(loginType)) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_SOM);
			} else if (Constant.PATH_FLAG_SOM_SD.equals(loginType)) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_SOM_SD);
			} else if (Constant.PATH_FLAG_AIMS.equals(loginType)) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_AIMS);
			}else if (Constant.PATH_FLAG_DECLARE.equals(loginType)) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_DECLARE);
			}else if (Constant.PATH_FLAG_WELFARE.equals(loginType)) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_WELFARE);
			}else if (Constant.PATH_FLAG_PRS.equals(loginType)) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_PRS);
			}else if (Constant.PATH_PAGE_DATAEXCHANGE.equals(loginType)) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_DATAEXCHANGE);
			}else {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_CDC);
			}
		} catch (Exception e) {
			if (Constant.PATH_FLAG_MBALANCE.equals(loginType)) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_MBALANCE);
			} else if (Constant.PATH_FLAG_ESUREY.equals(loginType)) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_ESUREY);
			} else if (Constant.PATH_FLAG_SOM.equals(loginType)) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_SOM);
			} else if (Constant.PATH_FLAG_SOM_SD.equals(loginType)) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_SOM_SD);
			}else if (Constant.PATH_FLAG_AIMS.equals(loginType)) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_AIMS);
			}else if (Constant.PATH_FLAG_DECLARE.equals(loginType)) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_DECLARE);
			}else if (Constant.PATH_FLAG_WELFARE.equals(loginType)) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_WELFARE);
			}else if (Constant.PATH_FLAG_PRS.equals(loginType)) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_PRS);
			}else if (Constant.PATH_PAGE_DATAEXCHANGE.equals(loginType)) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_DATAEXCHANGE);
			}else {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_CDC);
			}
		}
	}
	
	public void destroy() {
		super.destroy();
	}
	
}
