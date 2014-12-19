package com.inspur.cams.comm.extuser.util;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.extuser.data.ComExtUser;
import com.inspur.cams.comm.extuser.domain.IComExtUserDomain;
import com.inspur.cams.comm.util.StrUtil;

/**
 * 登录认证Servlet
 * @author shgtch
 * @date 2011-4-3
 */
public class CamsExtLoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private IComExtUserDomain comExtUserDomain = (IComExtUserDomain) ScaComponentFactory.getService(IComExtUserDomain.class, "comExtUserDomain/comExtUserDomain");

	public void init() throws ServletException {

	}
	String errorInfo = "";
	public void service(ServletRequest req, ServletResponse resp)
		throws ServletException, IOException {
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) resp;
		HttpSession session = request.getSession(true);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String loginType = request.getParameter("loginType");
		String contextPath = request.getContextPath();
		String userId = request.getParameter("userId");
		String pwd = request.getParameter("pwd");
		String caCheckStatus = StrUtil.n2b(request.getParameter("caCheckStatus"));
		String forwardPath = Constant.MENU_PAGE_PRS;
		try {
			// 外部单位用户domain
			if (comExtUserDomain != null) {
				ComExtUser comExtUser = comExtUserDomain.getComExtUser(userId);
				if (comExtUser != null && pwd.equals(comExtUser.getPwd())) {
					if ("1".equals(comExtUser.getAccountStatus())) {
						session.setAttribute(Constant.CAMS_LOGIN_EXTUSER, comExtUser);
						if (Constant.PATH_FLAG_MBALANCE.equals(loginType)) {
							forwardPath = Constant.MENU_PAGE_MBALANCE;	// 登录成功转向一站式结算主页面
						} else if (Constant.PATH_FLAG_ESUREY.equals(loginType)) {
							forwardPath = Constant.MENU_PAGE_ESUREY;	// 登录成功转向经济核对主页面
						} else if (Constant.PATH_FLAG_SOM.equals(loginType)) {
							forwardPath = Constant.MENU_PAGE_SOM;	// 登录成功转向民间组织年检主页面
						} else if (Constant.PATH_FLAG_SOM_SD.equals(loginType)) {
							if(caCheckStatus.equals("0")){
								checkIfCa(comExtUser);
							}
							forwardPath = Constant.MENU_PAGE_SOM_SD;	// 登录成功转向山东民间组织年检主页面
						}else if (Constant.PATH_FLAG_AIMS.equals(loginType)) {
							forwardPath = Constant.MENU_PAGE_AIMS;	// 登录成功转向山东农业产业化主页面
						}else if (Constant.PATH_FLAG_DECLARE.equals(loginType)) {
							forwardPath = Constant.MENU_PAGE_DECLARE;	// 登录成功转向山东农业产业化主页面
						}else if (Constant.PATH_FLAG_WELFARE.equals(loginType)) {
							forwardPath = Constant.MENU_PAGE_WELFARE;	// 登录成功转向福利企业主页面
						}else if (Constant.PATH_PAGE_DATAEXCHANGE.equals(loginType)) {
							forwardPath = Constant.MENU_PAGE_DATAEXCHANGE;	// 登录成功转向数据共享主页面
						}else if (Constant.PATH_FLAG_PRS.equals(loginType)) {
							forwardPath = Constant.MENU_PAGE_PRS;	// 登录成功转向退役士兵报名系统主页面
						}else {
							forwardPath = Constant.MENU_PAGE_CDC;	// 登录成功转向基层民主与社区建设主页面
						}
					} else {
						errorInfo = "帐号被锁定，请联系管理员!";
						throw new RuntimeException(errorInfo);
					}
				} else {
					errorInfo = "用户名或密码错误!";
					throw new RuntimeException(errorInfo);
				}
			} else {
				errorInfo = "登录出错!";
				throw new RuntimeException(errorInfo);
			}
			response.sendRedirect(contextPath + forwardPath);
		} catch (Exception e) {
			session.setAttribute(Constant.ERRORINFO , errorInfo);
			if (Constant.PATH_FLAG_MBALANCE.equals(loginType)) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_MBALANCE);
			} else if(Constant.PATH_FLAG_ESUREY.equals(loginType)) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_ESUREY);
			} else if(Constant.PATH_FLAG_SOM.equals(loginType)) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_SOM);
			} else if(Constant.PATH_FLAG_SOM_SD.equals(loginType)) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_SOM_SD);
			} else if(Constant.PATH_FLAG_AIMS.equals(loginType)) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_AIMS);
			}	else if(Constant.PATH_FLAG_DECLARE.equals(loginType)) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_DECLARE);
			} else if(Constant.PATH_FLAG_WELFARE.equals(loginType)) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_WELFARE);
			} else if(Constant.PATH_FLAG_PRS.equals(loginType)) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_PRS);
			}else if(Constant.PATH_PAGE_DATAEXCHANGE.equals(loginType)) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_DATAEXCHANGE);
			} else {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_CDC);
			}
		}
	}

	public void destroy() {
		super.destroy();
	}

	public void checkIfCa(ComExtUser comExtUser){
		ParameterSet pset = new ParameterSet();
		pset.setParameter("USER_ID", comExtUser.getUserId());
		DataSet ds = comExtUserDomain.queryExtUser(pset);
		if(ds.getCount()==1){
			ComExtUser comExtUser2 =(ComExtUser)ds.getRecord(0).toBean(ComExtUser.class);
			String status = comExtUser2.getIfCa();
			if(status!=null && status.equals("1")){
				errorInfo = "该用户登录需要CA证书!";
				throw new RuntimeException(errorInfo);
			}
		}
	}
}
