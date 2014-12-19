package com.inspur.cams.jcm.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

/**
 * 所有人员domain
 * 
 * @author xinming
 * @date 2014-12-15
 */
public interface IJcmAllPeopleQueryDomain {
	/**
	 * 查询 所有人员
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

}
