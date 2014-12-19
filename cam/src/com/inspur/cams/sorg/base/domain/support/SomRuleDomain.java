package com.inspur.cams.sorg.base.domain.support;

import org.loushang.bsp.share.organization.bean.OrganView;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.StrUtil;
import com.inspur.cams.sorg.base.dao.jdbc.SomRuleDao;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomElectronic;
import com.inspur.cams.sorg.base.data.SomMeeting;
import com.inspur.cams.sorg.base.data.SomRule;
import com.inspur.cams.sorg.base.domain.ISomApplyDomain;
import com.inspur.cams.sorg.base.domain.ISomElectronicDomain;
import com.inspur.cams.sorg.base.domain.ISomMeetingDomain;
import com.inspur.cams.sorg.base.domain.ISomRuleDomain;
import com.inspur.cams.sorg.util.ApplyType;
import com.inspur.cams.sorg.util.SomIdHelp;

/**
 * 社会组织章程信息domain
 * @author yanliangliang
 * @date 2011-9-21
 */
public class SomRuleDomain implements ISomRuleDomain {
	
	@Reference
	private SomRuleDao somRuleDao;

	@Reference
	private ISomMeetingDomain somMeetingDomain;

	@Reference
	private ISomApplyDomain somApplyDomain;
	
	@Reference
	private ISomElectronicDomain somElectronicDomain;

	public DataSet query(ParameterSet pset) {
		return somRuleDao.query(pset);
	}

	public DataSet queryRule(ParameterSet pset) {
		DataSet ds=new DataSet();
		DataSet somRuleDataSet = somRuleDao.query(pset);
		for (int i = 0; i < somRuleDataSet.getCount(); i++) {
			SomRule somRule = (SomRule) somRuleDataSet.getRecord(i).toBean(SomRule.class);
			SomMeeting somMeeting = somMeetingDomain.get(somRule.getMeetingId());
			if(somMeeting!=null){
				somRule.setMeetingName(somMeeting.getMeetingName());
				somRule.setMeetingPlace(somMeeting.getMeetingPlace());
				somRule.setMeetingDate(somMeeting.getMeetingDate());
				somRule.setMeetingFormat(somMeeting.getMeetingFormat());
				//如果是新的数据的话，即已经有会议和章程的关联关系，就直接取会议信息中的相关人数
				if(StrUtil.n2b(somMeeting.getIfOld()).equals("0")){
					somRule.setShouldNum(somMeeting.getShouldNum());
					somRule.setRealNum(somMeeting.getRealNum());
					somRule.setPassNum(somMeeting.getPassNum());
					somRule.setNopassNum(somMeeting.getNopassNum());
					somRule.setGiveupNum(somMeeting.getGiveupNum());
				}
			}
			ds.addRecord(somRule);
		}
		return ds;
	}

	public void insert(SomRule somRule) {
		OrganView corpOrgan = BspUtil.getCorpOrgan();
		OrganView empOrgan = BspUtil.getEmpOrgan();
		String time = DateUtil.getTime();
		// 保存会议信息
		SomMeeting somMeeting = new SomMeeting();
		somMeeting.setMeetingId(IdHelp.getUUID32());
		somMeeting.setSorgId(somRule.getSorgId());
		somMeeting.setMeetingName(somRule.getMeetingName());
		somMeeting.setMeetingPlace(somRule.getMeetingPlace());
		somMeeting.setMeetingDate(somRule.getMeetingDate());
		somMeeting.setMeetingFormat(somRule.getMeetingFormat());
		somMeeting.setMorgName(corpOrgan.getOrganName());
		somMeeting.setMorgArea(corpOrgan.getOrganCode());
		somMeeting.setCreatePeople(empOrgan.getOrganName());
		somMeeting.setCreateTime(time);
		somMeeting.setShouldNum(somRule.getShouldNum());
		somMeeting.setRealNum(somRule.getRealNum());
		somMeeting.setPassNum(somRule.getPassNum());
		somMeeting.setNopassNum(somRule.getNopassNum());
		somMeeting.setGiveupNum(somRule.getGiveupNum());
		somMeetingDomain.insert(somMeeting);
		
		// 保存章程信息
		somRule.setRuleId(IdHelp.getUUID32());
		somRule.setMeetingId(somMeeting.getMeetingId());
		somRule.setMorgName(corpOrgan.getOrganName());
		somRule.setMorgArea(corpOrgan.getOrganCode());
		somRule.setCreatePeople(empOrgan.getOrganName());
		somRule.setCreateTime(time);
		somRuleDao.insert(somRule);
	}
	
	/**
	 * meetingid前台提供
	 */
	public void insertWithOutMeetingInfo(SomRule somRule) {
		OrganView corpOrgan = BspUtil.getCorpOrgan();
		OrganView empOrgan = BspUtil.getEmpOrgan();
		String time = DateUtil.getTime();
		// 保存章程信息
		somRule.setRuleId(IdHelp.getUUID32());
		somRule.setMorgName(corpOrgan.getOrganName());
		somRule.setMorgArea(corpOrgan.getOrganCode());
		somRule.setCreatePeople(empOrgan.getOrganName());
		somRule.setCreateTime(time);
		somRuleDao.insert(somRule);
	}
	
