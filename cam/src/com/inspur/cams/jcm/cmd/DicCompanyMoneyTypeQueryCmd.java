package com.inspur.cams.jcm.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.domain.IDicCompanyMoneyTypeDomain;

/**
 * 单位经费类别查询cmd
 * @author 
 * @date 2014-05-21
 */
public class DicCompanyMoneyTypeQueryCmd extends BaseQueryCommand {

	private IDicCompanyMoneyTypeDomain dicCompanyMoneyTypeDomain = ScaComponentFactory
			.getService(IDicCompanyMoneyTypeDomain.class, "dicCompanyMoneyTypeDomain/dicCompanyMoneyTypeDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return dicCompanyMoneyTypeDomain.query(pset);
	}
	
}