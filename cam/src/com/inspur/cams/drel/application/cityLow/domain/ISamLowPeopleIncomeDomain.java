package com.inspur.cams.drel.application.cityLow.domain;

import java.util.Map;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.application.cityLow.data.SamLowPeopleIncome;

/**
 * 低收入家庭成员可支配收入表domain
 * @author 
 * @date 2014-03-11
 */
public interface ISamLowPeopleIncomeDomain {

	/**
	 * 查询 低收入家庭成员可支配收入表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 低收入家庭成员可支配收入表
	 * @param pset
	 * @return
	 */
	public SamLowPeopleIncome get(String incomeId);

	/**
	 * 增加 低收入家庭成员可支配收入表
	 * @param samLowPeopleIncome
	 */
	@Trans
	public void insert(SamLowPeopleIncome samLowPeopleIncome);
	
	/**
	 * 修改 低收入家庭成员可支配收入表
	 * @param samLowPeopleIncome
	 */
	@Trans
	public void update(SamLowPeopleIncome samLowPeopleIncome);
	
	/**
	 * 删除 低收入家庭成员可支配收入表
	 * @param incomeId
	 */
	@Trans
	public void delete(String incomeId);

	public DataSet queryByID(ParameterSet pset);

	public DataSet lowQueryByPeople(ParameterSet pset);

	public DataSet queryAllPeopleById(ParameterSet pset);

	public void batchDeleteFamilyAll(String[] delIds);

	public Map checkCardId(ParameterSet pset);

	public DataSet lowFamilyWealthCount(ParameterSet pset);

	public DataSet lowFamilyNoCount(ParameterSet pset);

	public DataSet lowFamilyCount(ParameterSet pset);

	public DataSet lowFamilyAvgIncCount(ParameterSet pset);

	public DataSet lowFamilyAvgAreaCount(ParameterSet pset);

}