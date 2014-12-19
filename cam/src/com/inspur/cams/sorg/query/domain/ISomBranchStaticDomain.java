package com.inspur.cams.sorg.query.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

public interface ISomBranchStaticDomain {
	/**
	 * 社团分支统计
	 * 
	 * @return
	 */
	public DataSet groupBranchStatic(ParameterSet pset);
}
