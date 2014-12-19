package com.inspur.cams.sorg.online.apply.fund.domain.support;

import java.util.List;
import java.util.Map;

import org.loushang.bsp.share.organization.bean.OrganView;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.base.dao.ISomDutyElectronicDao;
import com.inspur.cams.sorg.base.dao.jdbc.SomElectionDao;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomAspchief;
import com.inspur.cams.sorg.base.data.SomChange;
import com.inspur.cams.sorg.base.data.SomChangeApply;
import com.inspur.cams.sorg.base.data.SomDuty;
import com.inspur.cams.sorg.base.data.SomElection;
import com.inspur.cams.sorg.base.data.SomHeldOrgan;
import com.inspur.cams.sorg.base.data.SomHeldPeople;
import com.inspur.cams.sorg.base.data.SomLiqpeople;
import com.inspur.cams.sorg.base.data.SomMeeting;
import com.inspur.cams.sorg.base.data.SomOrgan;
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
import com.inspur.cams.sorg.base.domain.ISomMeetingDomain;
import com.inspur.cams.sorg.base.domain.ISomOrganDomain;
import com.inspur.cams.sorg.base.domain.ISomPeopleDomain;
import com.inspur.cams.sorg.base.domain.ISomRuleDomain;
import com.inspur.cams.sorg.base.domain.ISomSignetDomain;
import com.inspur.cams.sorg.online.apply.fund.domain.ISomFundOnlineDomain;
import com.inspur.cams.sorg.util.Activity;
import com.inspur.cams.sorg.util.ApplyType;
import com.inspur.cams.sorg.util.SomDutyDuties;
/**
 * @title 基金会外网录入Domain
 * @author doctor
 * @date 2012年11月28日
 */
public class SomFundOnlineDomain implements ISomFundOnlineDomain {
	@Reference
	private ISomOrganDomain somOrganDomain;
	@Reference
	private ISomApplyDomain somApplyDomain;
	//申请名称核准
	@Reference
	private ISomHeldPeopleDomain somHeldPeopleDomain;
	@Reference
	private ISomHeldOrganDomain somHeldOrganDomain;
	@Reference
	private ISomAspchiefDomain somAspchiefDomain;
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
	private SomElectionDao somElectionDao;
	@Reference
	private ISomMeetingDomain somMeetingDomain;
	//当前时间 DateUtil.getTime();
	//当前日期 DateUtil.getDay();
	/**
	 * @title 保存申请名称核准
	 * @param approvalInfo
	 */
	public void saveNameApproval(SomApply somApply) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SORG_ID", somApply.getSorgId());
		DataSet somOrganDataSet = somOrganDomain.query(pset);

