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
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.PhotoUtil;
import com.inspur.cams.drel.application.city.domain.ISamCityChangeDomain;
import com.inspur.cams.drel.application.comm.SamApplyType;
import com.inspur.cams.drel.comm.RoleCmp;
import com.inspur.cams.drel.ensureInfo.data.EnsureToClient;
import com.inspur.cams.drel.ensureInfo.domain.IEnsureToClientDomain;
import com.inspur.cams.drel.sam.data.SamApplyDiscussion;
import com.inspur.cams.drel.sam.data.SamApplyInfo;
import com.inspur.cams.drel.sam.data.SamApplyNotice;
import com.inspur.cams.drel.sam.data.SamApplyOptionsHis;
import com.inspur.cams.drel.sam.data.SamApplySurvey;
import com.inspur.cams.drel.sam.data.SamBankAccount;
import com.inspur.cams.drel.sam.data.SamFamilyAssistance;
import com.inspur.cams.drel.sam.data.SamFamilyTreatment;
import com.inspur.cams.drel.sam.data.SamPeopleExtend;
import com.inspur.cams.drel.sam.domain.ISamApplyDiscussionDomain;
import com.inspur.cams.drel.sam.domain.ISamApplyInfoDomain;
import com.inspur.cams.drel.sam.domain.ISamApplyNoticeDomain;
import com.inspur.cams.drel.sam.domain.ISamApplyOptionsHisDomain;
import com.inspur.cams.drel.sam.domain.ISamApplySurveyDomain;
import com.inspur.cams.drel.sam.domain.ISamBankAccountDomain;
import com.inspur.cams.drel.sam.domain.ISamFamilyAssistanceDomain;
import com.inspur.cams.drel.sam.domain.ISamFamilyTreatmentDomain;
import com.inspur.cams.drel.sam.domain.ISamPeopleExtendDomain;
/**
 * 城市低保复查变更业务Domain
 * @author yanliangliang
 * @date 2012年5月15日10:41:16
 */
public class SamCityChangeDomain  implements ISamCityChangeDomain{
	@Reference
	private IEnsureToClientDomain ensureToClientDomain;
	@Reference
	private ISamApplyInfoDomain samApplyInfoDomain;
	@Reference
	private IBaseinfoDomain baseinfoDomain;
	@Reference
	private ISamFamilyTreatmentDomain samFamilyTreatmentDomain;
	@Reference
	private ISamFamilyAssistanceDomain samFamilyAssistanceDomain;
	@Reference
	private ISamPeopleExtendDomain samPeopleExtendDomain;
	@Reference
	private ISamApplyNoticeDomain samApplyNoticeDomain;
	@Reference
	private ISamApplyDiscussionDomain samApplyDiscussionDomain;
	@Reference
	private ISamApplySurveyDomain samApplySurveyDomain;
	@Reference
	private ISamApplyOptionsHisDomain samApplyOptionsHisDomain;
	@Reference
	private ISamBankAccountDomain samBankAccountDomain;
	
	
	public static final String PROC_DEF_UNIQUE_ID = "8a898b03374e4b6601374e4b66320000";
	public static final String START_ACT_DEF_ID = "act1";
	
