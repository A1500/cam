package com.inspur.cams.sorg.online.apply.ungov.domain.support;

import java.math.BigDecimal;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.data.RecordSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.base.dao.ISomDutyElectronicDao;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomAspchief;
import com.inspur.cams.sorg.base.data.SomChange;
import com.inspur.cams.sorg.base.data.SomChangeApply;
import com.inspur.cams.sorg.base.data.SomDuty;
import com.inspur.cams.sorg.base.data.SomHeldOrgan;
import com.inspur.cams.sorg.base.data.SomHeldPeople;
import com.inspur.cams.sorg.base.data.SomLiqpeople;
import com.inspur.cams.sorg.base.data.SomOffice;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.data.SomPartyMember;
import com.inspur.cams.sorg.base.data.SomPartyPraise;
import com.inspur.cams.sorg.base.data.SomPeopleResume;
import com.inspur.cams.sorg.base.data.SomRule;
import com.inspur.cams.sorg.base.data.SomSession;
import com.inspur.cams.sorg.base.domain.ISomApplyDomain;
import com.inspur.cams.sorg.base.domain.ISomAspchiefDomain;
import com.inspur.cams.sorg.base.domain.ISomCertDomain;
import com.inspur.cams.sorg.base.domain.ISomChangeDomain;
import com.inspur.cams.sorg.base.domain.ISomDutyDomain;
import com.inspur.cams.sorg.base.domain.ISomHeldOrganDomain;
import com.inspur.cams.sorg.base.domain.ISomHeldPeopleDomain;
import com.inspur.cams.sorg.base.domain.ISomLiqpeopleDomain;
import com.inspur.cams.sorg.base.domain.ISomOfficeDomain;
import com.inspur.cams.sorg.base.domain.ISomOrganDomain;
import com.inspur.cams.sorg.base.domain.ISomPartyMemberDomain;
import com.inspur.cams.sorg.base.domain.ISomPartyPraiseDomain;
import com.inspur.cams.sorg.base.domain.ISomPeopleDomain;
import com.inspur.cams.sorg.base.domain.ISomPeopleResumeDomain;
import com.inspur.cams.sorg.base.domain.ISomRuleDomain;
import com.inspur.cams.sorg.base.domain.ISomSignetDomain;
import com.inspur.cams.sorg.online.apply.ungov.domain.ISomUngovOnlineDomain;
import com.inspur.cams.sorg.util.ApplyType;
import com.inspur.cams.sorg.util.SomDutyDuties;

public class SomUngovOnlineDomain implements ISomUngovOnlineDomain {
	
	@Reference
	private ISomOrganDomain somOrganDomain;
	@Reference
	private ISomApplyDomain somApplyDomain;
	@Reference
	private ISomHeldPeopleDomain somHeldPeopleDomain;
	@Reference
	private ISomHeldOrganDomain somHeldOrganDomain;
	@Reference
	private ISomOfficeDomain somOfficeDomain;
	@Reference
	private ISomRuleDomain somRuleDomain;
	@Reference
	private ISomLiqpeopleDomain somLiqpeopleDomain;
	@Reference
	private ISomDutyDomain somDutyDomain;
	//变更
	@Reference
	private ISomChangeDomain somChangeDomain;
	@Reference
	private ISomPeopleDomain somPeopleDomain;
	@Reference
	private ISomDutyElectronicDao somDutyElectronicDao;
	@Reference
	private ISomPeopleResumeDomain somPeopleResumeDomain;
	
	@Reference
	private ISomCertDomain somCertDomain;
	@Reference
	private ISomSignetDomain somSignetDomain;
	
	@Reference
	private ISomAspchiefDomain somAspchiefDomain;
	
	@Reference
	private ISomPartyMemberDomain somPartyMemberDomain;
	@Reference
	private ISomPartyPraiseDomain somPartyPraiseDomain;
	
