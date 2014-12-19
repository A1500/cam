package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204c21DieDomain;

/**
 * 车辆查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204c21DieQueryCmd extends BaseQueryCommand {

	private ID204c21DieDomain d204c21DieDomain = ScaComponentFactory
			.getService(ID204c21DieDomain.class, "d204c21DieDomain/d204c21DieDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204c21DieDomain.query(pset);
	}
	
}