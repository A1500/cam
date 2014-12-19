package com.inspur.cams.bpt.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptApplyHistory;

/**
 * 审批记录domain接口
 * @author zhanghui
 *
 */
public interface IBptApplyHistoryDomain {
	
	/**
	 * 添加审批记录
	 */
	public void insert(BptApplyHistory bptApplyHistory);
	
	
	/**
	 * 查询审批历史记录
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	
	/**
	 * 根据applyId删除历史表信息
	 * @param pset
	 */
	public void delHistoryByApplyId(ParameterSet pset);

}
