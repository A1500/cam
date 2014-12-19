package com.inspur.cams.sorg.history.group.domain.support;

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
import com.inspur.cams.sorg.base.domain.ISomPeopleDomain;
import com.inspur.cams.sorg.base.domain.ISomRuleDomain;
import com.inspur.cams.sorg.base.domain.ISomSignetDomain;
import com.inspur.cams.sorg.history.group.domain.ISomGroupHistoryDomain;
import com.inspur.cams.sorg.util.ApplyType;
import com.inspur.cams.sorg.util.SomDutyDuties;
/**
 * 社会团体历史业务Domain
 * @author yanliangliang
 * @date 2011-11-21
 */
public class SomGroupHistoryDomain implements ISomGroupHistoryDomain{
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
	
	//当前时间 DateUtil.getTime();
	//当前日期 DateUtil.getDay();
	//登记管理机关名称 BspUtil.getCorpOrgan().getOrganName();
	//登记管理机关行政区划 BspUtil.getCorpOrgan().getOrganCode();
	//登记管理机关ID BspUtil.getCorpOrgan().getOrganId();
	//受理部门名称 BspUtil.getDeptOrgan().getOrganName();
	//受理部门ID BspUtil.getDeptOrgan().getOrganId();
	//当前登录人 BspUtil.getEmpOrgan().getOrganName();
	//当前登录人Id GetBspInfo.getBspInfo().getUserId();
	
