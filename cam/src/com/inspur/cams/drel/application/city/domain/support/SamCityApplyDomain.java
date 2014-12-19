package com.inspur.cams.drel.application.city.domain.support;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.CommandContext;
import org.loushang.workflow.api.WfQuery;
import org.loushang.workflow.api.WfTaskRequestWrapper;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.baseinfo.domain.IBaseinfoDomain;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.DicUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.PhotoUtil;
import com.inspur.cams.drel.application.city.domain.ISamCityApplyDomain;
import com.inspur.cams.drel.application.comm.SamApplyType;
import com.inspur.cams.drel.ensureInfo.data.EnsureToClient;
import com.inspur.cams.drel.ensureInfo.domain.IEnsureToClientDomain;
import com.inspur.cams.drel.esurey.domain.ISamLowStandardsDomain;
import com.inspur.cams.drel.sam.data.SamApplyDiscussion;
import com.inspur.cams.drel.sam.data.SamApplyInfo;
import com.inspur.cams.drel.sam.data.SamApplyNotice;
import com.inspur.cams.drel.sam.data.SamApplyOptionsHis;
import com.inspur.cams.drel.sam.data.SamApplySurvey;
import com.inspur.cams.drel.sam.data.SamBankAccount;
import com.inspur.cams.drel.sam.data.SamFamilyAssistance;
import com.inspur.cams.drel.sam.data.SamFamilyTreatment;
import com.inspur.cams.drel.sam.data.SamPeopleDisability;
import com.inspur.cams.drel.sam.data.SamPeopleDisease;
import com.inspur.cams.drel.sam.data.SamPeopleEdu;
import com.inspur.cams.drel.sam.data.SamPeopleExtend;
import com.inspur.cams.drel.sam.data.SamPeopleIncome;
import com.inspur.cams.drel.sam.data.SamPeopleInsurance;
import com.inspur.cams.drel.sam.data.SamPeopleJobs;
import com.inspur.cams.drel.sam.data.SamPeopleType;
import com.inspur.cams.drel.sam.domain.ISamApplyDiscussionDomain;
import com.inspur.cams.drel.sam.domain.ISamApplyInfoDomain;
import com.inspur.cams.drel.sam.domain.ISamApplyNoticeDomain;
import com.inspur.cams.drel.sam.domain.ISamApplyOptionsHisDomain;
import com.inspur.cams.drel.sam.domain.ISamApplySurveyDomain;
import com.inspur.cams.drel.sam.domain.ISamBankAccountDomain;
import com.inspur.cams.drel.sam.domain.ISamCardNoDomain;
import com.inspur.cams.drel.sam.domain.ISamFamilyAssistanceDomain;
import com.inspur.cams.drel.sam.domain.ISamFamilyTreatmentDomain;
import com.inspur.cams.drel.sam.domain.ISamPeopleDisabilityDomain;
import com.inspur.cams.drel.sam.domain.ISamPeopleDiseaseDomain;
import com.inspur.cams.drel.sam.domain.ISamPeopleEduDomain;
import com.inspur.cams.drel.sam.domain.ISamPeopleExtendDomain;
import com.inspur.cams.drel.sam.domain.ISamPeopleIncomeDomain;
import com.inspur.cams.drel.sam.domain.ISamPeopleInsuranceDomain;
import com.inspur.cams.drel.sam.domain.ISamPeopleJobsDomain;
import com.inspur.cams.drel.sam.domain.ISamPeopleTypeDomain;

/**
 * 城市低保新申请业务Domain接口
 * @author yanliangliang
 * @date 2012年5月2日10:41:16
 */
public class SamCityApplyDomain implements ISamCityApplyDomain{
	
	@Reference
	private ISamApplyInfoDomain samApplyInfoDomain;
	@Reference
	private IBaseinfoDomain baseinfoDomain;
	@Reference
	private ISamFamilyTreatmentDomain samFamilyTreatmentDomain;
	@Reference
	private ISamFamilyAssistanceDomain samFamilyAssistanceDomain;
	@Reference
	private ISamPeopleTypeDomain samPeopleTypeDomain;
	@Reference
	private ISamPeopleExtendDomain samPeopleExtendDomain;
	@Reference
	private ISamPeopleDiseaseDomain samPeopleDiseaseDomain;
	@Reference
	private ISamPeopleDisabilityDomain samPeopleDisabilityDomain;
	@Reference
	private ISamPeopleEduDomain samPeopleEduDomain;
	@Reference
	private ISamPeopleIncomeDomain samPeopleIncomeDomain;
	@Reference
	private ISamPeopleJobsDomain samPeopleJobsDomain;
	@Reference
	private ISamPeopleInsuranceDomain samPeopleInsuranceDomain;
	@Reference
	private ISamApplyNoticeDomain samApplyNoticeDomain;
	@Reference
	private ISamApplyDiscussionDomain samApplyDiscussionDomain;
	@Reference
	private ISamApplySurveyDomain samApplySurveyDomain;
	@Reference
	private ISamApplyOptionsHisDomain samApplyOptionsHisDomain;
	@Reference
	private ISamCardNoDomain samCardNoDomain;
	
	@Reference
	private ISamLowStandardsDomain samLowStandardsDomain;
	@Reference
	private ISamBankAccountDomain samBankAccountDomain;
	
