package com.inspur.cams.fis.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.FisServicesOrganManage;

/**
 * 殡葬服务机构信息表domain
 * @author 
 * @date Wed May 02 09:01:05 GMT+08:00 2012
 */
public interface IFisServicesOrganManageDomain {

	/**
	 * 查询 殡葬服务机构信息表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 殡葬服务机构信息表
	 * @param pset
	 * @return
	 */
	public FisServicesOrganManage get(String recordId);

	/**
	 * 增加 殡葬服务机构信息表
	 * @param fisServicesOrganManage
	 */
	@Trans
	public void insert(FisServicesOrganManage fisServicesOrganManage);
	
	/**
	 * 修改 殡葬服务机构信息表
	 * @param fisServicesOrganManage
	 */
	@Trans
	public void update(FisServicesOrganManage fisServicesOrganManage);
	
	/**
	 * 删除 殡葬服务机构信息表
	 * @param recordId
	 */
	@Trans
	public void delete(String recordId);

}