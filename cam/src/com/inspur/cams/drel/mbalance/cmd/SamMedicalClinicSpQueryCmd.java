package com.inspur.cams.drel.mbalance.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.mbalance.domain.ISamMedicalClinicSpDomain;
/**
 * 
 * @author Jiangzhaobao
 *
 * @date 2011-7-20
 */
public class SamMedicalClinicSpQueryCmd extends BaseQueryCommand{
	private ISamMedicalClinicSpDomain service=ScaComponentFactory.getService(ISamMedicalClinicSpDomain.class,"samMedicalClinicSpDomain/samMedicalClinicSpDomain");
	
	public DataSet execute(){
		ParameterSet pset=getParameterSet();
		return service.query(pset);
	}
	
	/**
	 * 关联查询
	 */
	public DataSet queryBySql(){
		ParameterSet pset=getParameterSet();
		return service.queryBySql(pset);
	}
	/**
	 * 优抚门规汇总查询
	 * @param pset
	 * @return
	 */
	public DataSet queryForClinic(){
		ParameterSet pset=getParameterSet();
		return service.queryForClinic(pset);
	}


   	/**
   	 * 优抚门规明细查询
   	 * @param pset
   	 * @return
   	 */
	public DataSet queryForClinicDetail(){
		ParameterSet pset=getParameterSet();
		return service.queryForClinicDetail(pset);
	}
	

	/**
	 * 普通门规录入时人员查询
	 * @param pset
	 * @return
	 */
	
	public DataSet QueryPeople(){
		ParameterSet pset=getParameterSet();
		return service.QueryPeople(pset);
	}
	
	/**
	 * 普通门规查询
	 * @param pset
	 * @return
	 */
	
	public DataSet queryForNomClinic(){
		ParameterSet pset=getParameterSet();
		return service.queryForNomClinic(pset);
	}
}
