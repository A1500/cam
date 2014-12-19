package com.inspur.cams.sorg.online.apply.group.domain.support;

import java.math.BigDecimal;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.data.RecordSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.base.dao.ISomDutyElectronicDao;
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
import com.inspur.cams.sorg.base.domain.ISomApplyDomain;
import com.inspur.cams.sorg.base.domain.ISomAspchiefDomain;
import com.inspur.cams.sorg.base.domain.ISomCertDomain;
import com.inspur.cams.sorg.base.domain.ISomChangeDomain;
import com.inspur.cams.sorg.base.domain.ISomDutyDomain;
import com.inspur.cams.sorg.base.domain.ISomFeeDomain;
import com.inspur.cams.sorg.base.domain.ISomHeldOrganDomain;
import com.inspur.cams.sorg.base.domain.ISomHeldPeopleDomain;
import com.inspur.cams.sorg.base.domain.ISomLiqpeopleDomain;
import com.inspur.cams.sorg.base.domain.ISomOrganDomain;
import com.inspur.cams.sorg.base.domain.ISomPartyMemberDomain;
import com.inspur.cams.sorg.base.domain.ISomPartyPraiseDomain;
import com.inspur.cams.sorg.base.domain.ISomPeopleDomain;
import com.inspur.cams.sorg.base.domain.ISomRuleDomain;
import com.inspur.cams.sorg.base.domain.ISomSignetDomain;
import com.inspur.cams.sorg.online.apply.group.domain.ISomGroupOnlineDomain;
import com.inspur.cams.sorg.util.ApplyType;
import com.inspur.cams.sorg.util.SomDutyDuties;
/**
 * 社会团体历史业务Domain
 * @author yanliangliang
 * @date 2011-11-21
 */
public class SomGroupOnlineDomain implements ISomGroupOnlineDomain{
	@Reference
	private ISomOrganDomain somOrganDomain;
	@Reference
	private ISomHeldPeopleDomain somHeldPeopleDomain;
	@Reference
	private ISomHeldOrganDomain somHeldOrganDomain;
	@Reference
	private ISomAspchiefDomain somAspchiefDomain;
	@Reference
	private ISomApplyDomain somApplyDomain;
	//成立
	@Reference
	private ISomRuleDomain somRuleDomain;
	@Reference
	private ISomFeeDomain somFeeDomain;
	//变更
	@Reference
	private ISomChangeDomain somChangeDomain;
	@Reference
	private ISomPeopleDomain somPeopleDomain;
	@Reference
	private ISomDutyElectronicDao somDutyElectronicDao;
	// 注销
	@Reference
	private ISomLiqpeopleDomain somLiqpeopleDomain;
	@Reference
	private ISomDutyDomain somDutyDomain;
	@Reference
	private ISomCertDomain somCertDomain;
	@Reference
	private ISomSignetDomain somSignetDomain;
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
		somOrgan.setSorgType("S");
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
		somApply.setApplyType(ApplyType.SOM_GROUP_NAME_APPROVAL);
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
	
