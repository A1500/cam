package com.inspur.cams.fis.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.FisCemeInfo;

/**
 * 殡葬业务公墓信息表domain
 * @author 
 * @date 2013-08-01
 */
public interface IFisCemeInfoDomain {

	/**
	 * 查询 殡葬业务公墓信息表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 殡葬业务公墓信息表
	 * @param pset
	 * @return
	 */
	public FisCemeInfo get(String recordId);

	/**
	 * 增加 殡葬业务公墓信息表
	 * @param fisCemeInfo
	 */
	@Trans
	public void insert(FisCemeInfo fisCemeInfo);
	
	/**
	 * 修改 殡葬业务公墓信息表
	 * @param fisCemeInfo
	 */
	@Trans
	public void update(FisCemeInfo fisCemeInfo);
	
	/**
	 * 删除 殡葬业务公墓信息表
	 * @param recordId
	 */
	@Trans
	public void delete(String recordId);
	
	
	/**
	 * 修改公墓状态
	 * @param organState
	 * @param recordId
	 * */
	@Trans
	public void setOrganState(String organState,String recordId);

}