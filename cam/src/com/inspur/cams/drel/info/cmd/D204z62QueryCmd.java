package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204z62Domain;


/**
 * 殡葬信息查询cmd
 * @author 
 * @date 2014-08-21
 */
public class D204z62QueryCmd extends BaseQueryCommand {

	private ID204z62Domain d204z62Domain = ScaComponentFactory
			.getService(ID204z62Domain.class, "d204z62Domain/d204z62Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204z62Domain.query(pset);
	}
	public DataSet queryBinzang(){
		ParameterSet pset = getParameterSet();
		return d204z62Domain.queryBinzang(pset);
		
	}
	
}