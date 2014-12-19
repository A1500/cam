package com.inspur.cams.bpt.bptrecuperate.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.bpt.bptrecuperate.dao.jdbc.BptRecuperateDao;

/**
 * @title:BptRecuperateQueryCommand
 * @description:
 * @author:
 * @since:2011-11-09
 * @version:1.0
*/
public class BptRecuperateQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		BptRecuperateDao dao = (BptRecuperateDao) DaoFactory
        .getDao(BptRecuperateDao.class);
		return dao.queryBptRecperate(pset);
	}
	
	public DataSet query(){
	    ParameterSet pset = getParameterSet();
        BptRecuperateDao dao = (BptRecuperateDao) DaoFactory
        .getDao(BptRecuperateDao.class);
        return dao.query(pset);
	}
	
	/**
	 * 查询人员基本信息中的轮养修养信息
	 */
	public DataSet queryPeopleRecuperateDetail(){
		ParameterSet pset = getParameterSet();
		BptRecuperateDao dao = (BptRecuperateDao) DaoFactory
        .getDao(BptRecuperateDao.class);
		return dao.queryPeopleRecuperateDetail(pset);
	}
}
