package com.inspur.cams.drel.info.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.info.data.D204a01;

/**
 * 成员信息dao
 * @author 
 * @date 2014-06-09
 */
public interface ID204a01Dao extends BaseCURD<D204a01> {
	//删除家庭成员及其详细信息
	public void deletePersonAndInfo(ParameterSet pset);
	
	public DataSet queryPeopleInfo(ParameterSet pset);
}