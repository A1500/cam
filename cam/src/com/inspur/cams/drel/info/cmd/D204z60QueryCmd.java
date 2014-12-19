package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204z60Domain;

/**
 * 第三方支付信息查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204z60QueryCmd extends BaseQueryCommand {

	private ID204z60Domain d204z60Domain = ScaComponentFactory
			.getService(ID204z60Domain.class, "d204z60Domain/d204z60Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204z60Domain.query(pset);
	}
	
}