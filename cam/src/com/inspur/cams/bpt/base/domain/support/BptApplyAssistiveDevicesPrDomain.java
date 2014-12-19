package com.inspur.cams.bpt.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.bpt.base.dao.IBptApplyAssistiveDevicesPrDao;
import com.inspur.cams.bpt.base.data.BptApplyAssistiveDevicesPr;
import com.inspur.cams.bpt.base.domain.IBptApplyAssistiveDevicesPrDomain;
/**
 *  伤残辅助器械审批
 */
public class BptApplyAssistiveDevicesPrDomain implements IBptApplyAssistiveDevicesPrDomain{
	@Reference
	IBptApplyAssistiveDevicesPrDao bptApplyAssistiveDevicesPrDao;
	
	/**
	 * 添加一条伤残辅助器械审批记录
	 */
	public void insert(BptApplyAssistiveDevicesPr bptApplyAssistiveDevicesPr){
		bptApplyAssistiveDevicesPrDao.insert(bptApplyAssistiveDevicesPr);
	}
	
	/**
	 * 更新一条伤残辅助器械审批记录
	 */
	public void update(BptApplyAssistiveDevicesPr bptApplyAssistiveDevicesPr){
		bptApplyAssistiveDevicesPrDao.update(bptApplyAssistiveDevicesPr);
	}
	
	/**
	 * 删除一条伤残辅助器械审批记录
	 */
	public void delete(String applyId){
		bptApplyAssistiveDevicesPrDao.delete(applyId);
	}
	
	/**
	 * 批量删除伤残辅助器械审批记录
	 */
	public void delete(String[] applyId){
		bptApplyAssistiveDevicesPrDao.batchDelete(applyId);
	}
	
	/**
	 * 查询伤残辅助器械审批记录
	 */
	public DataSet query(ParameterSet pset){
		return bptApplyAssistiveDevicesPrDao.query(pset);
	}
}