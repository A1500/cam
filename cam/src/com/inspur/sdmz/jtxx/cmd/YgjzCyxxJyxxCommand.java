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

import com.inspur.sdmz.jtxx.data.SamPeopleEdu;
import com.inspur.sdmz.jtxx.domain.IYgjzJtxxCyxxDomain;


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
		List<SamPeopleEdu> list = new ArrayList<SamPeopleEdu>();
		for (int i = 0; i < ygjzcyxxjyxxRecords.length; i++) {
			SamPeopleEdu ygjzcyxxjyxx = (SamPeopleEdu)ygjzcyxxjyxxRecords[i].toBean(SamPeopleEdu.class);
			list.add(ygjzcyxxjyxx);
		}
		ygjzjtxxcyxxDomain.saveYgjzCyxxJyxx(list);
	}
	public void delete() {
		EntityDao<SamPeopleEdu> dao = (EntityDao<SamPeopleEdu>) DaoFactory
		.getDao("com.inspur.sdmz.jtxx.dao.jdbc.YgjzCyxxJyxxDao");
		String delId = (String) getParameter("delId");
		dao.delete(delId);
	}
}