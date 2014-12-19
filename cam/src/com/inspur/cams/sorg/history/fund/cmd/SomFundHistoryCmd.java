
package com.inspur.cams.sorg.history.fund.cmd;

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
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.data.SomPeopleResume;
import com.inspur.cams.sorg.base.data.SomRule;
import com.inspur.cams.sorg.base.data.SomSession;
import com.inspur.cams.sorg.history.fund.domain.ISomFundHistoryDomain;
/**
 * 基金会历史数据录入command
 * @author yanliangliang
 * @date 2011年12月27日
 */
public class SomFundHistoryCmd extends BaseAjaxCommand {
	
	private ISomFundHistoryDomain service = ScaComponentFactory.getService(ISomFundHistoryDomain.class,"somFundHistoryDomain/somFundHistoryDomain");
	// ---------------------------成立---------------------------
	/**
	 * 保存社会组织成立信息
	 */
	public void saveBuild(){
		service.saveBuild(getBuild());
	}
	/**
	 * 更新社会组织成立信息
	 */
	public void updateBuild(){
		service.updateBuild(getBuild());
	}
	/**
	 * 保存社会组织分支成立信息
	 */
	public void saveBranchBuild(){
		service.saveBranchBuild(getBranchBuild());
	}
	/**
	 * 更新社会组织成立信息
	 */
	public void updateBranchBuild(){
		service.updateBranchBuild(getBranchBuild());
	}
	// ---------------------------变更---------------------------
	/**
	 * 保存社会组织变更信息
	 */
	public void saveChange(){
		service.saveChange(getChange());
	}
	/**
	 * 更新社会组织变更信息
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
	
	/**
	 * 保存社会组织分支变更信息
	 */
	public void saveBranchChange(){
		service.saveBranchChange(getChange());
	}
	/**
	 * 更新社会组织分支变更信息
	 */
	public void updateBranchChange(){
		service.updateBranchChange(getChange());
	}
	
	public void updateBranchChangeOnly(){
		service.updateBranchChangeOnly(getChange());
	}
	// ---------------------------注销---------------------------
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
	// ---------------------------分支注销---------------------------
	/**
	 * 新增分支注销
	 */
	public void saveBranchCancel() {
		service.saveBranchCancel(getBranchCancel());
	}

