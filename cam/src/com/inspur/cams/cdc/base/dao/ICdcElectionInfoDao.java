package com.inspur.cams.cdc.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.data.CdcElectionInfo;

/**
 * 民主选举选举信息�?Dao??��??
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public interface ICdcElectionInfoDao extends BaseCURD<CdcElectionInfo> {

	DataSet queryCompletionSum(ParameterSet pset);

	DataSet querySumCompletion(ParameterSet pset);

}