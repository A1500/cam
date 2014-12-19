package com.inspur.cams.sorg.history.ungov.cmd;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomChange;
import com.inspur.cams.sorg.base.data.SomChangeApply;
import com.inspur.cams.sorg.base.data.SomDuty;
import com.inspur.cams.sorg.base.data.SomHeldOrgan;
import com.inspur.cams.sorg.base.data.SomHeldPeople;
import com.inspur.cams.sorg.base.data.SomLiqpeople;
import com.inspur.cams.sorg.base.data.SomOffice;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.data.SomPeopleResume;
import com.inspur.cams.sorg.base.data.SomRule;
import com.inspur.cams.sorg.base.data.SomSession;
import com.inspur.cams.sorg.history.ungov.domain.ISomUngovHistoryDomain;
import com.inspur.cams.sorg.util.SomDutyDuties;

public class SomUngovHistoryCmd extends BaseAjaxCommand {
	// 获取SCA组件
	private ISomUngovHistoryDomain service = ScaComponentFactory.getService(ISomUngovHistoryDomain.class,"somUngovHistoryDomain/somUngovHistoryDomain");

	//---------------------------成立--------------------------
	/**
	 * 保存业务信息
	 */
	public void insertBuildInfo() {	
		service.insertBuildInfo(getSomApply());		
	}
	/**
	 * 更新业务信息
	 */
	public void updateBuildInfo() {
		service.updateBuildInfo(getSomApply());
	}
	// ---------------------------变更---------------------------
	/**
	 * 保存变更信息
	 */
	public void saveChange(){
		service.saveChange(getChange());
	}
	/**
	 * 更新变更信息
	 */
	public void updateChange(){
		service.updateChange(getChange());
	}
	
	/**
	 * 修订社会组织变更信息，只保存change表
	 */
	public void updateChangeOnly(){
		service.updateChangeOnly(getChange());
	}
	
	//---------------------------注销---------------------------
	/**
	 * 新增注销
	 */
	public void saveCancel() {
		service.saveCancel(getCancel());
	}

	/**
	 * 修改注销
	 */
	public void updateCancel() {
		service.updateCancel(getCancel());
	}
	

