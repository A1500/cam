package com.inspur.cams.sorg.apply.fund.cmd;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.apply.fund.domain.IFundBuildDomain;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomAspchief;
import com.inspur.cams.sorg.base.data.SomDuty;
import com.inspur.cams.sorg.base.data.SomHeldOrgan;
import com.inspur.cams.sorg.base.data.SomHeldPeople;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.data.SomPartyMember;
import com.inspur.cams.sorg.base.data.SomPartyPraise;
import com.inspur.cams.sorg.base.data.SomPeopleResume;
import com.inspur.cams.sorg.base.data.SomRule;
import com.inspur.cams.sorg.base.data.SomSession;
/**
 *  社会团体成立登记Cmd
 * @author yanliangliang
 * @date 2011-9-26
 */
public class FundBuildCmd extends BaseAjaxCommand {
	// 获取SCA组件
	private IFundBuildDomain service = ScaComponentFactory.getService(IFundBuildDomain.class, "FundBuildDomain/FundBuildDomain");
	
	/**
	 * 社会组织主表查询
	 */
	public DataSet queryOrgan(){
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryOrgan(pset);
		return ds;
	}
	/**
	 * 业务流程意见表查询
	 */
	public void queryFlow(){
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryFlow(pset);
		setReturn("flowDataSet", ds);
	}
	
	/**
	 * 保存业务信息
	 */
	public void insertReportInfo() {		
		service.insertReportInfo(getAcceptSomApply());		
	}
	
	/**
	 * 业务信息保存创建并发送
	 */
	public void createAndSend(){
		service.createAndSend(getAcceptSomApply());
	}
	
	/**
	 * 更新业务信息
	 */
	public void updateReportInfo(){
		service.updateReportInfo(getAcceptSomApply());
		
	}
	
	/**
	 * 更新业务信息并发送
	 */
	public void updateForSendReport(){
		service.updateForSendReport(getAcceptSomApply());
	}
	
	/**
	 * 保存业务信息
	 */
	public void insertBuildInfo() {	
		
		service.insertBuildInfo(getAcceptSomApply());		
	}
	/**
	 * 业务信息保存创建并发送
	 */
	public void saveAndSendBuild(){
		service.saveAndSendBuild(getAcceptSomApply());
	}
	/**
	 * 更新业务信息
	 */
	public void updateBuildInfo(){
		service.updateBuildInfo(getAcceptSomApply());
		
	}
	/**
	 * 登记发证中的保存
	 */
	public void saveRegister(){
		service.saveRegister(getSomApply());
	}
	/**
	 * 登记发证中的发送流程
	 */
	public void printForSend(){
		SomApply applyBean=getSomApply();
		Map<String, String> map=new HashMap<String, String>();
		map.put("certType", (String)getParameter("certType"));
		map.put("endDate", (String)getParameter("endDate"));
		map.put("beginDate", (String)getParameter("beginDate"));
		map.put("PrintDate", (String)getParameter("PrintDate"));
		map.put("business", (String)getParameter("business"));
		map.put("issueReasonDesc", (String)getParameter("issueReasonDesc"));
		map.put("checkResult", (String)getParameter("checkResult"));
		map.put("fetchPeople", (String)getParameter("fetchPeople"));
		map.put("fetchDate", (String)getParameter("fetchDate"));
		map.put("fetchPhone", (String)getParameter("fetchPhone"));
		applyBean.setMap(map);
		service.printForSend(applyBean);
	}
	/**
	 * 更新业务信息并发送
	 */
	public void updateForSend(){
		service.updateForSend(getAcceptSomApply());
	}
	/**
	 * 更新业务意见信息
	 */
	public void updateApply(){
		//获取前台业务意见信息
		Record applyRd = (Record) getParameter("somApplyRecord");
		SomApply applyBean = (SomApply) applyRd.toBean(SomApply.class);
		service.updateApply(applyBean);
	}	
	/**
	 *  保存并发送
	 */
	public void send(){
		//根据环节定义获取环节信息
		Record applyRd = (Record) getParameter("somApplyRecord");
		SomApply applyBean = (SomApply) applyRd.toBean(SomApply.class);
		Map<String, String> map=new HashMap<String, String>();
		map.put("fetchPeople", (String)getParameter("fetchPeople"));
		map.put("fetchDate", (String)getParameter("fetchDate"));
		map.put("fetchPhone", (String)getParameter("fetchPhone"));
		applyBean.setMap(map);
		service.send(applyBean);
	}
	
