package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.bpt.base.domain.IBptApplyAssistiveDevicesDomain;
import com.inspur.cams.bpt.base.domain.IWfProcessBusinessDomain;
/**
 * @title:BptApplyAssistiveDevicesQueryCommand
 * @description:伤残辅助器械审批查询
 * @author:
 * @since:2011-05-31
 * @version:1.0
*/
public class BptApplyAssistiveDevicesQueryCommand extends BaseQueryCommand{
	
	/**
	 *  工作流信息的服务接口
	 */
	IWfProcessBusinessDomain processBusinessService = ScaComponentFactory.getService(IWfProcessBusinessDomain.class,
	"wfProcessBusinessDomain/wfProcessBusinessDomain");
	
	/**
	 * 伤残辅助器械服务接口
	 */
	IBptApplyAssistiveDevicesDomain assistiveDevicesService = ScaComponentFactory.getService(IBptApplyAssistiveDevicesDomain.class,
	"bptApplyAssistiveDevicesDomain/bptApplyAssistiveDevicesDomain");
	
	/**
	 * 根据applyId查询记录
	 */
	public DataSet query(){
		ParameterSet pset = getParameterSet();
		DataSet ds = processBusinessService.query(pset);
		String applyId = (String)ds.getRecord(0).get("businessId");
		pset.remove("process_Id");
		pset.setParameter("apply_Id", applyId);
		return assistiveDevicesService.query(pset);
	}
	
	/**
	 * 查询伤残辅助器械申请
	 */
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		DataSet ds =  assistiveDevicesService.query(pset);
		return ds;
	}
	
	/**
	 * 查询未提交的伤残辅助器械人员信息
	 */
	public DataSet queryUnCommitPeople( ){
		ParameterSet pset = getParameterSet();
		return assistiveDevicesService.queryUnCommitPeople(pset);
	}
	
	/**
	 * 查询伤残辅助器械配置情况
	 */
	public DataSet queryAsisDeviceConfig(){
		ParameterSet pset = getParameterSet();
		DataSet ds = assistiveDevicesService.queryAsisDeviceConfig(pset);
		return ds;
	}
}
