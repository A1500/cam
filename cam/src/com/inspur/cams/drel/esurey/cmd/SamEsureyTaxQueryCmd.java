package com.inspur.cams.drel.esurey.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.esurey.domain.ISamEsureyTaxDomain;
/**
 * @title:SamEsureyTaxQueryCmd
 * @description:国税查询Command
 * @author:luguosui
 * @since:2011-06-30
 * @version:1.0
*/
public class SamEsureyTaxQueryCmd extends BaseQueryCommand {
	ISamEsureyTaxDomain samEsureyTaxDomain = ScaComponentFactory.getService(ISamEsureyTaxDomain.class,
	"SamEsureyTaxDomain/SamEsureyTaxDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samEsureyTaxDomain.query(pset);
	}
	//国税查询
	public DataSet queryGExtTax() {
		ParameterSet pset = getParameterSet();
		return samEsureyTaxDomain.queryGExtTax(pset);
	}
	//地税查询
	public DataSet queryDExtTax() {
		ParameterSet pset = getParameterSet();
		return samEsureyTaxDomain.queryDExtTax(pset);
	}
}
