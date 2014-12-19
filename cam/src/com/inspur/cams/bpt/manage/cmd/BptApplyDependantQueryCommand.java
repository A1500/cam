package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.bpt.base.domain.IBptApplyDependantDomain;
import com.inspur.cams.bpt.base.domain.IWfProcessBusinessDomain;

/**
 * 三属申请查询command
 * 
 * @author zhanghui
 * 
 */
public class BptApplyDependantQueryCommand extends BaseQueryCommand {

	/**
	 * 工作流信息服务接口
	 */
	IWfProcessBusinessDomain wfProcessBusinessService = ScaComponentFactory
			.getService(IWfProcessBusinessDomain.class,
					"wfProcessBusinessDomain/wfProcessBusinessDomain");

	/**
	 * 三属人员申请接口
	 */
	private IBptApplyDependantDomain bptApplyService = ScaComponentFactory
			.getService(IBptApplyDependantDomain.class,
					"bptApplyDependantDomain/bptApplyDependantDomain");

	/**
	 * 查询三属申请审批信息
	 * @return
	 */
	public DataSet queryApplyDependant() {
		String processId = (String) getParameter("processId");
		String assignmentId = (String) getParameter("assignmentId");
		ParameterSet pset = getParameterSet();
		pset.clear();
		if (processId == null || "".equals(processId)) {
			processId = wfProcessBusinessService.getProcessId(assignmentId);
			pset.setParameter("@PROCESS_ID=", processId);
		} else {
			pset.setParameter("@PROCESS_ID=", processId);
		}
		String applyId = (String) wfProcessBusinessService.query(pset)
		.getRecord(0).get("businessId");
		return bptApplyService.queryApplyDependant(applyId);
	}
	public DataSet queryTownApproved(){
		ParameterSet pset = getParameterSet();
		
		return bptApplyService.queryApplyDependant(pset);
		
	}
}
