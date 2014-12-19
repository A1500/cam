package com.inspur.cams.bpt.query.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.bpt.query.dao.YouFuTongJi_DecreaseDao;

public class YouFuTongJi_DecreaseCmd extends BaseQueryCommand {
	
	private YouFuTongJi_DecreaseDao dao = (YouFuTongJi_DecreaseDao) DaoFactory.getDao( YouFuTongJi_DecreaseDao.class);
	public DataSet execute(){
		ParameterSet pset = getParameterSet();
		DataSet set = dao.getDataSet(pset);
		return set;
	}
}
