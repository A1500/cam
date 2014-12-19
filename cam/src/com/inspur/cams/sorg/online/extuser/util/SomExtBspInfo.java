package com.inspur.cams.sorg.online.extuser.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.extuser.data.ComExtUser;
import com.inspur.cams.comm.extuser.util.Constant;
import com.inspur.cams.sorg.online.extuser.data.SomExtUser;
import com.inspur.cams.sorg.online.extusermenu.dao.support.SomExtuserMenuDao;
import com.inspur.cams.sorg.online.extusermenu.data.SomExtuserMenu;

/**
 * 社会组织外网用户信息
 * @author zhaojin
 * @date 2012-11-1
 */
public class SomExtBspInfo {
	private static SomExtuserMenuDao dao = (SomExtuserMenuDao) DaoFactory
	.getDao("com.inspur.cams.sorg.online.extusermenu.dao.support.SomExtuserMenuDao");

	public static SomExtUser getUserInfo(HttpServletRequest req) {
		HttpSession session = req.getSession(true);
		ComExtUser comExtUser = (ComExtUser) session.getAttribute(Constant.CAMS_LOGIN_EXTUSER);
		SomExtUser somExtUser = new SomExtUser();
		somExtUser.setComExtUser(comExtUser);
		String userId = comExtUser.getUserId();
		ParameterSet pset = new ParameterSet();
		pset.setParameter("USER_ID", userId);
		DataSet ds = dao.query(pset);
		if(ds.getCount()>0){
			SomExtuserMenu somExtuserMenu = (SomExtuserMenu) ds.getRecord(0).toBean(SomExtuserMenu.class);
			somExtUser.setMenuInfo(somExtuserMenu.getMenuInfo());
			somExtUser.setSorgCode(somExtuserMenu.getSorgCode());
		}
		return somExtUser;
	}


}
