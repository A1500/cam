package com.inspur.cams.bpt.dicdisabilitylevel.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.bpt.dicdisabilitylevel.dao.*;

/**
 * @title:DicDisabilityLevelQueryCommand
 * @description:
 * @author:
 * @since:2011-11-03
 * @version:1.0
*/
public class DicDisabilityLevelQueryCommand extends BaseQueryCommand{
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<DicDisabilityLevel> dao = (EntityDao<DicDisabilityLevel>) DaoFactory
				.getDao("com.inspur.cams.bpt.dicdisabilitylevel.dao.DicDisabilityLevelDao");
		DataSet ds = dao.query(pset);
		ds.getMetaData().setIdProperty("CODE");
		return ds;
	}
	
} 
