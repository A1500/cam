package com.inspur.cams.sorg.query.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.sorg.query.dao.ISomEntityStaticDao;
import com.inspur.cams.sorg.query.domain.ISomEntityStaticDomain;

public class SomEntityStaticDomain implements ISomEntityStaticDomain {
	@Reference
	private ISomEntityStaticDao somEntityStaticDao;

	public DataSet groupEntityStatic(ParameterSet pset) {
		return somEntityStaticDao.groupEntityStatic(pset);
	}
}
