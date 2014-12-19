package com.inspur.cams.cdc.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.data.CdcVoluntaryInfo;

/**
 * 志愿者信息dao
 * @author 
 * @date 2013-02-26
 */
public interface ICdcVoluntaryInfoDao extends BaseCURD<CdcVoluntaryInfo> {
	/**
	 * 更新 志愿者信息参加活动次数
	 */
	void updateCaperTimes(List<CdcVoluntaryInfo> cdcVoluntaryInfoList, int i);

	/**
	 * @Description: 根据活动编码获取志愿者信息
	 * @author xuexzh
	 */
	DataSet queryByCaper(ParameterSet pset);

}