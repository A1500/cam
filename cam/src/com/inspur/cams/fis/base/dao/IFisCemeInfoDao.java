package com.inspur.cams.fis.base.dao;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.fis.base.data.FisCemeInfo;

/**
 * 殡葬业务公墓信息表dao
 * @author 
 * @date 2013-08-01
 */
public interface IFisCemeInfoDao extends BaseCURD<FisCemeInfo> {
	/**
	 * 修改公墓状态
	 * @param organState
	 * @param recordId
	 * */
	public void setOrganState(String organState, String recordId);
}