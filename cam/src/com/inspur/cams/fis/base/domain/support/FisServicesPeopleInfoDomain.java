package com.inspur.cams.fis.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.fis.base.dao.IFisServicesPeopleInfoDao;
import com.inspur.cams.fis.base.data.FisServicesPeopleInfo;
import com.inspur.cams.fis.base.domain.IFisServicesPeopleInfoDomain;

/**
 * 殡葬服务机构工作人员信息表domain
 * @author 
 * @date Wed May 02 09:01:05 GMT+08:00 2012
 */
public class FisServicesPeopleInfoDomain implements IFisServicesPeopleInfoDomain {

	@Reference
	private IFisServicesPeopleInfoDao fisServicesPeopleInfoDao;

	/**
	 * 查询 殡葬服务机构工作人员信息表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return fisServicesPeopleInfoDao.query(pset);
	}

	/**
	 * 获取 殡葬服务机构工作人员信息表
	 * @param pset
	 * @return
	 */
	public FisServicesPeopleInfo get(String peopleId) {
		return fisServicesPeopleInfoDao.get(peopleId);
	}

	/**
	 * 增加 殡葬服务机构工作人员信息表
	 * @param fisServicesPeopleInfo
	 */
	public void insert(FisServicesPeopleInfo fisServicesPeopleInfo) {
		fisServicesPeopleInfoDao.insert(fisServicesPeopleInfo);
	}
	
	/**
	 * 修改 殡葬服务机构工作人员信息表
	 * @param fisServicesPeopleInfo
	 */
	public void update(FisServicesPeopleInfo fisServicesPeopleInfo) {
		fisServicesPeopleInfoDao.update(fisServicesPeopleInfo);
	}
	
	/**
	 * 删除 殡葬服务机构工作人员信息表
	 * @param peopleId
	 */
	public void delete(String peopleId) {
		fisServicesPeopleInfoDao.delete(peopleId);
	}

	/**
	 * @Title: queryForPeopleRecords 
	 * @Description: TODO(查询服务机构人员信息) 
	 * @author wangziming
	 */
	public DataSet queryForPeopleRecords(ParameterSet pset) {
		// TODO Auto-generated method stub
		return fisServicesPeopleInfoDao.queryForPeopleRecords(pset);
	}

}