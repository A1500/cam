package com.inspur.cams.drel.application.cityLow.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.application.cityLow.data.SamLowPeopleIncome;

/**
 * 低收入家庭成员可支配收入表dao
 * @author 
 * @date 2014-03-11
 */
public interface ISamLowPeopleIncomeDao extends BaseCURD<SamLowPeopleIncome> {

	public DataSet queryThree(ParameterSet pset);

	public DataSet lowQueryByPeople(ParameterSet pset);

	public DataSet queryForUpDateFamilyInfo(ParameterSet pset);

	public void batchDeleteFamilyAll(String[] delIds);

	public DataSet lowFamilyCount(ParameterSet pset);
	
	public DataSet lowFamilyCountTable(ParameterSet pset);

	public DataSet lowFamilyAvgCount(ParameterSet pset,String column);

	
}