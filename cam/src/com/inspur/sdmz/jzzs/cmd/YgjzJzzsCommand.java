package com.inspur.sdmz.jzzs.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.*;

import com.inspur.sdmz.jzzs.dao.*;
import com.inspur.sdmz.jtxx.dao.*;

/**
 * @title:YgjzJzzsCommand
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
*/
public class YgjzJzzsCommand extends BaseQueryCommand {

	public DataSet execute() {
		IYgjzJtxxDomain ygjzjtxxDomain = ScaComponentFactory.getService(IYgjzJtxxDomain.class,
		"YgjzJtxxDomain/YgjzJtxxDomain");
		ParameterSet pset = getParameterSet();
		return ygjzjtxxDomain.queryYgjzJzzs(pset);
	}

	public void save() {
		IYgjzJtxxDomain ygjzjtxxDomain = ScaComponentFactory.getService(IYgjzJtxxDomain.class,
				"YgjzJtxxDomain/YgjzJtxxDomain");
		Record[] ygjzjzzsRecords = (Record[]) getParameter("ygjzjzzsRecords");
		List<YgjzJzzs> list = new ArrayList<YgjzJzzs>();
		for (int i = 0; i < ygjzjzzsRecords.length; i++) {
			YgjzJzzs ygjzjzzs = (YgjzJzzs)ygjzjzzsRecords[i].toBean(YgjzJzzs.class);
			list.add(ygjzjzzs);
		}
		ygjzjtxxDomain.saveYgjzJzzs(list);
	}
	public void delete() {
		EntityDao<YgjzJzzs> dao = (EntityDao<YgjzJzzs>) DaoFactory
		.getDao("com.inspur.sdmz.jzzs.dao.YgjzJzzsDao");
		String delId = (String) getParameter("delId");
		dao.delete(delId);
	}
}