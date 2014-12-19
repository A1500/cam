package com.inspur.cams.marry.analysis.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.marry.analysis.domain.IMarryAnalysisDomain;
import com.inspur.cams.marry.analysis.dao.IMarryAnalysisDao;


/**
 * @description:婚姻统计分析domain层
 */
public class MarryAnalysisDomain implements IMarryAnalysisDomain{

	@Reference
	private IMarryAnalysisDao marryAnalysisDao;

	/**
	 * 婚姻统计分析
	 * @param pset
	 * @return
	 */
	public DataSet analysisMarry(ParameterSet pSet){
		return marryAnalysisDao.analysisMarry(pSet);
	}

	public DataSet totalMarriageStatistics(ParameterSet set) {
		return marryAnalysisDao.totalMarriageStatistics(set);
	}
	
}
