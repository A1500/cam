package com.inspur.cams.drel.esurey.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.esurey.domain.ISamEsureyPeopleDomain;

public class SamEsureyPeopleQueryCmd extends BaseQueryCommand{
	private ISamEsureyPeopleDomain service = ScaComponentFactory.getService(
			ISamEsureyPeopleDomain.class, "SamEsureyPeopleDomain/SamEsureyPeopleDomain");
	public DataSet execute(){
		ParameterSet pset=getParameterSet();
		return service.query(pset);
	}
	/**
	 * 根据familyId查询赡养人员
	 */
	public DataSet querySupportPeo(){
		ParameterSet pset=getParameterSet();
		return service.querySupportPeople(pset);
	}
	/**
	 * 根据peopleId查询信息
	 */
	public DataSet queryPeopleById(){
		ParameterSet pset=getParameterSet();
		return service.queryPeopleById(pset);
	}
	
}
