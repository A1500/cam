package com.inspur.cams.fis.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.FisServicesDutyInfo;

/**
 * 殡葬服务机构人员岗位信息表domain
 * @author 
 * @date Wed May 02 09:01:05 GMT+08:00 2012
 */
public interface IFisServicesDutyInfoDomain {

	/**
	 * 查询 殡葬服务机构人员岗位信息表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 殡葬服务机构人员岗位信息表
	 * @param pset
	 * @return
	 */
	public FisServicesDutyInfo get(String dutyId);

	/**
	 * 增加 殡葬服务机构人员岗位信息表
	 * @param fisServicesDutyInfo
	 */
	@Trans
	public void insert(FisServicesDutyInfo fisServicesDutyInfo);
	
	/**
	 * 修改 殡葬服务机构人员岗位信息表
	 * @param fisServicesDutyInfo
	 */
	@Trans
	public void update(FisServicesDutyInfo fisServicesDutyInfo);
	
	/**
	 * 删除 殡葬服务机构人员岗位信息表
	 * @param dutyId
	 */
	@Trans
	public void delete(String dutyId);

}