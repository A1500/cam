package com.inspur.cams.bpt.dichealth.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.bpt.dichealth.dao.DicHealth;

/**
 * @title:DicHealthQueryCommand
 * @description:
 * @author:
 * @since:2011-12-26
 * @version:1.0
*/
public class DicHealthQueryCommand extends BaseQueryCommand{
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<DicHealth> dao = (EntityDao<DicHealth>) DaoFactory
				.getDao("com.inspur.cams.bpt.dichealth.dao.DicHealthDao");
		DataSet ds = dao.query(pset);
		ds.getMetaData().setIdProperty("CODE");
		return ds;
	}
	
} 
