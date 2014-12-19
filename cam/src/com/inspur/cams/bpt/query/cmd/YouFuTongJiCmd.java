package com.inspur.cams.bpt.query.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.bpt.query.dao.YouFuTongJiDao;

public class YouFuTongJiCmd extends BaseQueryCommand {
	
	private YouFuTongJiDao dao = (YouFuTongJiDao) DaoFactory.getDao( YouFuTongJiDao.class);
	public DataSet execute(){
		ParameterSet pset = getParameterSet();
		DataSet set = dao.getDataSet(pset);
		return set;
	}
	
	/**
	 * 获取优抚对象人数
	 * @return
	 */
	public DataSet getBptObjectNum(){
		ParameterSet pset = getParameterSet();
		DataSet ds = dao.getBptObjectNum(pset);
		return ds;
	}
}