	/**
	 * 保存社会组织筹备信息
	 * @param somApply
	 */
	public void savePrepare(SomApply somApply) {
		SomOrgan somOrgan = somApply.getSomOrgan();
		somApply.setSorgKind(somOrgan.getSorgKind());
		somApply.setSorgName(somOrgan.getCnName());
		somApply.setBorgName(somOrgan.getBorgName());
		somApply.setIfFinish("1");
		savePrepareInfo(somOrgan);
		somOrganDomain.insert(somOrgan);
		somApplyDomain.insertOnline(somApply);
	}
	/**
	 * 修改筹备
	 * 
	 * @param somApply
	 */
	public void updatePrepare(SomApply somApply) {
		SomOrgan somOrgan = somApply.getSomOrgan();
		String sorgId=somOrgan.getSorgId();
		somHeldPeopleDomain.deleteBySorgId(sorgId);
		somHeldOrganDomain.deleteBySorgId(sorgId);
		somAspchiefDomain.deleteBySorgId(sorgId);
		savePrepareInfo(somOrgan);
		somApply.setSorgKind(somOrgan.getSorgKind());
		somApply.setSorgName(somOrgan.getCnName());
		//somApply.setBorgName(somOrgan.getBorgName());
		//因为筹备存的是历史表，需要把登记状态重新回填一下
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SORG_ID", somOrgan.getSorgId());
		DataSet somOrganDataSet = somOrganDomain.query(pset);
		if(somOrganDataSet.getCount()>0){
			SomOrgan somOrganInfo = (SomOrgan)somOrganDataSet.getRecord(0).toBean(SomOrgan.class);
			somOrgan.setSorgStatus(somOrganInfo.getSorgStatus());
		}
		somOrganDomain.update(somOrgan);
		somApplyDomain.update(somApply);
		somApplyDomain.updateSomApplyInfo(somOrgan);
	}
	/**
	 * 新增成立信息
	 * @param somApply
	 */
	public void saveBuild(SomApply build) {
		SomOrgan somOrgan=build.getSomOrgan();
		List<SomDuty> somDutyList = somOrgan.getSomDutyList();
		SomRule somRule=somOrgan.getSomRule();
		SomFee somFee=somOrgan.getSomFee();
		SomSession somSession=somOrgan.getSomSession();
		String taskCode=build.getTaskCode();
		//保存社会组织基本信息
		if(somOrgan.getSorgStatus()==null || "".equals(somOrgan.getSorgStatus())){
			//somOrgan.setSorgId(SomIdHelp.getGroupSorgId());
			somOrgan.setSorgStatus("21");
			somOrgan.setSorgType("S");
			somOrgan.setIfBranch("0");
			somOrganDomain.insert(somOrgan);
		}else{
			somOrgan.setSorgStatus("21");
			somOrganDomain.update(somOrgan);
		}
		String sorgId=somOrgan.getSorgId();	
		//保存届次和任职基本信息
		if(somDutyList.size()>0){
			somSession.setTaskCode(taskCode);
			somSession.setSorgId(sorgId);
			somSession.setSeq("1");//顺序号
			somSession.setSomDutyList(somDutyList);
			somDutyDomain.regPeopleOnline(somSession);
			somDutyDomain.updateRegStatus("1",build.getTaskCode());
		}
		somRule.setSorgId(sorgId);
		somRule.setTaskCode(taskCode);
		somRule.setRegStatus("1");
		somRuleDomain.insertOnline(somRule);
		//保存会费标准基本信息
		somFee.setSorgId(sorgId);
		somFee.setTaskCode(taskCode);
		somFee.setRegStatus("1");
		somFeeDomain.insertOnline(somFee);
		dealSomPartyMember(build);
		//保存业务表基本信息
		build.setSorgId(sorgId);
		build.setApplyType(ApplyType.SOM_GROUP_BUILD);
		build.setSorgType("S");
		build.setSorgKind(somOrgan.getSorgKind());
		build.setSorgName(somOrgan.getCnName());
		build.setBorgName(somOrgan.getBorgName());
		build.setIfFinish("1");
		somApplyDomain.insertOnline(build);
	}
	/**
	 * 修改成立信息
	 * @param build
	 */
	public void updateBuild(SomApply build) {
		SomOrgan somOrgan=build.getSomOrgan();
		List<SomDuty> somDutyList = somOrgan.getSomDutyList();
		SomRule somRule=somOrgan.getSomRule();
		SomFee somFee=somOrgan.getSomFee();
		SomSession somSession=somOrgan.getSomSession();
		somOrganDomain.update(somOrgan);
		build.setSorgKind(somOrgan.getSorgKind());
		build.setSorgName(somOrgan.getCnName());
		//build.setBorgName(somOrgan.getBorgName());
		somApplyDomain.update(build);
		somApplyDomain.updateSomApplyInfo(somOrgan);
		somRuleDomain.update(somRule);
		somFeeDomain.update(somFee);
		if(somDutyList.size()>0){
			somDutyDomain.deleteByTaskCode(build.getTaskCode());
			somSession.setSomDutyList(somDutyList);
			somDutyDomain.regPeopleOnline(somSession);
			somDutyDomain.updateRegStatus("1",build.getTaskCode());
		}
		dealSomPartyMember(build);
	}
	/**
	 *  新增分支成立信息
	 */
	public void saveBranchBuild(SomApply branchBuild) {
		SomOrgan somOrgan = branchBuild.getSomOrgan();
		branchBuild.setApplyType(ApplyType.SOM_GROUP_BRANCH_BUILD);
		branchBuild.setSorgType("S");
		branchBuild.setSorgKind(somOrgan.getSorgKind());
		branchBuild.setSorgName(somOrgan.getCnName());
		branchBuild.setBorgName(somOrgan.getBorgName());
		branchBuild.setIfFinish("1");
		somOrgan.setSorgStatus("21");
		somOrganDomain.insert(somOrgan);
		//处理负责人信息
		SomSession somSession=somOrgan.getSomSession();
		List<SomDuty> somDutyList = somOrgan.getSomDutyList();
		somSession.setSeq("1");//顺序号
		somSession.setSomDutyList(somDutyList);
		somApplyDomain.insertOnline(branchBuild);
		somDutyDomain.regPeopleOnline(somSession);
		somDutyDomain.updateRegStatus("1",branchBuild.getTaskCode());
	}
	/**
	 * 修改分支成立信息
	 */
	public void updateBranchBuild(SomApply branchBuild) {
		SomOrgan somOrgan = branchBuild.getSomOrgan();
		somOrganDomain.updateAndBuildHis(somOrgan,branchBuild.getTaskCode());
		branchBuild.setSorgKind(somOrgan.getSorgKind());
		branchBuild.setSorgName(somOrgan.getCnName());
		//branchBuild.setBorgName(somOrgan.getBorgName());
		somApplyDomain.update(branchBuild);
		somApplyDomain.updateSomApplyInfo(somOrgan);
		SomSession somSession=somOrgan.getSomSession();
		List<SomDuty> somDutyList = somOrgan.getSomDutyList();
		somSession.setSomDutyList(somDutyList);
		somDutyDomain.deleteByTaskCode(branchBuild.getTaskCode());
		somDutyDomain.regPeopleOnline(somSession);
		somDutyDomain.updateRegStatus("1",branchBuild.getTaskCode());
	}
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
		somApplyDomain.update(somApply);
		somOrganDomain.update(somApply.getSomOrgan());
		somChangeDomain.deleteChangeByTaskCode(somApply.getTaskCode());
		saveChangeInfo(somChangeApply);
	}
	/**
	 * 保存社会组织分支变更信息
	 * @param somChangeApply
	 */
	public void saveBranchChange(SomChangeApply somChangeApply) {
		Map<String, String> map=somChangeApply.getMap();
		SomApply somApply=somChangeApply.getSomApply();
		somApply.setIfFinish("0");
		somApplyDomain.insertOnline(somApply);
		somOrganDomain.insert(somApply.getSomOrgan());
		saveChangeInfo(somChangeApply);
		
	}
	/**
	 * 更新社会组织分支变更信息
	 * @param somChangeApply
	 */
	public void updateBranchChange(SomChangeApply somChangeApply) {
		Map<String, String> map=somChangeApply.getMap();
		SomApply somApply=somChangeApply.getSomApply();
		somApplyDomain.update(somApply);
		somOrganDomain.update(somApply.getSomOrgan());
		somChangeDomain.deleteChangeByTaskCode(somApply.getTaskCode());
		saveChangeInfo(somChangeApply);
		
	}
	// ---------------------------注销---------------------------
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
		somApply.setApplyType(ApplyType.SOM_GROUP_CANCEL);
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

	

	// ---------------------------分支注销---------------------------
	/**
	 * 新增分支注销
	 * 
	 * @param somApply
	 */
	public void saveBranchCancel(SomApply somApply) {
		// 修改社会组织信息
		SomOrgan somOrgan = somApply.getSomOrgan();
		somOrgan.setSorgStatus("00");

		// 保存业务信息
		somApply.setSorgId(somOrgan.getSorgId());
		somApply.setApplyType(ApplyType.SOM_GROUP_BRANCH_CANCEL);
		somApply.setSorgType(somOrgan.getSorgType());
		somApply.setSorgKind(somOrgan.getSorgKind());
		somApply.setSorgName(somOrgan.getCnName());
		somApply.setBorgName(somOrgan.getBorgName());
		somApply.setIfFinish("1");
		// 保存所有信息
		somOrganDomain.insert(somOrgan);
		somApplyDomain.insertOnline(somApply);
	}
	/**
	 * 修改分支注销
	 * 
	 * @param somApply
	 */
	public void updateBranchCancel(SomApply somApply) {
		SomOrgan somOrgan = somApply.getSomOrgan();
		// 保存所有信息
		somOrganDomain.update(somOrgan);
		somApplyDomain.update(somApply);
	}
	/**
	 * 异地设立分支审查的保存
	 */
	public void saveBranchAPCheck(SomApply somApply) {
		SomOrgan somOrgan = somApply.getSomOrgan();
		somOrgan.setMorgName(BspUtil.getCorpOrgan().getOrganName());
		somOrgan.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
		somApply.setSorgKind(somOrgan.getSorgKind());
		somApply.setSorgName(somOrgan.getCnName());
		somApply.setBorgName(somOrgan.getBorgName());
		somApply.setIfFinish("1");
		somApply.setAcceptArea(BspUtil.getCorpOrgan().getOrganCode());
		somApply.setAcceptOrganName(BspUtil.getCorpOrgan().getOrganName());
		somApply.setAcceptDeptName(BspUtil.getDeptOrgan().getOrganName());
		somApply.setAcceptDeptId(BspUtil.getDeptOrgan().getOrganId());
		somApply.setAcceptPeopleId(GetBspInfo.getBspInfo().getUserId());
		somOrganDomain.insertAndBuildHis(somOrgan,somApply.getTaskCode());
		somApplyDomain.insertOnline(somApply);
		
	}
	/**
	 * 异地设立分支审查的更新
	 */
	public void updateBranchAPCheck(SomApply somApply) {
		SomOrgan somOrgan = somApply.getSomOrgan();
		somApply.setSorgKind(somOrgan.getSorgKind());
		somApply.setSorgName(somOrgan.getCnName());
		somApply.setBorgName(somOrgan.getBorgName());
		somOrganDomain.updateAndBuildHis(somOrgan,somApply.getTaskCode());
		somApplyDomain.update(somApply);
	}
	//TODO------------------------------私有方法--------------------------------------------
	/**
	 * 保存发起人，发起单位，拟任负责人信息
	 * @param somOrgan
	 */
	private void savePrepareInfo(SomOrgan somOrgan) {
		List<SomHeldPeople> somHeldPeopleList = somOrgan.getSomHeldPeopleList();
		List<SomHeldOrgan> somHeldOrganList = somOrgan.getSomHeldOrganList();
		List<SomAspchief> somAspchiefList = somOrgan.getSomAspchiefList();
		for(int i=0;i<somHeldPeopleList.size();i++){
			SomHeldPeople somHeldPeople = somHeldPeopleList.get(i);
			somHeldPeople.setId(IdHelp.getUUID32());
			somHeldPeople.setMorgName(somOrgan.getMorgName());
			somHeldPeople.setMorgArea(somOrgan.getMorgArea());
			somHeldPeopleDomain.insert(somHeldPeople);
		}
		for(int i=0;i<somHeldOrganList.size();i++){
			SomHeldOrgan somHeldOrgan = somHeldOrganList.get(i);
			somHeldOrgan.setId(IdHelp.getUUID32());
			somHeldOrgan.setMorgName(somOrgan.getMorgName());
			somHeldOrgan.setMorgArea(somOrgan.getMorgArea());
			somHeldOrganDomain.insert(somHeldOrgan);
		}
		for(int i=0;i<somAspchiefList.size();i++){
			SomAspchief somAspchief = somAspchiefList.get(i);
			somAspchief.setId(IdHelp.getUUID32());
			somAspchief.setMorgName(somOrgan.getMorgName());
			somAspchief.setMorgArea(somOrgan.getMorgArea());
			somAspchiefDomain.insert(somAspchief);
		}
	}
	private void saveChangeInfo(SomChangeApply somChangeApply) {
		Map<String, String> map=somChangeApply.getMap();
		List<SomChange> changes=somChangeApply.getSomChange();
		
		for(int i=0;i<changes.size();i++){
			SomChange somchange=changes.get(i);
			somchange.setTaskCode(somChangeApply.getSomApply().getTaskCode());
			somchange.setId(IdHelp.getUUID32());
			somchange.setSorgId(somChangeApply.getSomApply().getSorgId());
			somchange.setChangeStatus("1");
			if("2".equals(somchange.getChangeItem())){//更新法定代表人的dutyId
				somchange.setLegalDutyId(map.get("legalDutyId"));
			}
			somChangeDomain.insert(somchange);//插入变更信息
		}
		
		SomDuty people=somChangeApply.getSomLegalPeople();
		if(people != null){
			if(map.get("legalDutyId") != null && map.get("taskCode1") != null ){
				savePeopleAndMember(people,map);
			}
		}	
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
	/**
	 * 变更里面保存法定代表人
	 * @param people
	 * @param map
	 */
	private void savePeopleAndMember(SomDuty people, Map<String, String> map) {
		String peopleId=somPeopleDomain.create(people.getSomPeople());
		// 维护任职信息
		ParameterSet pset = new ParameterSet();
		pset.setParameter("DUTY_ID@=",map.get("legalDutyId"));
		DataSet dutyds=somDutyDomain.query(pset);
		if(dutyds.getCount() > 0){
			people.setTaskCode(map.get("taskCode1"));
			people.setSorgId(map.get("sorgId"));
			people.setPeopleId(peopleId);
			people.setRegStatus("3");
			people.setIfServe("1");
			people.setSorgType("S"); 
			people.setCreateTime(DateUtil.getTime());
			somDutyDomain.update(people);
		}else{
			people.setDutyId(map.get("legalDutyId"));
			somDutyDomain.changeOldDutyIdToNew(people);
			people.setTaskCode(map.get("taskCode1"));
			people.setSorgId(map.get("sorgId"));
			people.setPeopleId(peopleId);
			people.setRegStatus("3");
			people.setIfServe("1");
			people.setSorgType("S");
			people.setCreateTime(DateUtil.getTime());
			somDutyDomain.insert(people);
		}
		somDutyDomain.deletePeopleResumeByTaskCode(map.get("taskCode1"));
		List<SomPeopleResume> somResumeList = people.getSomPeopleResumeList();
		if(somResumeList.size() > 0 ){
			for (int j = 0; j < somResumeList.size(); j++) {
				SomPeopleResume somResume = somResumeList.get(j);
				somResume.setId(IdHelp.getUUID32());
				somResume.setDutyId(map.get("legalDutyId"));
				somResume.setTaskCode(map.get("taskCode1"));
				somDutyDomain.insertSomPeopleResume(somResume);
			}
		}
	}
	
}
