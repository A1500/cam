package com.inspur.cams.sorg.online.apply.group.cmd;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomAspchief;
import com.inspur.cams.sorg.base.data.SomChange;
import com.inspur.cams.sorg.base.data.SomChangeApply;
import com.inspur.cams.sorg.base.data.SomDuty;
import com.inspur.cams.sorg.base.data.SomFee;
import com.inspur.cams.sorg.base.data.SomHeldOrgan;
import com.inspur.cams.sorg.base.data.SomHeldPeople;
import com.inspur.cams.sorg.base.data.SomLiqpeople;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.data.SomPartyMember;
import com.inspur.cams.sorg.base.data.SomPartyPraise;
import com.inspur.cams.sorg.base.data.SomPeopleResume;
import com.inspur.cams.sorg.base.data.SomRule;
import com.inspur.cams.sorg.base.data.SomSession;
import com.inspur.cams.sorg.online.apply.group.domain.ISomGroupOnlineDomain;
import com.inspur.cams.sorg.util.SomDutyDuties;


/**
 * 社团历史数据录入command
 * 
 * @author yanliangliang
 * @date 2011-11-21
 */
public class SomGroupOnlineCmd extends BaseAjaxCommand {
	@Reference
	private ISomGroupOnlineDomain service = ScaComponentFactory.getService(ISomGroupOnlineDomain.class,"somGroupOnlineDomain/somGroupOnlineDomain");
	
	// ---------------------------名称核准---------------------------
	/**
	 * 保存社会组织名称核准信息
	 */
	public void saveNameApproval() {
		service.saveNameApproval(getNameApproval());
	}
	
	// ---------------------------筹备---------------------------
	/**
	 * 保存社会组织筹备信息
	 */
	public void savePrepare() {
		service.savePrepare(getPrepare());
	}

	/**
	 * 修改筹备
	 */
	public void updatePrepare() {
		service.updatePrepare(getPrepare());
	}
	// ---------------------------成立---------------------------
	/**
	 * 保存社会组织成立信息
	 */
	public void saveBuild(){
		service.saveBuild(getBuild());
	}
	/**
	 * 更新社会组织成立信息
	 */
	public void updateBuild(){
		service.updateBuild(getBuild());
	}
	/**
	 * 保存社会组织分支成立信息
	 */
	public void saveBranchBuild(){
		service.saveBranchBuild(getBranchBuild());
	}
	/**
	 * 更新社会组织成立信息
	 */
	public void updateBranchBuild(){
		service.updateBranchBuild(getBranchBuild());
	}
	// ---------------------------变更---------------------------
	/**
	 * 保存社会组织变更信息
	 */
	public void saveChange(){
		service.saveChange(getChange());
	}
	/**
	 * 更新社会组织变更信息
	 */
	public void updateChange(){
		service.updateChange(getChange());
	}
	/**
	 * 保存社会组织分支变更信息
	 */
	public void saveBranchChange(){
		service.saveBranchChange(getChange());
	}
	/**
	 * 更新社会组织分支变更信息
	 */
	public void updateBranchChange(){
		service.updateBranchChange(getChange());
	}
	// ---------------------------注销---------------------------
	/**
	 * 新增注销
	 */
	public void saveCancel() {
		service.saveCancel(getCancel());
	}

	/**
	 * 修改注销
	 */
	public void updateCancel() {
		service.updateCancel(getCancel());
	}
	// ---------------------------分支注销---------------------------
	/**
	 * 新增分支注销
	 */
	public void saveBranchCancel() {
		service.saveBranchCancel(getBranchCancel());
	}

