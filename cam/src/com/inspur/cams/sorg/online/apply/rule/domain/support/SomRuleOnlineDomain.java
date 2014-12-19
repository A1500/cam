package com.inspur.cams.sorg.online.apply.rule.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.base.dao.jdbc.SomRuleDao;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomMeeting;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.data.SomRule;
import com.inspur.cams.sorg.base.domain.ISomApplyDomain;
import com.inspur.cams.sorg.base.domain.ISomMeetingDomain;
import com.inspur.cams.sorg.base.domain.ISomOrganDomain;
import com.inspur.cams.sorg.online.apply.rule.domain.ISomRuleOnlineDomain;
import com.inspur.cams.sorg.util.ApplyType;

/**
 * 社会组织章程信息domain
 * @author yanliangliang
 * @date 2011-9-21
 */
public class SomRuleOnlineDomain implements ISomRuleOnlineDomain {
	
	@Reference
	private SomRuleDao somRuleDao;

	@Reference
	private ISomMeetingDomain somMeetingDomain;

	@Reference
	private ISomApplyDomain somApplyDomain;
	
	@Reference
	private ISomOrganDomain somOrganDomain;

	public DataSet query(ParameterSet pset) {
		return somRuleDao.query(pset);
	}

	public DataSet queryRule(ParameterSet pset) {
		DataSet ds=new DataSet();
		DataSet somRuleDataSet = somRuleDao.query(pset);
		for (int i = 0; i < somRuleDataSet.getCount(); i++) {
			SomRule somRule = (SomRule) somRuleDataSet.getRecord(i).toBean(SomRule.class);
			SomMeeting somMeeting = somMeetingDomain.get(somRule.getMeetingId());
			somRule.setMeetingName(somMeeting.getMeetingName());
			somRule.setMeetingPlace(somMeeting.getMeetingPlace());
			somRule.setMeetingDate(somMeeting.getMeetingDate());
			somRule.setMeetingFormat(somMeeting.getMeetingFormat());
			ds.addRecord(somRule);
		}
		return ds;
	}

	public void insertOnline(SomRule somRule) {
		String time = DateUtil.getTime();
		// 保存会议信息
		SomMeeting somMeeting = new SomMeeting();
		somMeeting.setMeetingId(IdHelp.getUUID32());
		somMeeting.setSorgId(somRule.getSorgId());
		somMeeting.setMeetingName(somRule.getMeetingName());
		somMeeting.setMeetingPlace(somRule.getMeetingPlace());
		somMeeting.setMeetingDate(somRule.getMeetingDate());
		somMeeting.setMeetingFormat(somRule.getMeetingFormat());
		somMeeting.setCreateTime(time);
		somMeetingDomain.insert(somMeeting);
		
		// 保存章程信息
		somRule.setRuleId(IdHelp.getUUID32());
		somRule.setMeetingId(somMeeting.getMeetingId());
		somRule.setCreateTime(time);
		somRuleDao.insert(somRule);
	}

	public void update(SomRule somRule) {
		SomMeeting somMeeting = somMeetingDomain.get(somRule.getMeetingId());
		somMeeting.setMeetingName(somRule.getMeetingName());
		somMeeting.setMeetingPlace(somRule.getMeetingPlace());
		somMeeting.setMeetingDate(somRule.getMeetingDate());
		somMeeting.setMeetingFormat(somRule.getMeetingFormat());
		somMeetingDomain.update(somMeeting);
		somRuleDao.update(somRule);
	}

	/**
	 * 增加章程核准业务
	 * @param somRule
	 */
	public void insertRuleApply(SomApply somApply, SomRule somRule) {
		if ("S".equals(somApply.getSorgType())) {
			somApply.setApplyType(ApplyType.SOM_GROUP_RULE_CHECK);
		} else if ("M".equals(somApply.getSorgType())) {
			somApply.setApplyType(ApplyType.SOM_UNGOV_RULE_CHECK);
		} else if ("J".equals(somApply.getSorgType())) {
			somApply.setApplyType(ApplyType.SOM_FUND_RULE_CHECK);
		}
		SomOrgan somOrgan = somApply.getSomOrgan();
		somApply.setSorgId(somRule.getSorgId());
		somApply.setIfFinish("1");
		somApply.setDataSource("ONLINE");
		somApply.setSorgName(somOrgan.getCnName());
		somApplyDomain.insertOnline(somApply);
		somOrganDomain.insert(somOrgan);
		// 维护章程信息
		insertOnline(somRule);
	}
	
	/**
	 * 更新章程业务
	 * @param somRule
	 */
	public void updateRuleApply(SomApply somApply, SomRule somRule) {
		SomOrgan somOrgan = somApply.getSomOrgan();
		somApply.setSorgName(somOrgan.getCnName());
		somApplyDomain.update(somApply);
		update(somRule);
		somOrganDomain.update(somApply.getSomOrgan());
	}
	
}
