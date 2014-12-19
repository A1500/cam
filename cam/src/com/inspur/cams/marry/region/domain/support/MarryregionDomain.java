package com.inspur.cams.marry.region.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.*;
import com.inspur.cams.marry.region.dao.IMarryregionDao;
import com.inspur.cams.marry.region.domain.IMarryregionDomain;

/**
 * @title: MarryregionDomain
 * @description:
 * @author:
 * @since:2011-07-13
 * @version:1.0
 */
public class MarryregionDomain implements IMarryregionDomain {

	private IMarryregionDao marryregionDao;

	@Reference
	public void setMarryregionDao(IMarryregionDao marryregionDao) {
		this.marryregionDao = marryregionDao;
	}

	public DataSet query(ParameterSet pset) {
		return marryregionDao.query(pset);
	}

	// 获取缓存行政区划信息
	public DataSet getCacheRegion(ParameterSet pset) {
		return marryregionDao.getCacheRegion(pset);
	}
}