	/**
	 * 保存低保新申请业务信息
	 */
	public SamApplyInfo insertInfo(SamApplyInfo applyInfo) {
		applyInfo.setCurActivityId("accept");
		applyInfo.setCurActivityName("受理");
		//处理家庭基本信息
		handleFamily(applyInfo);
		//处理业务信息
		handleApply(applyInfo);
		//处理多选的救助类型信息
		handleAssistance(applyInfo);
		//处理入户调查信息
		handleSurvey(applyInfo);
		//处理评议结果信息
		handleDiscussion(applyInfo);
		//处理公示结果信息
		handleNoticeList(applyInfo);
//		handleBank(applyInfo);//处理银行信息
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
		//保存低保新申请业务信息
		insertInfo(applyInfo);
		//工作流相应参数
		CommandContext.setContextParameter("assignmentId",applyInfo.getAssignmentId());
		Map context = new HashMap();
		String StruId = BspUtil.getParentStrId();
		context.put("organId", StruId);
		context.put("opinionId",applyInfo.getAcceptOpinionId());
		//调用工作流发送接口
		//调用工作流发送接口
		Map maps=WfTaskRequestWrapper.getInstance().send(context);	
		samApplyInfoDomain.updateCurActId(StruId,applyInfo.getApplyId());
		
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
		samApplyInfoDomain.update(applyInfo);
	}
	/**
	 * 发送流程
	 */
	@SuppressWarnings("unchecked")
	public void sendApply(SamApplyInfo applyInfo) {
		//处理家庭基本信息
		handleFamily(applyInfo);
		//处理入户调查信息
		handleSurvey(applyInfo);
		//处理公示结果信息
		handleNoticeList(applyInfo);
		//处理评议结果信息
		handleDiscussion(applyInfo);
		//处理业务信息
		BaseinfoFamily baseinfoFamily=applyInfo.getBaseInfoFamily();
		applyInfo.setAssistancePeopleNum(baseinfoFamily.getAssistancePeopleNum());
		applyInfo.setAssistanceMoney(baseinfoFamily.getAssistanceMoney());
		applyInfo.setAssistanceClassMoney(baseinfoFamily.getAssistanceClassMoney());
		applyInfo.setAssistanceMode(baseinfoFamily.getAssistanceMode());
		applyInfo.setAsisstanceClass(baseinfoFamily.getAssistanceClass());
		//维护apply的当前信息
		toFillCurInfo(applyInfo);
		samApplyInfoDomain.update(applyInfo);
		//工作流相应的参数
		CommandContext.setContextParameter("assignmentId",applyInfo.getAssignmentId());
		Map context = new HashMap();
		String StruId = BspUtil.getParentStrId();
		SamApplyOptionsHis samApplyOptionsHis=applyInfo.getSamApplyOptionsHis();
		//如果是回退
		if("3".equals(samApplyOptionsHis.getOpinionId())){
			//如果是审核回退
			if("check".equals(samApplyOptionsHis.getActivityId())){
				StruId=applyInfo.getAcceptDeptId();
			//如果是审批回退
			}else if("audit".equals(samApplyOptionsHis.getActivityId())){
				StruId=applyInfo.getCheckDeptId();
			}
		}
		context.put("organId",StruId);	
		context.put("opinionId",samApplyOptionsHis.getOpinionId());	
		
		//调用工作流发送接口
		WfTaskRequestWrapper.getInstance().send(context);	
		samApplyInfoDomain.updateCurActId(StruId,applyInfo.getApplyId());
	}
	/**
	 * 更新流程意见
	 */
	public void updateApply(SamApplyInfo applyInfo) {
		handleFamily(applyInfo);//处理家庭基本信息
		handleSurvey(applyInfo);//处理入户调查信息
		handleNoticeList(applyInfo);//处理公示结果信息
		//判断是审核环节还是审批环节来维护相应字段
		//如果是审核
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
		//如果是审批
		}else{
			if("1".equals(applyInfo.getAuditOpinionId())){
				applyInfo.setCurOpinion("审批同意");
			}else if("0".equals(applyInfo.getAuditOpinionId())){
				applyInfo.setCurOpinion("审批不同意");
			}else if("3".equals(applyInfo.getAuditOpinionId())){
				applyInfo.setCurOpinion("审批回退");
			}
			applyInfo.setAuditPeopleId(BspUtil.getEmpOrgan().getOrganId());
			applyInfo.setAuditPeopleName(BspUtil.getEmpOrgan().getOrganName());
			applyInfo.setAuditDeptId(BspUtil.getDeptStruId());
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
		DataSet ds=baseinfoDomain.queryPeople(pset);//查询人员表
		if(ds.getCount()>0){//人员表里有
			Record record=ds.getRecord(0);
			familyId=(String)record.get("familyId");
			peopleId=(String)record.get("peopleId");
			String domicileName=(String)record.get("domicileName");
			personalStatsTag=(String)record.get("personalStatsTag");
			pset.clear();
			pset.setParameter("FAMILY_ID",familyId);
			pset.setParameter("ASSISTANCE_TYPE@in","01,02,03");//救助类型
			DataSet TreatmentDs=samFamilyTreatmentDomain.queryForCheckIDCard(pset);//查询待遇信息表
			if(TreatmentDs.getCount()>0){//如果待遇信息表里有
				String assistanceType=(String)TreatmentDs.getRecord(0).get("ASSISTANCE_TYPE");
 				errorFlag="此人正在"+domicileName+"享受救助："+returnChinese(assistanceType);
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
		map.put("familyId", familyId);
		map.put("errorFlag", errorFlag);
		map.put("peopleId", peopleId);
		map.put("personalStatsTag", personalStatsTag);
		return map;
	}
	/**
	 * 更改申请人时保存人员申请人关系
	 */
	public void updatePeopleRelationshipType(Record[] peoples) {
		for(int i=0;i<peoples.length;i++){
			String peopleId=(String) peoples[i].get("PEOPLE_ID");
			String relationshipType=(String) peoples[i].get("RELATIONSHIP_TYPE");
			BaseinfoPeople baseinfoPeople=baseinfoDomain.getPeople(peopleId);
			baseinfoPeople.setRelationshipType(relationshipType);
			baseinfoDomain.updatePeople(baseinfoPeople);
			if("01".equals(baseinfoPeople.getRelationshipType())){
				BaseinfoFamily baseinfoFamily= baseinfoDomain.getFamily(baseinfoPeople.getFamilyId());
				baseinfoFamily.setFamilyCardNo(baseinfoPeople.getIdCard());
				baseinfoFamily.setFamilyName(baseinfoPeople.getName());
				baseinfoDomain.updateFamily(baseinfoFamily);
			}
		}
	}
	/**
	 * 更新低保家庭成员状态信息
	 */
	public BaseinfoFamily updatePeopleStats(String peopleId,String familyId,String personalStatsTag,String assistanceModeValue,String applyId){
		//更新人员状态
		ParameterSet pset=new ParameterSet();
		pset.setParameter("PEOPLE_ID", peopleId);
		DataSet peopleDs= baseinfoDomain.queryPeople(pset);
		if(peopleDs.getCount()<1){
			return null;
		}
		BaseinfoPeople baseinfoPeople= (BaseinfoPeople) peopleDs.getRecord(0).toBean(BaseinfoPeople.class);
		baseinfoPeople.setPersonalStatsTag(personalStatsTag);
		baseinfoDomain.updatePeople(baseinfoPeople);
		
		//更新人员扩展表的注销原因
		pset.clear();
		pset.setParameter("PEOPLE_ID", peopleId);
		DataSet peopleExtendDs= samPeopleExtendDomain.query(pset);
		if(peopleExtendDs.getCount()<1){
			return null;
		}
		SamPeopleExtend samPeopleExtend= (SamPeopleExtend) peopleExtendDs.getRecord(0).toBean(SamPeopleExtend.class);
		samPeopleExtend.setDelReason(personalStatsTag);
		samPeopleExtendDomain.update(samPeopleExtend);
		
		//根据人员月收入更新家庭收入
		baseinfoDomain.updateIncomeByMonth(familyId);
		//更新家庭人口信息		
		baseinfoDomain.updatePeopleNum(familyId);
		//查询家庭信息
		BaseinfoFamily baseinfoFamily=baseinfoDomain.getFamily(familyId);
		//更新apply信息
		if( !"".equals(applyId) && applyId != null){
			pset.clear();
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
	 * 保存区县内变更
	 */
	@SuppressWarnings("unchecked")
	public void saveInChange(SamApplyInfo applyInfo) {
		//处理家庭基本信息
		handleFamily(applyInfo);		
		if(applyInfo.getApplyId() == null || "".equals(applyInfo.getApplyId())){//新增
			applyInfo.setApplyId(IdHelp.getUUID32());
			applyInfo.setFamilyId(applyInfo.getBaseInfoFamily().getFamilyId());
			samApplyInfoDomain.insert(applyInfo);
		}
		//处理区县内变更人员信息
		handleInChangePeople(applyInfo);
		//处理业务信息
		BaseinfoFamily baseinfoFamily=applyInfo.getBaseInfoFamily();
		applyInfo.setAssistancePeopleNum(baseinfoFamily.getAssistancePeopleNum());
		applyInfo.setAssistanceMoney(baseinfoFamily.getAssistanceMoney());
		applyInfo.setAssistanceClassMoney(baseinfoFamily.getAssistanceClassMoney());
		applyInfo.setAssistanceMode(baseinfoFamily.getAssistanceMode());
		applyInfo.setAsisstanceClass(baseinfoFamily.getAssistanceClass());
		//维护apply的当前信息
		toFillCurInfo(applyInfo);
		samApplyInfoDomain.update(applyInfo);
	}
//TODO ###############################                私有方法                ##########################################################
	/**
	 * 处理业务信息
	 */
	private void handleApply(SamApplyInfo applyInfo) {
		//根据家庭信息生成业务信息
		fillApplyInfo(applyInfo);
		if(applyInfo.getApplyId() == null || "".equals(applyInfo.getApplyId()) || "null".equals(applyInfo.getApplyId())){//新增
			applyInfo.setApplyId(IdHelp.getUUID32());
			applyInfo.setFamilyId(applyInfo.getBaseInfoFamily().getFamilyId());
			applyInfo.setAcceptDate(DateUtil.getDay());
			applyInfo.setAcceptDeptId(BspUtil.getDeptStruId());
			applyInfo.setAcceptOrganId(BspUtil.getDeptOrganId());
			applyInfo.setAcceptPeopleId(BspUtil.getEmpOrgan().getOrganId());
			applyInfo.setAcceptPeopleName(BspUtil.getEmpOrgan().getOrganName());
			//根据家庭ID 查找业务表里的低保证号，维护到变更业务里来
			getFamilyCardNo(applyInfo);
			samApplyInfoDomain.insert(applyInfo);
			//发起流程
			create(applyInfo);
		}else{
			//修改
			samApplyInfoDomain.update(applyInfo);
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
		Map wfMap = WfTaskRequestWrapper.getInstance().create(applyInfo.getApplyId(), applyInfo.getFamilyName() + "城市低保复查变更业务申请");
		//得到委派实例ID
		List actList = (List) wfMap.get("actList");
		Map map1 = (Map) actList.get(0);
		List assList = (List) map1.get("assList");
		Map map2 = (Map) assList.get(0);
		String assignmentId = (String) map2.get("assignmentId");
		//把委派实例ID放入applyInfo
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
		//申请业务类别
		applyInfo.setApplyType(SamApplyType.SAM_CITY_CHANGE);
		applyInfo.setApplyDate(baseinfoFamily.getApplyDate());
		applyInfo.setApplyReason(baseinfoFamily.getApplyReason());
		//受理意见为评议结果
//		applyInfo.setAcceptOpinionId(applyInfo.getSamApplyDiscussionList().get(0).getDiscussionResult());
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
		//把历史意见放入applyInfo
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
			//如果已经存在，更新
			if(ds.getCount() == 1){
				SamApplyNotice bean=(SamApplyNotice)ds.getRecord(0).toBean(SamApplyNotice.class);
				bean.setBeginDate(samApplyNotice.getBeginDate());
				bean.setEndDate(samApplyNotice.getEndDate());
				bean.setNoticeResult(samApplyNotice.getNoticeResult());
				bean.setPrincipal(samApplyNotice.getPrincipal());
				bean.setRemarks(samApplyNotice.getRemarks());
				samApplyNoticeDomain.update(bean);
			//如果不存在，新增
			}else if(ds.getCount() == 0){
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
		if(samApplyDiscussionList == null){
			return;
		}
		ParameterSet pset =new ParameterSet();
		for (int i = 0; i < samApplyDiscussionList.size(); i++) {
			SamApplyDiscussion samApplyDiscussion = samApplyDiscussionList.get(i);
			pset.clear();
			pset.setParameter("APPLY_ID",applyInfo.getApplyId());
			pset.setParameter("ACTIVITY_ID",samApplyDiscussion.getActivityId());
			DataSet ds=samApplyDiscussionDomain.query(pset);
			//如果已经存在，更新
			if(ds.getCount() == 1){
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
			//如果不存在，新增
			}else if(ds.getCount() == 0){
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
			//如果已经存在，更新
			if(ds.getCount() == 1){
				SamApplySurvey bean=(SamApplySurvey)ds.getRecord(0).toBean(SamApplySurvey.class);
				bean.setRemarks(samApplySurvey.getRemarks());
				bean.setSurveyContents(samApplySurvey.getSurveyContents());
				bean.setSurveyDate(samApplySurvey.getSurveyDate());
				bean.setSurveyPeople(samApplySurvey.getSurveyPeople());
				bean.setSurveyResult(samApplySurvey.getSurveyResult());
				samApplySurveyDomain.update(bean);
			//如果不存在，新增
			}else if(ds.getCount() == 0){
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
		if("".equals(baseinfoFamily.getPhotoId()) || baseinfoFamily.getPhotoId() == null){
			baseinfoFamily.setPhotoId(savePhoto(baseinfoFamily.getPhotoTemp()));
		}else{
			baseinfoFamily.setPhotoId(updatePhoto(baseinfoFamily.getPhotoId(),baseinfoFamily.getPhotoTemp()));//更新照片
		}
		baseinfoDomain.updateFamily(baseinfoFamily);
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
	 * @param beforeMoney 
	 * @return
	 */
	private void resolveTreatment(SamApplyInfo applyInfo,String dataSource, BigDecimal beforeMoney) {
		SamFamilyTreatment samFamilyTreatment=new SamFamilyTreatment();
		samFamilyTreatment.setTreatmentId(IdHelp.getUUID32());
		samFamilyTreatment.setFamilyId(applyInfo.getFamilyId());
		samFamilyTreatment.setApplyId(applyInfo.getApplyId());
		samFamilyTreatment.setAssistanceMode(applyInfo.getAssistanceMode());
		samFamilyTreatment.setAssistanceMoney(applyInfo.getAssistanceMoney());
		samFamilyTreatment.setAssistanceClassMoney(applyInfo.getAssistanceClassMoney());
		samFamilyTreatment.setAssistancePeopleNum(applyInfo.getAssistancePeopleNum());
		samFamilyTreatment.setDomicileCode(applyInfo.getDomicileCode());
		//城市低保
		samFamilyTreatment.setAssistanceType("01");
		
		if(applyInfo.getBeginDate().trim() == null || "".equals(applyInfo.getBeginDate().trim())){
			throw new  RuntimeException("数据异常！未获取开始时间 at line 668！");
		}
		samFamilyTreatment.setBeginDate(applyInfo.getBeginDate());
		samFamilyTreatment.setEndDate("3000-12");
		samFamilyTreatment.setCardNo(applyInfo.getCardNo());
		//发放方式：社会化发放
		samFamilyTreatment.setReleaseWay("01");
		if( "07".equals(applyInfo.getChangeItem()) ){
			samFamilyTreatment.setDataSource(dataSource);//数据来源：apply
		}else{
			samFamilyTreatment.setDataSource("apply");//数据来源：apply
		}
		samFamilyTreatment.setDifference(getDifference(applyInfo.getAssistanceMoney(),beforeMoney));
		samFamilyTreatment.setChangeItem(applyInfo.getChangeItem());
		samFamilyTreatmentDomain.insert(samFamilyTreatment);

		if("04".equals(applyInfo.getChangeItem())){//如果是变更户主，给账户一个提示
			ParameterSet pset =new ParameterSet();
			pset.setParameter("FAMILY_ID",applyInfo.getFamilyId());
			DataSet ds=samBankAccountDomain.query(pset);
			if(ds.getCount() > 0){
				for(int i=0;i<ds.getCount();i++){
					SamBankAccount bean=(SamBankAccount)ds.getRecord(0).toBean(SamBankAccount.class);
					bean.setAccountStatus("2");//0:未填写1:正常2:需要修改
					samBankAccountDomain.update(bean);
				}
				
			}
		}
	}
	/**
	 * 计算差额（原保障金与现保障金差额）
	 * @param after
	 * @param before
	 * @return
	 */
	private BigDecimal getDifference(BigDecimal after, BigDecimal before){
		BigDecimal b=new BigDecimal(0);
//		if(after.compareTo(before) == -1){
//			b=before.subtract(after);
//		}else {
		if(after != null && before != null){
			b=after.subtract(before);
		}
//		}
		return b;
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
			//根据familyId删除当前家庭下的所有救助类型
			samFamilyAssistanceDomain.deleteByFamilyId(familyId);
			//把新的救助类型插入数据库
			for (int i = 0; i < samFamilyAssistanceList.size(); i++) {
				SamFamilyAssistance samFamilyAssistance=samFamilyAssistanceList.get(i);
				samFamilyAssistance.setFamilyId(familyId);
				samFamilyAssistanceDomain.insert(samFamilyAssistance);
			}
		}
		
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
	 * 维护apply的当前信息
	 * @param applyInfo
	 */
	private void toFillCurInfo(SamApplyInfo applyInfo) {
		applyInfo.setCurOpinion("");
		//如果是审核环节
		if("check".equals(applyInfo.getCurActivityId())){
			//生成审核的历史意见
			handleOptionsHis(applyInfo,"check");
			applyInfo.setCheckPeopleId(BspUtil.getEmpOrgan().getOrganId());
			applyInfo.setCheckPeopleName(BspUtil.getEmpOrgan().getOrganName());
			applyInfo.setCheckDeptId(BspUtil.getDeptStruId());
			//如果是审核退回
			if("3".equals(applyInfo.getCheckOpinionId())){
				applyInfo.setCurActivityId("accept");
				applyInfo.setCurActivityName("受理");
			//如果是审核同意或者不同意
			}else {
				applyInfo.setCurActivityId("audit");
				applyInfo.setCurActivityName("审批");
			}
		//如果是审批环节
		}else if("audit".equals(applyInfo.getCurActivityId())){
			//生成审批的历史意见
			handleOptionsHis(applyInfo,"audit");
			applyInfo.setAuditPeopleId(BspUtil.getEmpOrgan().getOrganId());
			applyInfo.setAuditPeopleName(BspUtil.getEmpOrgan().getOrganName());
			applyInfo.setAuditDeptId(BspUtil.getDeptStruId());
			//如果是审批退回
			if("3".equals(applyInfo.getAuditOpinionId())){
				applyInfo.setCurActivityId("check");
				applyInfo.setCurActivityName("审核");
			//如果是审批同意
			}else if("1".equals(applyInfo.getAuditOpinionId())){
				if("03".equals(applyInfo.getChangeItem())){
					//更新家庭信息
					BaseinfoFamily baseinfoFamily=applyInfo.getBaseInfoFamily();
					baseinfoFamily.setCurActivity("FINISHOK");
					baseinfoFamily.setCheckFlag("2");
					baseinfoDomain.updateFamily(baseinfoFamily);
					
					samFamilyAssistanceDomain.deleteAssistance(applyInfo.getFamilyId(), "01");//城市低保
					applyInfo.setCurActivityId("audit");
					applyInfo.setCurActivityName("审批");
					applyInfo.setCurOpinion("审批同意停保");
					applyInfo.setIsFinish("1");
					applyInfo.setFinishTime(DateUtil.getTime());
					//把救助结束日期维护到SamFamilyTreatment
					ParameterSet pset =new ParameterSet();
					pset.setParameter("FAMILY_ID",applyInfo.getFamilyId());
					pset.setParameter("BEGIN_DATE@<=",DateUtil.getMonth());
					pset.setParameter("END_DATE@>=",DateUtil.getMonth());
					
					DataSet ds=samFamilyTreatmentDomain.query(pset);
					//更新
					if(ds.getCount() == 1){
						SamFamilyTreatment samFamilyTreatment=(SamFamilyTreatment)ds.getRecord(0).toBean(SamFamilyTreatment.class);
						//维护一个结束日期
						if(applyInfo.getBeginDate().trim() == null || "".equals(applyInfo.getBeginDate().trim())){
							throw new  RuntimeException("数据异常！未获取结束时间 at line 811！");
						}
						samFamilyTreatment.setEndDate(applyInfo.getBeginDate());
						samFamilyTreatment.setChangeItem("03");
						samFamilyTreatmentDomain.update(samFamilyTreatment);
					}
				}else{
					applyInfo.setCurActivityId("audit");
					applyInfo.setCurActivityName("审批");
					applyInfo.setCurOpinion("审批同意");
					applyInfo.setIsFinish("1");
					applyInfo.setFinishTime(DateUtil.getTime());
					//维护救助结束日期到原来的SamFamilyTreatment
					ParameterSet pset =new ParameterSet();
					pset.setParameter("FAMILY_ID",applyInfo.getFamilyId());
					pset.setParameter("END_DATE","3000-12");
					DataSet ds=samFamilyTreatmentDomain.query(pset);
					//更新
					String dataSource="apply";//数据来源：apply
					BigDecimal beforeMoney=new BigDecimal(0);
					if(ds.getCount() == 1){
						SamFamilyTreatment samFamilyTreatment=(SamFamilyTreatment)ds.getRecord(0).toBean(SamFamilyTreatment.class);
						if(applyInfo.getBeginDate().trim() == null || "".equals(applyInfo.getBeginDate().trim())){
							throw new  RuntimeException("数据异常！未获取结束时间 at line 834！");
						}
						samFamilyTreatment.setEndDate(DateUtil.getLastmonth(applyInfo.getBeginDate()));
						dataSource=samFamilyTreatment.getDataSource();
						beforeMoney=samFamilyTreatment.getAssistanceMoney();
						if( beforeMoney == null ){
							beforeMoney = new BigDecimal(0);
						}
						samFamilyTreatmentDomain.update(samFamilyTreatment);	
					}
					//把救助开始日期新增一条SamFamilyTreatment
					resolveTreatment(applyInfo,dataSource,beforeMoney);
					//插入特定的救助类型：城市低保
					insertSpecialAssistance(applyInfo);
				}
				//调用存储过程把记录保存到备用表中
				samApplyInfoDomain.toDuplicateRecord(applyInfo);
			//如果是审批不同意
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
	 * 获得申请新业务时的低保证号
	 * @param applyInfo
	 * @return
	 */
	private void getFamilyCardNo(SamApplyInfo applyInfo) {
		ParameterSet pset =new ParameterSet();
		pset.setParameter("FAMILY_ID",applyInfo.getBaseInfoFamily().getFamilyId());
		pset.setParameter("APPLY_TYPE@IN","010,012");
		pset.setParameter("IS_FINISH","1");
		DataSet ds=samApplyInfoDomain.query(pset);
		if(ds.getCount()>0){
			applyInfo.setCardNo((String)ds.getRecord(0).get("cardNo"));
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
	/**
	 * 处理区县内变更人员信息
	 * @param applyInfo
	 */
	private void handleInChangePeople(SamApplyInfo applyInfo){
		String familyId=applyInfo.getFamilyId();
		ParameterSet pset=new ParameterSet();
		pset.setParameter("FAMILY_ID", familyId);
		DataSet ds=baseinfoDomain.queryPeople(pset);
		
		String organCode = BspUtil.getOrganCode();//判断如果是济南的就不更新户籍地区字段
		String organString = organCode.substring(0,4);
		
		for (int i = 0; i < ds.getCount(); i++) {
			BaseinfoPeople baseinfoPeople=(BaseinfoPeople) ds.getRecord(i).toBean(BaseinfoPeople.class);
			baseinfoPeople.setDomicileName(applyInfo.getDomicileName());
			baseinfoPeople.setDomicileCode(applyInfo.getDomicileCode());
			if(!organString.equals("3701")){
				baseinfoPeople.setApanageName(applyInfo.getDomicileName());
				baseinfoPeople.setApanageCode(applyInfo.getDomicileCode());
			}
			baseinfoDomain.updatePeople(baseinfoPeople);
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
//			dataBean.setBank(bank.getBank());
			dataBean.setAccountName(bank.getAccountName());
			dataBean.setAccountNumber(bank.getAccountNumber());
			samBankAccountDomain.update(dataBean);
		}
	}
	
	/******************复查业务私有方法***************/
	/**
	 * 保存低保新申请业务信息
	 */
	public SamApplyInfo insertInfoFromRecheck(SamApplyInfo applyInfo) {
		
		applyInfo.setCurActivityId("accept");
		applyInfo.setCurActivityName("受理中");
		// 处理业务信息
		handleApplyFromRecheck(applyInfo);

		return applyInfo;
	}
	public void ChangeStatus(ParameterSet pset){
		
		 ParameterSet peopleSet=new ParameterSet();
		
		 peopleSet.setParameter("ENSURE_ID",pset.getParameter("ensureId"));
		 
		 System.out.print(pset.getParameter("ensureId"));
		 DataSet peopleDs=ensureToClientDomain.query(peopleSet);
		 EnsureToClient bean=(EnsureToClient)peopleDs.getRecord(0).toBean(EnsureToClient.class);
		 bean.setCurrentStatus("2");
		 ensureToClientDomain.update(bean);
	}
	/**
	 * 发送流程--复查业务审批流程
	 */
	@SuppressWarnings("unchecked")
	public void sendApplyFromReCheck(SamApplyInfo applyInfo) {
		// 维护apply的当前信息
		
		// 工作流相应的参数
		CommandContext.setContextParameter("assignmentId", applyInfo
				.getAssignmentId());
		Map context = new HashMap();
		
		String StruId = "";
		String condition = "";
		if("check".equals(applyInfo.getCurActivityId())){//当前
			if(RoleCmp.getIfRoleName("城市低保复查审批")){//下一步
				StruId=BspUtil.getDeptStruId();			
			}else{
				StruId=BspUtil.getParentStrId();
			}
			//以下代码待验证、、、
//			if("1".equals(applyInfo.getCheckOpinionId())){
//				condition="PASS";
//			}
//			else{
//				condition="FAILED";
//			}
			condition="PASS";
		}		
		//auditOpinionId
		if("audit".equals(applyInfo.getCurActivityId())){
			
			if("1".equals(applyInfo.getAuditOpinionId())){
				condition="PASS";
			}
			else{
				condition="FAILED";
			}
		}		
		
		context.put("ORGANID", StruId);
		context.put("CONDITION", condition);

		// 调用工作流发送接口
		WfTaskRequestWrapper.getInstance().send(context);
		
		toFillCurInfoRecheck(applyInfo);
		samApplyInfoDomain.update(applyInfo);
		samApplyInfoDomain.updateCurActId(StruId,applyInfo.getApplyId());
		samApplyInfoDomain.updateFamilyArchive(applyInfo);
		
	}
	/**
	 * 处理复核业务信息---复查业务
	 */
	private void handleApplyFromRecheck(SamApplyInfo applyInfo) {
		// 根据家庭信息生成业务信息
		fillApplyInfo(applyInfo);
		if (applyInfo.getApplyId() == null || "".equals(applyInfo.getApplyId())
				|| "null".equals(applyInfo.getApplyId())) {// 新增
			applyInfo.setApplyId(IdHelp.getUUID32());
			applyInfo.setFamilyId(applyInfo.getBaseInfoFamily().getFamilyId());
			applyInfo.setAcceptDate(DateUtil.getDay());
			applyInfo.setAcceptDeptId(BspUtil.getDeptStruId());
			applyInfo.setAcceptOrganId(BspUtil.getDeptOrganId());
			applyInfo.setAcceptPeopleId(BspUtil.getEmpOrgan().getOrganId());
			applyInfo.setAcceptPeopleName(BspUtil.getEmpOrgan().getOrganName());
			applyInfo.setApplyType(SamApplyType.SAM_CITY_RECHECK);
			applyInfo.setIsFinish("0");
			// 根据家庭ID 查找业务表里的低保证号，维护到变更业务里来
			getFamilyCardNo(applyInfo);
			//samApplyInfoDomain.insert(applyInfo);
			// 发起流程
			createFromRecheck(applyInfo);
			
			if(RoleCmp.getIfRoleName("城市低保复查审核")&&!RoleCmp.getIfRoleName("城市低保复查审批")){
				
				applyInfo.setCurActivityId("check");
				applyInfo.setCurActivityName("开始审核");
			}else if(RoleCmp.getIfRoleName("城市低保复查审批")){
				
				applyInfo.setCurActivityId("audit");
				applyInfo.setCurActivityName("开始审批");
			}
			samApplyInfoDomain.insert(applyInfo);
			//samApplyInfoDomain.update(applyInfo);
		} else {
			// 修改
			samApplyInfoDomain.update(applyInfo);
		}
	}
	/**
	 * 发起流程, 复核业务流程发起
	 * 
	 * @param applyInfo
	 */
	
	@SuppressWarnings("unchecked")
	public static final String PROC_DEF_UNIQUE_ID_RECHECK = "8a898bc2478628720147863ac3600075";
	public static final String START_ACT_DEF_ID_RECHECK = "act1";
	private void createFromRecheck(SamApplyInfo applyInfo) {
		// 传入相应参数
		Map actDefMap = WfQuery.getActDefInfoByProcDefUniqueIdAndActDefId(
				PROC_DEF_UNIQUE_ID_RECHECK, START_ACT_DEF_ID_RECHECK);
		String actDefUniqueId = (String) actDefMap.get("actDefUniqueId");
		CommandContext.setContextParameter("procDefUniqueId",
				PROC_DEF_UNIQUE_ID_RECHECK);
		CommandContext.setContextParameter("startActDefUniqueId",
				actDefUniqueId);
		// 创建流程
		String StruId = "";
		String condition = "";
		Map context = new HashMap();		
		if("accept".equals(applyInfo.getCurActivityId())){
			if(RoleCmp.getIfRoleName("城市低保复查审核")||RoleCmp.getIfRoleName("城市低保复查审批")){
/*				StruId=BspUtil.getParentStrId();*/
				StruId=BspUtil.getDeptStruId();
			}else{
				StruId=BspUtil.getParentStrId();
			}
			//以下代码待验证、、、
			if(RoleCmp.getIfRoleName("城市低保复查审核")&&!RoleCmp.getIfRoleName("城市低保复查审批")){
				condition="CHECK";
				applyInfo.setCurActivityId("check");
				applyInfo.setCurActivityName("开始审核");
			}else if(RoleCmp.getIfRoleName("城市低保复查审批")){
				condition="AUDIT";
				applyInfo.setCurActivityId("audit");
				applyInfo.setCurActivityName("开始审批");
			}			
			//根据当前用户角色判断是否有审批权限，如果没有，condition="CHECK"，否则condition="AUDIT"
		}
		context.put("ORGANID", StruId);
		context.put("CONDITION", condition);

		Map wfMap = WfTaskRequestWrapper.getInstance().createAndSend(applyInfo.getApplyId(),applyInfo.getFamilyName() + "城市低保复查业务",context);
		// 得到委派实例ID
		List actList = (List) wfMap.get("actList");
		Map map1 = (Map) actList.get(0);
		List assList = (List) map1.get("assList");
		Map map2 = (Map) assList.get(0);
		String assignmentId = (String) map2.get("assignmentId");
		// 把委派实例ID放入applyInfo
		applyInfo.setAssignmentId(assignmentId);
	}
	/**
	 * 维护apply的当前信息recheck
	 * 
	 * @param applyInfo
	 */
	private void toFillCurInfoRecheck(SamApplyInfo applyInfo) {
		applyInfo.setCurOpinion("");
		// 如果是审核环节
		if ("check".equals(applyInfo.getCurActivityId())) {
			// 生成审核的历史意见
			handleOptionsHis(applyInfo, "check");
			applyInfo.setCheckPeopleId(BspUtil.getEmpOrgan().getOrganId());
			applyInfo.setCheckPeopleName(BspUtil.getEmpOrgan().getOrganName());
			applyInfo.setCheckDeptId(BspUtil.getDeptStruId());
			
						
			// 如果是审核不同意
			if ("0".equals(applyInfo.getCheckOpinionId())) {
				applyInfo.setCurActivityId("check");
				applyInfo.setCurActivityName("审核结束");
				applyInfo.setCurOpinion("审核不同意");
				applyInfo.setIsFinish("1");
				
				
				applyInfo.setFinishTime(DateUtil.getTime());
				// 如果是审核同意
			} else if ("1".equals(applyInfo.getCheckOpinionId())){
				applyInfo.setCurActivityId("audit");
				applyInfo.setCurActivityName("开始审批");
			}
			// 如果是审批环节
		} else if ("audit".equals(applyInfo.getCurActivityId())) {
			// 生成审批的历史意见
			handleOptionsHis(applyInfo, "audit");
			applyInfo.setAuditPeopleId(BspUtil.getEmpOrgan().getOrganId());
			applyInfo.setAuditPeopleName(BspUtil.getEmpOrgan().getOrganName());
			applyInfo.setAuditDeptId(BspUtil.getDeptStruId());
			if ("1".equals(applyInfo.getAuditOpinionId())) {
					applyInfo.setCurActivityId("audit");
					applyInfo.setCurActivityName("审批结束");
					applyInfo.setCurOpinion("审批同意");
					applyInfo.setIsFinish("1");
					applyInfo.setFinishTime(DateUtil.getTime());
					
				// 调用存储过程把记录保存到备用表中
				/*samApplyInfoDomain.toDuplicateRecord(applyInfo);*/
				// 如果是审批不同意
			} else if ("0".equals(applyInfo.getAuditOpinionId())) {
				applyInfo.setCurActivityId("audit");
				applyInfo.setCurActivityName("审批结束");
				applyInfo.setCurOpinion("审批不同意");
				applyInfo.setIsFinish("1");
				applyInfo.setFinishTime(DateUtil.getTime());
				// 调用存储过程把记录保存到备用表中
				/*samApplyInfoDomain.toDuplicateRecord(applyInfo);*/
			}
		}
	}
	
	//从复查结果开始执行变更业务
	public void insertChangeFromRecheck(SamApplyInfo samApplyInfo) {
		// TODO Auto-generated method stub
//		samApplyInfo.setCurActivityId("accept");
//		samApplyInfo.setCurActivityName("受理");
//		handleApply(samApplyInfo);
//		handleSurvey(samApplyInfo);	
//		// 处理公示结果信息
//		handleNoticeList(samApplyInfo);
		submitApply(samApplyInfo);
	}


	public SamApplyInfo batchInsertInfoFromRecheck(
			List<SamApplyInfo> batchApplyInfoFromCheck) {
		// TODO Auto-generated method stub
		for(int i=0;i<batchApplyInfoFromCheck.size();i++){
			SamApplyInfo sai = batchApplyInfoFromCheck.get(i);
			String familyCardNo = sai.getFamilyCardNo();
			ParameterSet pset = new ParameterSet();
			pset.setParameter("FAMILY_CARD_NO", familyCardNo);
			DataSet familyDs = baseinfoDomain.queryFamily(pset);
			BaseinfoFamily baseInfoFamily = (BaseinfoFamily)familyDs.getRecord(0).toBean(BaseinfoFamily.class);
			baseInfoFamily.setApplyDate(DateUtil.getDay());
			sai.setBaseInfoFamily(baseInfoFamily);
			insertInfoFromRecheck(sai);
		}
		return null;//此处不需要回传数据
	}

	public void batchInsertChangeFromRecheck(List<SamApplyInfo> applys) {
		// TODO Auto-generated method stub
		for(int i=0;i<applys.size();i++){
			SamApplyInfo sai = applys.get(i);
			String familyCardNo = sai.getFamilyCardNo();
			ParameterSet pset = new ParameterSet();
			pset.setParameter("FAMILY_CARD_NO", familyCardNo);
			DataSet familyDs = baseinfoDomain.queryFamily(pset);
			BaseinfoFamily baseInfoFamily = (BaseinfoFamily)familyDs.getRecord(0).toBean(BaseinfoFamily.class);
			baseInfoFamily.setApplyDate(DateUtil.getDay());
			sai.setBaseInfoFamily(baseInfoFamily);
			submitApply(sai);
		}		
	}
	
	
	public void ignoreSuspectedPersonnel(ParameterSet pset){
	    String ignoreReason = (String)pset.getParameter("ignoreReason");
	    String operateTime = (String)pset.getParameter("operateTime");
	    String organArea = (String)pset.getParameter("organArea");
	    Record[] records = (Record[])pset.getParameter("records");
	    List<SamApplyInfo> applyList = new ArrayList<SamApplyInfo>();
	    List<EnsureToClient> ensureList = new ArrayList<EnsureToClient>();
	    
		SamApplyInfo applyBean = new SamApplyInfo();
		for(int i=0;i<records.length;i++){
			applyBean.setApplyId(IdHelp.getUUID32());
			applyBean.setFamilyId((String)records[0].get("FAMILY_ID"));
			applyBean.setFamilyName((String)records[0].get("FAMILY_NAME"));
			applyBean.setFamilyCardNo((String)records[0].get("FAMILY_CARD_NO"));
			applyBean.setDomicileCode(organArea);
			applyBean.setApplyType((String)records[0].get("APPLY_TYPE"));
			applyBean.setApplyDate(operateTime);
			applyBean.setApplyReason(ignoreReason);
			applyList.add(applyBean);
			
			//更新ensureToClient表
			ParameterSet ensurePset = new ParameterSet();
			ensurePset.setParameter("APPLY_ID@=", applyBean.getApplyId());
			DataSet ds = ensureToClientDomain.query(ensurePset);
			EnsureToClient ensureBean = (EnsureToClient)ds.getRecord(0).toBean(EnsureToClient.class);
			ensureBean.setReadStatus("2");
			ensureList.add(ensureBean);
		}
		
		ensureToClientDomain.batchUpdate(ensureList);
		
		samApplyInfoDomain.batchInsert(applyList);  
		    
	}
}