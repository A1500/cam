package com.inspur.cams.cdc.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcPeopleInfoDao;
import com.inspur.cams.cdc.base.data.CdcPeopleInfo;
import com.inspur.cams.cdc.base.domain.ICdcPeopleInfoDomain;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 基础信息两委成员与工作者信息表domain
 * @author 
 * @date 2012-05-25
 */
public class CdcPeopleInfoDomain implements ICdcPeopleInfoDomain {

	@Reference
	private ICdcPeopleInfoDao cdcPeopleInfoDao;

	/**
	 * 查询 基础信息两委成员与工作者信息表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcPeopleInfoDao.query(pset);
	}

	/**
	 * 获取 基础信息两委成员与工作者信息表
	 * @param pset
	 * @return
	 */
	public CdcPeopleInfo get(String peopleId) {
		return cdcPeopleInfoDao.get(peopleId);
	}

	/**
	 * 增加 基础信息两委成员与工作者信息表
	 * @param cdcPeopleInfo
	 */
	public void insert(CdcPeopleInfo cdcPeopleInfo) {
		cdcPeopleInfo.setPeopleId(IdHelp.getUUID32());
		cdcPeopleInfoDao.insert(cdcPeopleInfo);
	}
	
	/**
	 * 修改 基础信息两委成员与工作者信息表
	 * @param cdcPeopleInfo
	 */
	public void update(CdcPeopleInfo cdcPeopleInfo) {
		cdcPeopleInfoDao.update(cdcPeopleInfo);
	}
	
	/**
	 * 删除 基础信息两委成员与工作者信息表
	 * @param 
	 */

	public void delete(String peopleId) {
		cdcPeopleInfoDao.delete(peopleId);
	}

	/**
	 * 查询届期
	 */
	public DataSet getSeasons(ParameterSet pset) {
		return cdcPeopleInfoDao.getSeasons(pset);
	}

}