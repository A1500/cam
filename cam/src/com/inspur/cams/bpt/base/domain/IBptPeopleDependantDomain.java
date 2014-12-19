package com.inspur.cams.bpt.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptPeopleDependant;

/**
 * 遗属Domain接口
 * @author 王宝才
 *
 */
public interface IBptPeopleDependantDomain{
	/**
	 * 添加遗属信息
	 */
	public void insert(BptPeopleDependant bptPeopleDependant);
	
	/**
	 * 更新类别三属信息
	 */
	public void update(BptPeopleDependant bptPeopleDependant);
	
	/**
	 * 查询人员遗属信息
	 */
	public DataSet query(ParameterSet pset);
	
	/**
	 * 查找人员、三属和优抚信息
	 */
	public DataSet queryDepePeo(ParameterSet pset);
	
	/**
	 * 查询未提交的三属信息
	 * @param pset
	 * @return
	 */
	public DataSet queryUncommitDependant(ParameterSet pset);
	
	/**
	 * 查询三属人员申请审批表头信息
	 * @param peopleId
	 * @return
	 */
	public DataSet queryApplyHeader(String peopleId);
}