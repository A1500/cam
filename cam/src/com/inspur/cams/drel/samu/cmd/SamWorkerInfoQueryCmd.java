package com.inspur.cams.drel.samu.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.samu.domain.ISamWorkerInfoDomain;

/**
 * 工作人员信息查询cmd
 * @author 
 * @date 2012-09-26
 */
public class SamWorkerInfoQueryCmd extends BaseQueryCommand {

	private ISamWorkerInfoDomain samWorkerInfoDomain = ScaComponentFactory
			.getService(ISamWorkerInfoDomain.class, "samWorkerInfoDomain/samWorkerInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samWorkerInfoDomain.query(pset);
	}
	//统计-敬老院工作员工
	public DataSet reportWorkerInfo(){
		ParameterSet pset=getParameterSet();
		return samWorkerInfoDomain.reportWorkerInfo(pset);
	}
}