	//当前时间 DateUtil.getTime();
	//当前日期 DateUtil.getDay();
	//登记管理机关名称 BspUtil.getCorpOrgan().getOrganName();
	//登记管理机关行政区划 BspUtil.getCorpOrgan().getOrganCode();
	//登记管理机关ID BspUtil.getCorpOrgan().getOrganId();
	//受理部门名称 BspUtil.getDeptOrgan().getOrganName();
	//受理部门ID BspUtil.getDeptOrgan().getOrganId();
	//当前登录人 BspUtil.getEmpOrgan().getOrganName();
	//当前登录人Id GetBspInfo.getBspInfo().getUserId();
	
	public void saveNameApproval(SomApply somApply) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SORG_ID", somApply.getSorgId());
		DataSet somOrganDataSet = somOrganDomain.query(pset);
		//1.保存业务数据
		SomOrgan somOrgan = somApply.getSomOrgan();
		somOrgan.setSorgStatus("8");
		somOrgan.setSorgType("M");
		if(somOrganDataSet.getCount()>0){
			somOrganDomain.update(somOrgan);
		}else{
			somOrganDomain.insert(somOrgan);
		}
		// 处理从表信息
		dealSomHeldPeople(somApply);
		dealSomHeldOrgan(somApply);
		dealSomAspchief(somApply);
		somApply.setSorgId(somOrgan.getSorgId());
		somApply.setApplyType(ApplyType.SOM_UNGOV_NAME_APPROVAL);
		somApply.setSorgType(somOrgan.getSorgType());
		somApply.setSorgName(somOrgan.getCnName());
		somApply.setBorgName(somOrgan.getBorgName());
		somApply.setIfFinish("0");
		if(somOrganDataSet.getCount()>0){
			somApply.setDataSource("ONLINE");
			//此处要注意，创建时间在修改方法中修改了
			somApply.setCreateTime(DateUtil.getTime());
			somApplyDomain.update(somApply);
		}else{
			somApplyDomain.insertOnline(somApply);
		}
		
