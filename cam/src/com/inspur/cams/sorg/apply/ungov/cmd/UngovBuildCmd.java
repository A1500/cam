package com.inspur.cams.sorg.apply.ungov.cmd;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.apply.ungov.domain.IUngovBuildDomain;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomDuty;
import com.inspur.cams.sorg.base.data.SomHeldOrgan;
import com.inspur.cams.sorg.base.data.SomHeldPeople;
import com.inspur.cams.sorg.base.data.SomOffice;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.data.SomPartyMember;
import com.inspur.cams.sorg.base.data.SomPartyPraise;
import com.inspur.cams.sorg.base.data.SomPeopleResume;
import com.inspur.cams.sorg.base.data.SomRule;
import com.inspur.cams.sorg.base.data.SomSession;
import com.inspur.cams.sorg.util.SomDutyDuties;
/**
 * @author zhaojin
 * 创建时间:2011-10-11
 * UngovBuildCmd
 * 说明:
 */
public class UngovBuildCmd extends BaseAjaxCommand {
	// 获取SCA组件
	private IUngovBuildDomain service = ScaComponentFactory.getService(IUngovBuildDomain.class, "ungovBuildDomain/ungovBuildDomain");
	
	/**
	 * 社会组织主表查询
	 */
	public DataSet queryOrgan(){
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryOrgan(pset);
		return ds;
	}
	/**
	 * 业务流程意见表查询
	 */
	public void queryFlow(){
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryFlow(pset);
		setReturn("flowDataSet", ds);
	}
	
	/**
	 * 业务信息保存创建并发送
	 */
	public void createAndSend(){
		service.createAndSend(getSomApply());
	}
	
	
	/**
	 * 保存业务信息
	 */
	public void insertBuildInfo() {	
		
		service.insertBuildInfo(getSomApply());		
	}
	/**
	 * 业务信息保存创建并发送
	 */
	public void saveAndSendBuild(){
		service.saveAndSendBuild(getSomApply());
	}
	/**
	 * 更新业务信息
	 */
	public void updateBuildInfo(){
		service.updateBuildInfo(getSomApply());
		
	}
	/**
	 * 更新业务信息并发送
	 */
	public void updateForSend(){
		service.updateForSend(getSomApply());
	}
	/**
	 * 更新业务意见信息
	 */
	public void updateApply(){
		//获取前台业务意见信息
		Record applyRd = (Record) getParameter("somApplyDataSetRd");
		SomApply applyBean = (SomApply) applyRd.toBean(SomApply.class);
		service.updateApply(applyBean);
	}
	
	/**
	 *  保存并发送
	 */
	public void send(){
		//根据环节定义获取环节信息
		Record applyRd = (Record) getParameter("somApplyDataSetRd");
		SomApply applyBean = (SomApply) applyRd.toBean(SomApply.class);
		Map<String, String> map=new HashMap<String, String>();
		map.put("fetchPeople", (String)getParameter("fetchPeople"));
		map.put("fetchDate", (String)getParameter("fetchDate"));
		map.put("fetchPhone", (String)getParameter("fetchPhone"));
		applyBean.setMap(map);
		service.send(applyBean);
	}
	
	/**
	 * 打印环节发送
	 */
	public void printForSend(){
		Record applyRd = (Record) getParameter("somApplyDataSetRd");
		SomApply applyBean = (SomApply) applyRd.toBean(SomApply.class);
		Map<String, String> map=new HashMap<String, String>();
		map.put("sorgCode", (String)getParameter("sorgCode"));
		map.put("organCode", (String)getParameter("organCode"));
		map.put("regDate", (String)getParameter("regDate"));
		map.put("certType", (String)getParameter("certType"));
		map.put("endDate", (String)getParameter("endDate"));
		map.put("beginDate", (String)getParameter("beginDate"));
		map.put("PrintDate", (String)getParameter("PrintDate"));
		map.put("business", (String)getParameter("business"));
		map.put("issueReasonDesc", (String)getParameter("issueReasonDesc"));
		map.put("fetchPeople", (String)getParameter("fetchPeople"));
		map.put("fetchDate", (String)getParameter("fetchDate"));
		map.put("fetchPhone", (String)getParameter("fetchPhone"));
		applyBean.setMap(map);
		service.printForSend(applyBean);
	}
	
	
	/**
	 * 获取最后环节processId
	 */
	public String getProcessId(String id){
		return service.queryProcessId(id);
	}
	
