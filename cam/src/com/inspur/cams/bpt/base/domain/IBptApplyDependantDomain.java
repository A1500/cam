package com.inspur.cams.bpt.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptApplyDependant;

/**
 * 三属申请审批
 * @author zhanghui
 *
 */
public interface IBptApplyDependantDomain {
	
	/**
	 * 添加一条三属申请信息
	 * @param bptApplyDependant
	 */
	public void insert(BptApplyDependant bptApplyDependant);
	
	/**
	 * 修改三属申请审批信息
	 * @param bptApplyDependant
	 */
	public void update(BptApplyDependant bptApplyDependant);
	
	
	/**
	 * 查询审批信息
	 * @param applyId
	 * @return
	 */
	public DataSet queryApplyDependant(String applyId) ;
	/**
	 * 查询审批信息
	 * @param ParameterSet
	 * @return
	 */
	public DataSet queryApplyDependant(ParameterSet pst);

	public void deleteDependant(ParameterSet pst);
}
