package com.inspur.cams.bpt.query.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.bpt.query.dao.YouFuTongJi_IncreaseDao;

public class YouFuTongJi_IncreaseCmd extends BaseQueryCommand {
	
	private YouFuTongJi_IncreaseDao dao = (YouFuTongJi_IncreaseDao) DaoFactory.getDao( YouFuTongJi_IncreaseDao.class);
	public DataSet execute(){
		ParameterSet pset = getParameterSet();
		DataSet set = dao.getDataSet(pset);
		return set;
	}
}
