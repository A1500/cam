package com.inspur.cams.fis.change.domain.support;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.fis.change.dao.support.FisCemeChangeDao;
import com.inspur.cams.fis.change.domain.IFisCemeChangeQueryDomain;

public class FisCemeChangeQueryDomain implements IFisCemeChangeQueryDomain {
	private FisCemeChangeDao fisCemeChangeDao = (FisCemeChangeDao) DaoFactory
			.getDao("com.inspur.cams.fis.change.dao.support.FisCemeChangeDao");

	public DataSet queryFisCemeList(ParameterSet pset) {
		return fisCemeChangeDao.queryFisCemeList(pset);
	}

}
