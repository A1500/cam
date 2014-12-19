package com.inspur.cams.sorg.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomPeopleResume;

public interface ISomPeopleResumeDomain {

	public DataSet executeQuery(ParameterSet pset);
	
	public DataSet commExecute(ParameterSet pset);
	
	@Trans
	public void deleteResume(String taskCode);
	
	@Trans
	public void insert(SomPeopleResume somPeopleResume);
}
