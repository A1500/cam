package com.inspur.cams.welfare.prosthesis.apply.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.welfare.prosthesis.apply.domain.IFitApplyQueryDomain;

public class FitApplyQueryCmd extends BaseQueryCommand{
	private IFitApplyQueryDomain fitApplyQueryDomain = ScaComponentFactory
	.getService(IFitApplyQueryDomain.class, "fitApplyQueryDomain/fitApplyQueryDomain");
	//查询认定信息采集任务列表
	public DataSet queryQualificationList(){
		ParameterSet pset = getParameterSet();
		return fitApplyQueryDomain.queryQualificationList(pset);
	}
	//查询认定信息采集任务列表
	public DataSet queryQualificationPrintList(){
		ParameterSet pset = getParameterSet();
		return fitApplyQueryDomain.queryQualificationPrintList(pset);
	}
	
}