	/**
	 * 保存照片并返回照片Id
	 */
	public void savePhoto(){
		ParameterSet pset = getParameterSet();
		String photoText = (String) pset.getParameter("photoText");
		String photoId = service.savePhoto(photoText);
		setReturn("photoId", photoId);
	}
	
	/**
	 * 更新照片
	 */
	public void updatePhoto(){
		ParameterSet pset = getParameterSet();
		String photoId = (String) pset.getParameter("photoId");
		String photoText = (String) pset.getParameter("photoText");
		String newPhotoId = service.updatePhoto(photoId,photoText);
		setReturn("photoId", newPhotoId);
	}
	
	
	/**
	 * 获取最后环节processId
	 */
	public String getProcessId(String id){
		return service.queryProcessId(id);
	}
	
	/**
	 * 通过processId获取taskCode
	 */
	public SomApply getTaskCode(String processId){
		return service.queryTaskCode(processId);
	}
	
	//从后台获取数据
	private SomApply getReportSomApply() {
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		SomApply somApply = (SomApply) somApplyRecord.toBean(SomApply.class);
		
		Record somOrganRecord = (Record) getParameter("somOrganRecord");
		SomOrgan somOrgan = (SomOrgan) somOrganRecord.toBean(SomOrgan.class);
		
		List<SomHeldPeople> somHeldPeopleList = new ArrayList<SomHeldPeople>();
		List<SomHeldOrgan> somHeldOrganList = new ArrayList<SomHeldOrgan>();

		Record[] somHeldPeopleRecord = (Record[]) getParameter("somHeldPeopleRecord");
		Record[] somHeldOrganRecord = (Record[]) getParameter("somHeldOrganRecord");
		Record aspChief = (Record) getParameter("aspChief");
		
		SomAspchief somAspChief=(SomAspchief)aspChief.toBean(SomAspchief.class);
		List<SomAspchief> somAspChiefList = new ArrayList<SomAspchief>();
		somAspChiefList.add(somAspChief);
		
		if (somHeldPeopleRecord != null) {
			for (int i = 0; i < somHeldPeopleRecord.length; i++) {
				SomHeldPeople somHeldPeople = (SomHeldPeople) somHeldPeopleRecord[i].toBean(SomHeldPeople.class);
				somHeldPeopleList.add(somHeldPeople);
			}
		}
		if (somHeldOrganRecord != null) {
			for (int i = 0; i < somHeldOrganRecord.length; i++) {
				SomHeldOrgan somHeldOrgan = (SomHeldOrgan) somHeldOrganRecord[i].toBean(SomHeldOrgan.class);
				somHeldOrganList.add(somHeldOrgan);
			}
		}
		somOrgan.setSomHeldPeopleList(somHeldPeopleList);
		somOrgan.setSomHeldOrganList(somHeldOrganList);
		somOrgan.setSomAspchiefList(somAspChiefList);
		somApply.setSomOrgan(somOrgan);
		
		return somApply;
	}
	//从后台获取数据
	private SomApply getAcceptSomApply() {
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		SomApply somApply = (SomApply) somApplyRecord.toBean(SomApply.class);
		
		Record somOrganRecord = (Record) getParameter("somOrganRecord");
		SomOrgan somOrgan = (SomOrgan) somOrganRecord.toBean(SomOrgan.class);
		
		List<SomHeldPeople> somHeldPeopleList = new ArrayList<SomHeldPeople>();
		List<SomHeldOrgan> somHeldOrganList = new ArrayList<SomHeldOrgan>();

		Record[] somHeldPeopleRecord = (Record[]) getParameter("somHeldPeopleRecord");
		Record[] somHeldOrganRecord = (Record[]) getParameter("somHeldOrganRecord");
		
		Record somSessionDataSet = (Record) getParameter("somSessionDataSet");
		Record aspChief = (Record) getParameter("aspChief");
		
		SomAspchief somAspChief=(SomAspchief)aspChief.toBean(SomAspchief.class);
		
		if(somSessionDataSet!=null){		
			SomSession somSession=(SomSession)somSessionDataSet.toBean(SomSession.class);
			somOrgan.setSomSession(somSession);
		}
		
		Record[] aspForLiShi = (Record[]) getParameter("aspForLiShi");
		Record[] aspForJianShi = (Record[]) getParameter("aspForJianShi");
		Record[] somResumeInsertDataSet = (Record[]) getParameter("somResumeInsertDataSet");
		
		//register中使用的
		Record somRuleRecord = (Record) getParameter("somRuleRecord");
		
		if(somRuleRecord!=null){
			SomRule somRule = (SomRule) somRuleRecord.toBean(SomRule.class);
			somOrgan.setSomRule(somRule);
		}
		
		List<SomAspchief> somAspchiefList = new ArrayList<SomAspchief>();
		somAspchiefList.add(somAspChief);
		
		if (somHeldPeopleRecord != null) {
			for (int i = 0; i < somHeldPeopleRecord.length; i++) {
				SomHeldPeople somHeldPeople = (SomHeldPeople) somHeldPeopleRecord[i].toBean(SomHeldPeople.class);
				somHeldPeopleList.add(somHeldPeople);
			}
		}
		if (somHeldOrganRecord != null) {
			for (int i = 0; i < somHeldOrganRecord.length; i++) {
				SomHeldOrgan somHeldOrgan = (SomHeldOrgan) somHeldOrganRecord[i].toBean(SomHeldOrgan.class);
				somHeldOrganList.add(somHeldOrgan);
			}
		}
		if(aspForLiShi!=null){
			for (int i = 0; i < aspForLiShi.length; i++) {
				SomAspchief somAspchief = (SomAspchief) aspForLiShi[i].toBean(SomAspchief.class);
				//处理简历
				List<SomPeopleResume> somResumeList = new ArrayList<SomPeopleResume>();
				somAspchief.setSomPeopleResumeList(somResumeList);
				if(somResumeInsertDataSet!=null){
					for (int j = 0; j < somResumeInsertDataSet.length; j++) {
						SomPeopleResume somResume = (SomPeopleResume) somResumeInsertDataSet[j].toBean(SomPeopleResume.class);
						if(somResume.getDutyId().equals(somAspchief.getId())){
							somAspchief.getSomPeopleResumeList().add(somResume);
						}
					}
				}
				somAspchiefList.add(somAspchief);
			}
		}
		if(aspForJianShi!=null){
			for (int i = 0; i < aspForJianShi.length; i++) {
				SomAspchief somAspchief = (SomAspchief) aspForJianShi[i].toBean(SomAspchief.class);
				List<SomPeopleResume> somResumeList = new ArrayList<SomPeopleResume>();
				somAspchief.setSomPeopleResumeList(somResumeList);
				//处理简历
				if(somResumeInsertDataSet!=null){
					for (int j = 0; j < somResumeInsertDataSet.length; j++) {
						SomPeopleResume somResume = (SomPeopleResume) somResumeInsertDataSet[j].toBean(SomPeopleResume.class);
						
						if(somResume.getDutyId().equals(somAspchief.getId())){
							somAspchief.getSomPeopleResumeList().add(somResume);	
						}
					}
				}
				somAspchiefList.add(somAspchief);
			}
		}
		
		somOrgan.setSomHeldPeopleList(somHeldPeopleList);
		somOrgan.setSomHeldOrganList(somHeldOrganList);	
		somOrgan.setSomAspchiefList(somAspchiefList);
		somApply.setSomOrgan(somOrgan);
		
		
		
		return somApply;
	}
	//从后台获取数据
	private SomApply getSomApply() {
		Record organRecord = (Record) getParameter("organRecord");
		Record somSessionRecord = (Record) getParameter("somSessionDataSet");
		Record somRuleRecord = (Record) getParameter("somRuleRecord");
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		Record[] aspForLiShi = (Record[]) getParameter("aspForLiShi");
		Record[] aspForJianShi = (Record[]) getParameter("aspForJianShi");
		Record[] somResumeInsertDataSet = (Record[]) getParameter("somResumeInsertDataSet");
		Record[] somPartyMemberRecords = (Record[])getParameter("somPartyMemberRecords");
		Record[] somPartyPraiseRecords = (Record[])getParameter("somPartyPraiseRecords");
		
		SomOrgan somOrgan=(SomOrgan)organRecord.toBean(SomOrgan.class);	
		SomSession somSession=(SomSession)somSessionRecord.toBean(SomSession.class);
		SomRule somRule=(SomRule)somRuleRecord.toBean(SomRule.class);
		SomApply somApply=(SomApply)somApplyRecord.toBean(SomApply.class);
		List<SomDuty> somDutyList = new ArrayList<SomDuty>();
		List<SomPartyMember> somPartyMemberList = new ArrayList<SomPartyMember>();
		
		if(aspForLiShi != null){
			for (int i = 0; i < aspForLiShi.length; i++) {
				SomDuty somDuty = (SomDuty) aspForLiShi[i].toBean(SomDuty.class);
				if(somDuty.getSorgDuties().equals("00001")){
					somDuty.setIfLegal("1");
				}
				//处理简历
				List<SomPeopleResume> somResumeList = new ArrayList<SomPeopleResume>();
				somDuty.setSomPeopleResumeList(somResumeList);
				if(somResumeInsertDataSet!=null){
					for (int j = 0; j < somResumeInsertDataSet.length; j++) {
						SomPeopleResume somResume = (SomPeopleResume) somResumeInsertDataSet[j].toBean(SomPeopleResume.class);
						if(somResume.getDutyId().equals(somDuty.getDutyId())){
							somDuty.getSomPeopleResumeList().add(somResume);
						}
					}
				}
				somDutyList.add(somDuty);
			}
		}
		if(aspForJianShi != null){
			for (int i = 0; i < aspForJianShi.length; i++) {
				SomDuty somDuty = (SomDuty) aspForJianShi[i].toBean(SomDuty.class);
				//处理简历
				List<SomPeopleResume> somResumeList = new ArrayList<SomPeopleResume>();
				somDuty.setSomPeopleResumeList(somResumeList);
				if(somResumeInsertDataSet!=null){
					for (int j = 0; j < somResumeInsertDataSet.length; j++) {
						SomPeopleResume somResume = (SomPeopleResume) somResumeInsertDataSet[j].toBean(SomPeopleResume.class);
						if(somResume.getDutyId().equals(somDuty.getDutyId())){
							somDuty.getSomPeopleResumeList().add(somResume);
						}
					}
				}
				somDutyList.add(somDuty);
			}
		}

		if (somPartyMemberRecords != null) {
			for (int i = 0; i < somPartyMemberRecords.length; i++) {
				SomPartyMember somPartyMember = (SomPartyMember) somPartyMemberRecords[i].toBean(SomPartyMember.class);
				somPartyMemberList.add(somPartyMember);
				List<SomPartyPraise> somPartyPraiseList = new ArrayList<SomPartyPraise>();
				if (somPartyPraiseRecords != null) {
					for (int j = 0; j < somPartyPraiseRecords.length; j++) {
						SomPartyPraise somPartyPraise = (SomPartyPraise) somPartyPraiseRecords[j].toBean(SomPartyPraise.class);
						if (somPartyPraise.getMemberId().equals(somPartyMember.getMemberId())) {
							somPartyPraiseList.add(somPartyPraise);							
						}
					}
					somPartyMember.setSomPartyPraiseList(somPartyPraiseList);
				}
			}
		}		
		somOrgan.setSomSession(somSession);
		somOrgan.setSomRule(somRule);
		somOrgan.setSomDutyList(somDutyList);
		somOrgan.setSomPartyMemberList(somPartyMemberList);
		somApply.setSomOrgan(somOrgan);
		
		return somApply;
	}
}
