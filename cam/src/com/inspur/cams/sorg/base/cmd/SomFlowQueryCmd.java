package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.domain.ISomFlowDomain;

/**
 * 业务流程历史意见信息查询cmd
 * @author shgtch
 * @date 2011-8-12
 */
public class SomFlowQueryCmd extends BaseQueryCommand {

	ISomFlowDomain somFlowDomain = ScaComponentFactory.getService(ISomFlowDomain.class, "SomFlowDomain/SomFlowDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return somFlowDomain.query(pset);
	}

}