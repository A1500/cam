package com.inspur.cams.marry.analysis.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

/**
 * @description:婚姻统计分析domain层接口
 */
public interface IMarryAnalysisDomain {
	
	/**
	 * 查询 婚姻统计分析
	 * @param pset
	 * @return
	 */
	public DataSet analysisMarry(ParameterSet pset);

	/**
	 * 查询最近六个月 结婚、离婚总量
	 * @param set
	 * @return
	 */
	public DataSet totalMarriageStatistics(ParameterSet set);
	
}