	@Reference
	private IEnsureToClientDomain ensureToClientDomain;
	
	
	public static final String PROC_DEF_UNIQUE_ID = "8a898b0337a5c7580137a60d700e0155";
	public static final String START_ACT_DEF_ID = "act1";
	/**
	 * 保存低保新申请业务信息
	 */
	public SamApplyInfo insertInfo(SamApplyInfo applyInfo) {
		applyInfo.setCurActivityId("accept");
		applyInfo.setCurActivityName("受理");
		handleFamily(applyInfo);//处理家庭基本信息
		handleApply(applyInfo);//处理业务信息
		handleAssistance(applyInfo);//处理多选的救助类型信息
		handleSurvey(applyInfo);//处理入户调查信息
		handleDiscussion(applyInfo);//处理评议结果信息
		handleNoticeList(applyInfo);//处理公示结果信息
		handleBank(applyInfo);//处理银行信息
		
		return applyInfo;
	}
	/**
	 * 保存低保新申请业务信息(审核新增的)
	 */
	public SamApplyInfo insertInfoFromCheck(SamApplyInfo applyInfo) {
		submitApply(applyInfo);
		
		applyInfo.setCheckPeopleId(BspUtil.getEmpOrgan().getOrganId());
		applyInfo.setCheckPeopleName(BspUtil.getEmpOrgan().getOrganName());
		applyInfo.setCheckDeptId(BspUtil.getDeptStruId());
		if("1".equals(applyInfo.getCheckOpinionId())){
			applyInfo.setCurOpinion("审核同意");
		}else if("0".equals(applyInfo.getCheckOpinionId())){
			applyInfo.setCurOpinion("审核不同意");
		}else if("3".equals(applyInfo.getCheckOpinionId())){
			applyInfo.setCurOpinion("审核回退");
		}
		samApplyInfoDomain.update(applyInfo);
		return applyInfo;
	}
	/**
	 * 更新低保新申请业务信息(审核新增的)
	 */
	public SamApplyInfo updateInfoFromCheck(SamApplyInfo applyInfo) {
		handleFamily(applyInfo);//处理家庭基本信息
		handleApply(applyInfo);//处理业务信息
		handleAssistance(applyInfo);//处理多选的救助类型信息
		handleSurvey(applyInfo);//处理入户调查信息
		handleDiscussion(applyInfo);//处理评议结果信息
		handleNoticeList(applyInfo);//处理公示结果信息
		
		handleBank(applyInfo);//处理银行信息
		//applyInfo.setCurActivityId("check");
		//applyInfo.setCurActivityName("审核");
		if("1".equals(applyInfo.getCheckOpinionId())){
			applyInfo.setCurOpinion("审核同意");
		}else if("0".equals(applyInfo.getCheckOpinionId())){
			applyInfo.setCurOpinion("审核不同意");
		}else if("3".equals(applyInfo.getCheckOpinionId())){
			applyInfo.setCurOpinion("审核回退");
		}
		samApplyInfoDomain.update(applyInfo);
		return applyInfo;
	}
	/**
	 * 受理时提交流程
	 */
	@SuppressWarnings("unchecked")
	public void submitApply(SamApplyInfo applyInfo) {
		insertInfo(applyInfo);//保存低保新申请业务信息
		//工作流相应参数
		CommandContext.setContextParameter("assignmentId",applyInfo.getAssignmentId());
		Map context = new HashMap();
		String StruId = BspUtil.getParentStrId();
		context.put("organCode", StruId);
		context.put("opinionId",applyInfo.getAcceptOpinionId());
		//调用工作流发送接口
		Map maps=WfTaskRequestWrapper.getInstance().send(context);	
		samApplyInfoDomain.updateCurActId(StruId,applyInfo.getApplyId());
		//受理评议结果不同意的时候，结束流程
		if("0".equals(applyInfo.getSamApplyDiscussionList().get(0).getDiscussionResult())){//评议结果为不同意
			applyInfo.setIsFinish("1");
			applyInfo.setCurOpinion("受理不同意");
			applyInfo.setFinishTime(DateUtil.getTime());
			applyInfo.setCurActivityId("accept");
			applyInfo.setCurActivityName("受理");
			//调用存储过程把记录保存到备用表中
			samApplyInfoDomain.toDuplicateRecord(applyInfo);
		}else{
			//得到委派实例ID
			List actList = (List) maps.get("actList");
			Map map1 = (Map) actList.get(0);
			List assList = (List) map1.get("assList");
			Map map2 = (Map) assList.get(0);
			String assignmentId = (String) map2.get("assignmentId");
			applyInfo.setAssignmentId(assignmentId);
			
			applyInfo.setCurActivityId("check");
			applyInfo.setCurOpinion("");
			applyInfo.setCurActivityName("审核");
		}
		samApplyInfoDomain.update(applyInfo);
	}
	/**
	 * 发送流程
	 */
	@SuppressWarnings("unchecked")
	public void sendApply(SamApplyInfo applyInfo) {
		//更改核对信息表状态
		String applyId = applyInfo.getApplyId();
		if(!"".equals(applyId)){
			ParameterSet pset = new ParameterSet();
			pset.setParameter("APPLY_ID@=", applyId);
			DataSet ds = ensureToClientDomain.query(pset);
			EnsureToClient bean = (EnsureToClient)ds.getRecord(0).toBean(EnsureToClient.class);
			bean.setReadStatus("2");
			ensureToClientDomain.update(bean);
		}
		handleSurvey(applyInfo);//处理入户调查信息
		handleNoticeList(applyInfo);//处理公示结果信息
		//处理业务信息
		BaseinfoFamily baseinfoFamily=applyInfo.getBaseInfoFamily();
		applyInfo.setAssistancePeopleNum(baseinfoFamily.getAssistancePeopleNum());
		applyInfo.setAssistanceMoney(baseinfoFamily.getAssistanceMoney());
		applyInfo.setAssistanceClassMoney(baseinfoFamily.getAssistanceClassMoney());
		applyInfo.setAssistanceMode(baseinfoFamily.getAssistanceMode());
		applyInfo.setAsisstanceClass(baseinfoFamily.getAssistanceClass());
		toFillCurInfo(applyInfo);//维护apply的当前信息
		samApplyInfoDomain.update(applyInfo);
		//工作流相应的参数
		CommandContext.setContextParameter("assignmentId",applyInfo.getAssignmentId());
		Map context = new HashMap();
		String StruId = BspUtil.getParentStrId();
		SamApplyOptionsHis samApplyOptionsHis=applyInfo.getSamApplyOptionsHis();
		if("3".equals(samApplyOptionsHis.getOpinionId())){//如果是回退
			if("check".equals(samApplyOptionsHis.getActivityId())){//如果是审核回退
				StruId=applyInfo.getAcceptDeptId();
			}else if("audit".equals(samApplyOptionsHis.getActivityId())){//如果是审批回退
				StruId=applyInfo.getCheckDeptId();
			}
		}
		//如果审批同意,维护家庭表里受理人的行政区划，提供给阳光民生
		if("1".equals(samApplyOptionsHis.getOpinionId()) &&
				"audit".equals(samApplyOptionsHis.getActivityId())){
			applyInfo.getBaseInfoFamily().setRegOrgArea(BspUtil.getCorpOrgan().getOrganCode());
			baseinfoFamily.setCurActivity("FINISHOK");
			baseinfoFamily.setCheckFlag("3");
		}
		handleFamily(applyInfo);//处理家庭基本信息
		context.put("organCode",StruId);	
		context.put("opinionId",samApplyOptionsHis.getOpinionId());	
		//调用工作流发送接口
		Map maps=WfTaskRequestWrapper.getInstance().send(context);
		//TODO 
		samApplyInfoDomain.updateCurActId(StruId,applyInfo.getApplyId());
		
	}
	/**
	 * 维护apply的当前信息
	 * @param applyInfo
	 */
	private void toFillCurInfo(SamApplyInfo applyInfo) {
		applyInfo.setCurOpinion("");
		if("check".equals(applyInfo.getCurActivityId())){//如果是审核环节
			handleOptionsHis(applyInfo,"check");//生成审核的历史意见
			applyInfo.setCheckPeopleId(BspUtil.getEmpOrgan().getOrganId());
			applyInfo.setCheckPeopleName(BspUtil.getEmpOrgan().getOrganName());
			applyInfo.setCheckDeptId(BspUtil.getDeptStruId());
			if("3".equals(applyInfo.getCheckOpinionId())){
				//applyInfo.setCurActivityId("accept");
				//applyInfo.setCurActivityName("受理");
			}else if("1".equals(applyInfo.getCheckOpinionId())){
				//applyInfo.setCurActivityId("audit");
				//applyInfo.setCurActivityName("审批");
			}else if("0".equals(applyInfo.getCheckOpinionId())){
				applyInfo.setCurActivityId("check");
				applyInfo.setCurActivityName("审核");
				applyInfo.setCurOpinion("审核不同意");
				applyInfo.setIsFinish("1");
				applyInfo.setFinishTime(DateUtil.getTime());
				//调用存储过程把记录保存到备用表中
				samApplyInfoDomain.toDuplicateRecord(applyInfo);
			}
		}else if("audit".equals(applyInfo.getCurActivityId())){//如果是审批环节
			handleOptionsHis(applyInfo,"audit");//生成审批的历史意见
			applyInfo.setAuditPeopleId(BspUtil.getEmpOrgan().getOrganId());
			applyInfo.setAuditPeopleName(BspUtil.getEmpOrgan().getOrganName());
			applyInfo.setAuditDeptId(BspUtil.getDeptStruId());
			if("3".equals(applyInfo.getAuditOpinionId())){
				//applyInfo.setCurActivityId("check");
				//applyInfo.setCurActivityName("审核");
			}else if("1".equals(applyInfo.getAuditOpinionId())){
				//applyInfo.setCurActivityId("audit");
				//applyInfo.setCurActivityName("审批");
				applyInfo.setCurOpinion("审批同意");
				applyInfo.setIsFinish("1");
				applyInfo.setFinishTime(DateUtil.getTime());
				applyInfo.setCardNo(samCardNoDomain.getCardNo("C",applyInfo.getDomicileCode()));//城市低保
				//把低保证号，救助开始日期维护到SamFamilyTreatment
				resolveTreatment(applyInfo);
				//插入特定的救助类型：城市低保
				insertSpecialAssistance(applyInfo);
				//调用存储过程把记录保存到备用表中
				samApplyInfoDomain.toDuplicateRecord(applyInfo);
			}else if("0".equals(applyInfo.getAuditOpinionId())){
				applyInfo.setCurActivityId("audit");
				applyInfo.setCurActivityName("审批");
				applyInfo.setCurOpinion("审批不同意");
				applyInfo.setIsFinish("1");
				applyInfo.setFinishTime(DateUtil.getTime());
				//调用存储过程把记录保存到备用表中
				samApplyInfoDomain.toDuplicateRecord(applyInfo);
			}
		}
		
	}
	/**
	 * 更新流程意见
	 */
	public void updateApply(SamApplyInfo applyInfo) {
		handleFamily(applyInfo);//处理家庭基本信息
		handleSurvey(applyInfo);//处理入户调查信息
		handleNoticeList(applyInfo);//处理公示结果信息
		//判断是审核环节还是审批环节来维护相应字段
		if("check".equals(applyInfo.getSamApplySurveyList().get(0).getActivityId())){
			applyInfo.setCheckPeopleId(BspUtil.getEmpOrgan().getOrganId());
			applyInfo.setCheckPeopleName(BspUtil.getEmpOrgan().getOrganName());
			applyInfo.setCheckDeptId(BspUtil.getDeptStruId());
			if("1".equals(applyInfo.getCheckOpinionId())){
				applyInfo.setCurOpinion("审核同意");
			}else if("0".equals(applyInfo.getCheckOpinionId())){
				applyInfo.setCurOpinion("审核不同意");
			}else if("3".equals(applyInfo.getCheckOpinionId())){
				applyInfo.setCurOpinion("审核回退");
			}
		}else{
			applyInfo.setAuditPeopleId(BspUtil.getEmpOrgan().getOrganId());
			applyInfo.setAuditPeopleName(BspUtil.getEmpOrgan().getOrganName());
			applyInfo.setAuditDeptId(BspUtil.getDeptStruId());
			if("1".equals(applyInfo.getAuditOpinionId())){
				applyInfo.setCurOpinion("审批同意");
			}else if("0".equals(applyInfo.getAuditOpinionId())){
				applyInfo.setCurOpinion("审批不同意");
			}else if("3".equals(applyInfo.getAuditOpinionId())){
				applyInfo.setCurOpinion("审批回退");
			}
		}
		BaseinfoFamily baseinfoFamily=applyInfo.getBaseInfoFamily();
		applyInfo.setAssistancePeopleNum(baseinfoFamily.getAssistancePeopleNum());
		applyInfo.setAssistanceMoney(baseinfoFamily.getAssistanceMoney());
		applyInfo.setAssistanceClassMoney(baseinfoFamily.getAssistanceClassMoney());
		applyInfo.setAssistanceMode(baseinfoFamily.getAssistanceMode());
		applyInfo.setAsisstanceClass(baseinfoFamily.getAssistanceClass());
		samApplyInfoDomain.update(applyInfo);
	}
	
