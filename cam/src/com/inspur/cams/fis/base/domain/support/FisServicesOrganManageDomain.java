package com.inspur.cams.fis.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.fis.base.dao.IFisServicesOrganManageDao;
import com.inspur.cams.fis.base.data.FisServicesOrganManage;
import com.inspur.cams.fis.base.domain.IFisServicesOrganManageDomain;

/**
 * 殡葬服务机构信息表domain
 * @author 
 * @date Wed May 02 09:01:05 GMT+08:00 2012
 */
public class FisServicesOrganManageDomain implements IFisServicesOrganManageDomain {

	@Reference
	private IFisServicesOrganManageDao fisServicesOrganManageDao;

	/**
	 * 查询 殡葬服务机构信息表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return fisServicesOrganManageDao.query(pset);
	}

	/**
	 * 获取 殡葬服务机构信息表
	 * @param pset
	 * @return
	 */
	public FisServicesOrganManage get(String recordId) {
		return fisServicesOrganManageDao.get(recordId);
	}

	/**
	 * 增加 殡葬服务机构信息表
	 * @param fisServicesOrganManage
	 */
	public void insert(FisServicesOrganManage fisServicesOrganManage) {
		fisServicesOrganManageDao.insert(fisServicesOrganManage);
	}
	
	/**
	 * 修改 殡葬服务机构信息表
	 * @param fisServicesOrganManage
	 */
	public void update(FisServicesOrganManage fisServicesOrganManage) {
		fisServicesOrganManageDao.update(fisServicesOrganManage);
	}
	
	/**
	 * 删除 殡葬服务机构信息表
	 * @param recordId
	 */
	public void delete(String recordId) {
		fisServicesOrganManageDao.delete(recordId);
	}

}