package com.inspur.cams.sorg.query.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

public interface ISomEntityStaticDomain {
	/**
	 * 社团举办实体统计
	 * 
	 * @return
	 */
	public DataSet groupEntityStatic(ParameterSet pset);
}
