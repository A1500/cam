package com.inspur.cams.bpt.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import com.inspur.cams.bpt.base.data.BptApplyCountryside;

/**
 * 在乡复员军人【带病回乡退伍军人】审批
 */

public interface IBptApplyCountrysideDomain {
	/**
	 * 添加一条审批记录
	 */
	public void insert(BptApplyCountryside bptApplyCountryside);
	
	/**
	 * 更新一条审批记录
	 */
	public void update(BptApplyCountryside bptApplyCountryside);
	
	/**
	 * 查询审批记录
	 */
	public DataSet query(ParameterSet pset);
	
}