	public void insertWithoutMeeting(SomRule somRule) {
		OrganView corpOrgan = BspUtil.getCorpOrgan();
		OrganView empOrgan = BspUtil.getEmpOrgan();
		String time = DateUtil.getTime();
		// 保存章程信息
		somRule.setRuleId(IdHelp.getUUID32());
//		somRule.setMeetingId(somMeeting.getMeetingId());
		somRule.setMorgName(corpOrgan.getOrganName());
		somRule.setMorgArea(corpOrgan.getOrganCode());
		somRule.setCreatePeople(empOrgan.getOrganName());
		somRule.setCreateTime(time);
		somRuleDao.insert(somRule);
		SomMeeting somMeeting = somMeetingDomain.get(somRule.getMeetingId());
		somMeeting.setMeetingFormat(somRule.getMeetingFormat());
		somMeeting.setShouldNum(somRule.getShouldNum());
		somMeeting.setRealNum(somRule.getRealNum());
		somMeeting.setPassNum(somRule.getPassNum());
		somMeeting.setNopassNum(somRule.getNopassNum());
		somMeeting.setGiveupNum(somRule.getGiveupNum());
		somMeetingDomain.update(somMeeting);
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
		somMeeting.setShouldNum(somRule.getShouldNum());
		somMeeting.setRealNum(somRule.getRealNum());
		somMeeting.setPassNum(somRule.getPassNum());
		somMeeting.setNopassNum(somRule.getNopassNum());
		somMeeting.setGiveupNum(somRule.getGiveupNum());
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
		//如果是新的数据的话，即已经有会议和章程的关联关系，就直接更新会议信息中的相关人数
		if(StrUtil.n2b(somMeeting.getIfOld()).equals("0")){
			somMeeting.setShouldNum(somRule.getShouldNum());
			somMeeting.setRealNum(somRule.getRealNum());
			somMeeting.setPassNum(somRule.getPassNum());
			somMeeting.setNopassNum(somRule.getNopassNum());
			somMeeting.setGiveupNum(somRule.getGiveupNum());
		}
		somMeetingDomain.update(somMeeting);
		somRuleDao.update(somRule);
	}

	/**
	 * 增加章程核准业务
	 * @param somRule
	 */
	public void insertRuleApply(SomApply somApply, SomRule somRule) {
		String areaCode = BspUtil.getCorpOrgan().getOrganCode();
		if ("S".equals(somApply.getSorgType())) {
			somApply.setApplyType(ApplyType.SOM_GROUP_RULE_CHECK);
		} else if ("M".equals(somApply.getSorgType())) {
			somApply.setApplyType(ApplyType.SOM_UNGOV_RULE_CHECK);
		} else if ("J".equals(somApply.getSorgType())) {
			somApply.setApplyType(ApplyType.SOM_FUND_RULE_CHECK);
		}
		somApply.setSorgId(somRule.getSorgId());
		somApply.setIfFinish("1");
		//网上申请的将电子档案表的sorgId更新为系统中已经存在的组织的sorgId
		if(somApply.getDataSource().equals("ONLINE")){
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", somApply.getTaskCode());
			DataSet ds = somElectronicDomain.queryElectronicOnly(pset);
			for(int i = 0;i<ds.getCount();i++){
				SomElectronic bean = (SomElectronic) ds.getRecord(i).toBean(SomElectronic.class);
				bean.setSorgId(somApply.getSorgId());
				somElectronicDomain.update(bean);
			}
		}else{
			somApply.setDataSource("LOCAL");
		}
		somApply.setAcceptArea(areaCode);
		somApplyDomain.insert(somApply);
		// 维护章程信息
		insert(somRule);
	}
	
	/**
	 * 增加章程核准业务不插入会议信息，章程核准页面调用
	 * @param somRule
	 */
	public void insertRuleApplyWithoutMeeting(SomApply somApply, SomRule somRule) {
		String areaCode = BspUtil.getCorpOrgan().getOrganCode();
		if ("S".equals(somApply.getSorgType())) {
			somApply.setApplyType(ApplyType.SOM_GROUP_RULE_CHECK);
		} else if ("M".equals(somApply.getSorgType())) {
			somApply.setApplyType(ApplyType.SOM_UNGOV_RULE_CHECK);
		} else if ("J".equals(somApply.getSorgType())) {
			somApply.setApplyType(ApplyType.SOM_FUND_RULE_CHECK);
		}
		somApply.setSorgId(somRule.getSorgId());
		somApply.setIfFinish("1");
		somApply.setDataSource("LOCAL");
		somApply.setAcceptArea(areaCode);
		somApplyDomain.insert(somApply);
		// 维护章程信息
		insertWithoutMeeting(somRule);
		//更新档案文件中的sorgId，内网预受理用
		somElectronicDomain.updateSorgId(somApply.getSorgId(), somApply.getTaskCode());
	
	}
	
	/**
	 * 更新章程业务
	 * @param somRule
	 */
	public void updateRuleApply(SomApply somApply, SomRule somRule) {
		somApplyDomain.update(somApply);
		update(somRule);
		//更新档案文件中的sorgId，内网预受理用
		somElectronicDomain.updateSorgId(somApply.getSorgId(), somApply.getTaskCode());
	}
	
	public void del(String taskCode){
		somRuleDao.del(taskCode);
	}
}
