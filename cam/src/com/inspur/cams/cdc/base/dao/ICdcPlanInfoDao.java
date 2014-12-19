package com.inspur.cams.cdc.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.data.CdcPlanInfo;

/**
 * 社区建设规划信息�?Dao??��??
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public interface ICdcPlanInfoDao extends BaseCURD<CdcPlanInfo> {

	DataSet queryList(ParameterSet pset);

}