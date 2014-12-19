package com.inspur.cams.sorg.history.fund.domain.support;

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
import com.inspur.cams.sorg.base.data.SomChange;
import com.inspur.cams.sorg.base.data.SomChangeApply;
import com.inspur.cams.sorg.base.data.SomDuty;
import com.inspur.cams.sorg.base.data.SomHeldOrgan;
import com.inspur.cams.sorg.base.data.SomHeldPeople;
import com.inspur.cams.sorg.base.data.SomLiqpeople;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.data.SomRule;
import com.inspur.cams.sorg.base.data.SomSession;
import com.inspur.cams.sorg.base.domain.ISomApplyDomain;
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
import com.inspur.cams.sorg.history.fund.domain.ISomFundHistoryDomain;
import com.inspur.cams.sorg.util.ApplyType;
import com.inspur.cams.sorg.util.SomDutyDuties;

public class SomFundHistoryDomain implements ISomFundHistoryDomain {
	@Reference
	private ISomOrganDomain somOrganDomain;
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
	private ISomHeldPeopleDomain somHeldPeopleDomain;
	@Reference
	private ISomHeldOrganDomain somHeldOrganDomain;	
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
	 * 新增成立信息
	 * @param somApply
	 */
	public void saveBuild(SomApply somApply) {
		SomOrgan somOrgan=somApply.getSomOrgan();
		somApply.setSorgKind(somOrgan.getSorgKind());
		somApply.setSorgName(somOrgan.getCnName());
		somApply.setBorgName(somOrgan.getBorgName());
		somApply.setIfFinish("1");
		somApply.setAcceptArea(BspUtil.getCorpOrgan().getOrganCode());
		somApply.setAcceptOrganName(BspUtil.getCorpOrgan().getOrganName());
		somApply.setAcceptDeptName(BspUtil.getDeptOrgan().getOrganName());
		somApply.setAcceptDeptId(BspUtil.getDeptOrgan().getOrganId());
		somApply.setAcceptPeopleId(GetBspInfo.getBspInfo().getUserId());
		somApplyDomain.insert(somApply);
		somOrgan.setSorgStatus("22");
		somOrgan.setMorgName(BspUtil.getCorpOrgan().getOrganName());
		somOrgan.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
		//处理organ
		somOrganDomain.insertAndBuildHis(somOrgan,somApply.getTaskCode());
		saveBuildInfo(somApply);
	}
	
