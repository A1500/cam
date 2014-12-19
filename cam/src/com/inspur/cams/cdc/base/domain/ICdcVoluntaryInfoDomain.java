package com.inspur.cams.cdc.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcVoluntaryInfo;

/**
 * 志愿者信息domain
 * @author 
 * @date 2013-02-26
 */
public interface ICdcVoluntaryInfoDomain {

	/**
	 * 查询 志愿者信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 志愿者信息
	 * @param pset
	 * @return
	 */
	public CdcVoluntaryInfo get(String voluntaryId);

	/**
	 * 增加 志愿者信息
	 * @param cdcVoluntaryInfo
	 */
	@Trans
	public void insert(CdcVoluntaryInfo cdcVoluntaryInfo);
	
	/**
	 * 修改 志愿者信息
	 * @param cdcVoluntaryInfo
	 */
	@Trans
	public void update(CdcVoluntaryInfo cdcVoluntaryInfo);
	
	/**
	 * 删除 志愿者信息
	 * @param voluntaryId
	 */
	@Trans
	public void delete(String voluntaryId);

	/**
	 * 更新 志愿者信息参加活动次数
	 */
	@Trans
	public void updateCaperTimes(List<CdcVoluntaryInfo> cdcVoluntaryInfoList, int i);

	/**
	 * @Description: 根据活动编码获取志愿者信息
	 * @author xuexzh
	 */
	public DataSet queryByCaper(ParameterSet pset);

}