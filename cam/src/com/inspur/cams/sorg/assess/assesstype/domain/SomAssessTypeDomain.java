package com.inspur.cams.sorg.assess.assesstype.domain;

import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.sorg.assess.assesstype.dao.ISomAssessTypeDao;
import com.inspur.cams.sorg.assess.assesstype.dao.SomAssessType;

/**
 * @title:SomAssessTypeDomain
 * @description:
 * @author:
 * @since:2011-12-03
 * @version:1.0
*/
 public class SomAssessTypeDomain implements ISomAssessTypeDomain {

	 ISomAssessTypeDao dao = (ISomAssessTypeDao) DaoFactory
		.getDao("com.inspur.cams.sorg.assess.assesstype.dao.SomAssessTypeDao");

	public void saveSomAssessType(List<SomAssessType> list) {
		dao.save(list);

	}

	public void delete(List<String> list) {
		String[] somassesstypeIds = list.toArray(new String[list.size()]);
		if (list != null && !list.isEmpty()) {
			dao.batchDelete(somassesstypeIds);
			
		}

	}

	public DataSet querySomAssessType(ParameterSet pset) {
		return dao.query(pset);
	}
	
	public void insert(SomAssessType somassesstype) {
		dao.insert(somassesstype);
	}

	public void update(SomAssessType somassesstype) {
		dao.update(somassesstype);
	}

	public void batchDelete(String[] delIds) {
		dao.batchDelete(delIds);
	}

	public void save(List<SomAssessType> list) {
		dao.save(list);
	}

}