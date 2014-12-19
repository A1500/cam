package com.inspur.cams.sorg.base.data;

import java.util.List;
import java.util.Map;

import org.loushang.next.data.StatefulDatabean;
/**
 * 变更流程封装Bean
 * @author yanliangliang
 * @date 2011-8-13
 */
public class SomChangeApply extends StatefulDatabean {
	//章程会议
	private SomMeeting somMeeting;
	//章程
	private SomRule somRule;
	//变更事项
	private List<SomChange> somChange;
	//人员信息
	private SomDuty somLegalPeople;
	//人员简历
	private List<SomPeopleResume> peopleResumes;
	//意见
	private SomApply somApply;
	//参数所用map
	private Map<String, String> map;
//参数包括:
//社会组织名称 cnName;
//社会组织ID sorgId;
//社会组织类型 sorgType;
//社会组织种类 sorgKind;
//业务编号 taskCode;
//业务种类 applyType;
//人员职务 sorgDuties;
//环节ID actDefUniqueId;
//社会组织是主体还是分支 organType;
//证书有效期止 endDate;
//证书有效期起beginDate;
//发证时间PrintDate;
//领证时间fetchPeople;
//领证人 fetchDate;
//法定代表人ID leaPeopleId;
	public SomMeeting getSomMeeting() {
		return somMeeting;
	}
	public void setSomMeeting(SomMeeting somMeeting) {
		this.somMeeting = somMeeting;
	}
	
	public List<SomChange> getSomChange() {
		return somChange;
	}
	public void setSomChange(List<SomChange> somChange) {
		this.somChange = somChange;
	}


	public SomRule getSomRule() {
		return somRule;
	}
	public void setSomRule(SomRule somRule) {
		this.somRule = somRule;
	}
	public SomDuty getSomLegalPeople() {
		return somLegalPeople;
	}
	public void setSomLegalPeople(SomDuty somLegalPeople) {
		this.somLegalPeople = somLegalPeople;
	}
	public SomApply getSomApply() {
		return somApply;
	}
	public void setSomApply(SomApply somApply) {
		this.somApply = somApply;
	}
	public Map<String, String> getMap() {
		return map;
	}
	public void setMap(Map<String, String> map) {
		this.map = map;
	}
	public List<SomPeopleResume> getPeopleResumes() {
		return peopleResumes;
	}
	public void setPeopleResumes(List<SomPeopleResume> peopleResumes) {
		this.peopleResumes = peopleResumes;
	}
	
	
}
