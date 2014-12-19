package com.inspur.cams.sorg.query.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.sorg.base.data.SomOrgan;

public interface ISomBranchStaticDao extends BaseCURD<SomOrgan> {

	/**
	 * 社团分支统计
	 * 
	 * @return
	 */
	public DataSet groupBranchStatic(ParameterSet pset);
}
