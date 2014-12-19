package com.inspur.cams.bpt.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;


import com.inspur.cams.bpt.base.data.Demobilizedflow;

public interface IBptApplyDemobilizedDomain {

	/**
	 * 添加在乡复员
	 */
	public void insert(Demobilizedflow demobilizedflowDevices);
	
	/**
	 * 更新在乡复员
	 */
	public void update(Demobilizedflow demobilizedflowDevices);
	
	/**
	 * 查询在乡复员
	 */
	public DataSet query(ParameterSet pset);

	

	/**
	 * 查询在乡复员申请表
	 */
	
	public DataSet queryDemobilized(ParameterSet pset);

	public String getProcessId(String assignmentId);

	public void updateExchaCertiDemo(Demobilizedflow dateBean);
	
	public void deleteDemobilized (ParameterSet pset);
	public void deleteDemobilizedIll (ParameterSet pset);
}
