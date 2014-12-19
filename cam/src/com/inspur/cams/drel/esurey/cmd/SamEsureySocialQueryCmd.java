package com.inspur.cams.drel.esurey.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.esurey.domain.ISamEsureySocialDomain;
/**
 * @title:SamEsureySocialQueryCommand
 * @description:人力资源与社会保障查询Command
 * @author:luguosui
 * @since:2011-06-29
 * @version:1.0
*/
public class SamEsureySocialQueryCmd extends BaseQueryCommand{
	ISamEsureySocialDomain samEsureySocialDomain = ScaComponentFactory.getService(ISamEsureySocialDomain.class,
	"SamEsureySocialDomain/SamEsureySocialDomain");
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samEsureySocialDomain.query(pset);
	}
	public DataSet queryExtSocial(){
		ParameterSet pset = getParameterSet();
		return samEsureySocialDomain.queryExtSocial(pset);
	}
}
