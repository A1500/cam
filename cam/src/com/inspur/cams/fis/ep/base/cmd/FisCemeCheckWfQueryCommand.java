package com.inspur.cams.fis.ep.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.fis.ep.base.dao.jdbc.FisCemeCheckReportDao;
import com.inspur.cams.fis.ep.base.dao.jdbc.FisCemeCheckResultDao;
import com.inspur.cams.fis.ep.base.dao.jdbc.FisCemeCheckWfDao;
import com.inspur.cams.fis.ep.base.data.FisCemeCheckResult;
import com.inspur.cams.fis.ep.base.data.FisCemeCheckWf;

/**
 * @title:FisCemeCheckResultQueryCommand
 * @description:
 * @author:
 * @since:2011-11-28
 * @version:1.0
*/

public class FisCemeCheckWfQueryCommand extends BaseQueryCommand{
	
	@SuppressWarnings("unchecked")
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<FisCemeCheckWf> dao = (EntityDao<FisCemeCheckWf>) DaoFactory
				.getDao("com.inspur.cams.fis.ep.base.dao.jdbc.FisCemeCheckWfDao");
		  return dao.query(pset);
	}
	 
	//查询需要进行年检的公益性公墓
	public DataSet cemeNoProfitCheckQuery(){
		FisCemeCheckWfDao fisCemeCheckWfDao =(FisCemeCheckWfDao) DaoFactory
		.getDao("com.inspur.cams.fis.ep.base.dao.jdbc.FisCemeCheckWfDao");
		ParameterSet pset = getParameterSet();
		return fisCemeCheckWfDao.cemeNoProfitCheckQuery(pset);
	}
	
	//查询需要进行检查的经营性公墓
	public DataSet cemeProfitCheckQuery(){
		FisCemeCheckWfDao fisCemeCheckWfDao =(FisCemeCheckWfDao) DaoFactory
		.getDao("com.inspur.cams.fis.ep.base.dao.jdbc.FisCemeCheckWfDao");
		ParameterSet pset = getParameterSet();
		return fisCemeCheckWfDao.cemeProfitCheckQuery(pset);
	}
	
	//查询需要进行年检的经营性公墓
	public DataSet cemeProfitFinalCheckQuery(){
		FisCemeCheckWfDao fisCemeCheckWfDao =(FisCemeCheckWfDao) DaoFactory
		.getDao("com.inspur.cams.fis.ep.base.dao.jdbc.FisCemeCheckWfDao");
		ParameterSet pset = getParameterSet();
		return fisCemeCheckWfDao.cemeProfitFinalCheckQuery(pset);
	}
	
	
}
