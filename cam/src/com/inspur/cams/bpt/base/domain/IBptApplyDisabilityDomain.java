package com.inspur.cams.bpt.base.domain;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import com.inspur.cams.bpt.base.data.BptApplyDisability;

/**
 * 伤残申请审批
 */
public interface IBptApplyDisabilityDomain{
	/**
	 * 添加一条伤残申请审批记录
	 */
	public void insert(BptApplyDisability bptApplyDisability);
	
	/**
	 * 更新一条伤残申请审批记录
	 */
	public void update(BptApplyDisability bptApplyDisability);
	
	/**
	 * 查询伤残申请审批记录
	 */
	public DataSet query(ParameterSet pset);
	
	/**
	 * 查询未提交的调残人员列表
	 * @param pset
	 * @return
	 */
	public DataSet queryUnCommiAdjust(ParameterSet pset);
	/**
	 * 删除伤残相关信息
	 * @param pset
	 */
	public void deleteAboutDisability(ParameterSet pset);
	
	/**
	 * 查询审批后打证信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryPrintInfo(ParameterSet pset);
	
	/**
	 * 修改打印标示
	 * @param pset
	 */
	public void editPrintFlag(ParameterSet pset);
	/**
	 * 通过applyId获得实体
	 */
	public BptApplyDisability getBeanByKey(ParameterSet pset);

	public DataSet queryApplyInfoForCheck(ParameterSet pset);
}