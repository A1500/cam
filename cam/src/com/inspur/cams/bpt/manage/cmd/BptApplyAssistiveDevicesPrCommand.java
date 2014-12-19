package com.inspur.cams.bpt.manage.cmd;

import java.util.HashMap;
import java.util.Map;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;
import org.loushang.workflow.api.WfTaskRequestWrapper;

import com.inspur.cams.bpt.base.data.BptApplyAssistiveDevicesPr;
import com.inspur.cams.bpt.base.data.BptApplyHistory;
import com.inspur.cams.bpt.base.domain.IBptApplyAssistiveDevicesPrDomain;
import com.inspur.cams.bpt.base.domain.IBptApplyHistoryDomain;
import com.inspur.cams.bpt.base.domain.IWfProcessBusinessDomain;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * @title:BptApplyAssistiveDevicesPrCommand
 * @description:伤残辅助器械审批
 * @author:
 * @since:2011-06-07
 * @version:1.0
*/
public class BptApplyAssistiveDevicesPrCommand extends BaseAjaxCommand{
	/**
	 * 伤残辅助器械审批服务接口
	 */
	IBptApplyAssistiveDevicesPrDomain assistiveDevicesPrService = ScaComponentFactory.getService(IBptApplyAssistiveDevicesPrDomain.class,
	"bptApplyAssistiveDevicesPrDomain/bptApplyAssistiveDevicesPrDomain");
	
	/**
	 * 审批记录历史服务接口
	 */
	IBptApplyHistoryDomain bptApplyHistoryService = ScaComponentFactory.getService(IBptApplyHistoryDomain.class,
	"BptApplyHistoryDomain/BptApplyHistoryDomain");
	
	/**
	 * 工作流信息服务接口
	 */
	IWfProcessBusinessDomain wfProcessBusinessService = ScaComponentFactory.getService(IWfProcessBusinessDomain.class,
	"wfProcessBusinessDomain/wfProcessBusinessDomain");
	
	/**
	 * 更新一条记录
	 */
	public void update(){
		Record record = (Record) getParameter("record");
		BptApplyAssistiveDevicesPr dateBean = (BptApplyAssistiveDevicesPr)record.toBean(BptApplyAssistiveDevicesPr.class);
		assistiveDevicesPrService.update(dateBean);
	}
	
	/**
	 * 发送流程
	 */
	@Trans
	public void send(){
		Map<String,String> context = new HashMap<String,String>();
		ParameterSet pset = getParameterSet();
		String currentField = (String)pset.getParameter("currentField");
		String actDefName = (String)pset.getParameter("actDefName");
		Record rd = (Record)pset.getParameter("record");
		String applyId = (String)rd.get("applyId");
		BptApplyHistory bptApplyHistory = new BptApplyHistory();
		bptApplyHistory.setHistoryId(IdHelp.getUUID32());
		bptApplyHistory.setApplyId(applyId);
		bptApplyHistory.setActdefName(actDefName);
		bptApplyHistory.setCreateTime(DateUtil.getTime());
		if("townCheck".equals(currentField)){
			String condition = (String)getParameter("condition");
			String cityOrganCode = BspUtil.getParentStrId();
			context.put("cityOrganCode", cityOrganCode);
			context.put("condition", condition);
			bptApplyHistory.setApplyAdvice((String)rd.get("checkAdvice"));
			bptApplyHistory.setApplyIncharge((String)rd.get("checkIncharge"));
			bptApplyHistory.setApplyTime((String)rd.get("checkApproveDate"));
		}else if("cityCheck".equals(currentField)){
			bptApplyHistory.setApplyAdvice((String)rd.get("aduitAdvice"));
			bptApplyHistory.setApplyIncharge((String)rd.get("aduitIncharge"));
			bptApplyHistory.setApplyTime((String)rd.get("aduitApproveDate"));
		}
		bptApplyHistoryService.insert(bptApplyHistory);
		//调用工作流发送接口
		Map map = WfTaskRequestWrapper.getInstance().send(context);
		if(map.containsKey("isEnd") && "true".equals((String) map.get("isEnd"))){
			pset.clear();
			pset.setParameter("APPLY_ID",applyId);
			BptApplyAssistiveDevicesPr dateBean = (BptApplyAssistiveDevicesPr)assistiveDevicesPrService.query(pset).getRecord(0).toBean(BptApplyAssistiveDevicesPr.class);
			dateBean.setApproveDate(DateUtil.getDay());
			dateBean.setAgreeFlag(dateBean.getAduitAgreeFlag());
			assistiveDevicesPrService.update(dateBean);
		}
	}
	
	/**
	 * 回退流程
	 */
	@Trans
	public void back(){
		ParameterSet pset = getParameterSet();
		Record rd = (Record)pset.getParameter("record");
		BptApplyHistory bptApplyHistory = new BptApplyHistory();
		bptApplyHistory.setHistoryId(IdHelp.getUUID32());
		bptApplyHistory.setApplyId((String)rd.get("applyId"));
		bptApplyHistory.setActdefName("市级审核");
		bptApplyHistory.setCreateTime(DateUtil.getTime());
		bptApplyHistory.setApplyAdvice((String)rd.get("aduitAdvice"));
		bptApplyHistory.setApplyIncharge((String)rd.get("aduitIncharge"));
		bptApplyHistory.setApplyTime((String)rd.get("aduitApproveDate"));
		bptApplyHistoryService.insert(bptApplyHistory);
		//调用工作流回退接口
		WfTaskRequestWrapper.getInstance().back();
		// 修改是否被退回标示为y（退回）
		ParameterSet pset1 = new ParameterSet();
		pset1.setParameter("applyId", (String)rd.get("applyId"));
		pset1.setParameter("ifback", "y");
		wfProcessBusinessService.updateIfback(pset1);
	}
}
