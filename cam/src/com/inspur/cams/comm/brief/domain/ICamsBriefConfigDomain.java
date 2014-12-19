package com.inspur.cams.comm.brief.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.brief.data.CamsBriefConfig;


/**
 * 快报简报配置表domain
 * @author 
 * @date 2014-03-04
 */
public interface ICamsBriefConfigDomain {

	/**
	 * 查询 快报简报配置表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	
	public DataSet queryCount(ParameterSet pset);

	/**
	 * 获取 快报简报配置表
	 * @param pset
	 * @return
	 */
	public CamsBriefConfig get(String configId);

	/**
	 * 增加 快报简报配置表
	 * @param camsBriefConfig
	 */
	@Trans
	public void insert(CamsBriefConfig camsBriefConfig);
	
	/**
	 * 修改 快报简报配置表
	 * @param camsBriefConfig
	 */
	@Trans
	public void update(CamsBriefConfig camsBriefConfig);
	
	/**
	 * 删除 快报简报配置表
	 * @param configId
	 */
	@Trans
	public void delete(String configId);

}