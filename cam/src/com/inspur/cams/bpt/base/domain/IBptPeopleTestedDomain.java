package com.inspur.cams.bpt.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptPeopleTested;

public interface IBptPeopleTestedDomain {
	public void insertTested(BptPeopleTested bptPeopleTested) ;
	public DataSet queryTested(ParameterSet pset) ;
	public DataSet queryPeopleTested(ParameterSet pSet);
	public void updatePeopleTeseted(BptPeopleTested bptPeopleTested);
	
	/**
	 * 查询未提交的参试人员信息
	 * @param pset
	 * @return
	 */
	public DataSet queryUnCommitTest(ParameterSet pset);
	
	public void deleteWarTest(ParameterSet pset);
	
	public DataSet queryTongJiTested(ParameterSet pset);
}
