package com.inspur.cams.bpt.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptPeopleTested;

/**
 * @title:IBptPeopleTestedDao
 * @description:
 * @author:
 * @since:2011-05-14
 * @version:1.0
*/
 public interface IBptPeopleTestedDao extends BaseCURD<BptPeopleTested>{
	public void save(List<BptPeopleTested> list);
	
	/**
	 * 就业状况DataSet
	 * @return
	 */
	public DataSet getEmployment();
	public DataSet queryTested(ParameterSet pset) ;
	//public void insertTested(BptPeopleTested peopleTested);
	
	/**
	 * 查询未提交的参试人员信息
	 * @param pset
	 * @return
	 */
	public DataSet queryUnCommitTest(ParameterSet pset);
	public void deleteWarTest(ParameterSet pset);
	
	public DataSet queryTongJiTested(ParameterSet pset);
}

