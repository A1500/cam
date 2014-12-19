package com.inspur.sdmz.jzfa.cmd;

import javax.servlet.http.HttpServletRequest;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.comm.extuser.util.ExtBspInfo;
import com.inspur.sdmz.jzfa.dao.jdbc.KnjtDao;

public class KnjtQueryCmd extends BaseQueryCommand {
	@SuppressWarnings("unchecked")
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		HttpServletRequest request = (HttpServletRequest) getRequest();
		String organCode = ExtBspInfo.getUserInfo(request).getAreaCode();
		pset.setParameter("organCode", organCode);
		KnjtDao dao = (KnjtDao) DaoFactory.getDao(KnjtDao.class);
		DataSet ds = dao.query(pset);
		ds.getMetaData().setIdProperty("jtid");
		return ds;
	}

	/**
	 * 计算相应条件下的户数和人数
	 * 
	 */
	public DataSet getJtxxNum() {
		ParameterSet pset = getParameterSet();
		HttpServletRequest request = (HttpServletRequest) getRequest();
		String organCode = ExtBspInfo.getUserInfo(request).getAreaCode();
		pset.setParameter("organCode", organCode);
		KnjtDao dao = (KnjtDao) DaoFactory.getDao(KnjtDao.class);
		return dao.getJtxxNum(pset);
	}
}