	/**
	 * 保存照片
	 * @param photoText
	 * @return
	 */
	public String savePhoto(String photoText) {
		String photoId = "";
		if (null != photoText && !"".equals(photoText)) {
			// 保存图片到表 COM_PHOTO 中，并返回该图片的主键
			photoId = PhotoUtil.savePhoto(photoText);
		}
		return photoId;
	}
	/**
	 * 更新照片
	 */
	public String updatePhoto(String photoId, String photoText) {
		return samApplyInfoDomain.updatePhoto(photoId, photoText);
	}
	/**
	 * 校验身份证
	 * @param idCard 身份证号码
	 * @return familyId或者此人享有其他待遇的提示
	 */
	public Map<String, String> checkIDCard(String idCard) {
		Map<String,String> map=new HashMap<String, String>();
		String familyId="";
		String errorFlag="";
		String peopleId="";
		String personalStatsTag="";
		ParameterSet pset =new ParameterSet();
		pset.setParameter("ID_CARD",idCard);
		try{
			DataSet ds=baseinfoDomain.queryPeople(pset);//查询人员表
			if(ds.getCount()>0){//人员表里有
				Record record=ds.getRecord(0);
				familyId=(String)record.get("familyId");
				peopleId=(String)record.get("peopleId");
			//	String domicileName=(String)record.get("domicileName");
				personalStatsTag=(String)record.get("personalStatsTag");
				pset.clear();
				pset.setParameter("FAMILY_ID",familyId);
				pset.setParameter("ASSISTANCE_TYPE@in","01,02,03");//救助类型
				DataSet TreatmentDs=samFamilyTreatmentDomain.queryForCheckIDCard(pset);//查询待遇信息表
				if(TreatmentDs.getCount()>0){//如果待遇信息表里有
					String assistanceType=(String)TreatmentDs.getRecord(0).get("ASSISTANCE_TYPE");
					String domicileCode=(String)TreatmentDs.getRecord(0).get("DOMICILE_CODE");
					
					String domicileName=DicUtil.getTextValueFromDic("dic_city","ID",domicileCode,"NAME");
					
					if( DateUtil.StringTimeToInt( (String)TreatmentDs.getRecord(0).get("BEGIN_DATE") ) > DateUtil.StringTimeToInt(DateUtil.getMonth()) ){
						errorFlag="此人已经在"+domicileName+"申请救助："+returnChinese(assistanceType)+"，救助开始月份为："+(String)TreatmentDs.getRecord(0).get("BEGIN_DATE");
					}else{
						errorFlag="此人正在"+domicileName+"享受救助："+returnChinese(assistanceType);
					}
				}else{//如果待遇信息表里没有
					pset.clear();
					pset.setParameter("FAMILY_ID",familyId);
					pset.setParameter("IS_FINISH","0");
					DataSet applyDs=samApplyInfoDomain.query(pset);
					if(applyDs.getCount()>0){
						String applyType=(String)applyDs.getRecord(0).get("applyType");
						String nname=(String)applyDs.getRecord(0).get("domicileName");
						errorFlag="此人正在"+nname+"申请救助业务："+returnChinese(applyType.substring(0, 2));
					}
				}
			}
		}catch (Exception e) {
			errorFlag = "errorFlag";
		}
		map.put("familyId", familyId);
		map.put("errorFlag", errorFlag);
		map.put("peopleId", peopleId);
		map.put("personalStatsTag", personalStatsTag);
		return map;
	}
	/**
	 * 通过传入的代码返回相应的业务类型
	 * @param assistanceType
	 * @return
	 */
	private String returnChinese(String assistanceType) {
		if("01".equals(assistanceType)){
			assistanceType="城市低保";
		}else if("02".equals(assistanceType)){
			assistanceType="农村低保";
		}else if("03".equals(assistanceType)){
			assistanceType="五保";
		}
		return assistanceType;
	}
	/**
	 * 获取当前救助标准
	 */
	public String getLowStandards(ParameterSet pset) {
		pset.setParameter("DOMICILE_CODE@like",BspUtil.getOrganCode().substring(0,6));
		DataSet ds = samLowStandardsDomain.query(pset);
		if(ds.getCount() > 0){
			return (String)ds.getRecord(0).get("lowStandards");
		}else{
			return "0";
		}
	}
	// TODO ###############################                私有方法                ##########################################################
	/**
	 * 处理业务信息
	 */
	private void handleApply(SamApplyInfo applyInfo) {
		fillApplyInfo(applyInfo);//根据家庭信息生成业务信息
		if(applyInfo.getApplyId() == null || "".equals(applyInfo.getApplyId()) || "null".equals(applyInfo.getApplyId())){//新增
			applyInfo.setApplyId(IdHelp.getUUID32());
			applyInfo.setFamilyId(applyInfo.getBaseInfoFamily().getFamilyId());
			applyInfo.setAcceptDate(DateUtil.getDay());
			applyInfo.setAcceptDeptId(BspUtil.getDeptStruId());
			applyInfo.setAcceptOrganId(BspUtil.getDeptOrganId());
			applyInfo.setAcceptPeopleId(BspUtil.getEmpOrgan().getOrganId());
			applyInfo.setAcceptPeopleName(BspUtil.getEmpOrgan().getOrganName());
			samApplyInfoDomain.insert(applyInfo);
			create(applyInfo);//发起流程
		}else{
			samApplyInfoDomain.update(applyInfo);//修改
		}
	}
	/**
	 * 发起流程
	 * @param applyInfo
	 */
	@SuppressWarnings("unchecked")
	private void create(SamApplyInfo applyInfo) {
		//传入相应参数
		Map actDefMap = WfQuery.getActDefInfoByProcDefUniqueIdAndActDefId(PROC_DEF_UNIQUE_ID,START_ACT_DEF_ID);
		String actDefUniqueId = (String)actDefMap.get("actDefUniqueId");
		CommandContext.setContextParameter("procDefUniqueId",PROC_DEF_UNIQUE_ID);
		CommandContext.setContextParameter("startActDefUniqueId",actDefUniqueId);
		//创建流程
		Map wfMap = WfTaskRequestWrapper.getInstance().create(applyInfo.getApplyId(), applyInfo.getFamilyName() + "城市低保业务申请");
		//得到委派实例ID
		List actList = (List) wfMap.get("actList");
		Map map1 = (Map) actList.get(0);
		List assList = (List) map1.get("assList");
		Map map2 = (Map) assList.get(0);
		String assignmentId = (String) map2.get("assignmentId");
		applyInfo.setAssignmentId(assignmentId);
	}