	/**
	 * 通过processId获取taskCode
	 */
	public SomApply getTaskCode(String processId){
		return service.queryTaskCode(processId);
	}
	
	
	//从后台获取数据
	private SomApply getSomApply() {
		Record organRecord = (Record) getParameter("organRecord");
		Record LegalPeopleRecord = (Record) getParameter("LegalPeopleRecord");
		Record somSessionRecord = (Record) getParameter("somSessionRecord");
		Record somRuleRecord = (Record) getParameter("somRuleRecord");
		//举办人情况-
		Record[] somHeldPeopleRds = (Record[]) getParameter("somHeldPeopleRds");
		//举办单位情况-
		Record[] somHeldOrganRds = (Record[]) getParameter("somHeldOrganRds");
		//内设机构
		Record[] somOfficeRds = (Record[]) getParameter("somOfficeDataSetRds");
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		Record[] somDutyRecords = (Record[])getParameter("somDutyRecords");
		Record[] somResumeRecords = (Record[])getParameter("somResumeRecords");
		Record[] somPartyMemberRecords = (Record[])getParameter("somPartyMemberRecords");
		Record[] somPartyPraiseRecords = (Record[])getParameter("somPartyPraiseRecords");
		
		List<SomDuty> somDutyList = new ArrayList<SomDuty>();
		List<SomHeldPeople> somHeldPeopleList = new ArrayList<SomHeldPeople>();
		List<SomHeldOrgan> somHeldOrganList = new ArrayList<SomHeldOrgan>();
		List<SomOffice> somOfficeList = new ArrayList<SomOffice>();
		List<SomPartyMember> somPartyMemberList = new ArrayList<SomPartyMember>();
		
		
		SomOrgan somOrgan=(SomOrgan)organRecord.toBean(SomOrgan.class);	
			
		if(LegalPeopleRecord != null){
			SomDuty LegalPeople=(SomDuty)LegalPeopleRecord.toBean(SomDuty.class);
			LegalPeople.setSorgDuties(SomDutyDuties.SOM_LEGAL_PEOPLE);
			//处理个人简历
			List<SomPeopleResume> somPeopleResumeList = new ArrayList<SomPeopleResume>();
			if(somResumeRecords!=null){
				for(int j=0;j<somResumeRecords.length;j++){
					SomPeopleResume somPeopleResume =(SomPeopleResume) somResumeRecords[j].toBean(SomPeopleResume.class);
					somPeopleResumeList.add(somPeopleResume);
				}
				LegalPeople.setSomPeopleResumeList(somPeopleResumeList);
			}
			//处理个人简历完成
			somDutyList.add(LegalPeople);
		}
		if(somSessionRecord != null){
			SomSession somSession=(SomSession)somSessionRecord.toBean(SomSession.class);
			somOrgan.setSomSession(somSession);
		}
		if(somRuleRecord != null){
			SomRule somRule=(SomRule)somRuleRecord.toBean(SomRule.class);
			somOrgan.setSomRule(somRule);
		}
		//组装duty
		SomApply somApply=(SomApply)somApplyRecord.toBean(SomApply.class);
		if(somDutyRecords != null){
			for(int i=0;i<somDutyRecords.length;i++){
				SomDuty somDuty=(SomDuty)somDutyRecords[i].toBean(SomDuty.class);
				//处理个人简历
				List<SomPeopleResume> somPeopleResumeList = new ArrayList<SomPeopleResume>();
				if(somResumeRecords!=null){
					for(int j=0;j<somResumeRecords.length;j++){
						SomPeopleResume somPeopleResume =(SomPeopleResume) somResumeRecords[j].toBean(SomPeopleResume.class);
						if(somPeopleResume.getDutyId().equals(somDuty.getDutyId())){
							somPeopleResumeList.add(somPeopleResume);
						}
					}
					somDuty.setSomPeopleResumeList(somPeopleResumeList);
				}
				//处理个人简历完成
				somDutyList.add(somDuty);
			}
		}
		
		//组装举办人情况
		if(somHeldPeopleRds != null){
			for(int i=0;i<somHeldPeopleRds.length;i++){
				SomHeldPeople somHeldPeople=(SomHeldPeople)somHeldPeopleRds[i].toBean(SomHeldPeople.class);
				somHeldPeopleList.add(somHeldPeople);
			}
		}
		//组装举办单位情况
		if(somHeldOrganRds != null){
			for(int i=0;i<somHeldOrganRds.length;i++){
				SomHeldOrgan somHeldOrgan=(SomHeldOrgan)somHeldOrganRds[i].toBean(SomHeldOrgan.class);
				somHeldOrganList.add(somHeldOrgan);
			}
		}
		//内设机构情况
		if(somOfficeRds != null){
			for(int i=0;i<somOfficeRds.length;i++){
				SomOffice somOffice=(SomOffice)somOfficeRds[i].toBean(SomOffice.class);
				somOfficeList.add(somOffice);
			}
		}
		if (somPartyMemberRecords != null) {
			for (int i = 0; i < somPartyMemberRecords.length; i++) {
				SomPartyMember somPartyMember = (SomPartyMember) somPartyMemberRecords[i].toBean(SomPartyMember.class);
				somPartyMemberList.add(somPartyMember);
				List<SomPartyPraise> somPartyPraiseList = new ArrayList<SomPartyPraise>();
				if (somPartyPraiseRecords != null) {
					for (int j = 0; j < somPartyPraiseRecords.length; j++) {
						SomPartyPraise somPartyPraise = (SomPartyPraise) somPartyPraiseRecords[j].toBean(SomPartyPraise.class);
						if (somPartyPraise.getMemberId().equals(somPartyMember.getMemberId())) {
							somPartyPraiseList.add(somPartyPraise);							
						}
					}
					somPartyMember.setSomPartyPraiseList(somPartyPraiseList);
				}
			}
		}	
		somOrgan.setSomDutyList(somDutyList);
		somOrgan.setSomHeldOrganList(somHeldOrganList);
		somOrgan.setSomHeldPeopleList(somHeldPeopleList);
		somOrgan.setSomOfficeList(somOfficeList);
		somOrgan.setSomPartyMemberList(somPartyMemberList);
		somApply.setSomOrgan(somOrgan);
		
		return somApply;
	}
}
