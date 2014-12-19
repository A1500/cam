package com.inspur.cams.drel.esurey.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.esurey.domain.ISamEsureyInsuranceDomain;
/**
 * @title:SamEsureyInsuranceQueryCmd
 * @description:保监查询Command
 * @author:luguosui
 * @since:2011-06-30
 * @version:1.0
*/
public class SamEsureyInsuranceQueryCmd extends BaseQueryCommand {
	ISamEsureyInsuranceDomain samEsureyInsuranceDomain = ScaComponentFactory.getService(ISamEsureyInsuranceDomain.class,
	"SamEsureyInsuranceDomain/SamEsureyInsuranceDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samEsureyInsuranceDomain.query(pset);
	}
	public DataSet queryExtInsurance() {
		ParameterSet pset = getParameterSet();
		return samEsureyInsuranceDomain.queryExtInsurance(pset);
	}
}
