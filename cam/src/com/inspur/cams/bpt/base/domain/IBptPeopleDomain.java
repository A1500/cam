package com.inspur.cams.bpt.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import com.inspur.cams.bpt.base.data.BptPeople;

/**
 * 添加优抚人员信息Domain接口
 * @author 王宝才
 */
public interface IBptPeopleDomain{
	
	/**
	 * 添加优抚人员信息
	 * @param bptPeople
	 */
	public void insert(BptPeople bptPeople);
	
	/**
	 *  查询优抚人员信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	
	/**
	 * 更新优抚人员信息
	 */
	public void update(BptPeople bptPeople);
	/**
	 * 查询人员各种审批信息
	 * @return
	 */
	
	public DataSet queryApplyInfo(ParameterSet pset);
	
	/**
	 * 查询优抚伤残减员人员信息
	 * @param pset
	 * @return
	 */
	public DataSet queryDecreaseBpt(ParameterSet pset);
	
	/**
	 * 查询优抚增员信息
	 * @param pset
	 * @return
	 */
	public DataSet queryIncreaseBpt(ParameterSet pset);
	/**
	 * 查询人口数量
	 * @return
	 */
	public DataSet queryPeopleNumInfo(ParameterSet pset);
	
	/**
	 * 查询优抚对像申请信息列表
	 * @param pset
	 * @return
	 */
	public DataSet queryPeopleService(ParameterSet pset);
	
	public String  getMsgForNOPrint (ParameterSet pset);
	
	/**
	 * 查询60岁服兵役年限人员信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet querySoldierYear(ParameterSet pset);
}