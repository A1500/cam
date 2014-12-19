package com.inspur.cams.drel.esurey.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.esurey.domain.ISamEsureySecuritiesDomain;
/**
 * @title:SamEsureySecuritiesQueryCmd
 * @description:证监查询Command
 * @author:luguosui
 * @since:2011-06-30
 * @version:1.0
*/
public class SamEsureySecuritiesQueryCmd extends BaseQueryCommand {
	ISamEsureySecuritiesDomain samEsureySecuritiesDomain = ScaComponentFactory.getService(ISamEsureySecuritiesDomain.class,
	"SamEsureySecuritiesDomain/SamEsureySecuritiesDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samEsureySecuritiesDomain.query(pset);
	}
	public DataSet queryExtSecurities() {
		ParameterSet pset = getParameterSet();
		return samEsureySecuritiesDomain.queryExtSecurities(pset);
	}
}
