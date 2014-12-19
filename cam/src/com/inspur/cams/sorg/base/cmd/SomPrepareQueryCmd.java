package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.domain.ISomPrepareDomain;

/**
 * 社会组织筹备信息查询cmd
 * @author shgtch
 * @date 2011-8-12
 */
public class SomPrepareQueryCmd extends BaseQueryCommand {
	
	ISomPrepareDomain somPrepareDomain = ScaComponentFactory.getService(ISomPrepareDomain.class, "somPrepareDomain/somPrepareDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return somPrepareDomain.query(pset);
	}
}