	/**
	 * 根据家庭信息生成业务信息
	 * @param baseinfoFamily
	 */
	private void fillApplyInfo(SamApplyInfo applyInfo) {
		BaseinfoFamily baseinfoFamily=applyInfo.getBaseInfoFamily();
		applyInfo.setFamilyName(baseinfoFamily.getFamilyName());
		applyInfo.setFamilyCardNo(baseinfoFamily.getFamilyCardNo());
		applyInfo.setPeopleNum(baseinfoFamily.getPeopleNum());
		applyInfo.setDomicileCode(baseinfoFamily.getDomicileCode());
		applyInfo.setDomicileName(baseinfoFamily.getDomicileName());
	
		applyInfo.setAssistancePeopleNum(baseinfoFamily.getAssistancePeopleNum());
		applyInfo.setAssistanceMoney(baseinfoFamily.getAssistanceMoney());
		applyInfo.setAssistanceClassMoney(baseinfoFamily.getAssistanceClassMoney());
		applyInfo.setAssistanceMode(baseinfoFamily.getAssistanceMode());
		applyInfo.setAsisstanceClass(baseinfoFamily.getAssistanceClass());
		
		applyInfo.setApplyType(SamApplyType.SAM_CITY_NEW_APPLY);//申请业务类别
		applyInfo.setApplyDate(baseinfoFamily.getApplyDate());
		applyInfo.setApplyReason(baseinfoFamily.getApplyReason());
	//	applyInfo.setCurActivityId("accept");
		//applyInfo.setCurActivityName("受理");
		//受理意见为评议结果
		applyInfo.setAcceptOpinionId(applyInfo.getSamApplyDiscussionList().get(0).getDiscussionResult());
		if("0".equals(applyInfo.getAcceptOpinionId())){
			applyInfo.setCurOpinion("受理不同意");
		}else if("1".equals(applyInfo.getAcceptOpinionId())){
			applyInfo.setCurOpinion("受理同意");
		}
		applyInfo.setAcceptDeptId(BspUtil.getDeptStruId());
		
		
	}
	/**
	 * 处理流程意见
	 * @param applyInfo
	 */
	private void handleOptionsHis(SamApplyInfo applyInfo,String activityId) {
		//生成新的历史流程意见
		SamApplyOptionsHis samApplyOptionsHis=new SamApplyOptionsHis();
		samApplyOptionsHis.setApplyId(applyInfo.getApplyId());
		samApplyOptionsHis.setOpinionHisId(IdHelp.getUUID32());
		samApplyOptionsHis.setPeopleName(BspUtil.getEmpOrgan().getOrganName());
		samApplyOptionsHis.setPeopleId(BspUtil.getEmpOrgan().getOrganId());
		samApplyOptionsHis.setExamineDate(DateUtil.getTime());
		samApplyOptionsHis.setOrganId(BspUtil.getCorpOrgan().getOrganId());
		samApplyOptionsHis.setDeptId(BspUtil.getDeptStruId());
		samApplyOptionsHis.setActivityId(activityId);
		//判断是审核还是审批环节，维护相应字段
		if("check".equals(activityId)){
			samApplyOptionsHis.setOpinionId(applyInfo.getCheckOpinionId());
			samApplyOptionsHis.setRemarks(applyInfo.getCheckRemarks());
			samApplyOptionsHis.setPrincipal(applyInfo.getCheckPrincipal());
			samApplyOptionsHis.setExamineDate(applyInfo.getCheckDate());
			samApplyOptionsHis.setAgent(applyInfo.getCheckAgent());
		}else{
			samApplyOptionsHis.setOpinionId(applyInfo.getAuditOpinionId());
			samApplyOptionsHis.setRemarks(applyInfo.getAuditRemarks());
			samApplyOptionsHis.setPrincipal(applyInfo.getAuditPrincipal());
			samApplyOptionsHis.setExamineDate(applyInfo.getAuditDate());
		}
		samApplyOptionsHisDomain.insert(samApplyOptionsHis);
		applyInfo.setSamApplyOptionsHis(samApplyOptionsHis);
	}
	/**
	 * 处理公示结果
	 * @param applyInfo
	 */
	private void handleNoticeList(SamApplyInfo applyInfo) {
		List<SamApplyNotice> samApplyNoticeList = applyInfo.getSamApplyNoticeList();
		ParameterSet pset =new ParameterSet();
		for (int i = 0; i < samApplyNoticeList.size(); i++) {
			SamApplyNotice samApplyNotice = samApplyNoticeList.get(i);
			pset.clear();
			pset.setParameter("APPLY_ID",applyInfo.getApplyId());
			pset.setParameter("ACTIVITY_ID",samApplyNotice.getActivityId());
			DataSet ds=samApplyNoticeDomain.query(pset);
			if(ds.getCount() == 1){//如果已经存在，更新
				SamApplyNotice bean=(SamApplyNotice)ds.getRecord(0).toBean(SamApplyNotice.class);
				String noticeResult=samApplyNotice.getNoticeResult();
				bean.setBeginDate(samApplyNotice.getBeginDate());
				bean.setEndDate(samApplyNotice.getEndDate());
				bean.setNoticeResult(samApplyNotice.getNoticeResult());
				bean.setPrincipal(samApplyNotice.getPrincipal());
				bean.setRemarks(samApplyNotice.getRemarks());
				samApplyNoticeDomain.update(bean);
			}else if(ds.getCount() == 0){//如果不存在，新增
				samApplyNotice.setApplyId(applyInfo.getApplyId());
				samApplyNotice.setNoticeId(IdHelp.getUUID32());
				samApplyNoticeDomain.insert(samApplyNotice);
			}
		}
		
	}
	/**
	 * 处理评议结果
	 * @param applyInfo
	 */
	private void handleDiscussion(SamApplyInfo applyInfo) {
		List<SamApplyDiscussion> samApplyDiscussionList = applyInfo.getSamApplyDiscussionList();
		ParameterSet pset =new ParameterSet();
		for (int i = 0; i < samApplyDiscussionList.size(); i++) {
			SamApplyDiscussion samApplyDiscussion = samApplyDiscussionList.get(i);
			pset.clear();
			pset.setParameter("APPLY_ID",applyInfo.getApplyId());
			pset.setParameter("ACTIVITY_ID",samApplyDiscussion.getActivityId());
			DataSet ds=samApplyDiscussionDomain.query(pset);
			if(ds.getCount() == 1){//如果已经存在，更新
				SamApplyDiscussion bean=(SamApplyDiscussion)ds.getRecord(0).toBean(SamApplyDiscussion.class);
				bean.setContent(samApplyDiscussion.getContent());
				bean.setDiscussionDate(samApplyDiscussion.getDiscussionDate());
				bean.setDiscussionResult(samApplyDiscussion.getDiscussionResult());
				bean.setPrincipal(samApplyDiscussion.getPrincipal());
				bean.setRemars(samApplyDiscussion.getRemars());
				bean.setAgreeNum(samApplyDiscussion.getAgreeNum());
				bean.setTotal(samApplyDiscussion.getTotal());
				bean.setDisagreeNum(samApplyDiscussion.getDisagreeNum());
				samApplyDiscussionDomain.update(bean);
			}else if(ds.getCount() == 0){//如果不存在，新增
				samApplyDiscussion.setApplyId(applyInfo.getApplyId());
				samApplyDiscussion.setDiscussionId(IdHelp.getUUID32());
				samApplyDiscussionDomain.insert(samApplyDiscussion);
			}
		}
	}
	/**
	 * 处理入户调查
	 * @param applyInfo
	 */
	private void handleSurvey(SamApplyInfo applyInfo) {
		List<SamApplySurvey> samApplySurveyList = applyInfo.getSamApplySurveyList();
		ParameterSet pset =new ParameterSet();
		for (int i = 0; i < samApplySurveyList.size(); i++) {
			SamApplySurvey samApplySurvey = samApplySurveyList.get(i);
			pset.clear();
			pset.setParameter("APPLY_ID",applyInfo.getApplyId());
			pset.setParameter("ACTIVITY_ID",samApplySurvey.getActivityId());
			DataSet ds=samApplySurveyDomain.query(pset);
			if(ds.getCount() == 1){//如果已经存在，更新
				SamApplySurvey bean=(SamApplySurvey)ds.getRecord(0).toBean(SamApplySurvey.class);
				bean.setRemarks(samApplySurvey.getRemarks());
				bean.setSurveyContents(samApplySurvey.getSurveyContents());
				bean.setSurveyDate(samApplySurvey.getSurveyDate());
				bean.setSurveyPeople(samApplySurvey.getSurveyPeople());
				bean.setSurveyResult(samApplySurvey.getSurveyResult());
				samApplySurveyDomain.update(bean);
			}else if(ds.getCount() == 0){//如果不存在，新增
				samApplySurvey.setApplyId(applyInfo.getApplyId());
				samApplySurvey.setSurveyId(IdHelp.getUUID32());
				samApplySurveyDomain.insert(samApplySurvey);
			}
		}
		
	}
	/**
	 * 处理家庭基本信息
	 */
	private void handleFamily(SamApplyInfo applyInfo) {
		BaseinfoFamily baseinfoFamily=applyInfo.getBaseInfoFamily();
		String familyId=baseinfoFamily.getFamilyId();
		if("".equals(familyId) || familyId == null){//新增
			baseinfoFamily.setPhotoId(savePhoto(baseinfoFamily.getPhotoTemp()));//保存照片
			baseinfoFamily.setVillage(baseinfoFamily.getDomicileCode());
			baseinfoDomain.insertFamily(baseinfoFamily);
		}else{//修改
			String photoId=baseinfoFamily.getPhotoId();
			String photoTemp=baseinfoFamily.getPhotoTemp();
			if(photoId==null||"".equals(photoId)){
				//保存照片
				photoId=savePhoto(photoTemp);
			}else{
				//更新照片
				photoId=updatePhoto(photoId, photoTemp);
			}
			baseinfoFamily.setPhotoId(photoId );//更新照片
			baseinfoDomain.updateFamily(baseinfoFamily);
		}
		//更新人员的地区字段
		ParameterSet pset =new ParameterSet();
		pset.setParameter("FAMILY_ID",baseinfoFamily.getFamilyId());
		DataSet ds=baseinfoDomain.queryPeople(pset);
		if(ds.getCount() > 0){
			for(int i=0;i<ds.getCount();i++){
				BaseinfoPeople bean=(BaseinfoPeople)ds.getRecord(i).toBean(BaseinfoPeople.class);
				bean.setDomicileCode(baseinfoFamily.getDomicileCode());
				bean.setDomicileName(baseinfoFamily.getDomicileName());
				baseinfoDomain.updatePeople(bean);
			}
			
		}
		
	}
	/**
	 * 处理家庭待遇信息
	 * @param applyInfo
	 * @return
	 */
	private void resolveTreatment(SamApplyInfo applyInfo) {
		SamFamilyTreatment samFamilyTreatment=new SamFamilyTreatment();
		samFamilyTreatment.setTreatmentId(IdHelp.getUUID32());
		samFamilyTreatment.setFamilyId(applyInfo.getFamilyId());
		samFamilyTreatment.setApplyId(applyInfo.getApplyId());
		samFamilyTreatment.setAssistanceMode(applyInfo.getAssistanceMode());
		samFamilyTreatment.setAssistanceMoney(applyInfo.getAssistanceMoney());
		samFamilyTreatment.setAssistanceClassMoney(applyInfo.getAssistanceClassMoney());
		samFamilyTreatment.setAssistancePeopleNum(applyInfo.getAssistancePeopleNum());
		samFamilyTreatment.setDomicileCode(applyInfo.getDomicileCode());
		samFamilyTreatment.setAssistanceType("01");//城市低保
//		if(applyInfo.getBeginDate().trim() == null || "".equals(applyInfo.getBeginDate().trim())){
//			throw new  RuntimeException("数据异常！未获取开始时间 at line 693！");
//		}
		
		samFamilyTreatment.setBeginDate(applyInfo.getBeginDate());
		samFamilyTreatment.setEndDate("3000-12");
		samFamilyTreatment.setCardNo(applyInfo.getCardNo());
		samFamilyTreatment.setReleaseWay("01");//发放方式：社会化发放
		samFamilyTreatment.setDataSource("apply");//数据来源：apply
		//samFamilyTreatment.setEnsureType(applyInfo.getEnsureType());
		samFamilyTreatmentDomain.insert(samFamilyTreatment);
	}
	/**
	 * 处理救助类型
	 * @param applyInfo
	 */
	private void handleAssistance(SamApplyInfo applyInfo) {
		List<SamFamilyAssistance> samFamilyAssistanceList = applyInfo.getSamFamilyAssistanceList();
		BaseinfoFamily baseinfoFamily=applyInfo.getBaseInfoFamily();
		String familyId=baseinfoFamily.getFamilyId();
		if(familyId !=null && !"".equals(familyId)){
			samFamilyAssistanceDomain.deleteByFamilyId(familyId);
			for (int i = 0; i < samFamilyAssistanceList.size(); i++) {
				SamFamilyAssistance samFamilyAssistance=samFamilyAssistanceList.get(i);
				samFamilyAssistance.setFamilyId(familyId);
				samFamilyAssistanceDomain.insert(samFamilyAssistance);
			}
		}
		
	}
	
