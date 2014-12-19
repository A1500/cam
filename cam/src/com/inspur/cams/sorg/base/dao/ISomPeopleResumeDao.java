package com.inspur.cams.sorg.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.sorg.base.data.SomPeopleResume;

/**
 * @title:ISomPeopleResumeDao
 * @description:
 * @author:
 * @since:2011-10-31
 * @version:1.0
*/
 public interface ISomPeopleResumeDao extends BaseCURD<SomPeopleResume>{
	 public void save(List<SomPeopleResume> list);
	
	 public void deleteResume(String taskCode);
	
	 public void deleteResumeByDutyId(String dutyId);
	 
	 public DataSet executeQuery(ParameterSet pset);
}

