package com.inspur.cams.cdc.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcVoluntaryCaperInfo;

/**
 * 志愿者参加活动信息domain
 * @author 
 * @date 2013-02-26
 */
public interface ICdcVoluntaryCaperInfoDomain {

	/**
	 * 查询 志愿者参加活动信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 志愿者参加活动信息
	 * @param pset
	 * @return
	 */
	public CdcVoluntaryCaperInfo get(String recordId);

	/**
	 * 增加 志愿者参加活动信息
	 * @param cdcVoluntaryCaperInfo
	 */
	@Trans
	public void insert(CdcVoluntaryCaperInfo cdcVoluntaryCaperInfo);
	
	/**
	 * 修改 志愿者参加活动信息
	 * @param cdcVoluntaryCaperInfo
	 */
	@Trans
	public void update(CdcVoluntaryCaperInfo cdcVoluntaryCaperInfo);
	
	/**
	 * 删除 志愿者参加活动信息
	 * @param recordId
	 */
	@Trans
	public void delete(String recordId);
	@Trans
	public void batchInsert(List<CdcVoluntaryCaperInfo> cdcVoluntaryCaperInfoList);
	@Trans
	public void batchUpdate(List<CdcVoluntaryCaperInfo> cdcVoluntaryCaperInfoList);
	@Trans
	public void save(List<CdcVoluntaryCaperInfo> cdcVoluntaryCaperInfoList);
	/**
	 * @Description: 删除活动下的所有关系
	 * @author xuexzh
	 */
	@Trans
	public void deleteByCaper(String caperId);
}