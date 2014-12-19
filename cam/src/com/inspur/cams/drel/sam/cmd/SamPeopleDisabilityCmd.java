package com.inspur.cams.drel.sam.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.sam.data.SamPeopleDisability;
import com.inspur.cams.drel.sam.domain.IBaseinfoPeopleDomain;
import com.inspur.cams.drel.sam.domain.ISamPeopleDisabilityDomain;
/**
 * @title:SamPeopleDisabilityCmd成员残疾
 * @description:
 * @author:
 * @since:2011-04-19
 * @version:1.0
*/
public class SamPeopleDisabilityCmd extends BaseQueryCommand {
	private ISamPeopleDisabilityDomain service = ScaComponentFactory.getService(ISamPeopleDisabilityDomain.class,"samPeopleDisabilityDomain/samPeopleDisabilityDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return service.query(pset);
	}

	public void save() {
		IBaseinfoPeopleDomain ygjzjtxxcyxxDomain = ScaComponentFactory.getService(IBaseinfoPeopleDomain.class,
				"SamBaseinfoPeopleDomain/SamBaseinfoPeopleDomain");
		Record[] ygjzcyxxcjxxRecords = (Record[]) getParameter("ygjzcyxxcjxxRecords");
		List<SamPeopleDisability> list = new ArrayList<SamPeopleDisability>();
		for (int i = 0; i < ygjzcyxxcjxxRecords.length; i++) {
			SamPeopleDisability ygjzcyxxcjxx = (SamPeopleDisability)ygjzcyxxcjxxRecords[i].toBean(SamPeopleDisability.class);
			list.add(ygjzcyxxcjxx);
		}
		ygjzjtxxcyxxDomain.saveYgjzCyxxCjxx(list);
	}

}