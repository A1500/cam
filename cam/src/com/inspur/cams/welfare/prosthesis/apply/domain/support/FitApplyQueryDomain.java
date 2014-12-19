package com.inspur.cams.welfare.prosthesis.apply.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.welfare.base.domain.IWealFitApplyDomain;
import com.inspur.cams.welfare.base.domain.IWealFitStatusDomain;


public class FitApplyQueryDomain {
	@Reference
	private IWealFitApplyDomain wealFitApplysDomain;
	@Reference
	private IWealFitStatusDomain wealFitStatusDomain;
	//查询认定信息采集任务列表
	public DataSet queryQualificationList(ParameterSet pset){
		return wealFitApplysDomain.queryQualificationList(pset);
	}
	//查询认定信息采集任务列表
	public DataSet queryQualificationPrintList(ParameterSet pset){
		return wealFitApplysDomain.queryQualificationPrintList(pset);
	}
	//查询状态表信息
	public DataSet queryFitStatusList(ParameterSet pset){
		return wealFitStatusDomain.query(pset);
	}
}
