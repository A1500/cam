package com.inspur.cams.sorg.apply.group.cmd;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.apply.group.domain.IGroupBuildDomain;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomDuty;
import com.inspur.cams.sorg.base.data.SomFee;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.data.SomPartyMember;
import com.inspur.cams.sorg.base.data.SomPartyPraise;
import com.inspur.cams.sorg.base.data.SomPeopleResume;
import com.inspur.cams.sorg.base.data.SomRule;
import com.inspur.cams.sorg.base.data.SomSession;
import com.inspur.cams.sorg.util.SomDutyDuties;
/**
 *  社会团体成立登记Cmd
 * @author yanliangliang
 * @date 2011-9-26
 */
public class GroupBuildCmd extends BaseAjaxCommand {
	// 获取SCA组件
	private IGroupBuildDomain service = ScaComponentFactory.getService(IGroupBuildDomain.class, "groupBuildDomain/groupBuildDomain");
	
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
		map.put("certType", (String)getParameter("certType"));
		map.put("endDate", (String)getParameter("endDate"));
		map.put("beginDate", (String)getParameter("beginDate"));
		map.put("PrintDate", (String)getParameter("PrintDate"));
		map.put("issueReasonDesc", (String)getParameter("issueReasonDesc"));
		map.put("organCode", (String)getParameter("organCode"));
		map.put("sorgCode", (String)getParameter("sorgCode"));
		map.put("regDate", (String)getParameter("regDate"));
		map.put("business", (String)getParameter("business"));
		map.put("fetchPeople", (String)getParameter("fetchPeople"));
		map.put("fetchDate", (String)getParameter("fetchDate"));
		map.put("fetchPhone", (String)getParameter("fetchPhone"));
		applyBean.setMap(map);
		service.printForSend(applyBean);
	}
	/**
	 * 保存照片并返回照片Id
	 */
	public void savePhoto(){
		ParameterSet pset = getParameterSet();
		String photoText = (String) pset.getParameter("photoText");
		String photoId = service.savePhoto(photoText);
		setReturn("photoId", photoId);
	}
	/**
	 * 更新照片
	 */
	public void updatePhoto(){
		ParameterSet pset = getParameterSet();
		String photoId = (String) pset.getParameter("photoId");
		String photoText = (String) pset.getParameter("photoText");
		String newPhotoId = service.updatePhoto(photoId,photoText);
		setReturn("photoId", newPhotoId);
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
	
	/**
	 * 通过processId获取photoId
	 * @param processId
	 * @return
	 */
	public String getPhotoId(String processId){
		return service.queryPhotoId(processId);
	}
	
	
	/**
	 * 从后台获取数据
	 */
	private SomApply getSomApply() {
		Record organRecord = (Record) getParameter("organRecord");
		Record LegalPeopleRecord = (Record) getParameter("LegalPeopleRecord");
		Record somSessionRecord = (Record) getParameter("somSessionRecord");
		Record somRuleRecord = (Record) getParameter("somRuleRecord");
		Record somFeeRecord = (Record) getParameter("somFeeRecord");
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		Record[] somDutyRecords = (Record[])getParameter("somDutyRecords");
		Record[] somResumeRecords = (Record[])getParameter("somResumeRecords");
		Record[] somPartyMemberRecords = (Record[])getParameter("somPartyMemberRecords");
		Record[] somPartyPraiseRecords = (Record[])getParameter("somPartyPraiseRecords");
		
		List<SomDuty> somDutyList = new ArrayList<SomDuty>();
		List<SomPartyMember> somPartyMemberList = new ArrayList<SomPartyMember>();
		
		SomOrgan somOrgan=(SomOrgan)organRecord.toBean(SomOrgan.class);	
		SomDuty LegalPeople=(SomDuty)LegalPeopleRecord.toBean(SomDuty.class);
		SomSession somSession=(SomSession)somSessionRecord.toBean(SomSession.class);
		SomRule somRule=(SomRule)somRuleRecord.toBean(SomRule.class);
		SomFee somFee=(SomFee)somFeeRecord.toBean(SomFee.class);
		SomApply somApply=(SomApply)somApplyRecord.toBean(SomApply.class);
		if(somDutyRecords != null){
			for(int i=0;i<somDutyRecords.length;i++){
				SomDuty somDuty=(SomDuty)somDutyRecords[i].toBean(SomDuty.class);
				//处理个人简历
				List<SomPeopleResume> somPeopleResumeList = new ArrayList<SomPeopleResume>();
				if(somResumeRecords!=null){
					for(int j=0;j<somResumeRecords.length;j++){
						SomPeopleResume somPeopleResume =(SomPeopleResume) somResumeRecords[j].toBean(SomPeopleResume.class);
						if( somPeopleResume.getDutyId().equals(somDuty.getDutyId()) ){
							somPeopleResumeList.add(somPeopleResume);
						}
					}
					somDuty.setSomPeopleResumeList(somPeopleResumeList);
				}
				//处理个人简历完成
				somDutyList.add(somDuty);
			}
		}
		LegalPeople.setSorgDuties(SomDutyDuties.SOM_LEGAL_PEOPLE);
		somDutyList.add(LegalPeople);

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
		somOrgan.setSomSession(somSession);
		somOrgan.setSomRule(somRule);
		somOrgan.setSomFee(somFee);
		somOrgan.setSomDutyList(somDutyList);
		somOrgan.setSomPartyMemberList(somPartyMemberList);
		somApply.setSomOrgan(somOrgan);
		
		return somApply;
	}
}
