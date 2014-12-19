package com.inspur.cams.bpt.manage.cmd;

import java.util.HashMap;
import java.util.Map;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.next.web.cmd.CommandContext;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;
import org.loushang.workflow.api.WfQuery;
import org.loushang.workflow.api.WfTaskRequestWrapper;

import com.inspur.cams.bpt.base.data.BptApplyAssistiveDevices;
import com.inspur.cams.bpt.base.data.BptApplyAssistiveDevicesPr;
import com.inspur.cams.bpt.base.data.BptApplyHistory;
import com.inspur.cams.bpt.base.data.WfProcessBusiness;
import com.inspur.cams.bpt.base.domain.IBptApplyAssistiveDevicesDomain;
import com.inspur.cams.bpt.base.domain.IBptApplyAssistiveDevicesPrDomain;
import com.inspur.cams.bpt.base.domain.IBptApplyHistoryDomain;
import com.inspur.cams.bpt.base.domain.IWfProcessBusinessDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.bpt.util.BptConstant;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
/**
 * @title:BptApplyAssistiveDevicesCommand
 * @description:伤残辅助器械申请维护
 * @author:
 * @since:2011-05-31
 * @version:1.0
*/
public class BptApplyAssistiveDevicesCommand extends BaseAjaxCommand{
	
	IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class,
	"bptGroupDomain/bptGroupDomain");
	
	/**
	 * 伤残辅助器械服务接口
	 */
	IBptApplyAssistiveDevicesDomain assistiveDevicesService = ScaComponentFactory.getService(IBptApplyAssistiveDevicesDomain.class,
	"bptApplyAssistiveDevicesDomain/bptApplyAssistiveDevicesDomain");
	
	/**
	 * 伤残辅助器械审批服务接口
	 */
	IBptApplyAssistiveDevicesPrDomain assistiveDevicesPrService = ScaComponentFactory.getService(IBptApplyAssistiveDevicesPrDomain.class,
	"bptApplyAssistiveDevicesPrDomain/bptApplyAssistiveDevicesPrDomain");
	
	/**
	 * 工作流信息服务接口
	 */
	IWfProcessBusinessDomain wfProcessBusinessService = ScaComponentFactory.getService(IWfProcessBusinessDomain.class,
	"wfProcessBusinessDomain/wfProcessBusinessDomain");
	
	/**
	 * 审批记录历史服务接口
	 */
	IBptApplyHistoryDomain bptApplyHistoryService = ScaComponentFactory.getService(IBptApplyHistoryDomain.class,
	"BptApplyHistoryDomain/BptApplyHistoryDomain");
	
	/**
	 * 插入伤残辅助器械申请和审批表信息
	 */
	@Trans
	public void insert() {
		String  applyId = IdHelp.getUUID30();
		Record record = (Record) getParameter("record");
		BptApplyAssistiveDevices dataBean=(BptApplyAssistiveDevices)record.toBean(BptApplyAssistiveDevices.class);
		dataBean.setApplyId(applyId);
		assistiveDevicesService.insert(dataBean);
		
		String peopleId = (String)record.get("peopleId");
		
		BptApplyAssistiveDevicesPr assistiveDevicesPr = new BptApplyAssistiveDevicesPr();
		assistiveDevicesPr.setApplyId(applyId);
		assistiveDevicesPr.setPeopleId(peopleId);
		assistiveDevicesPrService.insert(assistiveDevicesPr);
		this.setReturn("applyId",applyId);
		updatePeopleDevices(applyId);
	}
	
	/**
	 * 修改伤残辅助器械
	 */
	@Trans
	public void update(){
		Record record = (Record) getParameter("record");
		BptApplyAssistiveDevices dataBean=(BptApplyAssistiveDevices)record.toBean(BptApplyAssistiveDevices.class);
		assistiveDevicesService.update(dataBean);
		updatePeopleDevices(dataBean.getApplyId());
	}
	
	/**
	 * 创建并发起流程
	 */
	@SuppressWarnings("unchecked")
	@Trans
	public void  createAndSend() {
		ParameterSet pset = new ParameterSet();
		String peopleId = getParameter("PEOPLE_ID").toString();
		String applyId = getParameter("APPLY_ID").toString();
		String condition = (String)getParameter("condition");
		
		//更新伤残辅助器械信息
		pset.setParameter("APPLY_ID",applyId);
		BptApplyAssistiveDevices assistiveDevicesBean=(BptApplyAssistiveDevices)assistiveDevicesService.query(pset).getRecord(0).toBean(BptApplyAssistiveDevices.class);
		assistiveDevicesBean.setCommitFlag(BptConstant.COMMIT_FLAG);
		assistiveDevicesService.update(assistiveDevicesBean);
		
		//获取伤残辅助器械审批信息
		BptApplyAssistiveDevicesPr dateBean = (BptApplyAssistiveDevicesPr)assistiveDevicesPrService.query(pset).getRecord(0).toBean(BptApplyAssistiveDevicesPr.class);
		dateBean.setApproveOrganId(BspUtil.getOrganCode());
		if(("1".equals(dateBean.getCheckAgreeFlag())&&"0".equals(dateBean.getReportFlag()))||"0".equals(dateBean.getCheckAgreeFlag())){//同意不上报或不同意时结束流程 填写 审批时间
			dateBean.setApproveDate(DateUtil.getDay());
			dateBean.setAgreeFlag(dateBean.getCheckAgreeFlag());
		}
		assistiveDevicesPrService.update(dateBean);
		
        // 调用创建并发送流程接口
		//通过流程唯一ID获得流程第一个环节ID
		String procDefUniqueId = BptConstant.ASSISTIVEDEVICES_PROCDEFUNIQUEID;
		String startActDefUniqueId = (String)WfQuery.getActDefInfoByProcDefUniqueIdAndActDefId(procDefUniqueId,"act1").get("actDefUniqueId");
		CommandContext.setContextParameter("procDefUniqueId",procDefUniqueId);
		CommandContext.setContextParameter("startActDefUniqueId",startActDefUniqueId);
		
		Map<String,String> context = new HashMap<String,String>();
		String cityOrganCode = BspUtil.getParentStrId();
		String currentOrganName =  BspUtil.getCorpOrgan().getOrganName();
		context.put("cityOrganCode", cityOrganCode);
		context.put("condition", condition);
		Map<String,String> map=WfTaskRequestWrapper.getInstance().createAndSend(applyId, currentOrganName+"的配置伤残器械申请", context);
		
		// 插入审批记录历史表
		BptApplyHistory bptApplyHistory = new BptApplyHistory();
		bptApplyHistory.setHistoryId(IdHelp.getUUID30());
		bptApplyHistory.setApplyId(applyId);
		bptApplyHistory.setActdefName("县级审核");
		bptApplyHistory.setCreateTime(DateUtil.getTime());
		bptApplyHistory.setApplyAdvice(dateBean.getCheckAdvice());
		bptApplyHistory.setApplyIncharge(dateBean.getCheckIncharge());
		bptApplyHistory.setApplyTime(dateBean.getCheckApproveDate());
		
		bptApplyHistoryService.insert(bptApplyHistory);
		
		//添加工作流信息表
		String processId = (String)map.get("processId");
		WfProcessBusiness wfProcessBusiness = new WfProcessBusiness();
		wfProcessBusiness.setProcessId(processId);
		wfProcessBusiness.setBusinessId(applyId);
		wfProcessBusiness.setConnectId(peopleId);
		wfProcessBusiness.setBusinessType(BptConstant.BPT_DISABILITY_ASSISTIVEDEVICES);
		wfProcessBusinessService.insert(wfProcessBusiness);
	}
	
	/**
	 * 判断县级审核负责人和审核时间是否填写
	 */
	public void verifyTownInfor(){
		ParameterSet pset = new ParameterSet();
		String applyId = (String)getParameter("APPLY_ID");
		pset.setParameter("APPLY_ID",applyId);
		BptApplyAssistiveDevicesPr assistiveDevicesPr = (BptApplyAssistiveDevicesPr)assistiveDevicesPrService.query(pset).getRecord(0).toBean(BptApplyAssistiveDevicesPr.class);
		String checkIncharge = assistiveDevicesPr.getCheckIncharge();
		String checkApproveDate = assistiveDevicesPr.getCheckApproveDate();
		String agreeFlag = assistiveDevicesPr.getCheckAgreeFlag();
		String reportFlag = assistiveDevicesPr.getReportFlag();
		setReturn("checkIncharge",checkIncharge);
		setReturn("checkApproveDate",checkApproveDate);
		setReturn("checkAgreeFlag",agreeFlag);
		setReturn("reportFlag",reportFlag);
	}
	
	/**
	 * 删除伤残辅助器械申请和审批数据
	 */
	@Trans
	public void deleteRecords(){
		String[] peopleId = (String[])getParameter("peopleId");
		String[] applyId = (String[])getParameter("applyId");
		assistiveDevicesService.delete(peopleId);
		assistiveDevicesPrService.delete(applyId);
	}
	//更新伤残器械关联表
	public void updatePeopleDevices(String applyId){
		Record[] rs = (Record[])getParameter("records");
		if(rs!=null){
			assistiveDevicesService.updatePeopleDevices( rs,  applyId );
		}
		//String applyId = (String)getParameter("applyId");
		
	}
}
