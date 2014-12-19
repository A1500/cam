package com.inspur.cams.fis.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.fis.base.dao.IFisFuneralOrganManageDao;
import com.inspur.cams.fis.base.data.FisFuneralOrganManage;
import com.inspur.cams.fis.base.domain.IFisFuneralOrganManageDomain;

public class FisFuneralOrganManageDomain implements IFisFuneralOrganManageDomain {

	@Reference
	private IFisFuneralOrganManageDao fisFuneralOrganManageDao;

	public void insert(FisFuneralOrganManage bean) {
		fisFuneralOrganManageDao.insert(bean);
	}

	public DataSet query(ParameterSet pset) {
		return fisFuneralOrganManageDao.query(pset);
	}

	public Boolean queryUserIfExist(String organCode) {
		return fisFuneralOrganManageDao.queryUserIfExist(organCode);
	}

	/**
	 * @Title: queryOrganByUnitId
	 * @Description: 殡仪馆树的查询
	 * @return DataSet
	 * @throws
	 * @author jiangzhaobao
	 */
	public DataSet queryOrganByUnitId(ParameterSet pset) {
		return fisFuneralOrganManageDao.queryOrganByUnitId(pset);
	}

	public DataSet queryInfoByArea(ParameterSet pset) {
		return fisFuneralOrganManageDao.queryInfoByArea(pset);
	}

	public void deleteById(String organCode) {
		fisFuneralOrganManageDao.delete(organCode);
	}

	public void update(FisFuneralOrganManage bean) {
		fisFuneralOrganManageDao.update(bean);
	}

	/**
	 * @Description: 馆基本信息统计
	 * @author xuexzh
	 */
	public DataSet queryFuneralOrganSum(ParameterSet pset) {
		return fisFuneralOrganManageDao.queryFuneralOrganSum(pset);
	}

	/**
	 * @Description: 馆建设情况统计
	 * @author xuexzh
	 */
	public DataSet queryFuneralOrganBuildSum(ParameterSet pset) {
		return fisFuneralOrganManageDao.queryFuneralOrganBuildSum(pset);
	}

	/**
	 * @Description: 馆设备情况统计
	 * @author xuexzh
	 */
	public DataSet queryFuneralOrganEquSum(ParameterSet pset) {
		return fisFuneralOrganManageDao.queryFuneralOrganEquSum(pset);
	}
}
