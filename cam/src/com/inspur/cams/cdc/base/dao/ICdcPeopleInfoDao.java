package com.inspur.cams.cdc.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.data.CdcPeopleInfo;

/**
 * 基础信息两委成员与工作者信息表dao
 * @author 
 * @date 2012-05-25
 */
public interface ICdcPeopleInfoDao extends BaseCURD<CdcPeopleInfo> {

	/**
	 * 查询 选举届期
	 * @param pset
	 * @return
	 */
	DataSet getSeasons(ParameterSet pset);

}