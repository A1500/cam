package com.inspur.sdmz.jtxx.cmd;


import javax.servlet.http.HttpServletRequest;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.comm.extuser.util.ExtBspInfo;
import com.inspur.sdmz.comm.util.BspUtil;
import com.inspur.sdmz.jtxx.dao.jdbc.JtxxQueryDao;

public class JtxxQueryCommand extends BaseQueryCommand {
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		String organType=(String)pset.getParameter("organType");
		String organCode=(String)pset.getParameter("organCode");
		JtxxQueryDao dao = (JtxxQueryDao) DaoFactory.getDao(JtxxQueryDao.class);

		return dao.query(getParameterSet(),organType,organCode);
	}
	/**
	 *  计算相应条件下的户数和人数
	 * 
	 **/
	public DataSet getJtxxNum(){
		ParameterSet pset = getParameterSet();
		String organCode=(String)pset.getParameter("organCode");
	
		JtxxQueryDao dao = (JtxxQueryDao) DaoFactory.getDao(JtxxQueryDao.class);
		return dao.getJtxxNum(getParameterSet(),organCode);
	}
	/**
	 *  计算相应条件下的户数和人数
	 * 
	 **/
	public DataSet getJtcyNum(){
		ParameterSet pset = getParameterSet();
		String organCode=(String)pset.getParameter("organCode");
		JtxxQueryDao dao = (JtxxQueryDao) DaoFactory.getDao(JtxxQueryDao.class);
		return dao.getJtcyNum(getParameterSet(),organCode);
	}
	/**
	 *  电子监察查询困难户家庭成员信息
	 * 
	 **/
	public DataSet getJtcy() {
		//ParameterSet pset = getParameterSet();
		//String organCode=(String)pset.getParameter("organCode");
		HttpServletRequest request=(HttpServletRequest)getRequest();
		String organCode="";
		try{
			organCode=BspUtil.getCorpOrgan().getOrganCode();//当前登录行政区划
		}catch(Exception e){
			organCode = ExtBspInfo.getUserInfo(request).getAreaCode();
		}
		JtxxQueryDao dao = (JtxxQueryDao) DaoFactory.getDao(JtxxQueryDao.class);
		return dao.getJtcy(getParameterSet(),organCode);
	}
	/**
	 *  电子监察查询困难户家庭成员信息
	 * 
	 **/
	public DataSet getJtcy1() {
		HttpServletRequest request=(HttpServletRequest)getRequest();
		String organCode="";
		try{
			organCode=BspUtil.getCorpOrgan().getOrganCode();//当前登录行政区划
		}catch(Exception e){
			organCode = ExtBspInfo.getUserInfo(request).getAreaCode();
		}
		JtxxQueryDao dao = (JtxxQueryDao) DaoFactory.getDao(JtxxQueryDao.class);
		return dao.getJtcy1(getParameterSet(),organCode);
	}
	
}
