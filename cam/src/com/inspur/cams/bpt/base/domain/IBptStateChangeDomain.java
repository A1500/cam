package com.inspur.cams.bpt.base.domain;

import com.inspur.cams.bpt.base.data.BptStateChange;

/**
 * 状态变更Doamin接口
 */
public interface IBptStateChangeDomain{
	
	/**
	 * 添加状态变更信息
	 */
	public void insertBptStateChange(BptStateChange bptStateChange);
	
	/**
	 * 添加一条状态变更信息
	 * @param bptStateChange
	 */
	public void insert(BptStateChange bptStateChange);
	public void update(BptStateChange bptStateChange);
	public void updateClass(BptStateChange bptStateChange);
	/**
	 * 获取最新的变更前信息
	 * @return
	 */
	public String queryPreStateChange(String peopleId);
}