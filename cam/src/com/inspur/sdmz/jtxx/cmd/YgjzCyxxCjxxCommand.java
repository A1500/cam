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

import com.inspur.sdmz.jtxx.data.SamPeopleDisability;
import com.inspur.sdmz.jtxx.data.SamPeopleDisease;
import com.inspur.sdmz.jtxx.domain.IYgjzJtxxCyxxDomain;

/**
 * @title:YgjzCyxxCjxxCommand
 * @description:
 * @author:
 * @since:2011-04-19
 * @version:1.0
*/
public class YgjzCyxxCjxxCommand extends BaseQueryCommand {

	public DataSet execute() {
		IYgjzJtxxCyxxDomain ygjzjtxxcyxxDomain = ScaComponentFactory.getService(IYgjzJtxxCyxxDomain.class,
		"YgjzJtxxCyxxDomain/YgjzJtxxCyxxDomain");
		ParameterSet pset = getParameterSet();
		return ygjzjtxxcyxxDomain.queryYgjzCyxxCjxx(pset);
	}

	public void save() {
		IYgjzJtxxCyxxDomain ygjzjtxxcyxxDomain = ScaComponentFactory.getService(IYgjzJtxxCyxxDomain.class,
				"YgjzJtxxCyxxDomain/YgjzJtxxCyxxDomain");
		Record[] ygjzcyxxcjxxRecords = (Record[]) getParameter("ygjzcyxxcjxxRecords");
		List<SamPeopleDisability> list = new ArrayList<SamPeopleDisability>();
		for (int i = 0; i < ygjzcyxxcjxxRecords.length; i++) {
			SamPeopleDisability ygjzcyxxcjxx = (SamPeopleDisability)ygjzcyxxcjxxRecords[i].toBean(SamPeopleDisability.class);
			list.add(ygjzcyxxcjxx);
		}
		ygjzjtxxcyxxDomain.saveYgjzCyxxCjxx(list);
	}
	public void delete() {
		EntityDao<SamPeopleDisability> dao = (EntityDao<SamPeopleDisability>) DaoFactory
		.getDao("com.inspur.sdmz.jtxx.dao.jdbc.YgjzCyxxCjxxDao");
		String delId = (String) getParameter("delId");
		dao.delete(delId);
	}

}