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

import com.inspur.cams.drel.sam.data.SamPeopleDisease;
import com.inspur.cams.drel.sam.domain.IBaseinfoPeopleDomain;
import com.inspur.cams.drel.sam.domain.ISamPeopleDiseaseDomain;
/**
 * @title:SamPeopleDiseaseCmd成员患病
 * @description:
 * @author:
 * @since:2011-04-25
 * @version:1.0
*/
public class SamPeopleDiseaseCmd extends BaseQueryCommand {
	private ISamPeopleDiseaseDomain service = ScaComponentFactory.getService(ISamPeopleDiseaseDomain.class,"samPeopleDiseaseDomain/samPeopleDiseaseDomain");
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return service.query(pset);
	}

	public void save() {
		IBaseinfoPeopleDomain ygjzjtxxcyxxDomain = ScaComponentFactory.getService(IBaseinfoPeopleDomain.class,
				"SamBaseinfoPeopleDomain/SamBaseinfoPeopleDomain");
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
		.getDao("org.ygjzcyxxhbxx.dao.YgjzCyxxHbxxDao");
		String delId = (String) getParameter("delId");
		dao.delete(delId);
	}
}