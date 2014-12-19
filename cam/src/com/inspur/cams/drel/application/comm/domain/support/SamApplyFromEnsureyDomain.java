package com.inspur.cams.drel.application.comm.domain.support;

import java.util.List;
import java.util.Map;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.CommandContext;
import org.loushang.workflow.api.WfQuery;
import org.loushang.workflow.api.WfTaskRequestWrapper;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.baseinfo.domain.IBaseinfoDomain;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.application.comm.SamApplyType;
import com.inspur.cams.drel.application.comm.domain.ISamApplyFromEnsureyDomain;
import com.inspur.cams.drel.sam.data.SamApplyInfo;
import com.inspur.cams.drel.sam.domain.ISamApplyInfoDomain;

/**
* @Package com.inspur.cams.drel.application.comm.domain.support
* @Description: TODO
* @author luguosui 
* @date 2012-6-26
 */
public class SamApplyFromEnsureyDomain implements ISamApplyFromEnsureyDomain{
	
	@Reference
	private ISamApplyInfoDomain samApplyInfoDomain;
	@Reference
	private IBaseinfoDomain baseinfoDomain;
	
	public static final String PROC_DEF_UNIQUE_ID = "8a898b0337a5c7580137a60d700e0155";
	public static final String START_ACT_DEF_ID = "act1";
	/**
	* @Title: insertFromEnsurey
	* @Description: TODO(根据经济核对回填低保业务)  
	* @param set
	* @return String
	* @throws
	* @author luguosui
	 */
	public String insertFromEnsurey(ParameterSet set) {
		String applyId=IdHelp.getUUID32();
		String baseinfoFamilyId=IdHelp.getUUID32();
		set.setParameter("applyId", applyId);
		set.setParameter("baseinfoFamilyId", baseinfoFamilyId);
		//处理家庭信息：将家庭信息插入BASEINFO_FAMILY
		Record record=baseinfoDomain.insertFamilyFromEnsurey(set);
//		
//		Record applyRecord = (Record) set.getParameter("applyRecord");
//		SamApplyInfo samApplyInfo=(SamApplyInfo)applyRecord.toBean(SamApplyInfo.class);
//		samApplyInfo.setApplyId(applyId);
//		samApplyInfo.setFamilyId(baseinfoFamilyId);
//		samApplyInfo.setApplyType(SamApplyType.SAM_CITY_NEW_APPLY);//申请业务类别
////		samApplyInfo.setApplyDate(baseinfoFamily.getApplyDate());
////		samApplyInfo.setApplyReason(baseinfoFamily.getApplyReason());
//		samApplyInfo.setCurActivityId("accept");
//		samApplyInfo.setCurActivityName("受理");
//		//传入相应参数
//		Map actDefMap = WfQuery.getActDefInfoByProcDefUniqueIdAndActDefId(PROC_DEF_UNIQUE_ID,START_ACT_DEF_ID);
//		String actDefUniqueId = (String)actDefMap.get("actDefUniqueId");
//		CommandContext.setContextParameter("procDefUniqueId",PROC_DEF_UNIQUE_ID);
//		CommandContext.setContextParameter("startActDefUniqueId",actDefUniqueId);
//		//创建流程
//		Map wfMap = WfTaskRequestWrapper.getInstance().create(samApplyInfo.getApplyId(), samApplyInfo.getFamilyName() + "城市低保业务申请");
//		//得到委派实例ID
//		List actList = (List) wfMap.get("actList");
//		Map map1 = (Map) actList.get(0);
//		List assList = (List) map1.get("assList");
//		Map map2 = (Map) assList.get(0);
//		String assignmentId = (String) map2.get("assignmentId");
//		if(record!=null){
//			samApplyInfo.setFamilyName((String)record.get("FAMILY_NAME"));
//			samApplyInfo.setFamilyCardNo((String)record.get("FAMILY_CARD_NO"));
//			samApplyInfo.setDomicileCode((String)record.get("DOMICILE_CODE"));
//		}
		//处理家庭信息：将家庭信息插入SAM_APPLY_INFO
//		samApplyInfoDomain.insert(samApplyInfo);
//		samApplyInfoDomain.insertApplyFromEnsurey(set);
		//处理人员信息：将人员信息插入BASEINFO_PEOPLE
		baseinfoDomain.insertPeoFromEnsurey(set);
		return applyId;
	}

	/**
	* @Title: addCheck
	* @Description: TODO(审批时发起核对方法) void  
	* @param set
	* @throws
	* @author luguosui
	 */
	public void addCheck(ParameterSet set) {
		samApplyInfoDomain.addCheck(set);
	}
	
}