		SomOrgan somOrgan = somApply.getSomOrgan();
		somOrgan.setSorgStatus("8");
		somOrgan.setSorgType("J");
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
		somApply.setApplyType(ApplyType.SOM_FUND_NAME_APPROVAL);
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
	}
	/**
	 * @title 保存设立登记
	 * @param approvalInfo
	 */
	public void saveBuild(SomApply somApply) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SORG_ID", somApply.getSorgId());
		DataSet somOrganDataSet = somOrganDomain.query(pset);

		SomOrgan somOrgan = somApply.getSomOrgan();
		somOrgan.setSorgStatus("21");
		somOrgan.setSorgType("J");
		if(somOrganDataSet.getCount()>0){
			somOrganDomain.update(somOrgan);
		}else{
			somOrganDomain.insert(somOrgan);
		}
		somApply.setSorgId(somOrgan.getSorgId());
		somApply.setApplyType(ApplyType.SOM_FUND_BUILD);
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
		saveBuildInfo(somApply);
	}
	/**
	 *  新增分支设立信息
	 */
	public void saveBranchBuild(SomApply branchBuild) {
		SomOrgan somOrgan = branchBuild.getSomOrgan();
		branchBuild.setApplyType(ApplyType.SOM_FUND_BRANCH_BUILD);
		branchBuild.setSorgType("J");
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
	 * 修改分支设立信息
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
	 * @title 保存变更登记
	 * @param SomChangeApply
	 */
	public void saveChange(SomChangeApply changeInfo) {
		SomApply somApply=changeInfo.getSomApply();
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SORG_ID", somApply.getSorgId());
		DataSet somOrganDataSet = somOrganDomain.query(pset);

		SomOrgan somOrgan = somApply.getSomOrgan();
		somOrgan.setSorgType("J");
		if(somOrganDataSet.getCount()>0){
			somOrganDomain.update(somOrgan);
		}else{
			somOrganDomain.insert(somOrgan);
		}
		somApply.setSorgId(somOrgan.getSorgId());
		somApply.setApplyType(ApplyType.SOM_FUND_CHANGE);
		somApply.setSorgType(somOrgan.getSorgType());
		somApply.setSorgName(somOrgan.getCnName());
		//somApply.setBorgName(somOrgan.getBorgName());
		somApply.setIfFinish("0");
		if(somOrganDataSet.getCount()>0){
			somApply.setDataSource("ONLINE");
			//此处要注意，创建时间在修改方法中修改了
			somApply.setCreateTime(DateUtil.getTime());
			somApplyDomain.update(somApply);
		}else{
			somApplyDomain.insertOnline(somApply);
		}

		saveChangeInfo(changeInfo);
	}
	// ---------------------------分支变更---------------------------
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
		saveBranchChangeInfo(somChangeApply);

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
		saveBranchChangeInfo(somChangeApply);

	}
	/**
	 * @title 保存注销登记
	 */
	public void saveCancel(SomApply somApply) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SORG_ID", somApply.getSorgId());
		DataSet somOrganDataSet = somOrganDomain.query(pset);

		SomOrgan somOrgan = somApply.getSomOrgan();
		somOrgan.setSorgType("J");
		if(somOrganDataSet.getCount()>0){
			somOrganDomain.update(somOrgan);
		}else{
			somOrganDomain.insert(somOrgan);
		}
		somApply.setSorgId(somOrgan.getSorgId());
		somApply.setApplyType(ApplyType.SOM_FUND_CANCEL);
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
		dealSomLiqpeople(somApply);//处理清算组织人员
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
		// 保存业务信息
		somApply.setSorgId(somOrgan.getSorgId());
		somApply.setApplyType(ApplyType.SOM_FUND_BRANCH_CANCEL);
		somApply.setSorgType(somOrgan.getSorgType());
		somApply.setSorgKind(somOrgan.getSorgKind());
		somApply.setSorgName(somOrgan.getCnName());
		somApply.setBorgName(somOrgan.getBorgName());
		somApply.setIfFinish("0");
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
	 * 保存章程信息
	 */
	public void saveRule(SomApply somApply) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SORG_ID", somApply.getSorgId());
		DataSet somOrganDataSet = somOrganDomain.query(pset);

		SomOrgan somOrgan = somApply.getSomOrgan();
		somOrgan.setSorgType("J");
		somOrgan.setBorgName(somApply.getBorgName());
		if(somOrganDataSet.getCount()>0){
			somOrganDomain.update(somOrgan);
		}else{
			somOrganDomain.insert(somOrgan);
		}
		SomRule somRule = somOrgan.getSomRule();

		somApply.setSorgId(somOrgan.getSorgId());
		somApply.setApplyType(ApplyType.SOM_FUND_RULE_CHECK);
		somApply.setSorgName(somOrgan.getCnName());
		somApply.setIfFinish("0");
		if(somOrganDataSet.getCount()>0){
			somApply.setDataSource("ONLINE");
			//此处要注意，创建时间在修改方法中修改了
			somApply.setCreateTime(DateUtil.getTime());
			somApplyDomain.update(somApply);
			somRuleDomain.update(somRule);
		}else{
			somApplyDomain.insertOnline(somApply);

			somRule.setRuleId(IdHelp.getUUID32());
			somRuleDomain.insertOnline(somRule);
		}

	}
	/**
	 * 保存换届事先报批
	 */
	public void saveElection(SomApply somApply, SomOrgan somOrgan, SomElection election) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SORG_ID", somApply.getSorgId());
		DataSet somOrganDataSet = somOrganDomain.query(pset);

		somOrgan.setSorgType("J");
		somOrgan.setBorgName(somApply.getBorgName());
		if(somOrganDataSet.getCount()>0){
			somOrganDomain.update(somOrgan);
		}else{
			somOrganDomain.insert(somOrgan);
		}

		somApply.setSorgId(somOrgan.getSorgId());
		somApply.setApplyType(ApplyType.SOM_FUND_ELECTION_CHECK);
		somApply.setSorgName(somOrgan.getCnName());
		somApply.setIfFinish("0");
		if(somOrganDataSet.getCount()>0){
			somApply.setDataSource("ONLINE");
			//此处要注意，创建时间在修改方法中修改了
			somApply.setCreateTime(DateUtil.getTime());
			somApplyDomain.update(somApply);
			SomMeeting somMeeting = somMeetingDomain.get(election.getMeetingId());
			somMeeting.setMeetingName(election.getMeetingName());
			somMeeting.setMeetingPlace(election.getMeetingPlace());
			somMeeting.setMeetingDate(election.getMeetingDate());
			somMeeting.setMainPeople(election.getMainPeople());
			somMeeting.setLinkPeople(election.getLinkPeople());
			somMeeting.setLinkPhone(election.getLinkPhone());
			somMeetingDomain.update(somMeeting);
			somElectionDao.update(election);
		}else{
			somApplyDomain.insertOnline(somApply);
			SomMeeting somMeeting = new SomMeeting();
			somMeeting.setMeetingId(IdHelp.getUUID32());
			somMeeting.setSorgId(somApply.getSorgId());
			somMeeting.setMeetingName(election.getMeetingName());
			somMeeting.setMeetingPlace(election.getMeetingPlace());
			somMeeting.setMeetingDate(election.getMeetingDate());
			somMeeting.setMainPeople(election.getMainPeople());
			somMeeting.setLinkPeople(election.getLinkPeople());
			somMeeting.setLinkPhone(election.getLinkPhone());
			somMeeting.setCreateTime(DateUtil.getTime());
			somMeetingDomain.insert(somMeeting);
			// 保存选举信息
			election.setElectionId(IdHelp.getUUID32());
			election.setMeetingId(somMeeting.getMeetingId());
			election.setCreateTime(DateUtil.getTime());
			somElectionDao.insert(election);
		}
		// 维护负责人信息
		dealSomAspchiefElection(election);
	}

	/**
	 * 保存延期换届选举报批
	 */
	public void saveElectionDelay(SomApply somApply, SomOrgan somOrgan, SomElection election) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SORG_ID", somApply.getSorgId());
		DataSet somOrganDataSet = somOrganDomain.query(pset);

		somOrgan.setSorgType("J");
		somOrgan.setBorgName(somApply.getBorgName());
		if(somOrganDataSet.getCount()>0){
			somOrganDomain.update(somOrgan);
		}else{
			somOrganDomain.insert(somOrgan);
		}

		somApply.setSorgId(somOrgan.getSorgId());
		somApply.setApplyType(ApplyType.SOM_FUND_ELECTION_CHECK_DELAY);
		somApply.setSorgName(somOrgan.getCnName());
		somApply.setIfFinish("0");
		if(somOrganDataSet.getCount()>0){
			somApply.setDataSource("ONLINE");
			//此处要注意，创建时间在修改方法中修改了
			somApply.setCreateTime(DateUtil.getTime());
			somApplyDomain.update(somApply);
			SomMeeting somMeeting = somMeetingDomain.get(election.getMeetingId());
			somMeeting.setMeetingName(election.getMeetingName());
			somMeeting.setMeetingPlace(election.getMeetingPlace());
			somMeeting.setMeetingDate(election.getMeetingDate());
			somMeeting.setMainPeople(election.getMainPeople());
			somMeeting.setLinkPeople(election.getLinkPeople());
			somMeeting.setLinkPhone(election.getLinkPhone());
			somMeetingDomain.update(somMeeting);
			somElectionDao.update(election);
		}else{
			somApplyDomain.insertOnline(somApply);
			SomMeeting somMeeting = new SomMeeting();
			somMeeting.setMeetingId(IdHelp.getUUID32());
			somMeeting.setSorgId(somApply.getSorgId());
			somMeeting.setMeetingName(election.getMeetingName());
			somMeeting.setMeetingPlace(election.getMeetingPlace());
			somMeeting.setMeetingDate(election.getMeetingDate());
			somMeeting.setMainPeople(election.getMainPeople());
			somMeeting.setLinkPeople(election.getLinkPeople());
			somMeeting.setLinkPhone(election.getLinkPhone());
			somMeeting.setCreateTime(DateUtil.getTime());
			somMeetingDomain.insert(somMeeting);
			// 保存选举信息
			election.setElectionId(IdHelp.getUUID32());
			election.setMeetingId(somMeeting.getMeetingId());
			election.setCreateTime(DateUtil.getTime());
			somElectionDao.insert(election);
		}

	}
	/**
	 * 保存负责人换届备案
	 */
	public void saveManPeople(SomApply somApply) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SORG_ID", somApply.getSorgId());
		DataSet somOrganDataSet = somOrganDomain.query(pset);

		SomOrgan somOrgan = somApply.getSomOrgan();
		somOrgan.setSorgType("J");
		if(somOrganDataSet.getCount()>0){
			somOrganDomain.update(somOrgan);
		}else{
			somOrganDomain.insert(somOrgan);
		}
		somApply.setSorgId(somOrgan.getSorgId());
	//	somApply.setApplyType(ApplyType.SOM_FUND_CHARGER);
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
		SomSession somSession = somOrgan.getSomSession();
		somDutyDomain.deleteByTaskCode(somApply.getTaskCode());//先删除人员
		somDutyDomain.regPeopleOnline(somSession);//插入人员和届次
		somDutyDomain.updateRegStatus("1",somApply.getTaskCode());
	}
	/**
 * // TODO
 * #################################################################################################
 * #########################################     内部方法       ####################################
 * #################################################################################################
*/
	/**
	 * @title 获取发起人（自然人）
	 */
	private void dealSomHeldPeople(SomApply somApply) {
		SomOrgan somOrgan = somApply.getSomOrgan();
		somHeldPeopleDomain.deleteBySorgId(somOrgan.getSorgId());
		List<SomHeldPeople> somHeldPeopleList = somOrgan.getSomHeldPeopleList();
		for (int i = 0; i < somHeldPeopleList.size(); i++) {
			SomHeldPeople somHeldPeople = somHeldPeopleList.get(i);
				somHeldPeople.setId(IdHelp.getUUID30());
				somHeldPeople.setSorgId(somOrgan.getSorgId());
				somHeldPeople.setTaskCode(somApply.getTaskCode());
				somHeldPeople.setMorgArea(somOrgan.getMorgArea());
				somHeldPeople.setMorgName(somOrgan.getMorgName());
				somHeldPeople.setCreateTime(DateUtil.getTime());
				somHeldPeopleDomain.insert(somHeldPeople);
		}
	}
	/**
	 * @title 获取发起人（单位）
	 */
	private void dealSomHeldOrgan(SomApply somApply) {
		SomOrgan somOrgan = somApply.getSomOrgan();
		somHeldOrganDomain.deleteBySorgId(somOrgan.getSorgId());
		List<SomHeldOrgan> somHeldOrganList = somOrgan.getSomHeldOrganList();
		for (int i = 0; i < somHeldOrganList.size(); i++) {
			SomHeldOrgan somHeldOrgan = somHeldOrganList.get(i);
				somHeldOrgan.setId(IdHelp.getUUID30());
				somHeldOrgan.setSorgId(somOrgan.getSorgId());
				somHeldOrgan.setTaskCode(somApply.getTaskCode());
				somHeldOrgan.setMorgArea(somOrgan.getMorgArea());
				somHeldOrgan.setMorgName(somOrgan.getMorgName());
				somHeldOrgan.setCreateTime(DateUtil.getTime());
				somHeldOrganDomain.insert(somHeldOrgan);
		}
	}

	/**
	 * @title 获取拟任负责人
	 */
	private void dealSomAspchief(SomApply somApply) {
		somAspchiefDomain.deleteAllAspchiefByTaskCode(somApply.getTaskCode());
		SomOrgan somOrgan = somApply.getSomOrgan();
		List<SomAspchief> somAspchiefList = somOrgan.getSomAspchiefList();
		for (int i = 0; i < somAspchiefList.size(); i++) {
			SomAspchief somAspchief = somAspchiefList.get(i);
				somAspchief.setId(IdHelp.getUUID30());
				somAspchief.setSorgId(somOrgan.getSorgId());
				somAspchief.setTaskCode(somApply.getTaskCode());
				somAspchief.setMorgArea(somOrgan.getMorgArea());
				somAspchief.setMorgName(somOrgan.getMorgName());
				somAspchief.setCreateTime(DateUtil.getTime());
				somAspchiefDomain.insert(somAspchief);
		}
	}
	/**
	 * 获取拟任负责人
	 */
	private void dealSomAspchiefElection(SomElection somElection) {
		List<SomAspchief> somAspchiefList = somElection.getSomAspchiefList();
		somAspchiefDomain.deleteAllAspchiefByTaskCode(somElection.getTaskCode());
		for (int i = 0; i < somAspchiefList.size(); i++) {
			SomAspchief somAspchief = somAspchiefList.get(i);
			somAspchief.setId(IdHelp.getUUID32());
			somAspchief.setSorgId(somElection.getSorgId());
			somAspchief.setTaskCode(somElection.getTaskCode());
			somAspchief.setMorgArea(somElection.getMorgArea());
			somAspchief.setMorgName(somElection.getMorgName());
			somAspchief.setCreateTime(DateUtil.getTime());
			somAspchiefDomain.insert(somAspchief);
		}
	}
	/**
	 * 处理成立信息
	 * @param somApply
	 */
	private void saveBuildInfo(SomApply somApply) {
		SomOrgan somOrgan=somApply.getSomOrgan();
		String taskCode=somApply.getTaskCode();
		String sorgId=somOrgan.getSorgId();
		//处理章程
		SomRule somRule=somOrgan.getSomRule();
		if(somRule.getRuleId()==null || "".equals(somRule.getRuleId())){
			somRule.setSorgId(sorgId);
			somRule.setTaskCode(taskCode);
			somRule.setRegStatus("1");
			somRuleDomain.insertOnline(somRule);
		}else{
			somRuleDomain.update(somRule);
		}
		//届次
		SomSession somSession=somOrgan.getSomSession();
		somSession.setSeq("1");
		List<SomDuty> somDutyList=somOrgan.getSomDutyList();
		somSession.setSomDutyList(somDutyList);
		somSession.setSorgId(sorgId);
		//处理人员
		if(somDutyList.size()>1){
			//生成对应的拟任负责人
			somAspchiefDomain.deleteAllAspchiefByTaskCode(taskCode);//先删除
			somDutyDomain.deletePeopleResumeByTaskCode(taskCode);
			for (int i = 0; i < somDutyList.size(); i++) {
				SomDuty somduty =(SomDuty)somDutyList.get(i);
				SomAspchief somAspchief = new SomAspchief();
				somAspchief.setId(IdHelp.getUUID32());
				somAspchief.setSorgId(somOrgan.getSorgId());
				somAspchief.setTaskCode(somApply.getTaskCode());
				somAspchief.setMorgArea(somOrgan.getMorgArea());
				somAspchief.setMorgName(somOrgan.getMorgName());
				somAspchief.setCreateTime(DateUtil.getTime());

				somAspchief.setName(somduty.getName());//姓名
				somAspchief.setSex(somduty.getSex());//性别
				somAspchief.setBirthday(somduty.getBirthday());//出生日期
				somAspchief.setPolitics(somduty.getPolitics());//政治面貌
				somAspchief.setFolk(somduty.getFolk());//民族
				somAspchief.setCitizenship(somduty.getNation());//国籍
				somAspchief.setCardType("01");//证件类型
				somAspchief.setIdCard(somduty.getIdCard());//身份证号
				somAspchief.setPostCode(somduty.getPostCode());//邮编
				somAspchief.setPopulace(somduty.getAdds());//地址
				somAspchief.setSorgDuties(somduty.getSorgDuties());//社会组织职务
				somAspchief.setIfFulltime(somduty.getIfFulltime());//是否兼职
				somAspchief.setPhone(somduty.getPhone());//电话
				somAspchief.setOtherDuties(somduty.getOtherDuties());//其他社会职务
				List<SomPeopleResume> somResumeList = somduty.getSomPeopleResumeList();
				if(somResumeList.size() > 0 ){
					for (int j = 0; j < somResumeList.size(); j++) {
						SomPeopleResume somResume = somResumeList.get(j);
						somResume.setId(IdHelp.getUUID32());
						somResume.setDutyId(somAspchief.getId());
						somDutyDomain.insertSomPeopleResume(somResume);
					}
				}
				somAspchiefDomain.insert(somAspchief);
				somDutyDomain.deleteByTaskCode(somApply.getTaskCode());
				somDutyDomain.regPeopleOnline(somSession);
				somDutyDomain.updateRegStatus("1",somApply.getTaskCode());
			}
		}
		//处理发起人
		dealSomHeldPeople(somApply);
		//处理发起单位
		dealSomHeldOrgan(somApply);
	}
	/**
	 * 变更里保存章程
	 * @param somRule
	 * @param map
	 */
	private void forInsertRule(SomRule somRule, Map<String, String> map) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("TASK_CODE@=", map.get("taskCode1"));
		DataSet somRuleDataSet = somRuleDomain.queryRule(pset);

		if(somRuleDataSet.getCount()>0){
			somRuleDomain.update(somRule);
		}else{
			somRule.setSorgId(map.get("sorgId"));
			somRule.setTaskCode(map.get("taskCode1"));
			somRule.setRegStatus("3");//审批中
			somRuleDomain.insertOnline(somRule);
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
			people.setSorgType("J");//基金会
			people.setCreateTime(DateUtil.getTime());
			somDutyDomain.update(people);
		}else{
			people.setDutyId(map.get("legalDutyId"));
			somDutyDomain.changeOldDutyIdToNew(people);
			map.put("legalDutyId", people.getDutyId());
			people.setTaskCode(map.get("taskCode1"));
			people.setSorgId(map.get("sorgId"));
			people.setPeopleId(peopleId);
			people.setRegStatus("3");
			people.setIfServe("1");
			people.setSorgType("J");//基金会
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
	/**
	 * 保存变更相关信息
	 * @param somChangeApply
	 */
	private void saveChangeInfo(SomChangeApply somChangeApply) {
		Map<String, String> map=somChangeApply.getMap();
		List<SomChange> changes=somChangeApply.getSomChange();

		somChangeDomain.deleteChangeByTaskCode(somChangeApply.getSomApply().getTaskCode());
		for(int i=0;i<changes.size();i++){
			SomChange change=changes.get(i);
			change.setTaskCode(somChangeApply.getSomApply().getTaskCode());
			change.setId(IdHelp.getUUID32());
			change.setSorgId(map.get("sorgId"));
			change.setChangeStatus("0");
			if("2".equals(change)){//更新法定代表人的dutyId
				change.setLegalDutyId(map.get("legalDutyId"));
			}
			somChangeDomain.insert(change);//插入变更信息
		}
		SomDuty people=somChangeApply.getSomLegalPeople();
		if(people != null){
			if(map.get("legalDutyId") != null && map.get("taskCode1") != null ){
				savePeopleAndMember(people,map);
			}
		}
		SomRule somRule=somChangeApply.getSomRule();
		if(somRule!=null){
			forInsertRule(somRule,map);
		}
	}
	/**
	 * 保存分支变更相关信息
	 * @param somChangeApply
	 */
	private void saveBranchChangeInfo(SomChangeApply somChangeApply) {
		Map<String, String> map=somChangeApply.getMap();
		List<SomChange> changes=somChangeApply.getSomChange();
		SomDuty people=somChangeApply.getSomLegalPeople();
		if(people != null){
			if(map.get("legalDutyId") != null && map.get("taskCode1") != null ){
				savePeopleAndMember(people,map);
			}
		}
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
}
