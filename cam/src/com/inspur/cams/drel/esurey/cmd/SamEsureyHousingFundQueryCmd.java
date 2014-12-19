package com.inspur.cams.drel.esurey.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.esurey.domain.ISamEsureyHousingFundDomain;
/**
 * @title:SamEsureyHousingFundQueryCmd
 * @description:公积金查询Command
 * @author:luguosui
 * @since:2011-06-30
 * @version:1.0
*/
public class SamEsureyHousingFundQueryCmd extends BaseQueryCommand {
	ISamEsureyHousingFundDomain samEsureyHousingFundDomain = ScaComponentFactory.getService(ISamEsureyHousingFundDomain.class,
	"SamEsureyHousingFundDomain/SamEsureyHousingFundDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samEsureyHousingFundDomain.query(pset);
	}
	public DataSet queryExtHousingFund() {
		ParameterSet pset = getParameterSet();
		return samEsureyHousingFundDomain.queryExtHousingFund(pset);
	}
}
