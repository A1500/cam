package com.inspur.cams.marry.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.marry.base.data.MrmResourcesInfo;

/**
 * @title:MrmResourcesInfoQueryCommand
 * @description:
 * @author:
 * @since:2011-11-28
 * @version:1.0
*/
public class MrmResourcesInfoQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<MrmResourcesInfo> dao = (EntityDao<MrmResourcesInfo>) DaoFactory
				.getDao("com.inspur.cams.marry.base.dao.jdbc.MrmResourcesInfoDao");
		return dao.query(pset);
	}
}
