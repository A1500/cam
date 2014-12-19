package com.inspur.cams.welfare.welfarecorp.apply.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.welfare.welfarecorp.apply.domain.IUnitApplyQueryDomain;

/**
 * 社会福利企业资格认定
 * 
 * @author liuxin
 * @date 2013-06-08
 */
public class UnitApplyQueryCmd extends BaseQueryCommand {
	private IUnitApplyQueryDomain unitApplyQueryDomain = ScaComponentFactory
			.getService(IUnitApplyQueryDomain.class,
					"unitApplyQueryDomain/unitApplyQueryDomain");

	// 查询信息采集列表
	public DataSet queryQualificationList() {
		ParameterSet pset = getParameterSet();
		return unitApplyQueryDomain.queryQualificationList(pset);
	}

	// 查询认定信息采集任务列表
	public DataSet queryQualificationPrintList() {
		ParameterSet pset = getParameterSet();
		return unitApplyQueryDomain.queryQualificationPrintList(pset);
	}
	//查询年检信息
	public DataSet queryCheck() {
		ParameterSet pset = getParameterSet();
		return unitApplyQueryDomain.queryCheck(pset);
	}
}
