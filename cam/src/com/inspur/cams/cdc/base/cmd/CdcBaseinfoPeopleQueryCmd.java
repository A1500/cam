package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcBaseinfoPeopleDomain;

/**
 * 人员基础信息查询cmd
 * @author 
 * @date 2012-05-25
 */
public class CdcBaseinfoPeopleQueryCmd extends BaseQueryCommand {

	private ICdcBaseinfoPeopleDomain cdcBaseinfoPeopleDomain = ScaComponentFactory
			.getService(ICdcBaseinfoPeopleDomain.class, "cdcBaseinfoPeopleDomain/cdcBaseinfoPeopleDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcBaseinfoPeopleDomain.query(pset);
	}
	
}