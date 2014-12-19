package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.bpt.base.dao.jdbc.DicBptCareerDao;

/**
 * 行政区划查询cmd
 * @author wangbaocai
 * @date 2011-6-23
 */
public class DicBptCareerQueryCommand extends BaseQueryCommand {
	
	DicBptCareerDao dao = (DicBptCareerDao) DaoFactory.getDao("com.inspur.cams.bpt.base.dao.jdbc.DicBptCareerDao");
	
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		pset.setParameter("sort", "code");
		pset.setParameter("dir", "asc");
		DataSet ds = dao.query(pset);
		ds.getMetaData().setIdProperty("ID");
		return ds;
	}

	
	
	
} 
