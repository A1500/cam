package com.inspur.cams.welfare.welfarecorp.apply.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

/**
 * 社会福利企业资格认定
 * 
 * @author liuxin
 * @date 2013-06-08
 */
public interface IUnitApplyQueryDomain {
	public DataSet queryQualificationList(ParameterSet pset);

	public DataSet queryQualificationPrintList(ParameterSet pset);

	public DataSet queryCheck(ParameterSet pset);
}
