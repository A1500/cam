package com.inspur.cams.cdc.base.dao;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.cdc.base.data.CdcVoluntaryCaperInfo;

/**
 * 志愿者参加活动信息dao
 * @author 
 * @date 2013-02-26
 */
public interface ICdcVoluntaryCaperInfoDao extends BaseCURD<CdcVoluntaryCaperInfo> {

	/**
	 * @Description: 删除活动下的所有关系
	 * @author xuexzh
	 */
	void deleteByCaper(String caperId);

}