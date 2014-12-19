package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204c21Domain;

/**
 * 车辆查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204c21QueryCmd extends BaseQueryCommand {

	private ID204c21Domain d204c21Domain = ScaComponentFactory
			.getService(ID204c21Domain.class, "d204c21Domain/d204c21Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204c21Domain.query(pset);
	}
	/**
	 * 查询车辆信息
	 * @return
	 */
	public DataSet queryCheliang(){
		ParameterSet pset = getParameterSet();
		return d204c21Domain.queryCheliang(pset);
	}
	
}