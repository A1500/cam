package com.inspur.cams.bpt.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.bpt.base.dao.IBptApplyAssistiveDevicesDao;
import com.inspur.cams.bpt.base.data.BptApplyAssistiveDevices;
import com.inspur.cams.bpt.base.domain.IBptApplyAssistiveDevicesDomain;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
/**
 * 伤残辅助器械维护
 *
 */
public class BptApplyAssistiveDevicesDomain implements IBptApplyAssistiveDevicesDomain{
	
	@Reference
	IBptApplyAssistiveDevicesDao  bptApplyAssistiveDevicesDao;
	
	/**
	 * 添加伤残辅助器械
	 */
	public void insert(BptApplyAssistiveDevices bptApplyAssistiveDevices){
		bptApplyAssistiveDevices.setRegId(BspUtil.getEmpOrganId());
		bptApplyAssistiveDevices.setRegTime(DateUtil.getTime());
		bptApplyAssistiveDevices.setCommitFlag("0");
		bptApplyAssistiveDevicesDao.insert(bptApplyAssistiveDevices);
	}
	
	/**
	 * 更新伤残信息
	 */
	public void update(BptApplyAssistiveDevices bptApplyAssistiveDevices){
		bptApplyAssistiveDevicesDao.update(bptApplyAssistiveDevices);
	}
	
	/**
	 * 查询伤残辅助器械信息
	 */
	public DataSet query(ParameterSet pset){
		return bptApplyAssistiveDevicesDao.query(pset);
	}
	
	/**
	 * 查询未提交的伤残辅助器械人员信息
	 */
	public DataSet queryUnCommitPeople(ParameterSet pset){
		return bptApplyAssistiveDevicesDao.queryUnCommitPeople(pset);
	}
	
	/**
	 * 删除一条记录
	 */
	public void delete(String peopleId){
		bptApplyAssistiveDevicesDao.delete(peopleId);
	}
	
	/**
	 * 批量删除
	 */
	public void delete(String[] peopleId){
		bptApplyAssistiveDevicesDao.batchDelete(peopleId);
	}
	
	/**
	 * 查询伤残辅助器械配置情况
	 */
	public DataSet queryAsisDeviceConfig(ParameterSet pset){
		return bptApplyAssistiveDevicesDao.queryAsisDeviceConfig(pset);
	}
	
	public void updatePeopleDevices(Record[] rs, String applyId  ){
		bptApplyAssistiveDevicesDao.updatePeopleDevices( rs,  applyId );
	}
}