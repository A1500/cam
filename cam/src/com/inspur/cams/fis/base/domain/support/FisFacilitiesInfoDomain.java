package com.inspur.cams.fis.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.fis.base.dao.IFisFacilitiesInfoDao;
import com.inspur.cams.fis.base.dao.IFisResourceInfoDao;
import com.inspur.cams.fis.base.data.FisFacilitiesInfo;
import com.inspur.cams.fis.base.domain.IFisFacilitiesInfoDomain;

/**
 * @Path com.inspur.cams.fis.base.domain.support.FisFacilitiesInfoDomain
 * @Description: TODO 殡葬业务设施表domain实现
 * @author wangziming
 * @date 2011-11-15
 */
public class FisFacilitiesInfoDomain implements IFisFacilitiesInfoDomain {

	@Reference
	private IFisFacilitiesInfoDao fisFacilitiesInfoDao;
	@Reference
	private IFisResourceInfoDao fisResourceInfoDao;

	public DataSet query(ParameterSet pset) {
		return fisFacilitiesInfoDao.query(pset);
	}

	public void insert(FisFacilitiesInfo bean) {
	}

	public void batchInsert(List<FisFacilitiesInfo> list) {
	}

	public void update(FisFacilitiesInfo bean) {
	}

	public void batchUpdate(List<FisFacilitiesInfo> list) {
	}

	public void delete(String[] delIds) {
	}

	public void save(List<FisFacilitiesInfo> list) {
	}

	public DataSet queryForsFacilitiesInfo(ParameterSet pset) {
		return fisFacilitiesInfoDao.queryForsFacilitiesInfo(pset);
	}

	public DataSet queryForFacilitiesService(ParameterSet pset) {
		return fisFacilitiesInfoDao.queryForFacilitiesService(pset);
	}

	public DataSet queryForExport(ParameterSet set) {
		return fisFacilitiesInfoDao.queryForExport(set);
	}
}
