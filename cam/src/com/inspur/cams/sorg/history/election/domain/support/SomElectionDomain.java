package com.inspur.cams.sorg.history.election.domain.support;

import java.util.List;
import org.loushang.bsp.share.organization.bean.OrganView;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.base.dao.jdbc.SomElectionDao;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomAspchief;
import com.inspur.cams.sorg.base.data.SomElection;
import com.inspur.cams.sorg.base.data.SomElectronic;
import com.inspur.cams.sorg.base.data.SomMeeting;
import com.inspur.cams.sorg.base.domain.ISomApplyDomain;
import com.inspur.cams.sorg.base.domain.ISomAspchiefDomain;
import com.inspur.cams.sorg.base.domain.ISomElectronicDomain;
import com.inspur.cams.sorg.base.domain.ISomMeetingDomain;
import com.inspur.cams.sorg.history.election.domain.ISomElectionDomain;
import com.inspur.cams.sorg.util.ApplyType;

/**
 * 社会组织选举信息domain
 * @author yanliangliang
 * @date 2011-9-21
 */
public class SomElectionDomain implements ISomElectionDomain {
	
	@Reference
	private SomElectionDao somElectionDao;

	@Reference
	private ISomMeetingDomain somMeetingDomain;
	
	@Reference
	private ISomAspchiefDomain somAspchiefDomain;

	@Reference
	private ISomApplyDomain somApplyDomain;
	@Reference
	private ISomElectronicDomain somElectronicDomain;

	public DataSet query(ParameterSet pset) {
		return somElectionDao.query(pset);
	}
	
	public DataSet queryElection(ParameterSet pset) {
		DataSet somElectionDataSet = somElectionDao.query(pset);
		for (int i = somElectionDataSet.getCount()-1; i>=0; i--) {
			SomElection somElection = (SomElection) somElectionDataSet.getRecord(i).toBean(SomElection.class);
			SomMeeting somMeeting = somMeetingDomain.get(somElection.getMeetingId());
			somElection.setMeetingName(somMeeting.getMeetingName());
			somElection.setMeetingPlace(somMeeting.getMeetingPlace());
			somElection.setMeetingDate(somMeeting.getMeetingDate());
			somElection.setMainPeople(somMeeting.getMainPeople());
			somElection.setLinkPeople(somMeeting.getLinkPeople());
			somElection.setLinkPhone(somMeeting.getLinkPhone());
			somElectionDataSet.removeRecord(i);
			somElectionDataSet.addRecord(somElection);
		}
		return somElectionDataSet;
	}

	public void insert(SomElection somElection) {
		OrganView corpOrgan = BspUtil.getCorpOrgan();
		OrganView empOrgan = BspUtil.getEmpOrgan();
		String time = DateUtil.getTime();
		// 保存会议信息
		SomMeeting somMeeting = new SomMeeting();
		somMeeting.setMeetingId(IdHelp.getUUID32());
		somMeeting.setSorgId(somElection.getSorgId());
		somMeeting.setMeetingName(somElection.getMeetingName());
		somMeeting.setMeetingPlace(somElection.getMeetingPlace());
		somMeeting.setMeetingDate(somElection.getMeetingDate());
		somMeeting.setMainPeople(somElection.getMainPeople());
		somMeeting.setLinkPeople(somElection.getLinkPeople());
		somMeeting.setLinkPhone(somElection.getLinkPhone());
		somMeeting.setMorgName(corpOrgan.getOrganName());
		somMeeting.setMorgArea(corpOrgan.getOrganCode());
		somMeeting.setCreatePeople(empOrgan.getOrganName());
		somMeeting.setCreateTime(time);
		somMeetingDomain.insert(somMeeting);
		
		// 保存选举信息
		somElection.setElectionId(IdHelp.getUUID32());
		somElection.setMeetingId(somMeeting.getMeetingId());
		somElection.setMorgName(corpOrgan.getOrganName());
		somElection.setMorgArea(corpOrgan.getOrganCode());
		somElection.setCreatePeople(empOrgan.getOrganName());
		somElection.setCreateTime(time);
		somElectionDao.insert(somElection);
	}

	public void update(SomElection somElection) {
		SomMeeting somMeeting = somMeetingDomain.get(somElection.getMeetingId());
		somMeeting.setMeetingName(somElection.getMeetingName());
		somMeeting.setMeetingPlace(somElection.getMeetingPlace());
		somMeeting.setMeetingDate(somElection.getMeetingDate());
		somMeeting.setMainPeople(somElection.getMainPeople());
		somMeeting.setLinkPeople(somElection.getLinkPeople());
		somMeeting.setLinkPhone(somElection.getLinkPhone());
		somMeetingDomain.update(somMeeting);
		somElectionDao.update(somElection);
	}

	/**
	 * 增加事先报批业务
	 * @param somRule
	 */
	public void insertElectionApply(SomApply somApply, SomElection somElection) {
		String areaCode = BspUtil.getCorpOrgan().getOrganCode();
		if ("S".equals(somApply.getSorgType())) {
			somApply.setApplyType(ApplyType.SOM_GROUP_ELECTION_CHECK);
		} else if ("M".equals(somApply.getSorgType())) {
			// 民非无事先报批
		} else if ("J".equals(somApply.getSorgType())) {
			somApply.setApplyType(ApplyType.SOM_FUND_ELECTION_CHECK);
		}
		somApply.setIfFinish("1");
		somApply.setDataSource("MEND");
		somApply.setAcceptArea(areaCode);
		somApplyDomain.insert(somApply);
		// 维护选举信息
		insert(somElection);
		// 维护负责人信息
		dealSomAspchief(somElection);
	}
	
	/**
	 * 更新事先报批业务
	 * @param somRule
	 */
	public void updateElectionApply(SomApply somApply, SomElection somElection) {
		somApplyDomain.update(somApply);
		update(somElection);
		dealSomAspchief(somElection);
	}

	// 获取拟任负责人
	private void dealSomAspchief(SomElection somElection) {
		List<SomAspchief> somAspchiefList = somElection.getSomAspchiefList();
		
		somAspchiefDomain.deleteAllAspchiefByTaskCode(somElection.getTaskCode());
		
		for (int i = 0; i < somAspchiefList.size(); i++) {
			SomAspchief somAspchief = somAspchiefList.get(i);
			somAspchief.setId(IdHelp.getUUID32());
			somAspchief.setSorgId(somElection.getSorgId());
			somAspchief.setTaskCode(somElection.getTaskCode());
			somAspchief.setMorgArea(somElection.getMorgArea());
			somAspchief.setMorgName(somElection.getMorgName());
			somAspchief.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
			somAspchief.setCreateTime(DateUtil.getTime());
			somAspchiefDomain.insert(somAspchief);
		}
	}
	/**
	 * 换届审批查询用的方法（查询是否办理章程核准、会费备案、负责人备案）
	 * @return
	 */
	public DataSet electionForQuery(ParameterSet pset) {
		return somElectionDao.electionForQuery(pset);
	}

}
