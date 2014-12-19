package com.inspur.cams.comm.extuser.util;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.inspur.cams.comm.extuser.data.ComExtUser;

/**
 * 外部用户登录过滤
 * @author shgtch
 * @date 2011-7-6
 */
public class CamsExtUserFilter implements Filter {

	public void init(FilterConfig filterConfig) throws ServletException {

	}

	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) resp;
		String servletPath= request.getServletPath();
	    if(servletPath.toLowerCase().indexOf("/jsp/ext")>=0){
	    	doJspFilter(request,response,chain);
	    } else if(servletPath.toLowerCase().indexOf("/command/ajax")>=0){
	    	doAjaxFilter(request,response,chain);
	    } else {
	    	chain.doFilter(request, response);
	    }
	}
	
	public void doAjaxFilter(HttpServletRequest request ,HttpServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		Enumeration e = request.getHeaders("Referer"); 
		if(e.hasMoreElements()){ 
			if(((String)e.nextElement()).indexOf(request.getContextPath()+"/jsp/ext")>0){
				request.getRequestDispatcher(request.getRequestURI().substring(request.getContextPath().length())).forward(request, response);
			    return ;
			}
		}
		chain.doFilter(request, response);
	}
	public void doJspFilter(HttpServletRequest request ,HttpServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		String contextPath=request.getContextPath();
		String uri = request.getRequestURI();
		String servletPath= request.getServletPath();
		try {
			// 扩展路径不进行BSP权限校验
			if (uri != null) {
				if (uri.toLowerCase().indexOf(Constant.FILTE_PATH) < 0) {
					chain.doFilter(request, response);
				} else {
					if (!uri.toLowerCase().equals(contextPath + Constant.LOGIN_PAGE_ESUREY)
							&& !uri.toLowerCase().equals(contextPath + Constant.LOGIN_PAGE_MBALANCE)
							&& !uri.toLowerCase().equals(contextPath + Constant.LOGIN_PAGE_SOM)
							&& !uri.toLowerCase().equals(contextPath + Constant.LOGIN_PAGE_SOM_SD)
							&& !uri.toLowerCase().equals(contextPath + Constant.LOGIN_PAGE_PRS)
							&& !uri.toLowerCase().equals(contextPath + Constant.LOGIN_PAGE_AIMS)
							&& !uri.toLowerCase().equals(contextPath + Constant.LOGIN_PAGE_DECLARE)
							&& !uri.toLowerCase().equals(contextPath + Constant.LOGIN_PAGE_WELFARE)
							&& !uri.toLowerCase().equals(contextPath + Constant.LOGIN_PAGE_CDC)  
							&& !uri.toLowerCase().equals(contextPath + Constant.LOGIN_PAGE_DATAEXCHANGE) 
						) {
						//permit(request, response, uri, chain);
						ComExtUser user = ExtBspInfo.getUserInfo(request);
						if (user == null || user.getUserId() == null || "".equals(user.getUserId())) {
							if (uri.toLowerCase().indexOf("jsp/ext/cdc") > 0) {
								chain.doFilter(request, response);
								return;
							} else if(uri.toLowerCase().indexOf("/"+Constant.PATH_FLAG_ONLINE_SERVICE+"/") > 0){
								request.getRequestDispatcher(servletPath).forward(request, response);
								return ;
							}else {
								throw new ExtUserNoLoginException();
							}
						} else {
							if (uri.toLowerCase().indexOf("/"+Constant.PATH_FLAG_MBALANCE+"/") > 0) {
								if(!PrivUtil.hasMbalancePriv(user.getOrganType())){
									throw new ExtUserNoLoginException();
								}
								
							} else if (uri.toLowerCase().indexOf("/"+Constant.PATH_FLAG_ESUREY+"/") > 0) {
								if(!PrivUtil.hasEsureyPriv(user.getOrganType())){
									throw new ExtUserNoLoginException();
								}
							}else if (uri.toLowerCase().indexOf("/"+Constant.PATH_FLAG_SOM_SD+"/") > 0) {
								if(!PrivUtil.hasSomPriv(user.getOrganType())){
									throw new ExtUserNoLoginException();
								}
							}else if (uri.toLowerCase().indexOf("/"+Constant.PATH_FLAG_SOM+"/") > 0) {
								if(!PrivUtil.hasSomPriv(user.getOrganType())){
									throw new ExtUserNoLoginException();
								}
							}else if ((uri.toLowerCase().indexOf("/"+Constant.PATH_FLAG_AIMS+"/")==0)&&uri.toLowerCase().indexOf("/"+Constant.PATH_FLAG_DECLARE+"/") > 0) {
								if(!PrivUtil.hasDeclarePriv(user.getOrganType())){
									throw new ExtUserNoLoginException();
								}
							}else if (uri.toLowerCase().indexOf("/"+Constant.PATH_FLAG_PRS+"/") > 0) {
								if(!PrivUtil.hasPrsPriv(user.getOrganType())){
									throw new ExtUserNoLoginException();
								}
							}else if (uri.toLowerCase().lastIndexOf("/"+Constant.PATH_FLAG_AIMS+"/") > 0) {
								if(!PrivUtil.hasAimsPriv(user.getOrganType())){
									throw new ExtUserNoLoginException();
								}
							}else if (uri.toLowerCase().indexOf("/"+Constant.PATH_FLAG_WELFARE+"/") > 0) {
								if(!PrivUtil.hasWelfarePriv(user.getOrganType())){
									throw new ExtUserNoLoginException();
								}
							}else if (uri.toLowerCase().indexOf("/"+Constant.PATH_FLAG_CDC+"/") > 0) {
								if(!PrivUtil.hasCdcPriv(user.getOrganType())){
									throw new ExtUserNoLoginException();
								}
							}else if (uri.toLowerCase().indexOf("/"+Constant.PATH_PAGE_DATAEXCHANGE+"/") > 0) {
								if(!PrivUtil.hasEXPriv(user.getOrganType())){
									throw new ExtUserNoLoginException();
								}
							} else if (uri.toLowerCase().indexOf("/"+Constant.PATH_FLAG_COMM+"/") > 0) {
								
							} else if (uri.toLowerCase().indexOf("/"+Constant.PATH_FLAG_ONLINE_SERVICE+"/") > 0) {
								
							} else {
								throw new ExtUserNoLoginException();
							}
						}
					}
					
					request.getRequestDispatcher(servletPath).forward(request, response);
					return ;
				}
			}
		} catch (ExtUserNoLoginException e) {
			if (uri.toLowerCase().indexOf("/"+Constant.PATH_FLAG_MBALANCE+"/") > 0) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_MBALANCE);
			} else if (uri.toLowerCase().indexOf("/"+Constant.PATH_FLAG_ESUREY+"/") > 0) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_ESUREY);
			} else if (uri.toLowerCase().indexOf("/"+Constant.PATH_FLAG_SOM_SD+"/") > 0) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_SOM_SD);
			}else if (uri.toLowerCase().indexOf("/"+Constant.PATH_FLAG_SOM+"/") > 0) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_SOM);
			}else if (uri.toLowerCase().indexOf("/"+Constant.PATH_FLAG_AIMS+"/") > 0) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_AIMS);
			}else if (uri.toLowerCase().indexOf("/"+Constant.PATH_FLAG_DECLARE+"/") > 0) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_DECLARE);
			}else if (uri.toLowerCase().indexOf("/"+Constant.PATH_FLAG_WELFARE+"/") > 0) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_WELFARE);
			}else if (uri.toLowerCase().indexOf("/"+Constant.PATH_FLAG_PRS+"/") > 0) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_PRS);
			}else if (uri.toLowerCase().indexOf("/"+Constant.PATH_PAGE_DATAEXCHANGE+"/") > 0) {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_DATAEXCHANGE);
			}else {
				response.sendRedirect(contextPath + Constant.LOGIN_PAGE_CDC);
			}
		}
	}
//	
//	private void permit(HttpServletRequest request,String uri) {
//		ComExtUser user = ExtBspInfo.getUserInfo(request);
//		if (user == null || user.getUserId() == null || "".equals(user.getUserId())) {
//			throw new ExtUserNoLoginException();
//		}
//		if (uri.toLowerCase().indexOf(Constant.PATH_FLAG_MBALANCE) > 0) {
//			if(!PrivUtil.hasMbalancePriv(user.getOrganType())){
//				throw new ExtUserNoLoginException();
//			}
//			
//		} else if (uri.toLowerCase().indexOf(Constant.PATH_FLAG_ESUREY) > 0) {
//			if(!PrivUtil.hasEsureyPriv(user.getOrganType())){
//				throw new ExtUserNoLoginException();
//			}
//		} else if (uri.toLowerCase().indexOf(Constant.PATH_FLAG_CDC) > 0) {
//			if(!PrivUtil.hasCdcPriv(user.getOrganType())){
//				throw new ExtUserNoLoginException();
//			}
//		} else if (uri.toLowerCase().indexOf(Constant.PATH_FLAG_COMM) > 0) {
//			
//		}
//		else {
//			throw new ExtUserNoLoginException();
//		}
//	}
	

	public void destroy() {

	}

}