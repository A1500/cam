package com.inspur.cams.bpt.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptPeopleDemobilized;

/**
 * 在乡复员军人Domain接口
 * @author 王宝才
 *
 */
public interface IBptPeopleDemobilizedDomain{
	/**
	 * 添加在乡复员军人Domain接口方法
	 * @param bptPeopleDemobilized
	 */
	public void insert(BptPeopleDemobilized bptPeopleDemobilized);
	
	/**
	 * 查询在乡复员军人信息（用于明细记录信息）
	 */
	public DataSet query(ParameterSet pset);
	
	/**
	 * 查询未提交的乡复员军人
	 */
	public DataSet queryUnCimDemPeo(ParameterSet pset);
	
	/**
	 * 更新在乡人员信息和相关优抚信息
	 */
	public DataSet queryChangedemo(ParameterSet pset);
	public void updateBptPeopleDemobilized(BptPeopleDemobilized bptPeopleDemobilized);

	public DataSet queryDemobilizedFlowHeader(String peopleId);

	public String queryByProcessId(ParameterSet pset);
	public DataSet queryDemobilizedPeopleList(ParameterSet pset);
	public DataSet queryDemobilizedBptPeopleGetIdCard(ParameterSet pset);
	public DataSet queryDemoEmigrationPeopleList(ParameterSet pset);

	public DataSet queryDemoProv(ParameterSet pset);

	public DataSet queryIllEmigrationPeopleList(ParameterSet pset);

	public DataSet queryDemobilizedIllBptPeopleGetIdCard(ParameterSet pset);

	public DataSet queryillprovinceEmigrationPeopleList(ParameterSet pset);
	
}