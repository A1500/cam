package com.inspur.cams.drel.samu.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.samu.dao.ISamBedInfoDao;
import com.inspur.cams.drel.samu.data.SamBedInfo;
import com.inspur.cams.drel.samu.domain.ISamBedInfoDomain;

/**
 * 床位信息domain
 * @author 
 * @date 2012-09-26
 */
public class SamBedInfoDomain implements ISamBedInfoDomain {

	@Reference
	private ISamBedInfoDao samBedInfoDao;

	/**
	 * 查询 床位信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samBedInfoDao.query(pset);
	}

	/**
	 * 获取 床位信息
	 * @param pset
	 * @return
	 */
	public SamBedInfo get(String bedId) {
		return samBedInfoDao.get(bedId);
	}

	/**
	 * 增加 床位信息
	 * @param samBedInfo
	 */
	public void insert(SamBedInfo samBedInfo) {
		samBedInfoDao.insert(samBedInfo);
	}
	
	/**
	 * 修改 床位信息
	 * @param samBedInfo
	 */
	public void update(SamBedInfo samBedInfo) {
		samBedInfoDao.update(samBedInfo);
	}
	
	/**
	 * 删除 床位信息
	 * @param bedId
	 */
	public void delete(String bedId) {
		samBedInfoDao.delete(bedId);
	}

}