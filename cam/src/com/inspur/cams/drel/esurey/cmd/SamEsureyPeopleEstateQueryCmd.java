package com.inspur.cams.drel.esurey.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.esurey.domain.ISamEsureyPeopleEstateDomain;


public class SamEsureyPeopleEstateQueryCmd extends BaseQueryCommand{
	ISamEsureyPeopleEstateDomain server = ScaComponentFactory.getService(ISamEsureyPeopleEstateDomain.class,
	"SamEsureyPeopleEstateDomain/SamEsureyPeopleEstateDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return server.query(pset);
	}
	/**
	 * 查询家庭财产
	 * @param paramSet
	 * @return
	 */
	public DataSet queryFamilyWorth(){
		ParameterSet pset = getParameterSet();
		return server.queryFamilyWorth(pset);
	} 
	 /**
	 * 查询家庭成员的收入
	 * @param paramSet
	 * @return
	 */
	public DataSet queryPeopleIncom(){
		ParameterSet pset = getParameterSet();
		return server.queryPeopleIncom(pset);
	}
	/**
	 * 查询家庭成员收入
	 * @return
	 */
	public DataSet queryFamilyIncome(){
		ParameterSet pset = getParameterSet();
		return server.queryFamilyIncome(pset);
	}
}
