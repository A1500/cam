package com.inspur.cams.bpt.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptPeopleDemobilized;

/**
 * @title:IBptPeopleDemobilizedDao
 * @description:
 * @author:
 * @since:2011-05-20
 * @version:1.0
*/
 public interface IBptPeopleDemobilizedDao extends BaseCURD<BptPeopleDemobilized>{
	public void save(List<BptPeopleDemobilized> list);
	
	/**
	 * 查询在乡复员军人信息和相应的优抚人员信息
	 */
	public DataSet queryDemobilizedPeople(ParameterSet pset);
	               
	
	/**
	 * 查询未提交的乡复员军人
	 */
	public DataSet queryUnCimDemPeo(ParameterSet pset);

	public DataSet queryDemobilizedFlowHeader(String peopleId);

	public String queryByProcessId(String peopleId);

	/**
	 * 查询未提交的在乡复员换证军人列表
	 * @param pset 
	 */
	public DataSet queryDemobilizedPeopleList(ParameterSet pset);
	public DataSet queryChangedemo(ParameterSet pset);
	
	/**
	 * 查询未提交的在乡复员换证军人IdCard
	 */

	public DataSet queryDemobilizedBptPeopleGetIdCard(ParameterSet pset);
	
	public DataSet queryDemoEmigrationPeopleList(ParameterSet pset);

	public DataSet queryDemoProv(ParameterSet pset);

	public DataSet queryIllEmigrationPeopleList(ParameterSet pset);

	public DataSet queryDemobilizedIllBptPeopleGetIdCard(ParameterSet pset);

	public DataSet queryillprovinceEmigrationPeopleList(ParameterSet pset);
	
}

