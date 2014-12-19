package com.inspur.cams.bpt.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.bpt.base.data.BptApplyAssistiveDevices;


/**
 *伤残辅助器械维护
 */

public interface  IBptApplyAssistiveDevicesDomain{
	/**
	 * 添加伤残辅助器械
	 */
	public void insert(BptApplyAssistiveDevices bptApplyAssistiveDevices);
	
	/**
	 * 更新伤残辅助器械信息
	 */
	public void update(BptApplyAssistiveDevices bptApplyAssistiveDevices);
	
	/**
	 * 查询伤残辅助器械信息
	 */
	public DataSet query(ParameterSet pset);
	
	/**
	 * 查询未提交的伤残辅助器械人员信息
	 */
	public DataSet queryUnCommitPeople(ParameterSet pset);
	
	/**
	 * 删除一条记录
	 */
	public void delete(String peopleId);
	
	/**
	 * 删除一条记录
	 */
	public void delete(String[] peopleId);
	
	/**
	 * 查询伤残辅助器械配置情况
	 */
	public DataSet queryAsisDeviceConfig(ParameterSet pset);
	
	public void updatePeopleDevices(Record[] rs, String applyId  );
}