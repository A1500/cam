package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204c22Domain;

/**
 * 房产查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204c22QueryCmd extends BaseQueryCommand {

	private ID204c22Domain d204c22Domain = ScaComponentFactory
			.getService(ID204c22Domain.class, "d204c22Domain/d204c22Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204c22Domain.query(pset);
	}
	
	public DataSet queryHouse() {
		ParameterSet pset = getParameterSet();
		return d204c22Domain.queryHouse(pset);
	}
	public DataSet queryFangguan() {
		ParameterSet pset = getParameterSet();
		return d204c22Domain.queryFangguan(pset);
	}
	
}