	/**
	 * 保存低保家庭成员信息
	 */
	public BaseinfoFamily insertPeopleInfo(BaseinfoPeople baseinfoPeople,String applyId,String assistanceModeValue){
		String photoId=baseinfoPeople.getPhotoId();
		String photoTemp=baseinfoPeople.getPhotoTemp();
		if(photoId==null||"".equals(photoId)){
			//保存照片
			photoId=savePhoto(photoTemp);
		}else{
			//更新照片
			photoId=updatePhoto(photoId, photoTemp);
		}
		baseinfoPeople.setPhotoId(photoId);
		//处理人员成员信息
		String peopleId=handlePeople(baseinfoPeople);
		//处理户主信息
		if("01".equals(baseinfoPeople.getRelationshipType())){
			BaseinfoFamily baseinfoFamily= baseinfoDomain.getFamily(baseinfoPeople.getFamilyId());
			baseinfoFamily.setFamilyCardNo(baseinfoPeople.getIdCard());
			baseinfoFamily.setFamilyName(baseinfoPeople.getName());
			baseinfoDomain.updateFamily(baseinfoFamily);
		}
		baseinfoPeople.setPeopleId(peopleId);
		//处理人员类型信息
		handlePeopleType(baseinfoPeople);
		//处理人员扩展信息
		handlePeopleExtend(baseinfoPeople);
		//处理人员患病信息
		handlePeopleDisease(baseinfoPeople);
		//处理人员残疾信息
		handlePeopleDisability(baseinfoPeople);
		//处理人员教育信息
		handlePeopleEdu(baseinfoPeople);
		//处理人员收入信息
		handlePeopleIncome(baseinfoPeople);
		//处理人员就业信息
		handlePeopleJobs(baseinfoPeople);
		//处理人员保险信息
		handlePeopleInsurance(baseinfoPeople);	
		//根据人员月收入更新家庭收入
		baseinfoDomain.updateIncomeByMonth(baseinfoPeople.getFamilyId());
		//更新家庭人口信息
		baseinfoDomain.updatePeopleNum(baseinfoPeople.getFamilyId());
		//查询家庭信息
		BaseinfoFamily baseinfoFamily=baseinfoDomain.getFamily(baseinfoPeople.getFamilyId());
		
		//更新apply信息
		if( !"".equals(applyId) && applyId != null){
			ParameterSet pset =new ParameterSet();
			pset.setParameter("APPLY_ID", applyId);
			DataSet ds = samApplyInfoDomain.query(pset);
			if(ds.getCount() > 0 ){
				SamApplyInfo samApplyInfo=(SamApplyInfo)ds.getRecord(0).toBean(SamApplyInfo.class);
				samApplyInfo.setAssistancePeopleNum(baseinfoFamily.getAssistancePeopleNum());
				samApplyInfo.setPeopleNum(baseinfoFamily.getPeopleNum());
				
				if("10".equals(assistanceModeValue)){//如果救助金计算方式是补差，才进行户月保障金的计算
					//户月保障金的计算
					BigDecimal assistanceMoney=samApplyInfoDomain.getCityAssistanceMoney(baseinfoFamily);
					baseinfoFamily.setAssistanceMoney(assistanceMoney);
					samApplyInfo.setAssistanceMoney(assistanceMoney);
				}
				samApplyInfoDomain.update(samApplyInfo);
			}
		}
		
		
		return baseinfoFamily;
	}
	/**
	 * 删除低保家庭成员信息
	 */
	public BaseinfoFamily deletePeopleInfo(String peopleId,String familyId,String applyId,String assistanceModeValue){
		//处理人员成员信息
		baseinfoDomain.deletePeople(peopleId);
		//处理人员类型信息
		samPeopleTypeDomain.deleteByPeopleId(peopleId);
		//处理人员扩展信息
		samPeopleExtendDomain.deleteByPeopleId(peopleId);
		//处理人员患病信息
		samPeopleDiseaseDomain.delete(peopleId);
		//处理人员残疾信息
		samPeopleDisabilityDomain.delete(peopleId);
		//处理人员教育信息
		samPeopleEduDomain.delete(peopleId);
		//处理人员收入信息
		samPeopleIncomeDomain.deleteByPeopleId(peopleId);
		//处理人员就业信息
		samPeopleJobsDomain.deleteByPeopleId(peopleId);
		//处理人员保险信息
		samPeopleInsuranceDomain.deleteByPeopleId(peopleId);	
		//根据人员月收入更新家庭收入
		baseinfoDomain.updateIncomeByMonth(familyId);
		//更新家庭人口信息		
		baseinfoDomain.updatePeopleNum(familyId);
		//查询家庭信息
		BaseinfoFamily baseinfoFamily=baseinfoDomain.getFamily(familyId);
		//更新apply信息
		if( !"".equals(applyId) && applyId != null){
			ParameterSet pset =new ParameterSet();
			pset.setParameter("APPLY_ID", applyId);
			DataSet ds = samApplyInfoDomain.query(pset);
			if(ds.getCount() > 0 ){
				SamApplyInfo samApplyInfo=(SamApplyInfo)ds.getRecord(0).toBean(SamApplyInfo.class);
				samApplyInfo.setAssistancePeopleNum(baseinfoFamily.getAssistancePeopleNum());
				samApplyInfo.setPeopleNum(baseinfoFamily.getPeopleNum());
				if("10".equals(assistanceModeValue)){//如果救助金计算方式是补差，才进行户月保障金的计算
					//户月保障金的计算
					BigDecimal assistanceMoney=samApplyInfoDomain.getCityAssistanceMoney(baseinfoFamily);
					baseinfoFamily.setAssistanceMoney(assistanceMoney);
					samApplyInfo.setAssistanceMoney(assistanceMoney);
				}
				samApplyInfoDomain.update(samApplyInfo);
			}
		}
		return baseinfoFamily;
	}
	/**
	 * 补差计算户月保障金
	 */
	public String getAssistanceMoney(ParameterSet pset){
		String applyId=(String)pset.getParameter("applyId");
		String familyId=(String)pset.getParameter("familyId");
		if( !"".equals(applyId) && applyId != null){
			//查询家庭信息
			BaseinfoFamily baseinfoFamily=baseinfoDomain.getFamily(familyId);
			pset.clear();
			pset.setParameter("APPLY_ID", applyId);
			DataSet ds = samApplyInfoDomain.query(pset);
			if(ds.getCount() > 0 ){
				SamApplyInfo samApplyInfo=(SamApplyInfo)ds.getRecord(0).toBean(SamApplyInfo.class);
				samApplyInfo.setAssistancePeopleNum(baseinfoFamily.getAssistancePeopleNum());
				samApplyInfo.setPeopleNum(baseinfoFamily.getPeopleNum());
				//户月保障金的计算
				BigDecimal assistanceMoney=samApplyInfoDomain.getCityAssistanceMoney(baseinfoFamily);
				samApplyInfo.setAssistanceMoney(assistanceMoney);
				samApplyInfoDomain.update(samApplyInfo);
				baseinfoFamily.setAssistanceMoney(samApplyInfo.getAssistanceMoney());
				return samApplyInfo.getAssistanceMoney().toString();
			}
		}
		return "0";
	}
	/**
	 * 处理人员成员信息
	 */
	private String handlePeople(BaseinfoPeople baseinfoPeople) {
		String peopleId=baseinfoPeople.getPeopleId();
		if("".equals(peopleId) || peopleId == null){//新增
			baseinfoPeople.setCityResiFlag("1");//城市低保标志
			baseinfoPeople.setPersonalStatsTag("01");//人员状态正常
			baseinfoDomain.insertPeople(baseinfoPeople);
		}else{//修改
			baseinfoDomain.updatePeople(baseinfoPeople);
		}
		return baseinfoPeople.getPeopleId();
	}
	/**
	 * 处理人员类型
	 * @param baseinfoPeople
	 */
	private void handlePeopleType(BaseinfoPeople baseinfoPeople) {
		List<SamPeopleType> samPeopleTypeList = baseinfoPeople.getSamPeopleTypeList();
		String peopleId=baseinfoPeople.getPeopleId();
		samPeopleTypeDomain.deleteByPeopleId(peopleId);
		for (int i = 0; i < samPeopleTypeList.size(); i++) {
			SamPeopleType samPeopleType=samPeopleTypeList.get(i);
			samPeopleType.setPeopleTypeId(IdHelp.getUUID32());
			samPeopleType.setPeopleId(peopleId);
			samPeopleTypeDomain.insert(samPeopleType);
		}
	}
	/**
	 * 处理人员扩展信息
	 */
	private void handlePeopleExtend(BaseinfoPeople baseinfoPeople) {
		SamPeopleExtend peopleExtend=baseinfoPeople.getSamPeopleExtend();
		String extendId=peopleExtend.getExtnedId();
		if("".equals(extendId) || extendId == null){//新增
			peopleExtend.setExtnedId(IdHelp.getUUID32());
			peopleExtend.setPeopleId(baseinfoPeople.getPeopleId());
			samPeopleExtendDomain.insert(peopleExtend);
		}else{//修改
			samPeopleExtendDomain.update(peopleExtend);
		}
	}
	/**
	 * 处理人员患病信息
	 */
	private void handlePeopleDisease(BaseinfoPeople baseinfoPeople) {
		SamPeopleDisease peopleDisease=baseinfoPeople.getSamPeopleDisease();
		if(peopleDisease!=null){
			String peopleId=peopleDisease.getPeopleId();
			if("".equals(peopleId) || peopleId == null){//新增
				peopleDisease.setPeopleId(baseinfoPeople.getPeopleId());
				samPeopleDiseaseDomain.insert(peopleDisease);
			}else{//修改
				samPeopleDiseaseDomain.update(peopleDisease);
			}
		}else{
			samPeopleDiseaseDomain.delete(baseinfoPeople.getPeopleId());
		}
	}
	/**
	 * 处理人员残疾信息
	 */
	private void handlePeopleDisability(BaseinfoPeople baseinfoPeople) {
		SamPeopleDisability peopleDisability=baseinfoPeople.getSamPeopleDisability();
		if(peopleDisability!=null){
			String peopleId=peopleDisability.getPeopleId();
			if("".equals(peopleId) || peopleId == null){//新增
				peopleDisability.setPeopleId(baseinfoPeople.getPeopleId());
				samPeopleDisabilityDomain.insert(peopleDisability);
			}else{//修改
				samPeopleDisabilityDomain.update(peopleDisability);
			}
		}else{
			samPeopleDisabilityDomain.delete(baseinfoPeople.getPeopleId());
		}
	}
	/**
	 * 处理人员教育信息
	 */
	private void handlePeopleEdu(BaseinfoPeople baseinfoPeople) {
		SamPeopleEdu peopleEdu=baseinfoPeople.getSamPeopleEdu();
		String peopleId=peopleEdu.getPeopleId();
		if("".equals(peopleId) || peopleId == null){//新增
			peopleEdu.setPeopleId(baseinfoPeople.getPeopleId());
			peopleEdu.setRegDate(DateUtil.getDay());
			samPeopleEduDomain.insert(peopleEdu);
		}else{//修改
			samPeopleEduDomain.update(peopleEdu);
		}
	}
	/**
	 * 处理人员收入信息
	 */
	private void handlePeopleIncome(BaseinfoPeople baseinfoPeople) {
		//人员月收入
		BigDecimal incomeMonth=baseinfoPeople.getIncomeMonth();
		if(incomeMonth!=null&&!"".equals(incomeMonth)){
			SamPeopleIncome peopleIncome=new SamPeopleIncome();
			peopleIncome.setIncomeNum(incomeMonth+"");
			ParameterSet pset=new ParameterSet();
			pset.setParameter("PEOPLE_ID", baseinfoPeople.getPeopleId());
			DataSet ds=samPeopleIncomeDomain.query(pset);
			if (ds.getCount()>0) {
				//修改
				peopleIncome=(SamPeopleIncome) ds.getRecord(0).toBean(SamPeopleIncome.class);
				samPeopleIncomeDomain.update(peopleIncome);
			}else{
				//新增				
				peopleIncome.setIncomeId(IdHelp.getUUID32());
				peopleIncome.setPeopleId(baseinfoPeople.getPeopleId());
				samPeopleIncomeDomain.insert(peopleIncome);
			}			
		}
	}
	/**
	 * 处理人员就业信息
	 */
	private void handlePeopleJobs(BaseinfoPeople baseinfoPeople) {
		SamPeopleJobs peopleJobs=baseinfoPeople.getSamPeopleJobs();
		if(peopleJobs!=null){
			String jobId=peopleJobs.getJobId();
			if ("".equals(peopleJobs.getUnitName())) {
				samPeopleJobsDomain.deleteByPeopleId(baseinfoPeople.getPeopleId());
			}else{
				if("".equals(jobId) || jobId == null){//新增
					peopleJobs.setJobId(IdHelp.getUUID32());
					peopleJobs.setPeopleId(baseinfoPeople.getPeopleId());
					samPeopleJobsDomain.insert(peopleJobs);
				}else{//修改
					samPeopleJobsDomain.update(peopleJobs);
				}
			}
		}
	}
	/**
	 * 处理人员保险信息
	 */
	public void handlePeopleInsurance(BaseinfoPeople baseinfoPeople){
		List<SamPeopleInsurance> peopleInsuranceList =baseinfoPeople.getSamPeopleInsuranceList();
		for (int i = 0; i < peopleInsuranceList.size(); i++) {
			SamPeopleInsurance samPeopleInsurance = peopleInsuranceList.get(i);
			if (samPeopleInsurance.getState() == Record.STATE_NEW) {
				samPeopleInsurance.setInsuranceId(IdHelp.getUUID32());
				samPeopleInsurance.setPeopleId(baseinfoPeople.getPeopleId());
				samPeopleInsuranceDomain.insert(samPeopleInsurance);
			} else if (samPeopleInsurance.getState() == Record.STATE_MODIFIED) {
				samPeopleInsuranceDomain.update(samPeopleInsurance);
			} else if (samPeopleInsurance.getState() == Record.STATE_DELETED) {
				samPeopleInsuranceDomain.delete(samPeopleInsurance.getInsuranceId());
			}
		}		
	}
	/**
	 * 插入特定救助类型
	 */
	private void insertSpecialAssistance(SamApplyInfo applyInfo){
		ParameterSet pset=new ParameterSet();
		pset.setParameter("ASSISTANCE_TYPE","01");
		pset.setParameter("FAMILY_ID",applyInfo.getFamilyId());
		DataSet ds=samFamilyAssistanceDomain.query(pset);
		if(ds.getCount() > 0 ){
			SamFamilyAssistance samFamilyAssistance=(SamFamilyAssistance)ds.getRecord(0).toBean(SamFamilyAssistance.class);
			samFamilyAssistance.setCardNo(applyInfo.getCardNo());
			samFamilyAssistance.setAssistanceMon(applyInfo.getAssistanceMoney());
			samFamilyAssistance.setAssistanceClassMon(applyInfo.getAssistanceClassMoney());
			samFamilyAssistance.setAssistanceBegin(applyInfo.getBeginDate());
			samFamilyAssistanceDomain.update(samFamilyAssistance);
		}else{
			SamFamilyAssistance samFamilyAssistance=new SamFamilyAssistance();
			samFamilyAssistance.setFamilyId(applyInfo.getFamilyId());
			samFamilyAssistance.setAssistanceType("01");//城市低保
			samFamilyAssistance.setCardNo(applyInfo.getCardNo());
			samFamilyAssistance.setAssistanceMon(applyInfo.getAssistanceMoney());
			samFamilyAssistance.setAssistanceClassMon(applyInfo.getAssistanceClassMoney());
			samFamilyAssistance.setAssistanceBegin(applyInfo.getBeginDate());
			samFamilyAssistanceDomain.insert(samFamilyAssistance);
		}
	}
	
