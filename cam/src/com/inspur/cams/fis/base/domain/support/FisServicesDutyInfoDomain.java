package com.inspur.cams.fis.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.fis.base.dao.IFisServicesDutyInfoDao;
import com.inspur.cams.fis.base.data.FisServicesDutyInfo;
import com.inspur.cams.fis.base.domain.IFisServicesDutyInfoDomain;

/**
 * 殡葬服务机构人员岗位信息表domain
 * @author 
 * @date Wed May 02 09:01:05 GMT+08:00 2012
 */
public class FisServicesDutyInfoDomain implements IFisServicesDutyInfoDomain {

	@Reference
	private IFisServicesDutyInfoDao fisServicesDutyInfoDao;

	/**
	 * 查询 殡葬服务机构人员岗位信息表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return fisServicesDutyInfoDao.query(pset);
	}

	/**
	 * 获取 殡葬服务机构人员岗位信息表
	 * @param pset
	 * @return
	 */
	public FisServicesDutyInfo get(String dutyId) {
		return fisServicesDutyInfoDao.get(dutyId);
	}

	/**
	 * 增加 殡葬服务机构人员岗位信息表
	 * @param fisServicesDutyInfo
	 */
	public void insert(FisServicesDutyInfo fisServicesDutyInfo) {
		fisServicesDutyInfoDao.insert(fisServicesDutyInfo);
	}
	
	/**
	 * 修改 殡葬服务机构人员岗位信息表
	 * @param fisServicesDutyInfo
	 */
	public void update(FisServicesDutyInfo fisServicesDutyInfo) {
		fisServicesDutyInfoDao.update(fisServicesDutyInfo);
	}
	
	/**
	 * 删除 殡葬服务机构人员岗位信息表
	 * @param dutyId
	 */
	public void delete(String dutyId) {
		fisServicesDutyInfoDao.delete(dutyId);
	}

}