package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204z63Domain;


/**
 * 婚姻信息查询cmd
 * @author 
 * @date 2014-08-21
 */
public class D204z63QueryCmd extends BaseQueryCommand {

	private ID204z63Domain d204z63Domain = ScaComponentFactory
			.getService(ID204z63Domain.class, "d204z63Domain/d204z63Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204z63Domain.query(pset);
	}
	public DataSet queryMarry(){
		ParameterSet pset = getParameterSet();
		return d204z63Domain.queryMarry(pset);
		
		
	}
	
}