package com.inspur.cams.welfare.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.welfare.base.data.WealFitInfo;

/**
 * @title:WealFitInfoQueryCommand
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
public class WealFitInfoQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<WealFitInfo> dao = (EntityDao<WealFitInfo>) DaoFactory
				.getDao("com.inspur.cams.welfare.base.dao.support.WealFitInfoDao");
		return dao.query(pset);
	}
}
