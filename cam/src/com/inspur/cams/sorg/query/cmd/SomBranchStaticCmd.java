package com.inspur.cams.sorg.query.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.query.domain.ISomBranchStaticDomain;

public class SomBranchStaticCmd extends BaseQueryCommand {
	private ISomBranchStaticDomain service = ScaComponentFactory.getService(ISomBranchStaticDomain.class,"somBranchStaticDomain/somBranchStaticDomain");

	/**
	 * 社团分支统计
	 * 
	 * @return
	 */
	public DataSet groupBranchStatic() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.groupBranchStatic(pset);
		return ds;
	}
}
