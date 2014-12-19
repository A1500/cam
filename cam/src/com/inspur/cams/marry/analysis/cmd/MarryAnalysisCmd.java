package com.inspur.cams.marry.analysis.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.marry.analysis.domain.IMarryAnalysisDomain;

/**
 * @description:婚姻统计分析
 */
public class MarryAnalysisCmd extends BaseQueryCommand{
	//获得marryAnalysisDomain接口
	private IMarryAnalysisDomain marryAnalysisDomain = ScaComponentFactory.getService(IMarryAnalysisDomain.class,"marryAnalysisDomain/marryAnalysisDomain");
	
	public DataSet analysisMarry() {
		ParameterSet pSet = getParameterSet();
		return marryAnalysisDomain.analysisMarry(pSet);
	}
	public DataSet totalMarriageStatistics() {
		ParameterSet pSet = getParameterSet();
		return marryAnalysisDomain.totalMarriageStatistics(pSet);
	}
}
