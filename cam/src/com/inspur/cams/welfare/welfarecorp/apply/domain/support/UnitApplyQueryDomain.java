package com.inspur.cams.welfare.welfarecorp.apply.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.welfare.base.domain.IWealUnitApplyDomain;
import com.inspur.cams.welfare.base.domain.IWealUnitStatusDomain;
import com.inspur.cams.welfare.welfarecorp.apply.domain.IUnitApplyQueryDomain;

/**
 * 社会福利企业资格认定
 * 
 * @author liuxin
 * @date 2013-06-08
 */
public class UnitApplyQueryDomain implements IUnitApplyQueryDomain {
	@Reference
	private IWealUnitApplyDomain wealUnitApplysDomain;
	@Reference
	private IWealUnitStatusDomain wealUnitStatusDomain;

	// 查询信息采集任务列表
	public DataSet queryQualificationList(ParameterSet pset) {
		return wealUnitApplysDomain.queryQualificationList(pset);
	}

	// 查询信息采集任务列表
	public DataSet queryQualificationPrintList(ParameterSet pset) {
		return wealUnitApplysDomain.queryQualificationPrintList(pset);
	}

	public DataSet queryCheck(ParameterSet pset) {
		return wealUnitApplysDomain.queryCheck(pset);
	}

	// 查询信息采集状态列表
	public DataSet queryUnitStatusList(ParameterSet pset) {
		return wealUnitStatusDomain.query(pset);
	}

}