	/**
	 * 修改成立信息
	 * @param build
	 */
	public void updateBuild(SomApply somApply) {
		SomOrgan somOrgan=somApply.getSomOrgan();
		somApply.setSorgKind(somOrgan.getSorgKind());
		somApply.setSorgName(somOrgan.getCnName());
		somApply.setBorgName(somOrgan.getBorgName());
		somApplyDomain.update(somApply);
		somOrganDomain.updateAndBuildHis(somOrgan,somApply.getTaskCode());
		saveBuildInfo(somApply);
	}
	/**
	 *  新增分支成立信息
	 */
	public void saveBranchBuild(SomApply somApply) {
		SomOrgan somOrgan=somApply.getSomOrgan();
		
		somApply.setSorgKind(somOrgan.getSorgKind());
		somApply.setSorgName(somOrgan.getCnName());
		somApply.setBorgName(somOrgan.getBorgName());
		somApply.setIfFinish("1");
		somApply.setAcceptArea(BspUtil.getCorpOrgan().getOrganCode());
		somApply.setAcceptOrganName(BspUtil.getCorpOrgan().getOrganName());
		somApply.setAcceptDeptName(BspUtil.getDeptOrgan().getOrganName());
		somApply.setAcceptDeptId(BspUtil.getDeptOrgan().getOrganId());
		somApply.setAcceptPeopleId(GetBspInfo.getBspInfo().getUserId());
		somApplyDomain.insert(somApply);
		//set法人信息
		somOrgan.setMorgName(BspUtil.getCorpOrgan().getOrganName());
		somOrgan.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
		somOrganDomain.insertAndBuildHis(somOrgan,somApply.getTaskCode());
		//处理负责人信息
		SomSession somSession=somOrgan.getSomSession();
		List<SomDuty> somDutyList = somOrgan.getSomDutyList();
		somSession.setSeq("1");//顺序号
		somSession.setSomDutyList(somDutyList);
		//somDutyDomain.deleteByTaskCode(somApply.getTaskCode());
		somDutyDomain.regPeople(somSession);
		somDutyDomain.updateRegStatus("1",somApply.getTaskCode());
		
	}
	/**
	 * 修改分支成立信息
	 */
	public void updateBranchBuild(SomApply somApply) {
		SomOrgan somOrgan=somApply.getSomOrgan();
		somApply.setSorgKind(somOrgan.getSorgKind());
		somApply.setSorgName(somOrgan.getCnName());
		somApply.setBorgName(somOrgan.getBorgName());
		somApplyDomain.update(somApply);
		somOrganDomain.updateAndBuildHis(somOrgan,somApply.getTaskCode());
		//处理负责人信息
		SomSession somSession=somOrgan.getSomSession();
		List<SomDuty> somDutyList = somOrgan.getSomDutyList();
		somSession.setSeq("1");//顺序号
		somSession.setSomDutyList(somDutyList);
		somDutyDomain.deleteByTaskCode(somApply.getTaskCode());
		somDutyDomain.regPeople(somSession);
		somDutyDomain.updateRegStatus("1",somApply.getTaskCode());
	}
	/**
	 *  保存社会组织变更信息
	 * @param somChangeApply
	 */
	public void saveChange(SomChangeApply somChangeApply) {
		SomApply somApply=somChangeApply.getSomApply();
		Map<String, String> map=somChangeApply.getMap();
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
		somApply.setApplyType(ApplyType.SOM_FUND_CANCEL);
		somApply.setSorgType(somOrgan.getSorgType());
		somApply.setSorgKind(somOrgan.getSorgKind());
		somApply.setSorgName(somOrgan.getCnName());
		somApply.setBorgName(somOrgan.getBorgName());
		somApply.setIfFinish("1");
		somApply.setAcceptArea(BspUtil.getCorpOrgan().getOrganCode());
		somApply.setAcceptOrganId(BspUtil.getCorpOrgan().getOrganId());
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
		somApply.setApplyType(ApplyType.SOM_FUND_BRANCH_CANCEL);
		somApply.setSorgType(somOrgan.getSorgType());
		somApply.setSorgKind(somOrgan.getSorgKind());
		somApply.setSorgName(somOrgan.getCnName());
		somApply.setBorgName(somOrgan.getBorgName());
		somApply.setIfFinish("1");
		somApply.setAcceptArea(BspUtil.getCorpOrgan().getOrganCode());
		somApply.setAcceptOrganId(BspUtil.getCorpOrgan().getOrganId());
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
	//TODO  ************************私有方法*********************
	/**
	 * 处理成立信息
	 * @param somApply
	 */
	private void saveBuildInfo(SomApply somApply) {
		SomOrgan somOrgan=somApply.getSomOrgan();
		String taskCode=somApply.getTaskCode();	
		String sorgId=somOrgan.getSorgId();
		dealSomHeldPeople(somApply);
		dealSomHeldOrgan(somApply);
		//处理章程
		SomRule somRule=somOrgan.getSomRule();
		if(somRule.getRuleId()==null || "".equals(somRule.getRuleId())){
			somRule.setSorgId(sorgId);
			somRule.setTaskCode(taskCode);
			somRule.setRegStatus("1");
			somRuleDomain.insert(somRule);
		}else{
			somRuleDomain.update(somRule);
		}
		//届次
		SomSession somSession=somOrgan.getSomSession();
		somSession.setSeq("1");
		somSession.setSorgId(sorgId);
		List<SomDuty> somDutyList=somOrgan.getSomDutyList();
		//处理人员
		if(somDutyList.size()>1){
			//进行过换届备案的，成立时的负责状态会置为历史，此时再在历史数据采集成立保存时，会把duty状态置为在任，此时处理先取之前的状态，然后赋值给要保存的duty
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", somApply.getTaskCode());
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
			somDutyDomain.deleteByTaskCode(somApply.getTaskCode());
			somSession.setSomDutyList(somDutyList);
			somDutyDomain.regPeople(somSession);
			somDutyDomain.updateRegStatus(regStatus,somApply.getTaskCode());
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
				somHeldPeople.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
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
				somHeldOrgan.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
				somHeldOrgan.setCreateTime(DateUtil.getTime());
				somHeldOrganDomain.insert(somHeldOrgan);
			} else if (somHeldOrgan.getState() == Record.STATE_MODIFIED) {
				somHeldOrganDomain.update(somHeldOrgan);
			} else if (somHeldOrgan.getState() == Record.STATE_DELETED) {
				somHeldOrganDomain.delete(somHeldOrgan.getId());
			}
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
				somOrgan.setCnName(somchange.getChangeAfter());
				somApplyDomain.updateSomApplyInfo(somOrgan);//
			}else if(somchange.getChangeItem().equals("1")){ //住所变更
				somOrgan.setResidence(somchange.getChangeAfter());//变更住所
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
			}else if(somchange.getChangeItem().equals("5")){//变更宗旨
				somOrgan.setPurpose(somchange.getChangeAfter());
			}else if(somchange.getChangeItem().equals("6")){//变更类型
				somOrgan.setSorgKind(somchange.getChangeAfter());
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
				people.setSorgType("J");
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

}
