package com.inspur.cams.marry.reg.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.*;
import com.inspur.cams.marry.base.dao.*;
import com.inspur.cams.marry.reg.dao.IMarryregDao;
import com.inspur.cams.marry.reg.domain.IMarryregDomain;

/**
 * @title:MarryregDomain
 * @description:
 * @author:
 * @since:2011-07-13
 * @version:1.0
 */
public class MarryregDomain implements IMarryregDomain {

	private IMarryregDao marryregDao;

	@Reference
	public void setMarryregDao(IMarryregDao marryregDao) {
		this.marryregDao = marryregDao;
	}

	public DataSet query(ParameterSet pset) {
		return marryregDao.query(pset);
	}
}