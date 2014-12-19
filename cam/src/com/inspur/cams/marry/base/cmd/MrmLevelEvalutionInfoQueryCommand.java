package com.inspur.cams.marry.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.marry.base.data.MrmLevelEvalutionInfo;

/**
 * @title:MrmLevelEvalutionInfoQueryCommand
 * @description:
 * @author:
 * @since:2011-12-05
 * @version:1.0
*/
public class MrmLevelEvalutionInfoQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<MrmLevelEvalutionInfo> dao = (EntityDao<MrmLevelEvalutionInfo>) DaoFactory
				.getDao("com.inspur.cams.marry.base.dao.jdbc.MrmLevelEvalutionInfoDao");
		return dao.query(pset);
	}
}
