package com.inspur.cams.fis.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.fis.base.dao.IFisResourceTypeDao;
import com.inspur.cams.fis.base.data.FisResourceType;
import com.inspur.cams.fis.base.domain.IFisResourceTypeDomain;

/**
 * @Path com.inspur.cams.fis.base.domain.support.FisResourceTypeDomain
 * @Description: TODO 殡葬业务资源分类表domain实现
 * @author wangziming
 * @date 2011-11-15
 */
public class FisResourceTypeDomain implements IFisResourceTypeDomain {

	@Reference
	private IFisResourceTypeDao fisResourceTypeDao;

	public DataSet query(ParameterSet pset) {
		return fisResourceTypeDao.query(pset);
	}

	public void insert(FisResourceType fisResourceType) {
		fisResourceTypeDao.insert(fisResourceType);
	}

	public void batchInsert(List<FisResourceType> list) {
		fisResourceTypeDao.batchInsert(list);
	}

	public void update(FisResourceType fisResourceType) {
		fisResourceTypeDao.update(fisResourceType);
	}

	public void batchUpdate(List<FisResourceType> list) {
		fisResourceTypeDao.batchUpdate(list);
	}

	public void delete(String[] delIds) {
		fisResourceTypeDao.batchDelete(delIds);
	}

	public void save(List<FisResourceType> list) {
		fisResourceTypeDao.save(list);
	}

	public DataSet queryForExport(ParameterSet set) {
		return fisResourceTypeDao.queryForExport(set);
	}
}