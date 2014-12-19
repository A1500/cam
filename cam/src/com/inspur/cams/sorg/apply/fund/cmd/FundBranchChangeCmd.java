package com.inspur.cams.sorg.apply.fund.cmd;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;
import com.inspur.cams.sorg.apply.fund.domain.IFundBranchChangeDomain;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomChange;
import com.inspur.cams.sorg.base.data.SomChangeApply;
import com.inspur.cams.sorg.base.data.SomDuty;
import com.inspur.cams.sorg.base.data.SomRule;
/**
 * 基金会分支变更Cmd
 * @author yanliangliang
 * @date 2011-8-17
 */
public class FundBranchChangeCmd extends BaseAjaxCommand {
	private IFundBranchChangeDomain service = ScaComponentFactory.getService(IFundBranchChangeDomain.class, "fundBranchChangeDomain/fundBranchChangeDomain");
	/**
	 * 业务流程中的保存发送流程
	 */
	public void saveAndSendForChange(){
		SomChangeApply somChangeApply=createChangeInfo();
		
		service.saveAndSendForChange(somChangeApply);
	}
	/**
	 * 网上申请业务流程中的保存发送流程
	 */
	public void saveAndSendForChangeOnline(){
		SomChangeApply somChangeApply=createChangeInfo();
		
		service.saveAndSendForChangeOnline(somChangeApply);
	}
	/**
	 * 业务流程中的发送下一步流程
	 */
	public void sendForChange(){
		SomChangeApply somChangeApply=createChangeInfo();
		service.sendForChange(somChangeApply);
	}
	public void getProcessIdForList(){
		String id=(String)getParameter("assignmentId");
		String processId=getProcessId(id);
		setReturn("processId", processId);
	}
	public String getProcessId(String id){
		return service.queryProcessId(id);
	}
	public void printForChange(){
		SomChangeApply somChangeApply=new SomChangeApply();
		String processId=(String)getParameter("processId");
		String sorgId=(String)getParameter("sorgId");
		String endDate=(String)getParameter("endDate");
		String beginDate=(String)getParameter("beginDate");
		String PrintDate=(String)getParameter("PrintDate");
		String certType=(String)getParameter("certType");
		String sorgType=(String)getParameter("sorgType");
		Record opinion=(Record)getParameter("opinion");//意见
		String organType=(String)getParameter("organType");
		String issueReasonDesc=(String)getParameter("issueReasonDesc");
		String business=(String)getParameter("business");
		String actArea=(String)getParameter("actArea");
		Map<String, String> map=new HashMap<String, String>();
		map.put("processId", processId);
		map.put("sorgId", sorgId);
		map.put("endDate", endDate);
		map.put("beginDate", beginDate);
		map.put("PrintDate", PrintDate);
		map.put("certType", certType);	
		map.put("sorgType", sorgType);
		String applyType=(String)getParameter("applyType");
		map.put("applyType", applyType);
		map.put("organType", organType);
		map.put("issueReasonDesc", issueReasonDesc);
		map.put("business", business);
		map.put("actArea", actArea);
		map.put("fetchPeople", (String)getParameter("fetchPeople"));
		map.put("fetchDate", (String)getParameter("fetchDate"));
		map.put("fetchPhone", (String)getParameter("fetchPhone"));
		somChangeApply.setMap(map);	
		somChangeApply.setSomApply((SomApply)opinion.toBean(SomApply.class));
		service.endForChange(somChangeApply);
	}
	/**
	 * 受理保存
	 */
	public void saveForCreate(){
		
		SomChangeApply somChangeApply=createChangeInfo();
		
		service.createForChange(somChangeApply);
		
	}
	/**
	 * 受理保存
	 */
	public void saveForCreateOnline(){
		
		SomChangeApply somChangeApply=createChangeInfo();
		
		service.createForChangeOnline(somChangeApply);
		
	}
	/**
	 * 删除变更时做的操作
	 */
	@Trans
	public void deleteForChange() {
		 String id=(String)getParameter("id");
		 String changeItem=(String)getParameter("changeItem");
		 String taskCode=(String)getParameter("taskCode"); 
		 String sorgId=(String)getParameter("sorgId");
		 service.deleteForChange(id,changeItem,sorgId,taskCode);
		
	}
	/**
	 * 修改页面中的保存
	 */
	@Trans
	public void saveOpinion(){
		SomChangeApply somChangeApply=createChangeInfo();
		service.updateSomApply(somChangeApply);
	}
	
