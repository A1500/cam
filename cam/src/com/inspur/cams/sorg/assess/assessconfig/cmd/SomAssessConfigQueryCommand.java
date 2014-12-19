package com.inspur.cams.sorg.assess.assessconfig.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.assess.assessconfig.data.SomAssessConfig;

/**
 * @title:SomAssessConfigQueryCommand
 * @description:
 * @author:
 * @since:2011-12-03
 * @version:1.0
*/
public class SomAssessConfigQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomAssessConfig> dao = (EntityDao<SomAssessConfig>) DaoFactory
				.getDao("com.inspur.cams.sorg.assess.assessconfig.dao.SomAssessConfigDao");
		DataSet ds = dao.query(pset);
		ds.getMetaData().setIdProperty("CONFIG_ID");
		return ds;
	}
}
