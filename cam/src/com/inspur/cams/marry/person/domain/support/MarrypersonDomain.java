package com.inspur.cams.marry.person.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.*;

import com.inspur.cams.marry.person.dao.IMarrypersonDao;
import com.inspur.cams.marry.person.domain.IMarrypersonDomain;

/**
 * @title: MarrypersonDomain
 * @description:
 * @author:
 * @since:2011-07-13
 * @version:1.0
 */
public class MarrypersonDomain implements IMarrypersonDomain {

	private IMarrypersonDao marrypersonDao;

	@Reference
	public void setMarrypersonDao(IMarrypersonDao marrypersonDao) {
		this.marrypersonDao = marrypersonDao;
	}

	public DataSet query(ParameterSet pset) {
		return marrypersonDao.query(pset);
	}

	public DataSet queryMarryPersons(ParameterSet pset) {
		return marrypersonDao.queryMarryPersons(pset);
	}
	public DataSet queryCertifierPersons(ParameterSet pset) {
		return marrypersonDao.queryCertifierPersons(pset);
	}
}