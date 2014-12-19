package com.inspur.cams.drel.esurey.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.esurey.domain.ISamEsureyRelationDomain;


public class SamEsureyRelationQueryCmd extends BaseQueryCommand{
	private ISamEsureyRelationDomain service = ScaComponentFactory.getService(
			ISamEsureyRelationDomain.class, "SamEsureyRelationDomain/SamEsureyRelationDomain");

	public DataSet execute(){
		ParameterSet pset=getParameterSet();
		return service.query(pset);
	}
	 /**
	 * 根据家庭Id查找赡养家庭Id及人口数
	 * @param pset
	 * @return
	 */
	public DataSet queryRelFamiyIdNum(){
		ParameterSet pset=getParameterSet();
		return service.queryRelFamiyIdNum(pset);
	} 
}
