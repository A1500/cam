package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcPeopleInfo;

/**
 * 基础信息两委成员与工作者信息表domain
 * @author 
 * @date 2012-05-25
 */
public interface ICdcPeopleInfoDomain {

	/**
	 * 查询 基础信息两委成员与工作者信息表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 基础信息两委成员与工作者信息表
	 * @param pset
	 * @return
	 */
	public CdcPeopleInfo get(String peopleId);

	/**
	 * 增加 基础信息两委成员与工作者信息表
	 * @param cdcPeopleInfo
	 */
	@Trans
	public void insert(CdcPeopleInfo cdcPeopleInfo);
	
	/**
	 * 修改 基础信息两委成员与工作者信息表
	 * @param cdcPeopleInfo
	 */
	@Trans
	public void update(CdcPeopleInfo cdcPeopleInfo);
	
	/**
	 * 删除 基础信息两委成员与工作者信息表
	 * @param peopleId 
	 * @param 
	 */
	@Trans
	public void delete(String peopleId);

	/**
	 * 查询届期
	 * @param pset
	 * @return
	 */
	public DataSet getSeasons(ParameterSet pset);

}