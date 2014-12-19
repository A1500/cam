package com.inspur.cams.fis.ep.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.fis.ep.base.dao.jdbc.FisCemeCheckReportDao;
import com.inspur.cams.fis.ep.base.dao.jdbc.FisCemeCheckResultDao;
import com.inspur.cams.fis.ep.base.data.FisCemeCheckResult;

/**
 * @title:FisCemeCheckResultQueryCommand
 * @description:
 * @author:
 * @since:2011-11-28
 * @version:1.0
*/

public class FisCemeCheckResultQueryCommand extends BaseQueryCommand{
	//默认年检年份
	public final static String DEF_CHECK_YEAR = "2011";
	
	@SuppressWarnings("unchecked")
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<FisCemeCheckResult> dao = (EntityDao<FisCemeCheckResult>) DaoFactory
				.getDao("com.inspur.cams.fis.ep.base.dao.jdbc.FisCemeCheckResultDao");
		  return dao.query(pset);
	}
	 
	//公墓年检查询
	public DataSet cemecheckQuery(){
		FisCemeCheckResultDao fisCemeCheckResultDao =(FisCemeCheckResultDao) DaoFactory
		.getDao("com.inspur.cams.fis.ep.base.dao.jdbc.FisCemeCheckResultDao");
		ParameterSet pset = getParameterSet();
		return fisCemeCheckResultDao.cemecheckQuery(pset);
	}
	//年检历史查询
	public DataSet inspectionhistoryQuery(){
		FisCemeCheckResultDao fisCemeCheckResultDao =(FisCemeCheckResultDao) DaoFactory
		.getDao("com.inspur.cams.fis.ep.base.dao.jdbc.FisCemeCheckResultDao");
		ParameterSet pset = getParameterSet();
		return fisCemeCheckResultDao.inspectionhistoryQuery(pset);
	}
	/**
	 * @Title: queryForCheckReport 
	 * @Description: TODO(年检结果统计查询) 
	 * @param @return 设定文件 
	 * @return DataSet    返回类型
	 */
	public DataSet queryForCheckReport(){
		FisCemeCheckReportDao dao = (FisCemeCheckReportDao) DaoFactory.getDao( FisCemeCheckReportDao.class);
		ParameterSet pset = getParameterSet();
		DataSet ds=dao.getDataSet(pset);
		return ds;
	}

	
}
