package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204b14Domain;

/**
 * 转移性收入查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204b14QueryCmd extends BaseQueryCommand {

	private ID204b14Domain d204b14Domain = ScaComponentFactory
			.getService(ID204b14Domain.class, "d204b14Domain/d204b14Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204b14Domain.query(pset);
	}
	
}