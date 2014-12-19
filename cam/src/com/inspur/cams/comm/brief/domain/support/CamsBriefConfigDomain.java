package com.inspur.cams.comm.brief.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.brief.dao.ICamsBriefConfigDao;
import com.inspur.cams.comm.brief.data.CamsBriefConfig;
import com.inspur.cams.comm.brief.domain.ICamsBriefConfigDomain;

/**
 * 快报简报配置表domain
 * @author 
 * @date 2014-03-04
 */
public class CamsBriefConfigDomain implements ICamsBriefConfigDomain {

	@Reference
	private ICamsBriefConfigDao camsBriefConfigDao;
	/**
	 * 查询 快报简报配置表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return camsBriefConfigDao.query(pset);
	}

	public DataSet queryCount(ParameterSet pset) {
		return camsBriefConfigDao.queryCount(pset);
	}
	/**
	 * 获取 快报简报配置表
	 * @param pset
	 * @return
	 */
	public CamsBriefConfig get(String configId) {
		return camsBriefConfigDao.get(configId);
	}

	/**
	 * 增加 快报简报配置表
	 * @param camsBriefConfig
	 */
	public void insert(CamsBriefConfig camsBriefConfig) {
		camsBriefConfigDao.insert(camsBriefConfig);
	}
	
	/**
	 * 修改 快报简报配置表
	 * @param camsBriefConfig
	 */
	public void update(CamsBriefConfig camsBriefConfig) {
		camsBriefConfigDao.update(camsBriefConfig);
	}
	
	/**
	 * 删除 快报简报配置表
	 * @param configId
	 */
	public void delete(String configId) {
		camsBriefConfigDao.delete(configId);
		
	}

}