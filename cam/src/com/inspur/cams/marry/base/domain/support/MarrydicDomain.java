package com.inspur.cams.marry.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.*;
import com.inspur.cams.marry.base.dao.*;
import com.inspur.cams.marry.base.domain.IMarrydicDomain;

/**
 * @title: MarrydicDomain
 * @description:
 * @author:
 * @since:2011-07-13
 * @version:1.0
 */
public class MarrydicDomain implements IMarrydicDomain {

	private IMarrydicDao marrydicDao;

	@Reference
	public void setMarrydicDao(IMarrydicDao marrydicDao) {
		this.marrydicDao = marrydicDao;
	}
	
	//获取字典缓存信息
	public DataSet query(ParameterSet pset) {
		return marrydicDao.query(pset);
	}

	public DataSet getCacheDic(ParameterSet ps) {
		return marrydicDao.getCacheDic(ps);
	}

}