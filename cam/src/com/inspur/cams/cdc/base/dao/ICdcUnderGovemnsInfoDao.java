package com.inspur.cams.cdc.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.data.CdcUnderGovemnsInfo;

/**
 * @title:ICdcUnderGovemnsInfoDao
 * @description:
 * @author:
 * @since:2013-03-15
 * @version:1.0
*/
 public interface ICdcUnderGovemnsInfoDao extends BaseCURD<CdcUnderGovemnsInfo>{

	/**
	 * 获取某下辖村历史选举信息
	 * @param userId
	 * @return
	 */
	String getSelections(String userId);
	
	//查询下辖村
	public DataSet queryUnder(ParameterSet pset);

 }

