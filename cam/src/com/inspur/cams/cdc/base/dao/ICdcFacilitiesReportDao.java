package com.inspur.cams.cdc.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.data.CdcFacilitiesReport;

/**
 * 社区建设基础设施统计�?Dao??��??
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public interface ICdcFacilitiesReportDao extends BaseCURD<CdcFacilitiesReport> {

	DataSet queryList(ParameterSet pset);

}