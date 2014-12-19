package com.inspur.cams.drel.his.country.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.baseinfo.domain.IBaseinfoDomain;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.PhotoUtil;
import com.inspur.cams.drel.application.comm.SamApplyType;
import com.inspur.cams.drel.his.country.domain.ISamCountryHisDomain;
import com.inspur.cams.drel.sam.data.SamApplyDiscussion;
import com.inspur.cams.drel.sam.data.SamApplyInfo;
import com.inspur.cams.drel.sam.data.SamApplyNotice;
import com.inspur.cams.drel.sam.data.SamApplySurvey;
import com.inspur.cams.drel.sam.data.SamBankAccount;
import com.inspur.cams.drel.sam.data.SamFamilyAssistance;
import com.inspur.cams.drel.sam.data.SamFamilyTreatment;
import com.inspur.cams.drel.sam.domain.ISamApplyDiscussionDomain;
import com.inspur.cams.drel.sam.domain.ISamApplyInfoDomain;
import com.inspur.cams.drel.sam.domain.ISamApplyNoticeDomain;
import com.inspur.cams.drel.sam.domain.ISamApplySurveyDomain;
import com.inspur.cams.drel.sam.domain.ISamBankAccountDomain;
import com.inspur.cams.drel.sam.domain.ISamFamilyAssistanceDomain;
import com.inspur.cams.drel.sam.domain.ISamFamilyTreatmentDomain;

/**
 * 农村低保历史Domain接口
 * @author 
 * @date 
 */