	/**
	 * 保存社会组织筹备信息
	 * @param somApply
	 */
	public void savePrepare(SomApply somApply) {
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
		savePrepareInfo(somOrgan);
		somOrganDomain.insertAndBuildHis(somOrgan,somApply.getTaskCode());
		somApplyDomain.insert(somApply);
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
		somOrganDomain.updateAndBuildHis(somOrgan,somApply.getTaskCode());
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
			somOrgan.setSorgStatus("22");
			somOrgan.setMorgName(BspUtil.getCorpOrgan().getOrganName());
			somOrgan.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
			somOrgan.setSorgType("S");
			somOrgan.setIfBranch("0");
			somOrganDomain.insertAndBuildHis(somOrgan,build.getTaskCode());
		}else{
			somOrgan.setSorgStatus("22");
			somOrgan.setMorgName(BspUtil.getCorpOrgan().getOrganName());
			somOrgan.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
			somOrganDomain.updateAndBuildHis(somOrgan,build.getTaskCode());
		}
		String sorgId=somOrgan.getSorgId();	
		//保存届次和任职基本信息
		if(somDutyList.size()>0){
			somSession.setTaskCode(taskCode);
			somSession.setSorgId(sorgId);
			somSession.setSeq("1");//顺序号
			somSession.setSomDutyList(somDutyList);
			somDutyDomain.regPeople(somSession);
			somDutyDomain.updateRegStatus("1",build.getTaskCode());
		}
		somRule.setSorgId(sorgId);
		somRule.setTaskCode(taskCode);
		somRule.setRegStatus("1");
		somRuleDomain.insert(somRule);
		//保存会费标准基本信息
		somFee.setSorgId(sorgId);
		somFee.setTaskCode(taskCode);
		somFee.setRegStatus("1");
		somFeeDomain.insert(somFee);
		//保存业务表基本信息
		build.setSorgId(sorgId);
		build.setApplyType(ApplyType.SOM_GROUP_BUILD);
		build.setSorgType("S");
		build.setSorgKind(somOrgan.getSorgKind());
		build.setSorgName(somOrgan.getCnName());
		build.setBorgName(somOrgan.getBorgName());
		build.setIfFinish("1");
		build.setAcceptOrganId(BspUtil.getCorpOrgan().getOrganId());
		build.setAcceptArea(BspUtil.getCorpOrgan().getOrganCode());
		build.setAcceptOrganName(BspUtil.getCorpOrgan().getOrganName());
		build.setAcceptDeptName(BspUtil.getDeptOrgan().getOrganName());
		build.setAcceptDeptId(BspUtil.getDeptOrgan().getOrganId());
		build.setAcceptPeopleId(GetBspInfo.getBspInfo().getUserId());
		somApplyDomain.insert(build);
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
		somOrgan.setMorgName(BspUtil.getCorpOrgan().getOrganName());
		somOrgan.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
		somOrganDomain.updateAndBuildHis(somOrgan,build.getTaskCode());
		build.setSorgKind(somOrgan.getSorgKind());
		build.setSorgName(somOrgan.getCnName());
		//build.setBorgName(somOrgan.getBorgName());
		somApplyDomain.update(build);
		somApplyDomain.updateSomApplyInfo(somOrgan);
		somRuleDomain.update(somRule);
		somFeeDomain.update(somFee);
		if(somDutyList.size()>0){
			//进行过换届备案的，成立时的负责状态会置为历史，此时再在历史数据采集成立保存时，会把duty状态置为在任，此时处理先取之前的状态，然后赋值给要保存的duty
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", build.getTaskCode());
			DataSet ds = somDutyDomain.query(pset);
			String regStatus = "1";
			if(ds.getCount()>0){
				String ifServe = (String)ds.getRecord(0).get("ifServe");
				regStatus = (String)ds.getRecord(0).get("regStatus");
				for(int i=0;i<somDutyList.size();i++){
					SomDuty somDuty = somDutyList.get(i);
					somDuty.setIfServe(ifServe);
					somDuty.setRegStatus(regStatus);
				}
			}
			somDutyDomain.deleteByTaskCode(build.getTaskCode());
			somSession.setSomDutyList(somDutyList);
			somDutyDomain.regPeople(somSession);
			somDutyDomain.updateRegStatus(regStatus,build.getTaskCode());
		}
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
		branchBuild.setAcceptOrganId(BspUtil.getCorpOrgan().getOrganId());
		branchBuild.setAcceptArea(BspUtil.getCorpOrgan().getOrganCode());
		branchBuild.setAcceptOrganName(BspUtil.getCorpOrgan().getOrganName());
		branchBuild.setAcceptDeptName(BspUtil.getDeptOrgan().getOrganName());
		branchBuild.setAcceptDeptId(BspUtil.getDeptOrgan().getOrganId());
		branchBuild.setAcceptPeopleId(GetBspInfo.getBspInfo().getUserId());
		somOrgan.setSorgStatus("22");
		somOrgan.setMorgName(BspUtil.getCorpOrgan().getOrganName());
		somOrgan.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
		somOrganDomain.insertAndBuildHis(somOrgan,branchBuild.getTaskCode());
		//处理负责人信息
		SomSession somSession=somOrgan.getSomSession();
		List<SomDuty> somDutyList = somOrgan.getSomDutyList();
		somSession.setSeq("1");//顺序号
		somSession.setSomDutyList(somDutyList);
		somApplyDomain.insert(branchBuild);
		somDutyDomain.regPeople(somSession);
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
		somDutyDomain.regPeople(somSession);
		somDutyDomain.updateRegStatus("1",branchBuild.getTaskCode());
	}
	/**
	 *  保存社会组织变更信息
	 * @param somChangeApply
	 */
	public void saveChange(SomChangeApply somChangeApply) {
		Map<String, String> map=somChangeApply.getMap();
		SomApply somApply=somChangeApply.getSomApply();
		somApply.setSorgId(map.get("sorgId"));
		somApply.setSorgKind(map.get("sorgKind"));
		somApply.setSorgName(map.get("cnName"));
		somApply.setIfFinish("1");
		somApply.setAcceptOrganId(BspUtil.getCorpOrgan().getOrganId());
		somApply.setAcceptArea(BspUtil.getCorpOrgan().getOrganCode());
		somApply.setAcceptOrganName(BspUtil.getCorpOrgan().getOrganName());
		somApply.setAcceptDeptName(BspUtil.getDeptOrgan().getOrganName());
		somApply.setAcceptDeptId(BspUtil.getDeptOrgan().getOrganId());
		somApply.setAcceptPeopleId(GetBspInfo.getBspInfo().getUserId());
		somApplyDomain.insert(somApply);
		
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
		somDutyDomain.reNewPeopleInfo(somApply.getTaskCode());
		saveChangeInfo(somChangeApply);
		
	}
	
	/**
	 * 保存社会组织分支变更信息
	 * @param somChangeApply
	 */
	public void saveBranchChange(SomChangeApply somChangeApply) {
		Map<String, String> map=somChangeApply.getMap();
		SomApply somApply=somChangeApply.getSomApply();
		somApply.setSorgId(map.get("sorgId"));
		somApply.setSorgKind(map.get("sorgKind"));
		somApply.setSorgName(map.get("cnName"));
		somApply.setIfFinish("1");
		somApply.setAcceptOrganId(BspUtil.getCorpOrgan().getOrganId());
		somApply.setAcceptArea(BspUtil.getCorpOrgan().getOrganCode());
		somApply.setAcceptOrganName(BspUtil.getCorpOrgan().getOrganName());
		somApply.setAcceptDeptName(BspUtil.getDeptOrgan().getOrganName());
		somApply.setAcceptDeptId(BspUtil.getDeptOrgan().getOrganId());
		somApply.setAcceptPeopleId(GetBspInfo.getBspInfo().getUserId());
		somApplyDomain.insert(somApply);
		
		saveChangeInfo(somChangeApply);
		
	}
	/**
	 * 更新社会组织分支变更信息
	 * @param somChangeApply
	 */
	public void updateBranchChange(SomChangeApply somChangeApply) {
		Map<String, String> map=somChangeApply.getMap();
		SomApply somApply=somChangeApply.getSomApply();
		somApply.setSorgKind(map.get("sorgKind"));
		somApply.setSorgName(map.get("cnName"));
		somApplyDomain.update(somApply);
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
		somOrgan.setSorgStatus("32");

		// 保存业务信息
		somApply.setSorgId(somOrgan.getSorgId());
		somApply.setApplyType(ApplyType.SOM_GROUP_CANCEL);
		somApply.setSorgType(somOrgan.getSorgType());
		somApply.setSorgKind(somOrgan.getSorgKind());
		somApply.setSorgName(somOrgan.getCnName());
		somApply.setBorgName(somOrgan.getBorgName());
		somApply.setIfFinish("1");
		somApply.setAcceptArea(BspUtil.getCorpOrgan().getOrganCode());
		somApply.setAcceptOrganId(BspUtil.getCorpOrgan().getOrganId());
		somApply.setAcceptArea(BspUtil.getCorpOrgan().getOrganCode());
		somApply.setAcceptOrganName(BspUtil.getCorpOrgan().getOrganName());
		somApply.setAcceptDeptName(BspUtil.getDeptOrgan().getOrganName());
		somApply.setAcceptDeptId(BspUtil.getDeptOrgan().getOrganId());
		somApply.setAcceptPeopleId(GetBspInfo.getBspInfo().getUserId());
		// 保存所有信息
		somOrganDomain.updateAndBuildHis(somOrgan,somApply.getTaskCode());
		dealSomLiqpeople(somApply);
		somApplyDomain.insert(somApply);
		// 注销社会组织成员
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SORG_ID", somOrgan.getSorgId());
		pset.setParameter("IF_SERVE", "1");
		DataSet dutyDs = somDutyDomain.query(pset);
		for (int i = 0; i < dutyDs.getCount(); i++) {
			SomDuty somDuty = (SomDuty) dutyDs.getRecord(i).toBean(
					SomDuty.class);
			somDuty.setIfServe("0");
			somDutyDomain.update(somDuty);
		}
	}

	/**
	 * 修改注销
	 * 
	 * @param somApply
	 */
	public void updateCancel(SomApply somApply) {
		SomOrgan somOrgan = somApply.getSomOrgan();
		// 保存所有信息
		somOrganDomain.updateAndBuildHis(somOrgan,somApply.getTaskCode());
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
		somOrgan.setSorgStatus("32");

		// 保存业务信息
		somApply.setSorgId(somOrgan.getSorgId());
		somApply.setApplyType(ApplyType.SOM_GROUP_BRANCH_CANCEL);
		somApply.setSorgType(somOrgan.getSorgType());
		somApply.setSorgKind(somOrgan.getSorgKind());
		somApply.setSorgName(somOrgan.getCnName());
		somApply.setBorgName(somOrgan.getBorgName());
		somApply.setIfFinish("1");
		somApply.setAcceptArea(BspUtil.getCorpOrgan().getOrganCode());
		somApply.setAcceptOrganId(BspUtil.getCorpOrgan().getOrganId());
		somApply.setAcceptArea(BspUtil.getCorpOrgan().getOrganCode());
		somApply.setAcceptOrganName(BspUtil.getCorpOrgan().getOrganName());
		somApply.setAcceptDeptName(BspUtil.getDeptOrgan().getOrganName());
		somApply.setAcceptDeptId(BspUtil.getDeptOrgan().getOrganId());
		somApply.setAcceptPeopleId(GetBspInfo.getBspInfo().getUserId());
		// 保存所有信息
		somOrganDomain.updateAndBuildHis(somOrgan,somApply.getTaskCode());
		somApplyDomain.insert(somApply);
		// 注销社会组织成员
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SORG_ID", somOrgan.getSorgId());
		pset.setParameter("IF_SERVE", "1");
		DataSet dutyDs = somDutyDomain.query(pset);
		for (int i = 0; i < dutyDs.getCount(); i++) {
			SomDuty somDuty = (SomDuty) dutyDs.getRecord(i).toBean(
					SomDuty.class);
			somDuty.setIfServe("0");
			somDutyDomain.update(somDuty);
		}
	}
	/**
	 * 修改分支注销
	 * 
	 * @param somApply
	 */
	public void updateBranchCancel(SomApply somApply) {
		SomOrgan somOrgan = somApply.getSomOrgan();
		// 保存所有信息
		somOrganDomain.updateAndBuildHis(somOrgan,somApply.getTaskCode());
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
		somApplyDomain.insert(somApply);
		
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
			somHeldPeople.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
			somHeldPeople.setCreateTime(DateUtil.getTime());
			somHeldPeople.setMorgName(BspUtil.getCorpOrgan().getOrganName());
			somHeldPeople.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
			somHeldPeopleDomain.insert(somHeldPeople);
		}
		for(int i=0;i<somHeldOrganList.size();i++){
			SomHeldOrgan somHeldOrgan = somHeldOrganList.get(i);
			somHeldOrgan.setId(IdHelp.getUUID32());
			somHeldOrgan.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
			somHeldOrgan.setCreateTime(DateUtil.getTime());
			somHeldOrgan.setMorgName(BspUtil.getCorpOrgan().getOrganName());
			somHeldOrgan.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
			somHeldOrganDomain.insert(somHeldOrgan);
		}
		for(int i=0;i<somAspchiefList.size();i++){
			SomAspchief somAspchief = somAspchiefList.get(i);
			somAspchief.setId(IdHelp.getUUID32());
			somAspchief.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
			somAspchief.setCreateTime(DateUtil.getTime());
			somAspchief.setMorgName(BspUtil.getCorpOrgan().getOrganName());
			somAspchief.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
			somAspchiefDomain.insert(somAspchief);
		}
	}
	
	/**
	 * 修订社会组织变更信息，只保存change表
	 * @param somChangeApply
	 */
	public void updateChangeOnly(SomChangeApply somChangeApply) {
		Map<String, String> map=somChangeApply.getMap();
		SomApply somApply=somChangeApply.getSomApply();
		somApply.setSorgKind(map.get("sorgKind"));
		somApply.setSorgName(map.get("cnName"));
		somApplyDomain.update(somApply);
		somChangeDomain.deleteChangeByTaskCode(somApply.getTaskCode());
		somDutyDomain.reNewPeopleInfo(somApply.getTaskCode());
		saveChangeOnly(somChangeApply);
		
	}
	
	public void updateBranchChangeOnly(SomChangeApply somChangeApply) {
		Map<String, String> map=somChangeApply.getMap();
		SomApply somApply=somChangeApply.getSomApply();
		somApply.setSorgKind(map.get("sorgKind"));
		somApply.setSorgName(map.get("cnName"));
		somApplyDomain.update(somApply);
		somChangeDomain.deleteChangeByTaskCode(somApply.getTaskCode());
		saveChangeOnly(somChangeApply);
		
	}
	
	private void saveChangeOnly(SomChangeApply somChangeApply) {
		Map<String, String> map=somChangeApply.getMap();
		List<SomChange> changes=somChangeApply.getSomChange();
		for(int i=0;i<changes.size();i++){
			SomChange somchange=changes.get(i);
			somchange.setTaskCode(somChangeApply.getSomApply().getTaskCode());
			somchange.setId(IdHelp.getUUID32());
			somchange.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
			somchange.setMorgName(BspUtil.getCorpOrgan().getOrganName());
			somchange.setSorgId(map.get("sorgId"));
			somchange.setChangeStatus("1");
			somChangeDomain.insert(somchange);//插入变更信息
		}
	}
	private void saveChangeInfo(SomChangeApply somChangeApply) {
		Map<String, String> map=somChangeApply.getMap();
		List<SomChange> changes=somChangeApply.getSomChange();
		
		ParameterSet pset=new ParameterSet();
		pset.setParameter("SORG_ID",map.get("sorgId"));
		DataSet DataSet = somOrganDomain.query(pset);
		Record record =(Record)  DataSet.getRecord(0);
		SomOrgan somOrgan= (SomOrgan) record.toBean(SomOrgan.class);//社会组织
		for(int i=0;i<changes.size();i++){
			SomChange somchange=changes.get(i);
			somchange.setTaskCode(somChangeApply.getSomApply().getTaskCode());
			somchange.setId(IdHelp.getUUID32());
			somchange.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
			somchange.setMorgName(BspUtil.getCorpOrgan().getOrganName());
			somchange.setSorgId(map.get("sorgId"));
			somchange.setChangeStatus("1");
			somChangeDomain.insert(somchange);//插入变更信息
			//对社会组织进行更新
			if(somchange.getChangeItem().equals("0")){//名称
				String[] s=somchange.getChangeAfter().split(";",-1);
				if(s[0]!=null &&!"".equals(s[0])){
					somOrgan.setCnName(s[0]);
				}if(s[1]!=null &&!"".equals(s[1])){
					somOrgan.setSorgKind(s[1]);
				}if(s[2]!=null &&!"".equals(s[2])){
					somOrgan.setBusScope(s[2]);
				}
				somApplyDomain.updateSomApplyInfo(somOrgan);//
			}else if(somchange.getChangeItem().equals("1")){ //住所变更
				String[] s=somchange.getChangeAfter().split(";",-1);
				if(s[0]!=null &&!"".equals(s[0])){
					somOrgan.setResideSource(s[0]);//住所来源,
				}if(s[1]!=null &&!"".equals(s[1])){
					somOrgan.setResidence(s[1]);//变更住所
				}if(s[2]!=null &&!"".equals(s[2])){
					somOrgan.setHousingOrgan(s[2]);//产权单位 
				}if(s[3]!=null &&!"".equals(s[3])){
					somOrgan.setHousingArea(new BigDecimal(s[3]));//用房面积
				}if(s[4]!=null &&!"".equals(s[4])){
					somOrgan.setLeasePeriod(s[4]);//租借期限
				}	
			}else if(somchange.getChangeItem().equals("2")){//变更法定代表人
				if("1".equals(somOrgan.getIfBranch())){
					somOrgan.setBranchCharger(somchange.getChangeAfter());
				}else{
					somOrgan.setLegalPeople(somchange.getChangeAfter());
				}
			}else if(somchange.getChangeItem().equals("3")){//变更业务范围
				somOrgan.setBusiness(somchange.getChangeAfter());//变更业务范围
			}else if(somchange.getChangeItem().equals("4")){ //资金变更
				String[] s=somchange.getChangeAfter().split(";",-1);
				if(s[0]!=null &&!"".equals(s[0])){
					somOrgan.setMoneySource(s[0]);//资金来源
				}if(s[1]!=null &&!"".equals(s[1])){
					somOrgan.setRegMon(s[1]);//变更注册资金
				}
			}else if(somchange.getChangeItem().equals("5")){//变更业务主管单位
				somOrgan.setBorgName(somchange.getChangeAfter());
			}
		}
		somOrganDomain.updateAndBuildHis(somOrgan,somChangeApply.getSomApply().getTaskCode());
		
		SomDuty people=somChangeApply.getSomLegalPeople();
		if(people != null){
			if("0".equals(somOrgan.getIfBranch())){
				//把在任的法定代表人维护为卸任
				pset.clear();
				pset.setParameter("SORG_ID",map.get("sorgId"));
				pset.setParameter("IF_SERVE", "1");
				pset.setParameter("REG_STATUS", "1");//有效的
				pset.setParameter("SORG_DUTIES", SomDutyDuties.SOM_LEGAL_PEOPLE);
				DataSet memberDatasets=somDutyDomain.queryPeople(pset);
				RecordSet memrecords=memberDatasets.getRecordSet();
				Iterator<Record> mems= memrecords.iterator();//变更
				while(mems.hasNext()){
					SomDuty somDuty=(SomDuty)mems.next().toBean(SomDuty.class);
					somDuty.setIfServe("0");//卸任
					somDuty.setRegStatus("2");//备案状态为历史
					somDuty.setEndDate(DateUtil.getDay());
					somDutyDomain.update(somDuty);
				}
				
				String peopleId=somPeopleDomain.create(people.getSomPeople());
				// 维护任职信息
				String oldDutyId=map.get("legalDutyId");
				people.setDutyId(IdHelp.getUUID32());
				if(oldDutyId!=null){
					somDutyElectronicDao.updateDutyId(oldDutyId, people.getDutyId());
				}
				people.setTaskCode(map.get("taskCode1"));
				people.setSorgId(map.get("sorgId"));
				people.setPeopleId(peopleId);
				people.setRegStatus("1");
				people.setIfServe("1");
				people.setSorgType("S");//社会团体
				people.setSorgDuties(SomDutyDuties.SOM_LEGAL_PEOPLE);
				people.setCreateTime(DateUtil.getTime());
				people.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
				people.setMorgName(BspUtil.getCorpOrgan().getOrganName());
				people.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
				somDutyDomain.insert(people);
			}else{
				//把在任的法定代表人维护为卸任
				pset.clear();
				pset.setParameter("SORG_ID",map.get("sorgId"));
				pset.setParameter("IF_SERVE", "1");
				pset.setParameter("REG_STATUS", "1");//有效的
				pset.setParameter("SORG_DUTIES","00002");
				DataSet memberDatasets=somDutyDomain.queryPeople(pset);
				RecordSet memrecords=memberDatasets.getRecordSet();
				Iterator<Record> mems= memrecords.iterator();//变更
				while(mems.hasNext()){
					SomDuty somDuty=(SomDuty)mems.next().toBean(SomDuty.class);
					somDuty.setIfServe("0");//卸任
					somDuty.setRegStatus("2");//备案状态为历史
					somDuty.setEndDate(DateUtil.getDay());
					somDutyDomain.update(somDuty);
				}
				
				people.setRegStatus("1");
				somDutyDomain.update(people);
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
	public void deleteChange(String taskCode) {
		// TODO Auto-generated method stub
		
	}
	
	
	
	
}
