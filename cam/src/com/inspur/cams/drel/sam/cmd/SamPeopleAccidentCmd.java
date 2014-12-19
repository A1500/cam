package com.inspur.cams.drel.sam.cmd;


import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.sam.data.SamPeopleAccident;
import com.inspur.cams.drel.sam.domain.IBaseinfoPeopleDomain;

/**
 * @title:SamPeopleAccidentCmd
 * @description:
 * @author:
 * @since:2011-04-25
 * @version:1.0
*/
public class SamPeopleAccidentCmd extends BaseQueryCommand {

	public DataSet execute() {
		IBaseinfoPeopleDomain ygjzjtxxcyxxDomain = ScaComponentFactory.getService(IBaseinfoPeopleDomain.class,
		"SamBaseinfoPeopleDomain/SamBaseinfoPeopleDomain");
		ParameterSet pset = getParameterSet();
		return ygjzjtxxcyxxDomain.queryCyxxSgxx(pset);
	}

	public void save() {
		IBaseinfoPeopleDomain ygjzjtxxcyxxDomain = ScaComponentFactory.getService(IBaseinfoPeopleDomain.class,
				"SamBaseinfoPeopleDomain/SamBaseinfoPeopleDomain");
		Record[] ygjzcyxxsgxxRecords = (Record[]) getParameter("ygjzcyxxsgxxRecords");
		List<SamPeopleAccident> list = new ArrayList<SamPeopleAccident>();
		for (int i = 0; i < ygjzcyxxsgxxRecords.length; i++) {
			SamPeopleAccident ygjzcyxxsgxx = (SamPeopleAccident)ygjzcyxxsgxxRecords[i].toBean(SamPeopleAccident.class);
			list.add(ygjzcyxxsgxx);
		}
		ygjzjtxxcyxxDomain.saveYgjzCyxxSgxx(list);
	}
	public void delete() {
		EntityDao<SamPeopleAccident> dao = (EntityDao<SamPeopleAccident>) DaoFactory.getDao("org.ygjzcyxxsgxx.dao.jdbc.YgjzCyxxSgxxDao");
		String delId = (String) getParameter("delId");
		dao.delete(delId);
	}
}