		//返回参数
	}
	
	//---------------------------成立---------------------------
	/**
	 * 保存业务信息
	 */
	public void insertBuildInfo(SomApply applyBean) {
		//保存相关信息
		insertBuildContent(applyBean);
		somApplyDomain.insertOnline(applyBean);
		dealSomPartyMember(applyBean);
	}
	/**
	 * 更新业务信息
	 */
	public void updateBuildInfo(SomApply applyBean){
		String createTime = DateUtil.getTime();
		
		SomOrgan somOrgan=applyBean.getSomOrgan();
		List<SomDuty> somDutyList = somOrgan.getSomDutyList();
		SomRule somRule=somOrgan.getSomRule();
		SomSession somSession=somOrgan.getSomSession();
		List<SomHeldPeople> heldPeopleList = somOrgan.getSomHeldPeopleList();
		List<SomHeldOrgan> somHeldOrganList = somOrgan.getSomHeldOrganList();
		List<SomOffice> somOfficeList = somOrgan.getSomOfficeList();
		
		somOrgan.setBorgName(applyBean.getBorgName());
		somOrganDomain.update(somOrgan);
		somApplyDomain.update(applyBean);
		somRuleDomain.update(somRule);
		
		for (int i = 0; i < heldPeopleList.size(); i++) {
			SomHeldPeople heldPeopleBean = heldPeopleList.get(i);
			if(heldPeopleBean.getId().equals("")){
				heldPeopleBean.setId(IdHelp.getUUID30());
				heldPeopleBean.setTaskCode(applyBean.getTaskCode());
				heldPeopleBean.setSorgId(somOrgan.getSorgId());
				heldPeopleBean.setIfChief("0");
				heldPeopleBean.setCreateTime(createTime);
				somHeldPeopleDomain.insert(heldPeopleBean);
			}else{
				if(heldPeopleBean.getState() == Record.STATE_MODIFIED){
					somHeldPeopleDomain.update(heldPeopleBean);
				}
				if(heldPeopleBean.getState() == Record.STATE_DELETED){
					somHeldPeopleDomain.delete(heldPeopleBean.getId());
				}
			}
		}
		for (int i = 0; i < somHeldOrganList.size(); i++) {
			SomHeldOrgan somHeldOrgan = somHeldOrganList.get(i);
			if(somHeldOrgan.getId().equals("")){
				somHeldOrgan.setId(IdHelp.getUUID32());
				somHeldOrgan.setTaskCode(applyBean.getTaskCode());
				somHeldOrgan.setSorgId(somOrgan.getSorgId());
				somHeldOrgan.setCreateTime(createTime);
				somHeldOrganDomain.insert(somHeldOrgan);
			}else{
				if(somHeldOrgan.getState() == Record.STATE_MODIFIED){
					somHeldOrganDomain.update(somHeldOrgan);
				}
				if(somHeldOrgan.getState() == Record.STATE_DELETED){
					somHeldOrganDomain.delete(somHeldOrgan.getId());
				}
			}
		}
		for (int i = 0; i < somOfficeList.size(); i++) {
			SomOffice somOffice = somOfficeList.get(i);
			if(somOffice.getId().equals("")){
				somOffice.setId(IdHelp.getUUID30());
				somOffice.setSorgId(somOrgan.getSorgId());
				somOffice.setTaskCode(applyBean.getTaskCode());
				somOffice.setSorgType("M");
				somOffice.setCreateTime(createTime);
				somOfficeDomain.insertOnline(somOffice);
			}else{
				if(somOffice.getState() == Record.STATE_MODIFIED){
					somOfficeDomain.update(somOffice);
				}
				if(somOffice.getState() == Record.STATE_DELETED){
					somOfficeDomain.delete(somOffice);
				}
			}
		}
		if(somDutyList.size()>0){
			somDutyDomain.deleteByTaskCode(applyBean.getTaskCode());
			somSession.setSomDutyList(somDutyList);
			somDutyDomain.regUngovPeopleOnline(somSession);
			somDutyDomain.updateRegStatus("1",applyBean.getTaskCode());
		}
		dealSomPartyMember(applyBean);
	}
	//---------------------------变更---------------------------
	/**
	 *  保存社会组织变更信息
	 * @param somChangeApply
	 */
	public void saveChange(SomChangeApply somChangeApply) {
		Map<String, String> map=somChangeApply.getMap();
		SomApply somApply=somChangeApply.getSomApply();
		somApplyDomain.insertOnline(somApply);
		somOrganDomain.insert(somApply.getSomOrgan());
		saveChangeInfo(somChangeApply);
		
	}
	/**
	 * 更新社会组织变更信息
	 * @param somChangeApply
	 */
	public void updateChange(SomChangeApply somChangeApply) {
		Map<String, String> map=somChangeApply.getMap();
		SomApply somApply=somChangeApply.getSomApply();
		somApply.setSorgKind(map.get("sorgKind"));
		somApply.setSorgName(map.get("cnName"));
		somApplyDomain.update(somApply);
		somChangeDomain.deleteChangeByTaskCode(somApply.getTaskCode());
		somOrganDomain.update(somApply.getSomOrgan());
		saveChangeInfo(somChangeApply);
		
	}
	//---------------------------注销---------------------------
	/**
	 * 新增注销
	 * 
	 * @param somApply
	 */
	public void saveCancel(SomApply somApply) {
		// 修改社会组织信息
		SomOrgan somOrgan = somApply.getSomOrgan();

		// 保存业务信息
		somApply.setSorgId(somOrgan.getSorgId());
		somApply.setApplyType(ApplyType.SOM_UNGOV_CANCEL);
		somApply.setSorgType(somOrgan.getSorgType());
		somApply.setSorgKind(somOrgan.getSorgKind());
		somApply.setSorgName(somOrgan.getCnName());
		somApply.setBorgName(somOrgan.getBorgName());
		// 保存所有信息
		somOrganDomain.insert(somOrgan);
		dealSomLiqpeople(somApply);
		somApplyDomain.insertOnline(somApply);
	}
	
	/**
	 * 修改注销
	 * 
	 * @param somApply
	 */
	public void updateCancel(SomApply somApply) {
		SomOrgan somOrgan = somApply.getSomOrgan();
		// 保存所有信息
		somOrganDomain.update(somOrgan);
		dealSomLiqpeople(somApply);
		somApplyDomain.update(somApply);
	}
	
	/**
	 * 处理清算组织人员
	 * 
	 * @param somApply
	 */	
	private void dealSomLiqpeople(SomApply somApply) {
		SomOrgan somOrgan = somApply.getSomOrgan();
		List<SomLiqpeople> somHeldPeopleList = somOrgan.getSomLiqpeopleList();
		for (int i = 0; i < somHeldPeopleList.size(); i++) {
			SomLiqpeople somLiqpeople = somHeldPeopleList.get(i);
			if (somLiqpeople.getState() == Record.STATE_NEW) {
				somLiqpeople.setId(IdHelp.getUUID30());
				somLiqpeople.setSorgId(somOrgan.getSorgId());
				somLiqpeopleDomain.insert(somLiqpeople);
			} else if (somLiqpeople.getState() == Record.STATE_MODIFIED) {
				somLiqpeopleDomain.update(somLiqpeople);
			} else if (somLiqpeople.getState() == Record.STATE_DELETED) {
				somLiqpeopleDomain.delete(somLiqpeople.getId());
			}
		}
	}
	//-----------------------------------------私有方法-----------------------------------------------
	/**
	 * 保存业务信息
	 */
	private void insertBuildContent(SomApply applyBean) {	
		SomOrgan somOrgan=applyBean.getSomOrgan();
		List<SomDuty> somDutyList = somOrgan.getSomDutyList();
		List<SomHeldPeople> somHeldPeopleList = somOrgan.getSomHeldPeopleList();
		List<SomHeldOrgan> somHeldOrganList = somOrgan.getSomHeldOrganList();
		List<SomOffice> somOfficeList = somOrgan.getSomOfficeList();
		SomRule somRule=somOrgan.getSomRule();
		SomSession somSession=new SomSession();
		somSession.setSessionId("");
		
		String createTime = DateUtil.getTime();
		String taskCode=applyBean.getTaskCode();
		String sorgId=somOrgan.getSorgId();		
		
		somOrgan.setSorgStatus("21");
		somOrgan.setSorgType("M");
		somOrgan.setIfBranch("0");
		somOrgan.setBorgName(applyBean.getBorgName());
		somOrganDomain.insertAndBuildHis(somOrgan,applyBean.getTaskCode());
		somSession.setTaskCode(taskCode);
		somSession.setSorgId(sorgId);
		somSession.setSeq("1");//顺序号
		somSession.setSomDutyList(somDutyList);
		if(somDutyList.size()>0){
			somDutyDomain.regUngovPeopleOnline(somSession);
			somDutyDomain.updateRegStatus("1",applyBean.getTaskCode());
		}
		for(int i=0;i<somHeldPeopleList.size();i++){
			SomHeldPeople somHeldPeople=somHeldPeopleList.get(i);
			if(somHeldPeople.getState() == Record.STATE_DELETED){
				continue;
			}
			somHeldPeople.setId(IdHelp.getUUID32());
			somHeldPeople.setTaskCode(taskCode);
			somHeldPeople.setSorgId(sorgId);
			somHeldPeople.setIfChief("0");
			somHeldPeople.setCreateTime(createTime);
			somHeldPeopleDomain.insert(somHeldPeople);
		}
		for(int i=0;i<somHeldOrganList.size();i++){
			SomHeldOrgan somHeldOrgan=somHeldOrganList.get(i);
			if(somHeldOrgan.getState() == Record.STATE_DELETED){
				continue;
			}
			somHeldOrgan.setId(IdHelp.getUUID32());
			somHeldOrgan.setTaskCode(taskCode);
			somHeldOrgan.setSorgId(sorgId);
			somHeldOrgan.setCreateTime(createTime);
			somHeldOrganDomain.insert(somHeldOrgan);
		}
		for(int i=0;i<somOfficeList.size();i++){
			SomOffice somOffice=somOfficeList.get(i);
			somOffice.setSorgId(sorgId);
			somOffice.setTaskCode(taskCode);
			somOffice.setSorgType("M");
			somOfficeDomain.insertOnline(somOffice);
		}
		somRule.setSorgId(sorgId);
		somRule.setTaskCode(taskCode);
		somRule.setRegStatus("1");//有效
		somRule.setIfDraft("0");
		somRuleDomain.insertOnline(somRule);
		applyBean.setSorgId(sorgId);
		applyBean.setSorgType("M");
		applyBean.setSorgKind(somOrgan.getSorgKind());
		applyBean.setSorgName(somOrgan.getCnName());
		applyBean.setIfFinish("1");
		applyBean.setDataSource("ONLINE");
	}
	
	private void saveChangeInfo(SomChangeApply somChangeApply) {
		Map<String, String> map=somChangeApply.getMap();
		List<SomChange> changes=somChangeApply.getSomChange();
		String taskCode = somChangeApply.getSomApply().getTaskCode();
		String sorgId = somChangeApply.getSomApply().getSorgId();
		for(int i=0;i<changes.size();i++){
			SomChange somchange=changes.get(i);
			somchange.setTaskCode(somChangeApply.getSomApply().getTaskCode());
			somchange.setId(IdHelp.getUUID32());
			somchange.setSorgId(map.get("sorgId"));
			somchange.setChangeStatus("1");
			somChangeDomain.insert(somchange);//插入变更信息
		}
		
		somDutyDomain.deleteByTaskCode(taskCode);
		//保存法定代表人信息
		List<SomPeopleResume> peopleResumes=somChangeApply.getPeopleResumes();
		SomDuty people=somChangeApply.getSomLegalPeople();
		if(people != null){
			String peopleId=somPeopleDomain.create(people.getSomPeople());
			// 维护任职信息
			String oldDutyId=map.get("legalDutyId");
			people.setDutyId(IdHelp.getUUID32());
			if(oldDutyId!=null){
				somDutyElectronicDao.updateDutyId(oldDutyId, people.getDutyId());
			}
			people.setTaskCode(taskCode);
			people.setSorgId(sorgId);
			people.setPeopleId(peopleId);
			people.setRegStatus("1");
			people.setIfServe("1");
			people.setSorgType("S");
			people.setCreateTime(DateUtil.getTime());
			somDutyDomain.insert(people);
		}	
		somPeopleResumeDomain.deleteResume(taskCode);//清空人员简历信息
		if(peopleResumes!=null){
			for (int i = 0; i < peopleResumes.size(); i++) {
				SomPeopleResume somPeopleResume = peopleResumes.get(i);
				somPeopleResume.setId(IdHelp.getUUID32());
				somPeopleResume.setTaskCode(taskCode);
				somPeopleResume.setDutyId(map.get("legalDutyId"));
				somPeopleResumeDomain.insert(somPeopleResume);
			}
		}
	}
	
	// 获取发起人（自然人）
	private void dealSomHeldPeople(SomApply somApply) {
		SomOrgan somOrgan = somApply.getSomOrgan();
		List<SomHeldPeople> somHeldPeopleList = somOrgan.getSomHeldPeopleList();
		for (int i = 0; i < somHeldPeopleList.size(); i++) {
			SomHeldPeople somHeldPeople = somHeldPeopleList.get(i);
			if (somHeldPeople.getState() == Record.STATE_NEW) {
				somHeldPeople.setId(IdHelp.getUUID30());
				somHeldPeople.setSorgId(somOrgan.getSorgId());
				somHeldPeople.setTaskCode(somApply.getTaskCode());
				somHeldPeople.setMorgArea(somOrgan.getMorgArea());
				somHeldPeople.setMorgName(somOrgan.getMorgName());
				somHeldPeople.setCreatePeople(somApply.getCreatePerson());
				somHeldPeople.setCreateTime(DateUtil.getTime());
				somHeldPeopleDomain.insert(somHeldPeople);
			} else if (somHeldPeople.getState() == Record.STATE_MODIFIED) {
				somHeldPeopleDomain.update(somHeldPeople);
			} else if (somHeldPeople.getState() == Record.STATE_DELETED) {
				somHeldPeopleDomain.delete(somHeldPeople.getId());
			}
		}
	}
	
	// 获取发起人（单位）
	private void dealSomHeldOrgan(SomApply somApply) {
		SomOrgan somOrgan = somApply.getSomOrgan();
		List<SomHeldOrgan> somHeldOrganList = somOrgan.getSomHeldOrganList();
		for (int i = 0; i < somHeldOrganList.size(); i++) {
			SomHeldOrgan somHeldOrgan = somHeldOrganList.get(i);
			if (somHeldOrgan.getState() == Record.STATE_NEW) {
				somHeldOrgan.setId(IdHelp.getUUID30());
				somHeldOrgan.setSorgId(somOrgan.getSorgId());
				somHeldOrgan.setTaskCode(somApply.getTaskCode());
				somHeldOrgan.setMorgArea(somOrgan.getMorgArea());
				somHeldOrgan.setMorgName(somOrgan.getMorgName());
				somHeldOrgan.setCreatePeople(somApply.getCreatePerson());
				somHeldOrgan.setCreateTime(DateUtil.getTime());
				somHeldOrganDomain.insert(somHeldOrgan);
			} else if (somHeldOrgan.getState() == Record.STATE_MODIFIED) {
				somHeldOrganDomain.update(somHeldOrgan);
			} else if (somHeldOrgan.getState() == Record.STATE_DELETED) {
				somHeldOrganDomain.delete(somHeldOrgan.getId());
			}
		}
	}
	
	// 获取拟任负责人
	private void dealSomAspchief(SomApply somApply) {
		SomOrgan somOrgan = somApply.getSomOrgan();
		List<SomAspchief> somAspchiefList = somOrgan.getSomAspchiefList();
		for (int i = 0; i < somAspchiefList.size(); i++) {
			SomAspchief somAspchief = somAspchiefList.get(i);
			if (somAspchief.getState() == Record.STATE_NEW) {
				somAspchief.setId(IdHelp.getUUID30());
				somAspchief.setSorgId(somOrgan.getSorgId());
				somAspchief.setTaskCode(somApply.getTaskCode());
				somAspchief.setMorgArea(somOrgan.getMorgArea());
				somAspchief.setMorgName(somOrgan.getMorgName());
				somAspchief.setCreatePeople(somApply.getCreatePerson());
				somAspchief.setCreateTime(DateUtil.getTime());
				somAspchiefDomain.insert(somAspchief);
			} else if (somAspchief.getState() == Record.STATE_MODIFIED) {
				somAspchiefDomain.update(somAspchief);
			} else if (somAspchief.getState() == Record.STATE_DELETED) {
				somAspchiefDomain.delete(somAspchief.getId());
			}
		}
	}
	
	// 获取党员
	private void dealSomPartyMember(SomApply somApply) {
		String regDate = DateUtil.getDay();
		SomOrgan somOrgan = somApply.getSomOrgan();
		List<SomPartyMember> somPartyMemberList = somOrgan.getSomPartyMemberList();
		somPartyMemberDomain.deleteBySorgId(somOrgan.getSorgId());
		for (int i = 0; i < somPartyMemberList.size(); i++) {
			SomPartyMember somPartyMember = somPartyMemberList.get(i);
			somPartyMember.setRegDate(regDate);
			somPartyMemberDomain.insert(somPartyMember);
			List<SomPartyPraise> somPartyPraiseList=somPartyMember.getSomPartyPraiseList();
			for (int j = 0; j < somPartyPraiseList.size(); j++) {
				SomPartyPraise somPartyPraise=somPartyPraiseList.get(j);
				if (somPartyPraise.getMemberId().equals(somPartyMember.getMemberId())) {
					if(somPartyPraise.getPraiseId()==null ||"".equals(somPartyPraise.getPraiseId())){
						somPartyPraise.setPraiseId(IdHelp.getUUID32());
						somPartyPraiseDomain.insert(somPartyPraise);
					}else{
						somPartyPraiseDomain.update(somPartyPraise);
					}
				}
			}
		}
	}
}
