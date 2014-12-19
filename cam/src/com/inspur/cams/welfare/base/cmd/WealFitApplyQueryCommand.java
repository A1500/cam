package com.inspur.cams.welfare.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.welfare.base.dao.support.WealFitApplyDao;
import com.inspur.cams.welfare.base.data.WealFitApply;

/**
 * @title:WealFitApplyQueryCommand
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
public class WealFitApplyQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<WealFitApply> dao = (EntityDao<WealFitApply>) DaoFactory
				.getDao("com.inspur.cams.welfare.base.dao.support.WealFitApplyDao");
		return dao.query(pset);
	}
	public DataSet queryInfo (){
		ParameterSet pset = getParameterSet();
		WealFitApplyDao dao = (WealFitApplyDao) DaoFactory
				.getDao("com.inspur.cams.welfare.base.dao.support.WealFitApplyDao");
		return dao.queryInfo(pset);
	}
}
