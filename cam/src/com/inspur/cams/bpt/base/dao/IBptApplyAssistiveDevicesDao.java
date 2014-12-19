package com.inspur.cams.bpt.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.bpt.base.data.BptApplyAssistiveDevices;

/**
 * @title:IBptApplyAssistiveDevicesDao
 * @description:
 * @author:
 * @since:2011-05-31
 * @version:1.0
*/
 public interface IBptApplyAssistiveDevicesDao extends BaseCURD<BptApplyAssistiveDevices>{
	public void save(List<BptApplyAssistiveDevices> list);
	
	/**
	 * 查询未提交的伤残辅助器械人员信息
	 */
	public DataSet queryUnCommitPeople(ParameterSet pset);
	
	/**
	 * 查询伤残辅助器械配置情况
	 */
	public DataSet queryAsisDeviceConfig(ParameterSet pset);
	
	public void updatePeopleDevices(Record[] rs, String applyId  );
}