	public void batchSaveCheck(SamApplyInfo batchApply){
		List<String> applyIdList = batchApply.getApplyIdList();
		List<String> assignmentIdList = batchApply.getAssignmentIdList();
		
		List<SamApplySurvey> samApplySurveyList = batchApply.getSamApplySurveyList();
		List<SamApplyNotice> samApplyNoticeList = batchApply.getSamApplyNoticeList();
		List<SamApplyDiscussion> SamApplyDiscussionList = batchApply.getSamApplyDiscussionList();
		
		for (int i = 0; i < applyIdList.size(); i++) {
			String applyId=applyIdList.get(i);
			String assignmentId= assignmentIdList.get(i);
			if(applyId != null && !"".equals(applyId)){
				List<SamApplyNotice> SamApplyNoticeList1 = new ArrayList<SamApplyNotice>();
				List<SamApplySurvey> samApplySurveyList1 =  new ArrayList<SamApplySurvey>();
				List<SamApplyDiscussion> SamApplyDiscussionList1 =  new ArrayList<SamApplyDiscussion>();
				for (int j = 0; j < samApplySurveyList.size(); j++) {
					SamApplySurvey bean=samApplySurveyList.get(j);
					bean.setApplyId(applyId);
					samApplySurveyList1.add(bean);
				}
				for (int j = 0; j < samApplyNoticeList.size(); j++) {
					SamApplyNotice bean=samApplyNoticeList.get(j);
					bean.setApplyId(applyId);
					SamApplyNoticeList1.add(bean);
				}
				SamApplyDiscussion samApplyDiscussion=SamApplyDiscussionList.get(0);
				samApplyDiscussion.setApplyId(applyId);
				SamApplyDiscussionList1.add(samApplyDiscussion);
				
				ParameterSet pset= new ParameterSet();
				pset.setParameter("APPLY_ID",applyId);
				DataSet ds = samApplyInfoDomain.query(pset);
				if(ds.getCount() > 0 ){
					SamApplyInfo samApplyInfo=(SamApplyInfo)ds.getRecord(0).toBean(SamApplyInfo.class);
					//页面上的内容填充
					samApplyInfo.setCheckRemarks(batchApply.getCheckRemarks());
					samApplyInfo.setCheckOpinionId(batchApply.getCheckOpinionId());
					samApplyInfo.setCheckPrincipal(batchApply.getCheckPrincipal());
					samApplyInfo.setCheckDate(batchApply.getCheckDate());
					samApplyInfo.setCheckAgent(batchApply.getCheckAgent());
					samApplyInfo.setCheckOrganId(BspUtil.getCorpOrganId());
					samApplyInfo.setCheckPeopleId(BspUtil.getEmpOrgan().getOrganId());
					samApplyInfo.setCheckPeopleName(BspUtil.getEmpOrgan().getOrganName());
					
					BaseinfoFamily baseInfoFamily = baseinfoDomain.getFamily(samApplyInfo.getFamilyId());
					baseInfoFamily.setAssistancePeopleNum(samApplyInfo.getAssistancePeopleNum());
					baseInfoFamily.setAssistanceMoney(samApplyInfo.getAssistanceMoney());
					baseInfoFamily.setAssistanceClassMoney(samApplyInfo.getAssistanceClassMoney());
					baseInfoFamily.setAssistanceMode(samApplyInfo.getAssistanceMode());
					baseInfoFamily.setAssistanceClass(samApplyInfo.getAsisstanceClass());
					
					samApplyInfo.setSamApplyDiscussionList(SamApplyDiscussionList1);
					handleDiscussion(samApplyInfo);
					
					samApplyInfo.setBaseInfoFamily(baseInfoFamily);
					samApplyInfo.setSamApplyNoticeList(SamApplyNoticeList1);
					samApplyInfo.setSamApplySurveyList(samApplySurveyList1);
					
					samApplyInfo.setAssignmentId(assignmentId);
					handleSurvey(samApplyInfo);//处理入户调查信息
					handleNoticeList(samApplyInfo);//处理公示结果信息
					samApplyInfoDomain.update(samApplyInfo);
				}
			}
		}
		
	}
	/**
	 * 街道批量提交 
	 */
	public void batchSubmitCheck(SamApplyInfo batchApply){
		List<String> applyIdList = batchApply.getApplyIdList();
		List<String> assignmentIdList = batchApply.getAssignmentIdList();
		
		List<SamApplySurvey> samApplySurveyList = batchApply.getSamApplySurveyList();
		List<SamApplyNotice> samApplyNoticeList = batchApply.getSamApplyNoticeList();
		List<SamApplyDiscussion> SamApplyDiscussionList = batchApply.getSamApplyDiscussionList();
		
		for (int i = 0; i < applyIdList.size(); i++) {
			String applyId=applyIdList.get(i);
			String assignmentId= assignmentIdList.get(i);
			if(applyId != null && !"".equals(applyId)){
				List<SamApplyNotice> SamApplyNoticeList1 = new ArrayList<SamApplyNotice>();
				List<SamApplySurvey> samApplySurveyList1 =  new ArrayList<SamApplySurvey>();
				List<SamApplyDiscussion> SamApplyDiscussionList1 =  new ArrayList<SamApplyDiscussion>();
				for (int j = 0; j < samApplySurveyList.size(); j++) {
					SamApplySurvey bean=samApplySurveyList.get(j);
					bean.setApplyId(applyId);
					samApplySurveyList1.add(bean);
				}
				for (int j = 0; j < samApplyNoticeList.size(); j++) {
					SamApplyNotice bean=samApplyNoticeList.get(j);
					bean.setApplyId(applyId);
					SamApplyNoticeList1.add(bean);
				}
				SamApplyDiscussion samApplyDiscussion=SamApplyDiscussionList.get(0);
				samApplyDiscussion.setApplyId(applyId);
				SamApplyDiscussionList1.add(samApplyDiscussion);
				
				ParameterSet pset= new ParameterSet();
				pset.setParameter("APPLY_ID",applyId);
				DataSet ds = samApplyInfoDomain.query(pset);
				if(ds.getCount() > 0 ){
					SamApplyInfo samApplyInfo=(SamApplyInfo)ds.getRecord(0).toBean(SamApplyInfo.class);
					//页面上的内容填充
					samApplyInfo.setCheckRemarks(batchApply.getCheckRemarks());
					samApplyInfo.setCheckOpinionId(batchApply.getCheckOpinionId());
					samApplyInfo.setCheckPrincipal(batchApply.getCheckPrincipal());
					samApplyInfo.setCheckDate(batchApply.getCheckDate());
					samApplyInfo.setCheckAgent(batchApply.getCheckAgent());
					samApplyInfo.setCheckOrganId(BspUtil.getCorpOrganId());
					samApplyInfo.setCheckPeopleId(BspUtil.getEmpOrgan().getOrganId());
					samApplyInfo.setCheckPeopleName(BspUtil.getEmpOrgan().getOrganName());
					
					BaseinfoFamily baseInfoFamily = baseinfoDomain.getFamily(samApplyInfo.getFamilyId());
					baseInfoFamily.setAssistancePeopleNum(samApplyInfo.getAssistancePeopleNum());
					baseInfoFamily.setAssistanceMoney(samApplyInfo.getAssistanceMoney());
					baseInfoFamily.setAssistanceClassMoney(samApplyInfo.getAssistanceClassMoney());
					baseInfoFamily.setAssistanceMode(samApplyInfo.getAssistanceMode());
					baseInfoFamily.setAssistanceClass(samApplyInfo.getAsisstanceClass());
					
					samApplyInfo.setSamApplyDiscussionList(SamApplyDiscussionList1);
					//handleDiscussion
					handleDiscussion(samApplyInfo);
					
					samApplyInfo.setBaseInfoFamily(baseInfoFamily);
					samApplyInfo.setSamApplyNoticeList(SamApplyNoticeList1);
					samApplyInfo.setSamApplySurveyList(samApplySurveyList1);
					
					samApplyInfo.setAssignmentId(assignmentId);
					
					sendApply(samApplyInfo);
				}
			}
		}
		
	}
	/**
	 * 批量审批
	 */
	public void batchApp(SamApplyInfo batchApply) {
		List<String> applyIdList = batchApply.getApplyIdList();
		List<String> assignmentIdList = batchApply.getAssignmentIdList();
		List<SamApplySurvey> samApplySurveyList = batchApply.getSamApplySurveyList();
		List<SamApplyNotice> samApplyNoticeList = batchApply.getSamApplyNoticeList();
		SamApplySurvey samApplySurvey=samApplySurveyList.get(0);
		SamApplyNotice samApplyNotice=samApplyNoticeList.get(0);
		
		for (int i = 0; i < applyIdList.size(); i++) {
			String applyId=applyIdList.get(i);
			String assignmentId= assignmentIdList.get(i);
			if(applyId != null && !"".equals(applyId)){
				samApplySurvey.setApplyId(applyId);
				samApplyNotice.setApplyId(applyId);
				ParameterSet pset= new ParameterSet();
				pset.setParameter("APPLY_ID",applyId);
				DataSet ds = samApplyInfoDomain.query(pset);
				if(ds.getCount() > 0 ){
					SamApplyInfo samApplyInfo=(SamApplyInfo)ds.getRecord(0).toBean(SamApplyInfo.class);
					fillTrueApply(samApplyInfo,batchApply);
					BaseinfoFamily baseInfoFamily = baseinfoDomain.getFamily(samApplyInfo.getFamilyId());
					baseInfoFamily.setAssistancePeopleNum(samApplyInfo.getAssistancePeopleNum());
					baseInfoFamily.setAssistanceMoney(samApplyInfo.getAssistanceMoney());
					baseInfoFamily.setAssistanceClassMoney(samApplyInfo.getAssistanceClassMoney());
					baseInfoFamily.setAssistanceMode(samApplyInfo.getAssistanceMode());
					baseInfoFamily.setAssistanceClass(samApplyInfo.getAsisstanceClass());
					
					List<SamApplyNotice> SamApplyNoticeList1 = new ArrayList<SamApplyNotice>();
					SamApplyNoticeList1.add(samApplyNotice);
					List<SamApplySurvey> samApplySurveyList1 =  new ArrayList<SamApplySurvey>();
					samApplySurveyList1.add(samApplySurvey);
					samApplyInfo.setBaseInfoFamily(baseInfoFamily);
					samApplyInfo.setSamApplyNoticeList(SamApplyNoticeList1);
					samApplyInfo.setSamApplySurveyList(samApplySurveyList1);
					
					samApplyInfo.setAssignmentId(assignmentId);
					sendApply(samApplyInfo);
				}
			}
		}
	}
	/**
	 * 根据页面上的apply把页面内容放到数据库读出的apply上
	 * @param samApplyInfo 数据库读出的apply
	 * @param batchApply 页面的apply
	 */
	private void fillTrueApply(SamApplyInfo samApplyInfo,
			SamApplyInfo batchApply) {
		samApplyInfo.setAuditRemarks(batchApply.getAuditRemarks());
		samApplyInfo.setAuditDate(batchApply.getAuditDate());
		samApplyInfo.setAuditAgent(batchApply.getAuditAgent());
		samApplyInfo.setAuditOpinionId(batchApply.getAuditOpinionId());
		samApplyInfo.setBeginDate(batchApply.getBeginDate());
		samApplyInfo.setAuditPrincipal(batchApply.getAuditPrincipal());
		
	}
	/**
	 * 处理银行信息
	 * @param applyInfo
	 */
	private void handleBank(SamApplyInfo applyInfo) {
		SamBankAccount bank=applyInfo.getSamBankAccount();
		ParameterSet pset=new ParameterSet();
		pset.setParameter("FAMILY_ID",applyInfo.getFamilyId());
		DataSet ds=samBankAccountDomain.query(pset);
		if(ds.getCount() == 0){
			bank.setAccountId(IdHelp.getUUID32());
			bank.setFamilyId(applyInfo.getFamilyId());
			samBankAccountDomain.insert(bank);
		}else{
			SamBankAccount dataBean = (SamBankAccount)ds.getRecord(0).toBean(SamBankAccount.class);
			dataBean.setBank(bank.getBank());
			dataBean.setAccountName(bank.getAccountName());
			dataBean.setAccountNumber(bank.getAccountNumber());
			samBankAccountDomain.update(dataBean);
		}
	}
}
