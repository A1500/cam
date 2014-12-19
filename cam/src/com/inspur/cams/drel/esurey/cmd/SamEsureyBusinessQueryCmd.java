package com.inspur.cams.drel.esurey.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.esurey.domain.ISamEsureyBusinessDomain;
/**
 * @title:SamEsureyBusinessQueryCmd
 * @description:工商查询Command
 * @author:luguosui
 * @since:2011-06-30
 * @version:1.0
*/
public class SamEsureyBusinessQueryCmd extends BaseQueryCommand {
	ISamEsureyBusinessDomain samEsureyBusinessDomain = ScaComponentFactory.getService(ISamEsureyBusinessDomain.class,
	"SamEsureyBusinessDomain/SamEsureyBusinessDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samEsureyBusinessDomain.query(pset);
	}
	public DataSet queryExtBusiness() {
		ParameterSet pset = getParameterSet();
		return samEsureyBusinessDomain.queryExtBusiness(pset);
	}
}
