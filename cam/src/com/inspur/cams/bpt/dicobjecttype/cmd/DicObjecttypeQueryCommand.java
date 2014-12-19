package com.inspur.cams.bpt.dicobjecttype.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.bpt.dicobjecttype.dao.*;

/**
 * @title:DicObjecttypeQueryCommand
 * @description:
 * @author:
 * @since:2011-08-16
 * @version:1.0
*/
public class DicObjecttypeQueryCommand extends BaseQueryCommand{
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		pset.setSortField("TYPE_ID");
		EntityDao<DicObjecttype> dao = (EntityDao<DicObjecttype>) DaoFactory
				.getDao("com.inspur.cams.bpt.dicobjecttype.dao.DicObjecttypeDao");
		DataSet ds = dao.query(pset);
		ds.getMetaData().setIdProperty("TYPE_ID");
		return ds;
	}
	
} 
