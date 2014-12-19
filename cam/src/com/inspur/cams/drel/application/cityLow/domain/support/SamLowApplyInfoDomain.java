package com.inspur.cams.drel.application.cityLow.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.application.cityLow.dao.ISamLowApplyInfoDao;
import com.inspur.cams.drel.application.cityLow.data.SamLowApplyInfo;
import com.inspur.cams.drel.application.cityLow.domain.ISamLowApplyInfoDomain;

/**
 * 低收入家庭认定业务表domain
 * @author 
 * @date 2014-03-11
 */
public class SamLowApplyInfoDomain implements ISamLowApplyInfoDomain {

	@Reference
	private ISamLowApplyInfoDao samLowApplyInfoDao;

	/**
	 * 查询 低收入家庭认定业务表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samLowApplyInfoDao.query(pset);
	}

	/**
	 * 获取 低收入家庭认定业务表
	 * @param pset
	 * @return
	 */
	public SamLowApplyInfo get(String lowApplyId) {
		return samLowApplyInfoDao.get(lowApplyId);
	}

	/**
	 * 增加 低收入家庭认定业务表
	 * @param samLowApplyInfo
	 */
	public void insert(SamLowApplyInfo samLowApplyInfo) {
		samLowApplyInfoDao.insert(samLowApplyInfo);
	}
	
	/**
	 * 修改 低收入家庭认定业务表
	 * @param samLowApplyInfo
	 */
	public void update(SamLowApplyInfo samLowApplyInfo) {
		samLowApplyInfoDao.update(samLowApplyInfo);
	}
	
	/**
	 * 删除 低收入家庭认定业务表
	 * @param lowApplyId
	 */
	public void delete(String lowApplyId) {
		samLowApplyInfoDao.delete(lowApplyId);
	}

}