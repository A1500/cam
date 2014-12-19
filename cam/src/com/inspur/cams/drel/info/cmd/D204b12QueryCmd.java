package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.domain.ID204b12Domain;

/**
 * 经营性收入查询cmd
 * @author 
 * @date 2014-06-09
 */
public class D204b12QueryCmd extends BaseQueryCommand {

	private ID204b12Domain d204b12Domain = ScaComponentFactory
			.getService(ID204b12Domain.class, "d204b12Domain/d204b12Domain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return d204b12Domain.query(pset);
	}
	public DataSet queryGongshang(){
		
		ParameterSet pset = getParameterSet();

		return d204b12Domain.queryGongshang(pset);
		
		
	}
	
}