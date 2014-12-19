package com.inspur.sdmz.jzzs.cmd;


import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.sdmz.jzzs.data.YgjzJzzsConf;

/**
 * @title:YgjzJzzsConfQueryCommand
 * @description:
 * @author:
 * @since:2011-06-09
 * @version:1.0
*/
public class YgjzJzzsConfQueryCommand extends BaseQueryCommand{
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<YgjzJzzsConf> dao = (EntityDao<YgjzJzzsConf>) DaoFactory
				.getDao("com.inspur.sdmz.jzzs.dao.jdbc.YgjzJzzsConfDao");
		return dao.query(pset);
		
	}
}
