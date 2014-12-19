package com.inspur.cams.fis.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.fis.base.data.FisDicCity;

/**
 * @title:FisDicCityQueryCommand
 * @description:
 * @author:
 * @since:2012-02-10
 * @version:1.0
*/
public class FisDicCityQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<FisDicCity> dao = (EntityDao<FisDicCity>) DaoFactory
				.getDao("com.inspur.cams.fis.base.dao.jdbc.FisDicCityDao");
		pset.setParameter("sort", "id");
		pset.setParameter("dir", "asc");
		DataSet ds = dao.query(pset);
		ds.getMetaData().setIdProperty("ID");
		return ds;
	}
}
