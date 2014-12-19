package com.inspur.cams.sorg.online.apply.delayElection.domain.support;

import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.base.dao.jdbc.SomElectionDao;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomElection;
import com.inspur.cams.sorg.base.data.SomMeeting;
import com.inspur.cams.sorg.base.domain.ISomApplyDomain;
import com.inspur.cams.sorg.base.domain.ISomAspchiefDomain;
import com.inspur.cams.sorg.base.domain.ISomMeetingDomain;
import com.inspur.cams.sorg.base.domain.ISomOrganDomain;
import com.inspur.cams.sorg.base.domain.ISomSessionDomain;
import com.inspur.cams.sorg.online.apply.delayElection.domain.ISomElectionDelayOnlineDomain;
import com.inspur.cams.sorg.util.Activity;
import com.inspur.cams.sorg.util.ApplyType;
/**
 * 延期换届选举报批domain
 * @author 
 * @date 
 */
public class SomElectionDelayOnlineDomain implements ISomElectionDelayOnlineDomain {
	@Reference
	private SomElectionDao somElectionDao;

	@Reference
	private ISomMeetingDomain somMeetingDomain;
	
	@Reference
	private ISomAspchiefDomain somAspchiefDomain;

	@Reference
	private ISomApplyDomain somApplyDomain;
	
	@Reference
	private ISomSessionDomain somSessionDomain;
	
	@Reference
	private ISomOrganDomain somOrganDomain;
	
	/**
	 * 受理保存
	 * @param somApply
	 * @param somElection
	 */
	public void insert(SomApply somApply, SomElection somElection) {
		somApply.setApplyType(ApplyType.SOM_GROUP_ELECTION_CHECK_DELAY);
		somApply.setCurActivity(Activity.ACT_ACCEPT_CN);
		somApply.setAcceptTime(DateUtil.getTime());
//		somApplyDomain.curSomApply(somApply);
		somApplyDomain.insertOnline(somApply);
		somOrganDomain.insert(somApply.getSomOrgan());
		// 维护选举信息
		insertSomElection(somElection);
		//返回参数
	}
	/**
	 * 受理更新保存
	 * @param somApply
	 * @param somElection
	 */
	public void update(SomApply somApply, SomElection somElection) {
		somApplyDomain.update(somApply);
		updateSomElection(somElection);
		somOrganDomain.update(somApply.getSomOrgan());
	}
//*****************************************************************************************************************
//*****************************************************************************************************************
	/**
	 * 保存换届审批信息
	 */
	private void insertSomElection(SomElection somElection) {
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
		somMeeting.setCreateTime(time);
		somMeetingDomain.insert(somMeeting);
		// 保存选举信息
		somElection.setElectionId(IdHelp.getUUID32());
		somElection.setMeetingId(somMeeting.getMeetingId());
		somElection.setCreateTime(time);
		somElectionDao.insert(somElection);
	}
	/**
	 *  更新换届审批信息
	 * @param somElection
	 */
	private void updateSomElection(SomElection somElection) {
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
	
}
