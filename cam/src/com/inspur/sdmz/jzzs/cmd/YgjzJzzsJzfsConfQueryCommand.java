package com.inspur.sdmz.jzzs.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.sdmz.jzzs.data.YgjzJzzsJzfsConf;

/**
 * @title:YgjzJzzsJzfsConfQueryCommand
 * @description:
 * @author:
 * @since:2011-05-14
 * @version:1.0
*/
public class YgjzJzzsJzfsConfQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<YgjzJzzsJzfsConf> dao = (EntityDao<YgjzJzzsJzfsConf>) DaoFactory
				.getDao("demo.example.dao.YgjzJzzsJzfsConfDao");
		return dao.query(pset);
	}
}
