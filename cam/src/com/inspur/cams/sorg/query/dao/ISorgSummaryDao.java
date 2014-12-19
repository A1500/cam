package com.inspur.cams.sorg.query.dao;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

public interface ISorgSummaryDao {
	/**
	 * 决策分析——社会组织数量统计表
	 * @param pset
	 * @return
	 */
	public DataSet querySorgNum(ParameterSet pset);
}
