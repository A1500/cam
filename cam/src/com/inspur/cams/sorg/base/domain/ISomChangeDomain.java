package com.inspur.cams.sorg.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomChange;

/**
 * 变更表domain接口
 * @author yanliangliang
 * @date 2011-7-18
 */
public interface ISomChangeDomain {
	/**
	 * 查询变更
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	/**
	 * 插入一条变更信息
	 */
	@Trans
	public void insert(SomChange somChange);
	
	@Trans
	public void update(SomChange somChange);
	/**
	 * 根据id删除一条变更信息
	 * @param id
	 */
	@Trans
	public void deleteChange(String id);
	/**
	 * 通过业务编号删除变更
	 */
	@Trans
	public void deleteChangeByTaskCode(String taskCode);
	/**
	 * 更新变更表里的dutyId
	 * @param oldDutyId
	 * @param dutyId
	 */
	@Trans
	public void updateDutyId(String oldDutyId, String dutyId);	
	
	public DataSet queryChangeInfo(ParameterSet pset);
	
}
