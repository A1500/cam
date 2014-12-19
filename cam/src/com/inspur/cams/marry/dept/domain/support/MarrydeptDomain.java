package com.inspur.cams.marry.dept.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.*;
import com.inspur.cams.marry.dept.dao.IMarrydeptDao;
import com.inspur.cams.marry.dept.domain.IMarrydeptDomain;

/**
 * @title: MarrydeptDomain
 * @description:
 * @author:
 * @since:2011-07-13
 * @version:1.0
 */
public class MarrydeptDomain implements IMarrydeptDomain {

	private IMarrydeptDao marrydeptDao;

	@Reference
	public void setMarrydeptDao(IMarrydeptDao marrydeptDao) {
		this.marrydeptDao = marrydeptDao;
	}

	public DataSet query(ParameterSet pset) {
		return marrydeptDao.query(pset);
	}

	// 获取缓存部门信息
	public DataSet getCacheDept(ParameterSet pset) {
		return marrydeptDao.getCacheDept(pset);
	}

}