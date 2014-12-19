package com.inspur.cams.welfare.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.welfare.base.dao.support.WealFitStatusDao;
import com.inspur.cams.welfare.base.data.WealFitStatus;

/**
 * @title:WealFitStatusQueryCommand
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
public class WealFitStatusQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<WealFitStatus> dao = (EntityDao<WealFitStatus>) DaoFactory
				.getDao("com.inspur.cams.welfare.base.dao.support.WealFitStatusDao");
		return dao.query(pset);
	}
	
	//假肢装配企业基本信息查询
	public DataSet queryInfo() {
		ParameterSet pset = getParameterSet();
		WealFitStatusDao dao = (WealFitStatusDao) DaoFactory
			.getDao("com.inspur.cams.welfare.base.dao.support.WealFitStatusDao");
		return dao.queryInfoBySql(pset);
	}
}
