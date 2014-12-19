package com.inspur.cams.drel.esurey.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.esurey.domain.ISamEsureyFamilySumDomain;
/**
 * @title:SamEsureyFamilySumQueryCmd
 * @description:经济核对_家庭经济状况审核汇总查询Command
 * @author:luguosui
 * @since:2011-06-30
 * @version:1.0
*/
public class SamEsureyFamilySumQueryCmd extends BaseQueryCommand {
	ISamEsureyFamilySumDomain samEsureyFamilySumDomain = ScaComponentFactory.getService(ISamEsureyFamilySumDomain.class,
	"SamEsureyFamilySumDomain/SamEsureyFamilySumDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samEsureyFamilySumDomain.query(pset);
	}
}
