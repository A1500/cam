package com.inspur.cams.fis.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.fis.base.dao.IFisResourceLevelDao;
import com.inspur.cams.fis.base.data.FisResourceLevel;
import com.inspur.cams.fis.base.domain.IFisResourceLevelDomain;

/**
 * @Path com.inspur.cams.fis.base.domain.support.FisResourceLevelDomain
 * @Description: TODO 殡葬业务资源级别定义表domain实现
 * @author wangziming
 * @date 2011-11-15
 */
public class FisResourceLevelDomain implements IFisResourceLevelDomain {

	@Reference
	private IFisResourceLevelDao fisResourceLevelDao;

	public DataSet query(ParameterSet pset) {
		return fisResourceLevelDao.query(pset);
	}

	public void insert(FisResourceLevel fisResourceLevel) {
		fisResourceLevelDao.insert(fisResourceLevel);
	}

	public void batchInsert(List<FisResourceLevel> list) {
		fisResourceLevelDao.batchInsert(list);
	}

	public void update(FisResourceLevel fisResourceLevel) {
		fisResourceLevelDao.update(fisResourceLevel);
	}

	public void batchUpdate(List<FisResourceLevel> list) {
		fisResourceLevelDao.batchUpdate(list);
	}

	public void delete(String[] delIds) {
		fisResourceLevelDao.batchDelete(delIds);
	}

	public void save(List<FisResourceLevel> list) {
		fisResourceLevelDao.save(list);
	}

	public DataSet queryForExport(ParameterSet set) {
		return fisResourceLevelDao.queryForExport(set);
	}
}