	/**
	 * 修改分支注销
	 */
	public void updateBranchCancel() {
		service.updateBranchCancel(getBranchCancel());
	}
	// ---------------------------异地设立分支审查---------------------------
	/**
	 * 异地设立分支审查的保存
	 */
	public void saveBranchAPCheck(){
		service.saveBranchAPCheck(getBranchAPCheck());
	}
	/**
	 * 异地设立分支审查的更新
	 */
	public void updateBranchAPCheck(){
		service.updateBranchAPCheck(getBranchAPCheck());
	}
//------------------------------------------私有方法-------------------------------------------------
	/**
	 * 获取成立信息
	 * @return 
	 */
	private SomApply getBuild() {
		Record organRecord = (Record) getParameter("organRecord");
		Record somSessionRecord = (Record) getParameter("somSessionDataSet");
		Record somRuleRecord = (Record) getParameter("somRuleRecord");
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		Record[] aspForLiShi = (Record[]) getParameter("aspForLiShi");
		Record[] aspForJianShi = (Record[]) getParameter("aspForJianShi");
		Record[] somResumeInsertDataSet = (Record[]) getParameter("somResumeInsertDataSet");
		
		Record[] somHeldPeopleRecord = (Record[]) getParameter("somHeldPeopleRecord");
		Record[] somHeldOrganRecord = (Record[]) getParameter("somHeldOrganRecord");
		
		SomOrgan somOrgan=(SomOrgan)organRecord.toBean(SomOrgan.class);	
		SomSession somSession=(SomSession)somSessionRecord.toBean(SomSession.class);
		SomRule somRule=(SomRule)somRuleRecord.toBean(SomRule.class);
		SomApply somApply=(SomApply)somApplyRecord.toBean(SomApply.class);
		List<SomDuty> somDutyList = new ArrayList<SomDuty>();
		List<SomHeldPeople> somHeldPeopleList = new ArrayList<SomHeldPeople>();
		List<SomHeldOrgan> somHeldOrganList = new ArrayList<SomHeldOrgan>();
		if (somHeldPeopleRecord != null) {
			for (int i = 0; i < somHeldPeopleRecord.length; i++) {
				SomHeldPeople somHeldPeople = (SomHeldPeople) somHeldPeopleRecord[i].toBean(SomHeldPeople.class);
				somHeldPeopleList.add(somHeldPeople);
			}
		}
		if (somHeldOrganRecord != null) {
			for (int i = 0; i < somHeldOrganRecord.length; i++) {
				SomHeldOrgan somHeldOrgan = (SomHeldOrgan) somHeldOrganRecord[i].toBean(SomHeldOrgan.class);
				somHeldOrganList.add(somHeldOrgan);
			}
		}
		
		if(aspForLiShi != null){
			for (int i = 0; i < aspForLiShi.length; i++) {
				SomDuty somDuty = (SomDuty) aspForLiShi[i].toBean(SomDuty.class);
				if(somDuty.getSorgDuties().equals("00001")){
					somDuty.setIfLegal("1");
				}
				//处理简历
				List<SomPeopleResume> somResumeList = new ArrayList<SomPeopleResume>();
				somDuty.setSomPeopleResumeList(somResumeList);
				if(somResumeInsertDataSet!=null){
					for (int j = 0; j < somResumeInsertDataSet.length; j++) {
						SomPeopleResume somResume = (SomPeopleResume) somResumeInsertDataSet[j].toBean(SomPeopleResume.class);
						if(somResume.getDutyId().equals(somDuty.getDutyId())){
							somDuty.getSomPeopleResumeList().add(somResume);
						}
					}
				}
				somDutyList.add(somDuty);
			}
		}
		if(aspForJianShi != null){
			for (int i = 0; i < aspForJianShi.length; i++) {
				SomDuty somDuty = (SomDuty) aspForJianShi[i].toBean(SomDuty.class);
				//处理简历
				List<SomPeopleResume> somResumeList = new ArrayList<SomPeopleResume>();
				somDuty.setSomPeopleResumeList(somResumeList);
				if(somResumeInsertDataSet!=null){
					for (int j = 0; j < somResumeInsertDataSet.length; j++) {
						SomPeopleResume somResume = (SomPeopleResume) somResumeInsertDataSet[j].toBean(SomPeopleResume.class);
						if(somResume.getDutyId().equals(somDuty.getDutyId())){
							somDuty.getSomPeopleResumeList().add(somResume);
						}
					}
				}
				somDutyList.add(somDuty);
			}
		}
		somOrgan.setSomHeldPeopleList(somHeldPeopleList);
		somOrgan.setSomHeldOrganList(somHeldOrganList);	
		somOrgan.setSomSession(somSession);
		somOrgan.setSomRule(somRule);
		somOrgan.setSomDutyList(somDutyList);
		//联系人信息
		somOrgan.setSorgPeople(somApply.getAppPeople());
		somOrgan.setSorgPeoplePhone(somApply.getAppPhone());
		somApply.setSomOrgan(somOrgan);
		
		return somApply;
	}
	/**
	 * 封装分支成立信息
	 * @return
	 */
	private SomApply getBranchBuild() {
		Record organRd = (Record) getParameter("somOrganRecord");
		SomOrgan organBean = (SomOrgan) organRd.toBean(SomOrgan.class);
		//获取前台业务意见信息
		Record applyRd = (Record) getParameter("somApplyRecord");
		SomApply applyBean = (SomApply) applyRd.toBean(SomApply.class);
		Record somSessionRecord = (Record) getParameter("somSessionRecord");
		Record[] somDutyRecords = (Record[])getParameter("somDutyRecords");
		Record[] somResumeRecords = (Record[])getParameter("somResumeRecords");
		
		List<SomDuty> somDutyList = new ArrayList<SomDuty>();
		SomSession somSession=(SomSession)somSessionRecord.toBean(SomSession.class);
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
				organBean.setBranchCharger(somDuty.getName());
			}
		}
		organBean.setSomSession(somSession);
		organBean.setSomDutyList(somDutyList);
		applyBean.setSomOrgan(organBean);
		return applyBean;
	}
	/**
	 *  封装变更信息
	 * @return
	 */
	private SomChangeApply getChange() {
		SomChangeApply somChangeApply=new SomChangeApply();
		List<SomChange> changeList=new ArrayList<SomChange>();
		Record[] changes=(Record[])getParameter("Changes");
		Record somLegalPeople=(Record)getParameter("somLegalPeople");
		String cnName=(String)getParameter("cnName");
		String sorgId=(String)getParameter("sorgId");
		String taskCode=(String)getParameter("taskCode");
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
			map.put("leaPeopleId", somPeople.getDutyId());
		}
		
		String applyType=(String)getParameter("applyType");
		String legalDutyId=(String) getParameter("legalDutyId");
		map.put("applyType", applyType);
		map.put("legalDutyId", legalDutyId);
		map.put("cnName", cnName);
		map.put("sorgId", sorgId);
		map.put("taskCode1", taskCode);
		map.put("sorgKind", sorgKind);
		map.put("sorgDuties", sorgDuties);
		
		somChangeApply.setSomChange(changeList);
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

	/**
	 * 获取分支注销信息
	 * 
	 * @return SomApply
	 */
	private SomApply getBranchCancel() {
		// 获取前台社会组织信息
		Record somOrganRd = (Record) getParameter("somOrganRd");
		SomOrgan somOrgan = (SomOrgan) somOrganRd.toBean(SomOrgan.class);
		// 获取前台业务意见信息
		Record somApplyRd = (Record) getParameter("somApplyRd");
		SomApply somApply = (SomApply) somApplyRd.toBean(SomApply.class);
		// 封装数据
		somApply.setSomOrgan(somOrgan);
		return somApply;
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
	/**
	 * 封装异地设立分支信息
	 * @return
	 */
	private SomApply getBranchAPCheck() {
		Record organRecord = (Record) getParameter("organRecord");
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		SomOrgan somOrgan=(SomOrgan)organRecord.toBean(SomOrgan.class);	
		SomApply somApply=(SomApply)somApplyRecord.toBean(SomApply.class);
		somApply.setSomOrgan(somOrgan);
		return somApply;
	}
}
