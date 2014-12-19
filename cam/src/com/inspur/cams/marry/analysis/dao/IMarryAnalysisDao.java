package com.inspur.cams.marry.analysis.dao;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

/**
 * @description:婚姻统计分析dao层接口
 */
public interface IMarryAnalysisDao {
		
	public DataSet analysisMarry(ParameterSet pset);

	public DataSet totalMarriageStatistics(ParameterSet set);
}
