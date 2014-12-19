package com.inspur.cams.cdc.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcOrganInfoDao;
import com.inspur.cams.cdc.base.data.CdcOrganInfo;
import com.inspur.cams.cdc.base.domain.ICdcOrganInfoDomain;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 基础信息社区单位组织信息表domain实现类
 * @author shgtch
 * @date 2012-1-4
 */
public class CdcOrganInfoDomain implements ICdcOrganInfoDomain {

	@Reference
	private ICdcOrganInfoDao cdcOrganInfoDao;

	/**
	 * 查询基础信息社区单位组织信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcOrganInfoDao.query(pset);
	}

	/**
	 * 增加基础信息社区单位组织信息
	 * @param cdcOrganInfo
	 */
	public void insert(CdcOrganInfo cdcOrganInfo) {
		cdcOrganInfo.setOrganId(IdHelp.getUUID32());
		cdcOrganInfoDao.insert(cdcOrganInfo);
	}
	
	/**
	 * 修改基础信息社区单位组织信息
	 * @param cdcOrganInfo
	 */
	public void update(CdcOrganInfo cdcOrganInfo) {
		cdcOrganInfoDao.update(cdcOrganInfo);
	}
	
	/**
	 * 删除基础信息社区单位组织信息
	 * @param organId
	 */
	public void delete(String organId) {
		cdcOrganInfoDao.delete(organId);
	}

}