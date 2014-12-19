package com.inspur.sdmz.jtxx.cmd;


import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.*;

import com.inspur.sdmz.jtxx.data.SamPeopleDisease;
import com.inspur.sdmz.jtxx.domain.IYgjzJtxxCyxxDomain;


/**
 * @title:YgjzCyxxHbxxCommand
 * @description:
 * @author:
 * @since:2011-04-25
 * @version:1.0
*/
public class YgjzCyxxHbxxCommand extends BaseQueryCommand {

	public DataSet execute() {
		IYgjzJtxxCyxxDomain ygjzjtxxcyxxDomain = ScaComponentFactory.getService(IYgjzJtxxCyxxDomain.class,
		"YgjzJtxxCyxxDomain/YgjzJtxxCyxxDomain");
		ParameterSet pset = getParameterSet();
		return ygjzjtxxcyxxDomain.queryYgjzCyxxHbxx(pset);
	}

	public void save() {
		IYgjzJtxxCyxxDomain ygjzjtxxcyxxDomain = ScaComponentFactory.getService(IYgjzJtxxCyxxDomain.class,
				"YgjzJtxxCyxxDomain/YgjzJtxxCyxxDomain");
		Record[] ygjzcyxxhbxxRecords = (Record[]) getParameter("ygjzcyxxhbxxRecords");
		List<SamPeopleDisease> list = new ArrayList<SamPeopleDisease>();
		for (int i = 0; i < ygjzcyxxhbxxRecords.length; i++) {
			SamPeopleDisease ygjzcyxxhbxx = (SamPeopleDisease)ygjzcyxxhbxxRecords[i].toBean(SamPeopleDisease.class);
			list.add(ygjzcyxxhbxx);
		}
		ygjzjtxxcyxxDomain.saveYgjzCyxxHbxx(list);
	}
	public void delete() {
		EntityDao<SamPeopleDisease> dao = (EntityDao<SamPeopleDisease>) DaoFactory
		.getDao("com.inspur.sdmz.jtxx.dao.jdbc.YgjzCyxxHbxxDao");
		String delId = (String) getParameter("delId");
		dao.delete(delId);
	}
}