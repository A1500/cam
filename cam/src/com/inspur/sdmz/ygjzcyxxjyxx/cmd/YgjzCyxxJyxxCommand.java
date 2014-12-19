package com.inspur.sdmz.ygjzcyxxjyxx.cmd;


import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.sdmz.jtxxcyxx.domain.IYgjzJtxxCyxxDomain;
import com.inspur.sdmz.ygjzcyxxjyxx.dao.YgjzCyxxJyxx;
 

/**
 * @title:YgjzCyxxJyxxCommand
 * @description:
 * @author:
 * @since:2011-04-25
 * @version:1.0
*/
public class YgjzCyxxJyxxCommand extends BaseQueryCommand {

	public DataSet execute() {
		IYgjzJtxxCyxxDomain ygjzjtxxcyxxDomain = ScaComponentFactory.getService(IYgjzJtxxCyxxDomain.class,
		"YgjzJtxxCyxxDomain/YgjzJtxxCyxxDomain");
		ParameterSet pset = getParameterSet();
		return ygjzjtxxcyxxDomain.queryYgjzCyxxJyxx(pset);
	}

	public void save() {
		IYgjzJtxxCyxxDomain ygjzjtxxcyxxDomain = ScaComponentFactory.getService(IYgjzJtxxCyxxDomain.class,
				"YgjzJtxxCyxxDomain/YgjzJtxxCyxxDomain");
		Record[] ygjzcyxxjyxxRecords = (Record[]) getParameter("ygjzcyxxjyxxRecords");
		List<YgjzCyxxJyxx> list = new ArrayList<YgjzCyxxJyxx>();
		for (int i = 0; i < ygjzcyxxjyxxRecords.length; i++) {
			YgjzCyxxJyxx ygjzcyxxjyxx = (YgjzCyxxJyxx)ygjzcyxxjyxxRecords[i].toBean(YgjzCyxxJyxx.class);
			list.add(ygjzcyxxjyxx);
		}
		ygjzjtxxcyxxDomain.saveYgjzCyxxJyxx(list);
	}
	public void delete() {
		EntityDao<YgjzCyxxJyxx> dao = (EntityDao<YgjzCyxxJyxx>) DaoFactory
		.getDao("org.ygjzcyxxjyxx.dao.YgjzCyxxJyxxDao");
		String delId = (String) getParameter("delId");
		dao.delete(delId);
	}
}