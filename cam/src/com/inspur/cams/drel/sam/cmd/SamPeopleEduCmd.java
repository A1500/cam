package com.inspur.cams.drel.sam.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.sam.data.SamPeopleEdu;
import com.inspur.cams.drel.sam.domain.IBaseinfoPeopleDomain;
import com.inspur.cams.drel.sam.domain.ISamPeopleEduDomain;

/**
 * @title:YgjzCyxxJyxxCommand成员教育
 * @description:
 * @author:
 * @since:2011-04-25
 * @version:1.0
*/
public class SamPeopleEduCmd extends BaseQueryCommand {
	private ISamPeopleEduDomain service = ScaComponentFactory.getService(ISamPeopleEduDomain.class,"samPeopleEduDomain/samPeopleEduDomain");
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return service.query(pset);
	}

	public void save() {
		IBaseinfoPeopleDomain ygjzjtxxcyxxDomain = ScaComponentFactory.getService(IBaseinfoPeopleDomain.class,
				"SamBaseinfoPeopleDomain/SamBaseinfoPeopleDomain");
		Record[] ygjzcyxxjyxxRecords = (Record[]) getParameter("ygjzcyxxjyxxRecords");
		List<SamPeopleEdu> list = new ArrayList<SamPeopleEdu>();
		for (int i = 0; i < ygjzcyxxjyxxRecords.length; i++) {
			SamPeopleEdu ygjzcyxxjyxx = (SamPeopleEdu)ygjzcyxxjyxxRecords[i].toBean(SamPeopleEdu.class);
			list.add(ygjzcyxxjyxx);
		}
		ygjzjtxxcyxxDomain.saveYgjzCyxxJyxx(list);
	}
//	public void delete() {
//		EntityDao<SamPeopleEdu> dao = (EntityDao<SamPeopleEdu>) DaoFactory
//		.getDao("org.ygjzcyxxjyxx.dao.YgjzCyxxJyxxDao");
//		String delId = (String) getParameter("delId");
//		dao.delete(delId);
//	}
}