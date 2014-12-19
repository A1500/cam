package com.inspur.sdmz.jtxx.cmd;


import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.sdmz.jtxx.data.SamPeopleAccident;
import com.inspur.sdmz.jtxx.domain.IYgjzJtxxCyxxDomain;


/**
 * @title:YgjzCyxxSgxxCommand
 * @description:
 * @author:
 * @since:2011-04-25
 * @version:1.0
*/
public class YgjzCyxxSgxxCommand extends BaseQueryCommand {

	public DataSet execute() {
		IYgjzJtxxCyxxDomain ygjzjtxxcyxxDomain = ScaComponentFactory.getService(IYgjzJtxxCyxxDomain.class,
		"YgjzJtxxCyxxDomain/YgjzJtxxCyxxDomain");
		ParameterSet pset = getParameterSet();
		return ygjzjtxxcyxxDomain.queryYgjzCyxxSgxx(pset);
	}

	public void save() {
		IYgjzJtxxCyxxDomain ygjzjtxxcyxxDomain = ScaComponentFactory.getService(IYgjzJtxxCyxxDomain.class,
				"YgjzJtxxCyxxDomain/YgjzJtxxCyxxDomain");
		Record[] ygjzcyxxsgxxRecords = (Record[]) getParameter("ygjzcyxxsgxxRecords");
		List<SamPeopleAccident> list = new ArrayList<SamPeopleAccident>();
		for (int i = 0; i < ygjzcyxxsgxxRecords.length; i++) {
			SamPeopleAccident ygjzcyxxsgxx = (SamPeopleAccident)ygjzcyxxsgxxRecords[i].toBean(SamPeopleAccident.class);
			list.add(ygjzcyxxsgxx);
		}
		ygjzjtxxcyxxDomain.saveYgjzCyxxSgxx(list);
	}
	public void delete() {
		EntityDao<SamPeopleAccident> dao = (EntityDao<SamPeopleAccident>) DaoFactory.getDao("com.inspur.sdmz.jtxx.dao.jdbc.YgjzCyxxSgxxDao");
		String delId = (String) getParameter("delId");
		dao.delete(delId);
	}
}