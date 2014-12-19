package com.inspur.cams.drel.surey.comm.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.surey.comm.data.SamSurey;
import com.inspur.cams.drel.surey.comm.data.SamSureyWf;


public interface ISamSureyDomain {
	
    public DataSet query(ParameterSet pset);
	
	public void outerCreate(SamSurey sureyBean,SamSureyWf sureyWfBean);
	
	public void outerSend(SamSureyWf bean, String userId, String userName);
	
	public String getApplyTitle(String peopleName,String surveyType);
	
	public Boolean isCityLevel(String organArea);
	
	public  String getOrganName(String organArea);
}
