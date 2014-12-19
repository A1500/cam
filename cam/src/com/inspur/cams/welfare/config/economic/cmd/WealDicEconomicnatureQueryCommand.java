package com.inspur.cams.welfare.config.economic.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.welfare.config.economic.dao.WealDicEconomicnature;

/**
 * @title:WealDicEconomicnatureQueryCommand
 * @description:
 * @author:
 * @since:2013-04-25
 * @version:1.0
*/
public class WealDicEconomicnatureQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<WealDicEconomicnature> dao = (EntityDao<WealDicEconomicnature>) DaoFactory
				.getDao("com.inspur.cams.welfare.config.economic.dao.WealDicEconomicnatureDao");
		return dao.query(pset);
	}
}
