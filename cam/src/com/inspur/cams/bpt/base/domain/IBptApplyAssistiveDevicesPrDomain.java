package com.inspur.cams.bpt.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import com.inspur.cams.bpt.base.data.BptApplyAssistiveDevicesPr;

/**
 *  伤残辅助器械审批
 */
public interface IBptApplyAssistiveDevicesPrDomain{
	
	/**
	 * 添加一条伤残辅助器械审批记录
	 */
	public void insert(BptApplyAssistiveDevicesPr bptApplyAssistiveDevicesPr);
	
	/**
	 * 更新一条伤残辅助器械审批记录
	 */
	public void update(BptApplyAssistiveDevicesPr bptApplyAssistiveDevicesPr);
	
	/**
	 * 删除一条伤残辅助器械审批记录
	 */
	public void delete(String applyId);
	
	/**
	 * 批量删除伤残辅助器械审批记录
	 */
	public void delete(String[] applyId);
	
	/**
	 * 查询伤残辅助器械审批记录
	 */
	public DataSet query(ParameterSet pset);
}