	/**
	 * 通过processId获得somApply
	 */
	public String getSomApplyByProcessId(String id){
		
		return service.getSomApplyByProcessId(id).getIfFinish();
	}
	/**
	 * 通过sorgId获得法定代表人姓名
	 */
	public void getLegalPeopleNameByTaskCode(){
		String sorgId=(String)getParameter("sorgId"); 
		String name=service.getLegalPeopleNameByTaskCode(sorgId);
		setReturn("legalPeopleName", name);
	}
	/**
	 * 整理保存信息
	 * @return
	 */
	private SomChangeApply createChangeInfo() {
		SomChangeApply somChangeApply=new SomChangeApply();
		List<SomChange> changeList=new ArrayList<SomChange>();
		Record[] changes=(Record[])getParameter("Changes");
		Record somLegalPeople=(Record)getParameter("somLegalPeople");
		String cnName=(String)getParameter("cnName");
		String sorgId=(String)getParameter("sorgId");
		String taskCode=(String)getParameter("taskCode");
		String sorgType=(String)getParameter("sorgType");
		String sorgKind=(String)getParameter("sorgKind");
		String sorgDuties=(String)getParameter("sorgDuties");
		Record somFlow=(Record)getParameter("opinion");
		
		String actDefUniqueId=(String)getParameter("actDefUniqueId");
		String fetchPeople=(String)getParameter("fetchPeople");
		String fetchDate=(String)getParameter("fetchDate");
		String fetchPhone=(String)getParameter("fetchPhone");
		
		String process=(String)getParameter("process");
		
		//封装变更信息
		for(int i=0;i<changes.length;i++){
			SomChange somChange=(SomChange)changes[i].toBean(SomChange.class);
			changeList.add(somChange);
		}
		Map<String, String> map=new HashMap<String, String>();
		//封装法定代表人信息
		if(somLegalPeople!=null){
			SomDuty somPeople=(SomDuty)somLegalPeople.toBean(SomDuty.class);
			somChangeApply.setSomLegalPeople(somPeople);
			map.put("leaPeopleId", somPeople.getDutyId());
		}
		
		String applyType=(String)getParameter("applyType");
		map.put("applyType", applyType);
		map.put("cnName", cnName);
		map.put("sorgId", sorgId);
		map.put("taskCode1", taskCode);
		map.put("sorgType", sorgType);
		map.put("sorgKind", sorgKind);
		map.put("sorgDuties", sorgDuties);
		map.put("actDefUniqueId", actDefUniqueId);
		map.put("fetchDate", fetchDate);
		map.put("fetchPeople", fetchPeople);
		map.put("fetchPhone", fetchPhone);
		
		
		somChangeApply.setSomChange(changeList);
		if(somFlow!=null){
			SomApply somApply=(SomApply)somFlow.toBean(SomApply.class);
			if(!"".equals(process) && process!=null){
				somApply.setProcess(process);
			}
			somChangeApply.setSomApply(somApply);
		}
		somChangeApply.setMap(map);	
		return somChangeApply;
	}
	/**
	 * 保存意见
	 */
	public void saveFlow(){
		Record record=(Record)getParameter("opinion");
		SomApply somApply=(SomApply)record.toBean(SomApply.class);
		service.saveFlow(somApply);
	}
}

