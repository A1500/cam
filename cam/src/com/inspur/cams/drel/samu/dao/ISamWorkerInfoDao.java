package com.inspur.cams.drel.samu.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.samu.data.SamWorkerInfo;

/**
 * 工作人员信息dao
 * @author 
 * @date 2012-09-26
 */
public interface ISamWorkerInfoDao extends BaseCURD<SamWorkerInfo> {
	//统计-敬老院工作员工
	public DataSet reportWorkerInfo(ParameterSet pset);
}