public class SamCountryHisDomain implements ISamCountryHisDomain{	
	@Reference
	private ISamApplyInfoDomain samApplyInfoDomain;
	@Reference
	private IBaseinfoDomain baseinfoDomain;
	@Reference
	private ISamFamilyTreatmentDomain samFamilyTreatmentDomain;
	@Reference
	private ISamFamilyAssistanceDomain samFamilyAssistanceDomain;
	@Reference
	private ISamApplyNoticeDomain samApplyNoticeDomain;
	@Reference
	private ISamApplyDiscussionDomain samApplyDiscussionDomain;
	@Reference
	private ISamApplySurveyDomain samApplySurveyDomain;
	@Reference
	private ISamBankAccountDomain samBankAccountDomain;
	/**
	 * 保存
	 */
	public SamApplyInfo insertInfo(SamApplyInfo applyInfo) {
		handleFamily(applyInfo);//处理家庭基本信息
		handleApply(applyInfo);//处理业务信息
		handleAssistance(applyInfo);//处理多选的救助类型信息
		handleSurvey(applyInfo);//处理入户调查信息
		handleDiscussion(applyInfo);//处理评议结果信息
		handleNotice(applyInfo);//处理公示结果信息
		handleBank(applyInfo);//处理银行信息
		//把低保证号，救助开始日期维护到SamFamilyTreatment
		resolveTreatment(applyInfo);
		//插入特定的救助类型：城市低保
		insertSpecialAssistance(applyInfo);
		//调用存储过程把记录保存到备用表中
		samApplyInfoDomain.toDuplicateRecord(applyInfo);
		return applyInfo;
	}
	/**
	 * 调用存储过程把记录保存到备用表中
	 */
	public void toDuplicateRecord(SamApplyInfo samApplyInfo) {
		samApplyInfoDomain.toDuplicateRecord(samApplyInfo);
		
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
			baseinfoFamily.setRegId(BspUtil.getEmpOrgan().getOrganId());
			baseinfoFamily.setRegOrg(BspUtil.getCorpOrgan().getOrganId());
		    baseinfoFamily.setRegOrgArea(BspUtil.getCorpOrgan().getOrganCode());
			baseinfoFamily.setRegOrgName(BspUtil.getCorpOrgan().getOrganName());
			baseinfoFamily.setRegPeople(BspUtil.getEmpOrgan().getOrganName());
			baseinfoFamily.setRegTime(DateUtil.getTime());
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
			baseinfoFamily.setRegId(BspUtil.getEmpOrgan().getOrganId());
			baseinfoFamily.setRegOrg(BspUtil.getCorpOrgan().getOrganId());
		    baseinfoFamily.setRegOrgArea(BspUtil.getCorpOrgan().getOrganCode());
			baseinfoFamily.setRegOrgName(BspUtil.getCorpOrgan().getOrganName());
			baseinfoFamily.setRegPeople(BspUtil.getEmpOrgan().getOrganName());
			baseinfoFamily.setRegTime(DateUtil.getTime());
			baseinfoDomain.updateFamily(baseinfoFamily);
			
			ParameterSet pset =new ParameterSet();
			pset.setParameter("FAMILY_ID",baseinfoFamily.getFamilyId());
			pset.setParameter("relationship_type","01");
			DataSet ds=baseinfoDomain.queryPeople(pset);
			if(ds.getCount() > 0){
				BaseinfoPeople bean=(BaseinfoPeople)ds.getRecord(0).toBean(BaseinfoPeople.class);
				bean.setName(baseinfoFamily.getFamilyName());
				bean.setIdCard(baseinfoFamily.getFamilyCardNo());
				baseinfoDomain.updatePeople(bean);
			}
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
	 * 处理业务信息
	 */
	private void handleApply(SamApplyInfo applyInfo) {
		fillApplyInfo(applyInfo);//根据家庭信息生成业务信息
		if(applyInfo.getApplyId() == null || "".equals(applyInfo.getApplyId()) || "null".equals(applyInfo.getApplyId())){//新增
			applyInfo.setApplyId(IdHelp.getUUID32());
			applyInfo.setFamilyId(applyInfo.getBaseInfoFamily().getFamilyId());
			samApplyInfoDomain.insert(applyInfo);
		}else{
			samApplyInfoDomain.update(applyInfo);//修改
		}
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
				String surveyResult=samApplySurvey.getSurveyResult();
				if(surveyResult==null||"".equals(surveyResult)){
					samApplySurveyDomain.delete(bean.getSurveyId());
				}else{
					bean.setRemarks(samApplySurvey.getRemarks());
					bean.setSurveyContents(samApplySurvey.getSurveyContents());
					bean.setSurveyDate(samApplySurvey.getSurveyDate());
					bean.setSurveyPeople(samApplySurvey.getSurveyPeople());
					bean.setSurveyResult(samApplySurvey.getSurveyResult());
					samApplySurveyDomain.update(bean);
				}
			}else if(ds.getCount() == 0){//如果不存在，新增
				samApplySurvey.setApplyId(applyInfo.getApplyId());
				samApplySurvey.setSurveyId(IdHelp.getUUID32());
				samApplySurveyDomain.insert(samApplySurvey);
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
	 * 处理公示结果
	 * @param applyInfo
	 */
	private void handleNotice(SamApplyInfo applyInfo) {
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
				if (noticeResult==null||"".equals(noticeResult)) {
					samApplyNoticeDomain.delete(bean.getNoticeId());
				}else{
					bean.setBeginDate(samApplyNotice.getBeginDate());
					bean.setEndDate(samApplyNotice.getEndDate());
					bean.setNoticeResult(samApplyNotice.getNoticeResult());
					bean.setPrincipal(samApplyNotice.getPrincipal());
					bean.setRemarks(samApplyNotice.getRemarks());
					samApplyNoticeDomain.update(bean);
				}
			}else if(ds.getCount() == 0){//如果不存在，新增
				samApplyNotice.setApplyId(applyInfo.getApplyId());
				samApplyNotice.setNoticeId(IdHelp.getUUID32());
				samApplyNoticeDomain.insert(samApplyNotice);
			}
		}		
	}
	/**
	 * 处理家庭待遇信息
	 * @param baseinfoFamily
	 * @return
	 */
	private void resolveTreatment(SamApplyInfo applyInfo) {
		ParameterSet pset=new ParameterSet();
		pset.setParameter("APPLY_ID",applyInfo.getApplyId());
		pset.setParameter("FAMILY_ID",applyInfo.getFamilyId());
		DataSet ds=samFamilyTreatmentDomain.query(pset);
		if(ds.getCount() == 1){//如果已经存在，更新
			SamFamilyTreatment samFamilyTreatment=(SamFamilyTreatment)ds.getRecord(0).toBean(SamFamilyTreatment.class);
			samFamilyTreatment.setAssistanceMode(applyInfo.getAssistanceMode());
			samFamilyTreatment.setAssistanceMoney(applyInfo.getAssistanceMoney());
			samFamilyTreatment.setAssistanceClassMoney(applyInfo.getAssistanceClassMoney());
			samFamilyTreatment.setAssistancePeopleNum(applyInfo.getAssistancePeopleNum());
			samFamilyTreatment.setDomicileCode(applyInfo.getDomicileCode());
			samFamilyTreatment.setBeginDate(applyInfo.getBeginDate());
			if(applyInfo.getBaseInfoFamily().getEndDate()!= null && !"".equals(applyInfo.getBaseInfoFamily().getEndDate())){
				samFamilyTreatment.setEndDate(applyInfo.getBaseInfoFamily().getEndDate());
			}
			samFamilyTreatment.setCardNo(applyInfo.getCardNo());
			samFamilyTreatmentDomain.update(samFamilyTreatment);
		}else{
			SamFamilyTreatment samFamilyTreatment=new SamFamilyTreatment();
			samFamilyTreatment.setAssistanceMode(applyInfo.getAssistanceMode());
			samFamilyTreatment.setAssistanceMoney(applyInfo.getAssistanceMoney());
			samFamilyTreatment.setAssistanceClassMoney(applyInfo.getAssistanceClassMoney());
			samFamilyTreatment.setAssistancePeopleNum(applyInfo.getAssistancePeopleNum());
			samFamilyTreatment.setDomicileCode(applyInfo.getDomicileCode());
			samFamilyTreatment.setBeginDate(applyInfo.getBeginDate());
			samFamilyTreatment.setCardNo(applyInfo.getCardNo());
			samFamilyTreatment.setAssistanceType("02");//农村低保
			samFamilyTreatment.setEndDate("3000-12");
			samFamilyTreatment.setReleaseWay("01");//发放方式：社会化发放
			
			samFamilyTreatment.setTreatmentId(IdHelp.getUUID32());
			samFamilyTreatment.setFamilyId(applyInfo.getFamilyId());
			samFamilyTreatment.setApplyId(applyInfo.getApplyId());
			samFamilyTreatment.setDataSource("his");//数据来源：his
			samFamilyTreatmentDomain.insert(samFamilyTreatment);
		}
	}
	/**
	 * 根据家庭信息生成业务信息
	 */
	private void fillApplyInfo(SamApplyInfo applyInfo) {
		BaseinfoFamily baseinfoFamily=applyInfo.getBaseInfoFamily();
		applyInfo.setFamilyName(baseinfoFamily.getFamilyName());
		applyInfo.setFamilyCardNo(baseinfoFamily.getFamilyCardNo());
		applyInfo.setPeopleNum(baseinfoFamily.getPeopleNum());
		applyInfo.setDomicileCode(baseinfoFamily.getDomicileCode());
		applyInfo.setDomicileName(baseinfoFamily.getDomicileName());
		applyInfo.setBeginDate(baseinfoFamily.getBeginDate());
		applyInfo.setCardNo(baseinfoFamily.getCardNo());
	
		applyInfo.setAssistancePeopleNum(baseinfoFamily.getAssistancePeopleNum());
		applyInfo.setAssistanceMoney(baseinfoFamily.getAssistanceMoney());
		applyInfo.setAssistanceClassMoney(baseinfoFamily.getAssistanceClassMoney());
		applyInfo.setAssistanceMode(baseinfoFamily.getAssistanceMode());
		applyInfo.setAsisstanceClass(baseinfoFamily.getAssistanceClass());
		applyInfo.setApplyType(SamApplyType.SAM_COUNTRY_HIS);//申请业务类别
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
	/**
	 * 插入特定救助类型
	 */
	private void insertSpecialAssistance(SamApplyInfo applyInfo){
		ParameterSet pset=new ParameterSet();
		pset.setParameter("ASSISTANCE_TYPE","02");
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
			samFamilyAssistance.setAssistanceType("02");
			samFamilyAssistance.setCardNo(applyInfo.getCardNo());
			samFamilyAssistance.setAssistanceMon(applyInfo.getAssistanceMoney());
			samFamilyAssistance.setAssistanceClassMon(applyInfo.getAssistanceClassMoney());
			samFamilyAssistance.setAssistanceBegin(applyInfo.getBeginDate());
			samFamilyAssistanceDomain.insert(samFamilyAssistance);
		}
		
	}
}