	/**
	 * 修改分支注销
	 */
	public void updateBranchCancel() {
		service.updateBranchCancel(getBranchCancel());
	}
	// ---------------------------异地设立分支审查---------------------------
	/**
	 * 异地设立分支审查的保存
	 */
	public void saveBranchAPCheck(){
		service.saveBranchAPCheck(getBranchAPCheck());
	}
	/**
	 * 异地设立分支审查的更新
	 */
	public void updateBranchAPCheck(){
		service.updateBranchAPCheck(getBranchAPCheck());
	}
//TODO ------------------------------------------私有方法-------------------------------------------------
	/**
	 * 获取筹备相应信息
	 * 
	 * @return 封装的somApply
	 */
	private SomApply getPrepare() {
		Record organ = (Record) getParameter("somOrgan");
		Record apply = (Record) getParameter("somApply");
		Record[] heldPeoples = (Record[]) getParameter("somHeldPeople");
		Record[] heldOrgans = (Record[]) getParameter("somHeldOrgan");
		Record[] aspchiefs = (Record[]) getParameter("somAspchief");

		List<SomHeldPeople> somHeldPeopleList = new ArrayList<SomHeldPeople>();
		List<SomHeldOrgan> somHeldOrganList = new ArrayList<SomHeldOrgan>();
		List<SomAspchief> somAspchiefList = new ArrayList<SomAspchief>();

		SomApply somApply = (SomApply) apply.toBean(SomApply.class);
		SomOrgan somOrgan = (SomOrgan) organ.toBean(SomOrgan.class);
		if (heldPeoples != null) {
			for (int i = 0; i < heldPeoples.length; i++) {
				SomHeldPeople somHeldPeople = (SomHeldPeople) heldPeoples[i].toBean(SomHeldPeople.class);
				somHeldPeopleList.add(somHeldPeople);
			}
		}
		if (heldOrgans != null) {
			for (int i = 0; i < heldOrgans.length; i++) {
				SomHeldOrgan somHeldPeople = (SomHeldOrgan) heldOrgans[i].toBean(SomHeldOrgan.class);
				somHeldOrganList.add(somHeldPeople);
			}
		}
		if (aspchiefs != null) {
			for (int i = 0; i < aspchiefs.length; i++) {
				SomAspchief somAspchief = (SomAspchief) aspchiefs[i].toBean(SomAspchief.class);
				somAspchiefList.add(somAspchief);
			}
		}
		somOrgan.setSomHeldPeopleList(somHeldPeopleList);
		somOrgan.setSomHeldOrganList(somHeldOrganList);
		somOrgan.setSomAspchiefList(somAspchiefList);
		//维护organ表中联系人与联系电话
		somOrgan.setSorgPeople(somApply.getAppPeople());
		somOrgan.setSorgPeoplePhone(somApply.getAppPhone());
		somApply.setSomOrgan(somOrgan);
		somApply.setSomOrgan(somOrgan);
		return somApply;
	}
	/**
	 * 获取成立信息
	 * @return 
	 */
	private SomApply getBuild() {
		Record organRecord = (Record) getParameter("organRecord");
		Record LegalPeopleRecord = (Record) getParameter("LegalPeopleRecord");
		Record somSessionRecord = (Record) getParameter("somSessionRecord");
		Record somRuleRecord = (Record) getParameter("somRuleRecord");
		Record somFeeRecord = (Record) getParameter("somFeeRecord");
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		Record[] somDutyRecords = (Record[])getParameter("somDutyRecords");
		Record[] somResumeRecords = (Record[])getParameter("somResumeRecords");
		Record[] somPartyMemberRecords = (Record[])getParameter("somPartyMemberRecords");
		Record[] somPartyPraiseRecords = (Record[])getParameter("somPartyPraiseRecords");
		
		List<SomDuty> somDutyList = new ArrayList<SomDuty>();
		List<SomPartyMember> somPartyMemberList = new ArrayList<SomPartyMember>();
		SomOrgan somOrgan=(SomOrgan)organRecord.toBean(SomOrgan.class);	
		SomDuty LegalPeople=(SomDuty)LegalPeopleRecord.toBean(SomDuty.class);
		SomSession somSession=(SomSession)somSessionRecord.toBean(SomSession.class);
		SomRule somRule=(SomRule)somRuleRecord.toBean(SomRule.class);
		SomFee somFee=(SomFee)somFeeRecord.toBean(SomFee.class);
		SomApply somApply=(SomApply)somApplyRecord.toBean(SomApply.class);
		
		somSession.setSorgId(somOrgan.getSorgId());
		somFee.setSorgId(somOrgan.getSorgId());
		somRule.setSorgId(somOrgan.getSorgId());
		LegalPeople.setSorgId(somOrgan.getSorgId());
		if(somDutyRecords != null){
			for(int i=0;i<somDutyRecords.length;i++){
				SomDuty somDuty=(SomDuty)somDutyRecords[i].toBean(SomDuty.class);
				somDuty.setSorgId(somOrgan.getSorgId());
				//处理个人简历
				List<SomPeopleResume> somPeopleResumeList = new ArrayList<SomPeopleResume>();
				if(somResumeRecords!=null){
					for(int j=0;j<somResumeRecords.length;j++){
						SomPeopleResume somPeopleResume =(SomPeopleResume) somResumeRecords[j].toBean(SomPeopleResume.class);
						if( somPeopleResume.getDutyId().equals(somDuty.getDutyId()) ){
							somPeopleResumeList.add(somPeopleResume);
						}
					}
					somDuty.setSomPeopleResumeList(somPeopleResumeList);
				}
				//处理个人简历完成
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
		LegalPeople.setSorgDuties(SomDutyDuties.SOM_LEGAL_PEOPLE);
		if(!LegalPeople.getName().equals("")&&LegalPeople.getName()!=null){
			somDutyList.add(LegalPeople);
		}
		somOrgan.setSomSession(somSession);
		somOrgan.setSomRule(somRule);
		somOrgan.setSomFee(somFee);
		somOrgan.setSomDutyList(somDutyList);
		somOrgan.setSomPartyMemberList(somPartyMemberList);
		somApply.setSomOrgan(somOrgan);
		return somApply;
	}
	/**
	 * 封装分支成立信息
	 * @return
	 */
	private SomApply getBranchBuild() {
		Record organRd = (Record) getParameter("somOrganRecord");
		SomOrgan organBean = (SomOrgan) organRd.toBean(SomOrgan.class);
		//获取前台业务意见信息
		Record applyRd = (Record) getParameter("somApplyRecord");
		SomApply applyBean = (SomApply) applyRd.toBean(SomApply.class);
		Record somSessionRecord = (Record) getParameter("somSessionRecord");
		Record[] somDutyRecords = (Record[])getParameter("somDutyRecords");
		Record[] somResumeRecords = (Record[])getParameter("somResumeRecords");
		List<SomDuty> somDutyList = new ArrayList<SomDuty>();
		SomSession somSession=(SomSession)somSessionRecord.toBean(SomSession.class);
		if(somDutyRecords != null){
			for(int i=0;i<somDutyRecords.length;i++){
				SomDuty somDuty=(SomDuty)somDutyRecords[i].toBean(SomDuty.class);
				//处理个人简历
				List<SomPeopleResume> somPeopleResumeList = new ArrayList<SomPeopleResume>();
				if(somResumeRecords!=null){
					for(int j=0;j<somResumeRecords.length;j++){
						SomPeopleResume somPeopleResume =(SomPeopleResume) somResumeRecords[j].toBean(SomPeopleResume.class);
						if(somPeopleResume.getDutyId().equals(somDuty.getDutyId())){
							somPeopleResumeList.add(somPeopleResume);
						}
					}
					somDuty.setSomPeopleResumeList(somPeopleResumeList);
				}
				//处理个人简历完成
				somDutyList.add(somDuty);
				organBean.setBranchCharger(somDuty.getName());
			}
		}
		organBean.setSomSession(somSession);
		organBean.setSomDutyList(somDutyList);
		applyBean.setSomOrgan(organBean);
		return applyBean;
	}
	/**
	 *  封装变更信息
	 * @return
	 */
	private SomChangeApply getChange() {
		SomChangeApply somChangeApply=new SomChangeApply();
		List<SomChange> changeList=new ArrayList<SomChange>();
		List<SomPeopleResume> legalResumeList=new ArrayList<SomPeopleResume>();
		Record[] changes=(Record[])getParameter("Changes");
		Record[] legalResumeRecords=(Record[]) getParameter("legalResumeRecords");
		Record somLegalPeople=(Record)getParameter("somLegalPeople");
		String sorgDuties=(String)getParameter("sorgDuties");
		Record somFlow=(Record)getParameter("somApply");
		Record somOrgan=(Record)getParameter("somOrganRecord");
		//封装变更信息
		for(int i=0;i<changes.length;i++){
			SomChange somChange=(SomChange)changes[i].toBean(SomChange.class);
			changeList.add(somChange);
		}
		Map<String, String> map=new HashMap<String, String>();
		//封装法定代表人信息
		if(somLegalPeople!=null){
			SomDuty somPeople=(SomDuty)somLegalPeople.toBean(SomDuty.class);
			//封装简历信息
			if(legalResumeRecords!=null){
				for(int i=0;i<legalResumeRecords.length;i++){
					SomPeopleResume somPeopleResume = (SomPeopleResume) legalResumeRecords[i].toBean(SomPeopleResume.class);
					legalResumeList.add(somPeopleResume);
				}
				somPeople.setSomPeopleResumeList(legalResumeList);
			}
			somChangeApply.setSomLegalPeople(somPeople);
			map.put("leaPeopleId", somPeople.getDutyId());
		}
		
		String legalDutyId=(String)getParameter("legalDutyId");
		map.put("legalDutyId", legalDutyId);
		map.put("sorgDuties", sorgDuties);
		somChangeApply.setSomChange(changeList);
		somChangeApply.setPeopleResumes(legalResumeList);
		SomApply somApply=(SomApply)somFlow.toBean(SomApply.class);
		map.put("taskCode1", somApply.getTaskCode());
		map.put("sorgId", somApply.getSorgId());
		somApply.setSomOrgan((SomOrgan)somOrgan.toBean(SomOrgan.class));
		somChangeApply.setSomApply(somApply);
		somChangeApply.setMap(map);	
		return somChangeApply;
	}
	/**
	 * 获取注销信息
	 * 
	 * @return SomApply
	 */
	private SomApply getCancel() {
		List<SomLiqpeople> somLiqpeopleList = new ArrayList<SomLiqpeople>();
		// 获取前台社会组织信息
		Record somOrganRd = (Record) getParameter("somOrganRd");
		SomOrgan somOrgan = (SomOrgan) somOrganRd.toBean(SomOrgan.class);

		// 获取前台社会组织清算人员信息列表
		Record[] somLiqpeopleRds = (Record[]) getParameter("somLiqpeopleRds");
		if (somLiqpeopleRds != null && somLiqpeopleRds.length > 0) {
			for (int i = 0; i < somLiqpeopleRds.length; i++) {
				SomLiqpeople somLiqpeople = (SomLiqpeople) somLiqpeopleRds[i]
						.toBean(SomLiqpeople.class);
				somLiqpeopleList.add(somLiqpeople);
			}
			somOrgan.setSomLiqpeopleList(somLiqpeopleList);
		}

		// 获取前台业务意见信息
		Record somApplyRd = (Record) getParameter("somApplyRd");
		SomApply somApply = (SomApply) somApplyRd.toBean(SomApply.class);

		// 封装数据
		somApply.setSomOrgan(somOrgan);
		return somApply;
	}
	/**
	 * 获取分支注销信息
	 * 
	 * @return SomApply
	 */
	private SomApply getBranchCancel() {
		// 获取前台社会组织信息
		Record somOrganRd = (Record) getParameter("somOrganRd");
		SomOrgan somOrgan = (SomOrgan) somOrganRd.toBean(SomOrgan.class);
		// 获取前台业务意见信息
		Record somApplyRd = (Record) getParameter("somApplyRd");
		SomApply somApply = (SomApply) somApplyRd.toBean(SomApply.class);
		// 封装数据
		somApply.setSomOrgan(somOrgan);
		return somApply;
	}
	/**
	 * 封装异地设立分支信息
	 * @return
	 */
	private SomApply getBranchAPCheck() {
		Record organRecord = (Record) getParameter("organRecord");
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		SomOrgan somOrgan=(SomOrgan)organRecord.toBean(SomOrgan.class);	
		SomApply somApply=(SomApply)somApplyRecord.toBean(SomApply.class);
		somApply.setSomOrgan(somOrgan);
		return somApply;
	}
	
	// 前台页面获取数据并组装
	private SomApply getNameApproval() {
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		SomApply somApply = (SomApply) somApplyRecord.toBean(SomApply.class);
		
		Record somOrganRecord = (Record) getParameter("somOrganRecord");
		SomOrgan somOrgan = (SomOrgan) somOrganRecord.toBean(SomOrgan.class);
		
		List<SomHeldPeople> somHeldPeopleList = new ArrayList<SomHeldPeople>();
		List<SomHeldOrgan> somHeldOrganList = new ArrayList<SomHeldOrgan>();
		List<SomAspchief> somAspchiefList = new ArrayList<SomAspchief>();

		Record[] somHeldPeopleRecord = (Record[]) getParameter("somHeldPeopleRecord");
		Record[] somHeldOrganRecord = (Record[]) getParameter("somHeldOrganRecord");
		Record[] somAspchiefRecord = (Record[]) getParameter("somAspchiefRecord");
		
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
		if (somAspchiefRecord != null) {
			for (int i = 0; i < somAspchiefRecord.length; i++) {
				SomAspchief somAspchief = (SomAspchief) somAspchiefRecord[i].toBean(SomAspchief.class);
				somAspchiefList.add(somAspchief);
			}
		}
		somOrgan.setSomHeldPeopleList(somHeldPeopleList);
		somOrgan.setSomHeldOrganList(somHeldOrganList);
		somOrgan.setSomAspchiefList(somAspchiefList);
		//维护organ表中联系人与联系电话
		somOrgan.setSorgPeople(somApply.getAppPeople());
		somOrgan.setSorgPeoplePhone(somApply.getAppPhone());
		somApply.setSomOrgan(somOrgan);
		
		return somApply;
	}
}
