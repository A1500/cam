package com.inspur.cams.sorg.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.sorg.base.dao.ISomPeopleResumeDao;
import com.inspur.cams.sorg.base.data.SomPeopleResume;
import com.inspur.cams.sorg.base.domain.ISomPeopleResumeDomain;

public class SomPeopleResumeDomain implements ISomPeopleResumeDomain {

	@Reference
	private ISomPeopleResumeDao somPeopleResumeDao;

	public DataSet executeQuery(ParameterSet pset) {
		return somPeopleResumeDao.executeQuery(pset);
	}
	public DataSet commExecute(ParameterSet pset){
		return somPeopleResumeDao.query(pset);
	}
	
	public void deleteResume(String taskCode){
		somPeopleResumeDao.deleteResume(taskCode);
	}
	
	public void insert(SomPeopleResume somPeopleResume){
		somPeopleResumeDao.insert(somPeopleResume);
	}
}
