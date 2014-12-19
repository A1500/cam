package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.bpt.base.dao.jdbc.BptPerjuryDao;
import com.inspur.cams.bpt.base.data.BptPerjury;
/**
 * @title:BptPerjuryQueryCommand
 * @description:
 * @author:
 * @since:2014-03-20
 * @version:1.0
*/
public class BptPerjuryQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<BptPerjury> dao = (EntityDao<BptPerjury>) DaoFactory
				.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPerjuryDao");
		return dao.query(pset);
	}
	
	public DataSet queryPerjury() {
		ParameterSet pset = getParameterSet();
		BptPerjuryDao dao = (BptPerjuryDao) DaoFactory
				.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPerjuryDao");
		return dao.queryPerjury(pset);
	}
	
}