	/**
	 * 获取注销信息
	 * 
	 * @return SomApply
	 */
	private SomApply getCancel() {
		List<SomLiqpeople> somLiqpeopleList = new ArrayList<SomLiqpeople>();
		// 获取前台社会组织信息
		Record somOrganRd = (Record) getParameter("somOrganRd");
		SomOrgan somOrgan = (SomOrgan) somOrganRd.toBean(SomOrgan.class);

		// 获取前台社会组织清算人员信息列表
		Record[] somLiqpeopleRds = (Record[]) getParameter("somLiqpeopleRds");
		if (somLiqpeopleRds != null && somLiqpeopleRds.length > 0) {
			for (int i = 0; i < somLiqpeopleRds.length; i++) {
				SomLiqpeople somLiqpeople = (SomLiqpeople) somLiqpeopleRds[i]
						.toBean(SomLiqpeople.class);
				somLiqpeopleList.add(somLiqpeople);
			}
			somOrgan.setSomLiqpeopleList(somLiqpeopleList);
		}

		// 获取前台业务意见信息
		Record somApplyRd = (Record) getParameter("somApplyRd");
		SomApply somApply = (SomApply) somApplyRd.toBean(SomApply.class);

		// 封装数据
		somApply.setSomOrgan(somOrgan);
		return somApply;
	}
	//-----------------------------私有方法------------------------------------
	//从前台获取数据
	private SomApply getSomApply() {
		Record organRecord = (Record) getParameter("organRecord");
		Record[] somDutyRecords = (Record[])getParameter("somDutyRecords");
		Record LegalPeopleRecord = (Record) getParameter("LegalPeopleRecord");
		Record[] somHeldPeopleRds = (Record[]) getParameter("somHeldPeopleRds");
		Record[] somHeldOrganRds = (Record[]) getParameter("somHeldOrganRds");
		Record[] somOfficeRds = (Record[]) getParameter("somOfficeDataSetRds");
		Record somRuleRecord = (Record) getParameter("somRuleRecord");
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		Record[] somResumeRecords = (Record[])getParameter("somResumeRecords");
		Record somSessionRecord = (Record) getParameter("somSessionRecord");
		
		List<SomDuty> somDutyList = new ArrayList<SomDuty>();
		List<SomHeldPeople> somHeldPeopleList = new ArrayList<SomHeldPeople>();
		List<SomHeldOrgan> somHeldOrganList = new ArrayList<SomHeldOrgan>();
		List<SomOffice> somOfficeList = new ArrayList<SomOffice>();
		
		SomOrgan somOrgan=(SomOrgan)organRecord.toBean(SomOrgan.class);	
		SomDuty LegalPeople=(SomDuty)LegalPeopleRecord.toBean(SomDuty.class);
		if(LegalPeopleRecord != null&&!LegalPeople.getName().equals("")){
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
		SomApply somApply=(SomApply)somApplyRecord.toBean(SomApply.class);
		
		if(somSessionRecord != null){
			SomSession somSession=(SomSession)somSessionRecord.toBean(SomSession.class);
			somOrgan.setSomSession(somSession);
		}
		//组装duty
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
		//章程核准
		if(somRuleRecord != null){
			SomRule somRule=(SomRule)somRuleRecord.toBean(SomRule.class);
			somOrgan.setSomRule(somRule);
		}
		somOrgan.setSomDutyList(somDutyList);
		somOrgan.setSomHeldOrganList(somHeldOrganList);
		somOrgan.setSomHeldPeopleList(somHeldPeopleList);
		somOrgan.setSomOfficeList(somOfficeList);
		somApply.setSomOrgan(somOrgan);
		
		return somApply;
	}
	/**
	 *  封装变更信息
	 * @return
	 */
	private SomChangeApply getChange() {
		SomChangeApply somChangeApply=new SomChangeApply();
		List<SomChange> changeList=new ArrayList<SomChange>();
		List<SomPeopleResume> legalResumeList=new ArrayList<SomPeopleResume>();
		Record[] changes=(Record[])getParameter("Changes");
		Record[] legalResumeRecords=(Record[]) getParameter("legalResumeRecords");
		Record somLegalPeople=(Record)getParameter("somLegalPeople");
		String cnName=(String)getParameter("cnName");
		String sorgId=(String)getParameter("sorgId");
		String taskCode=(String)getParameter("taskCode");
		String sorgType=(String)getParameter("sorgType");
		String sorgKind=(String)getParameter("sorgKind");
		String sorgDuties=(String)getParameter("sorgDuties");
		Record somFlow=(Record)getParameter("opinion");
		String process=(String)getParameter("process");
		//封装变更信息
		for(int i=0;i<changes.length;i++){
			SomChange somChange=(SomChange)changes[i].toBean(SomChange.class);
			changeList.add(somChange);
		}
		Map<String, String> map=new HashMap<String, String>();
		//封装法定代表人信息
		if(somLegalPeople!=null){
			SomDuty somPeople=(SomDuty)somLegalPeople.toBean(SomDuty.class);
			somChangeApply.setSomLegalPeople(somPeople);
		}
		//封装简历信息
		if(legalResumeRecords!=null){
			for(int i=0;i<legalResumeRecords.length;i++){
				SomPeopleResume somPeopleResume = (SomPeopleResume) legalResumeRecords[i].toBean(SomPeopleResume.class);
				legalResumeList.add(somPeopleResume);
			}
		}
		String applyType=(String)getParameter("applyType");
		String legalDutyId=(String)getParameter("legalDutyId");
		map.put("applyType", applyType);
		map.put("legalDutyId", legalDutyId);
		map.put("cnName", cnName);
		map.put("sorgId", sorgId);
		map.put("taskCode1", taskCode);
		map.put("sorgType", sorgType);
		map.put("sorgKind", sorgKind);
		map.put("sorgDuties", sorgDuties);
		
		somChangeApply.setSomChange(changeList);
		somChangeApply.setPeopleResumes(legalResumeList);
		if(somFlow!=null){
			SomApply somApply=(SomApply)somFlow.toBean(SomApply.class);
			if(!"".equals(process) && process!=null){
				somApply.setProcess(process);
			}
			somChangeApply.setSomApply(somApply);
		}
		somChangeApply.setMap(map);	
		return somChangeApply;
	}
}