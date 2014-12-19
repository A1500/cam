package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcOrganChangeDomain;

/**
 * 社区变更表查询cmd
 * @author 
 * @date 2012-04-13
 */
public class CdcOrganChangeQueryCmd extends BaseQueryCommand {

	private ICdcOrganChangeDomain cdcOrganChangeDomain = ScaComponentFactory
			.getService(ICdcOrganChangeDomain.class, "cdcOrganChangeDomain/cdcOrganChangeDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcOrganChangeDomain.query(pset);
	}
	
}