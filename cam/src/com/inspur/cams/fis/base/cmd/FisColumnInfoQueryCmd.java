package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IFisColumnInfoDomain;

/**
 * 页面列描述查询cmd
 * @author 
 * @date 2012-07-16
 */
public class FisColumnInfoQueryCmd extends BaseQueryCommand {

	private IFisColumnInfoDomain fisColumnInfoDomain = ScaComponentFactory
			.getService(IFisColumnInfoDomain.class, "fisColumnInfoDomain/fisColumnInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return fisColumnInfoDomain.query(pset);
	}
	
}