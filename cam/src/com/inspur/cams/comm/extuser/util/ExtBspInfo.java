package com.inspur.cams.comm.extuser.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.inspur.cams.comm.extuser.data.ComExtUser;

/**
 * 外部单位扩展用户信息
 * @author shgtch
 * @date 2011-7-6
 */
public class ExtBspInfo {
	
	public static ComExtUser getUserInfo(HttpServletRequest req) {
		HttpSession session = req.getSession(true);
		return (ComExtUser) session.getAttribute(Constant.CAMS_LOGIN_EXTUSER);
	}
	
	public static void setUserInfo(HttpServletRequest req, ComExtUser comExtUser) {
		HttpSession session = req.getSession(true);
		session.setAttribute(Constant.CAMS_LOGIN_EXTUSER, comExtUser);
	}

}
