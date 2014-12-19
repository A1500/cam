package com.inspur.cams.fis.cremationRate.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.fis.cremationRate.dao.FisCremationRateConfigDao;
import com.inspur.cams.fis.cremationRate.data.*;
/**
 * @title:FisCremationRateConfigQueryCommand
 * @description:
 * @author:
 * @since:2012-11-16
 * @version:1.0
*/
public class FisCremationRateConfigQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<FisCremationRateConfig> dao = (EntityDao<FisCremationRateConfig>) DaoFactory
				.getDao("com.inspur.cams.fis.cremationRate.dao.FisCremationRateConfigDao");
		return dao.query(pset);
	}
}
