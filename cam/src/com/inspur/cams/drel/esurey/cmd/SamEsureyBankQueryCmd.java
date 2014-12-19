package com.inspur.cams.drel.esurey.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.esurey.domain.ISamEsureyBankDomain;
/**
 * @title:SamEsureyBankQueryCmd
 * @description:银行查询Command
 * @author:luguosui
 * @since:2011-06-30
 * @version:1.0
*/
public class SamEsureyBankQueryCmd extends BaseQueryCommand {
	ISamEsureyBankDomain samEsureyBankDomain = ScaComponentFactory.getService(ISamEsureyBankDomain.class,
	"SamEsureyBankDomain/SamEsureyBankDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samEsureyBankDomain.query(pset);
	}
	public DataSet queryExtBank() {
		ParameterSet pset = getParameterSet();
		return samEsureyBankDomain.queryExtBank(pset);
	}
}
