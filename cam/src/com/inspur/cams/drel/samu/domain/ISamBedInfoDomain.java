package com.inspur.cams.drel.samu.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.samu.data.SamBedInfo;

/**
 * 床位信息domain
 * @author 
 * @date 2012-09-26
 */
public interface ISamBedInfoDomain {

	/**
	 * 查询 床位信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 床位信息
	 * @param pset
	 * @return
	 */
	public SamBedInfo get(String bedId);

	/**
	 * 增加 床位信息
	 * @param samBedInfo
	 */
	@Trans
	public void insert(SamBedInfo samBedInfo);
	
	/**
	 * 修改 床位信息
	 * @param samBedInfo
	 */
	@Trans
	public void update(SamBedInfo samBedInfo);
	
	/**
	 * 删除 床位信息
	 * @param bedId
	 */
	@Trans
	public void delete(String bedId);

}