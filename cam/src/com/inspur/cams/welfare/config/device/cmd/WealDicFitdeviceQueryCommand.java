package com.inspur.cams.welfare.config.device.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.welfare.config.device.dao.WealDicFitdevice;

/**
 * @title:WealDicFitdeviceQueryCommand
 * @description:
 * @author:
 * @since:2013-04-25
 * @version:1.0
*/
public class WealDicFitdeviceQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<WealDicFitdevice> dao = (EntityDao<WealDicFitdevice>) DaoFactory
				.getDao("com.inspur.cams.welfare.config.device.dao.WealDicFitdeviceDao");
		return dao.query(pset);
	}
}
