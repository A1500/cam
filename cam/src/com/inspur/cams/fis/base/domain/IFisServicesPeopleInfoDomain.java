package com.inspur.cams.fis.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.FisServicesPeopleInfo;

/**
 * 殡葬服务机构工作人员信息表domain
 * @author 
 * @date Wed May 02 09:01:05 GMT+08:00 2012
 */
public interface IFisServicesPeopleInfoDomain {

	/**
	 * 查询 殡葬服务机构工作人员信息表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 殡葬服务机构工作人员信息表
	 * @param pset
	 * @return
	 */
	public FisServicesPeopleInfo get(String peopleId);

	/**
	 * 增加 殡葬服务机构工作人员信息表
	 * @param fisServicesPeopleInfo
	 */
	@Trans
	public void insert(FisServicesPeopleInfo fisServicesPeopleInfo);
	
	/**
	 * 修改 殡葬服务机构工作人员信息表
	 * @param fisServicesPeopleInfo
	 */
	@Trans
	public void update(FisServicesPeopleInfo fisServicesPeopleInfo);
	
	/**
	 * 删除 殡葬服务机构工作人员信息表
	 * @param peopleId
	 */
	@Trans
	public void delete(String peopleId);

	/**
	 * @Title: queryForPeopleRecords 
	 * @Description: TODO(查询服务机构人员信息) 
	 * @author wangziming
	 */
	public DataSet queryForPeopleRecords(ParameterSet pset);

}