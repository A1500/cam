
package com.inspur.cams.sorg.online.apply.fund.cmd;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomAspchief;
import com.inspur.cams.sorg.base.data.SomChange;
import com.inspur.cams.sorg.base.data.SomChangeApply;
import com.inspur.cams.sorg.base.data.SomDuty;
import com.inspur.cams.sorg.base.data.SomElection;
import com.inspur.cams.sorg.base.data.SomHeldOrgan;
import com.inspur.cams.sorg.base.data.SomHeldPeople;
import com.inspur.cams.sorg.base.data.SomLiqpeople;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.data.SomPeopleResume;
import com.inspur.cams.sorg.base.data.SomRule;
import com.inspur.cams.sorg.base.data.SomSession;
import com.inspur.cams.sorg.online.apply.fund.domain.ISomFundOnlineDomain;
/**
 * 基金会外网录入command
 * @author yanliangliang
 * @date 2012年11月28日
 */
public class SomFundOnlineCmd extends BaseAjaxCommand {
	@Reference
	private ISomFundOnlineDomain service = ScaComponentFactory.getService(ISomFundOnlineDomain.class,"somFundOnlineDomain/somFundOnlineDomain");
	
	/**
	 * @title 保存申请名称核准             
	 */
	public void saveNameApproval() {
		service.saveNameApproval(getApprovalInfo());
	}
	/**
	 * @title 保存设立登记          
	 */
	public void saveBuild() {
		service.saveBuild(getBuildInfo());
	}
	// ---------------------------分支设立---------------------------
	/**
	 * 保存社会组织分支设立信息
	 */
	public void saveBranchBuild(){
		service.saveBranchBuild(getBranchBuild());
	}
	/**
	 * 更新社会组织分支设立信息
	 */
	public void updateBranchBuild(){
		service.updateBranchBuild(getBranchBuild());
	}
	/**
	 * @title 保存变更登记
	 */
	public void saveChange(){
		service.saveChange(getChangeInfo());
	}
	// ---------------------------分支变更---------------------------
	/**
	 * 保存社会组织分支变更信息
	 */
	public void saveBranchChange(){
		service.saveBranchChange(getBranchChange());
	}
	/**
	 * 更新社会组织分支变更信息
	 */
	public void updateBranchChange(){
		service.updateBranchChange(getBranchChange());
	}
	/**
	 * @title 保存注销登记
	 */
	public void saveCancel(){
		service.saveCancel(getCancel());
	}
	/**
	 * 保存章程信息
	 */
	public void saveRule(){
		service.saveRule(getRuleInfo());
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
	/**
	 * 保存换届事先报批
	 */
	public void saveElection(){
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		SomApply somApply = (SomApply) somApplyRecord.toBean(SomApply.class);
		Record organRecord = (Record) getParameter("organRecord");
		SomOrgan somOrgan = (SomOrgan)organRecord.toBean(SomOrgan.class);
		service.saveElection( somApply,somOrgan,getElection() );
	}
	/**
	 * 保存延期换届选举报批
	 */
	public void saveElectionDelay(){
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		SomApply somApply = (SomApply) somApplyRecord.toBean(SomApply.class);
		Record organRecord = (Record) getParameter("organRecord");
		SomOrgan somOrgan = (SomOrgan)organRecord.toBean(SomOrgan.class);
		service.saveElectionDelay( somApply,somOrgan,getElectionDelay() );
	}
	
	
	/**
	 * 保存负责人换届备案
	 */
	public void saveManPeople(){
		service.saveManPeople(getSomSession());
	}
	/**
 *  TODO
 * #################################################################################################
 * #########################################     内部方法       ####################################
 * #################################################################################################
*/
	/**
	 * @title 封装申请名称核准信息
	 * @return SomApply
	 */
	private SomApply getApprovalInfo() {
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		SomApply somApply = (SomApply) somApplyRecord.toBean(SomApply.class);
		
		Record somOrganRecord = (Record) getParameter("somOrganRecord");
		SomOrgan somOrgan = (SomOrgan) somOrganRecord.toBean(SomOrgan.class);
		
		List<SomHeldPeople> somHeldPeopleList = new ArrayList<SomHeldPeople>();
		List<SomHeldOrgan> somHeldOrganList = new ArrayList<SomHeldOrgan>();

		Record[] somHeldPeopleRecord = (Record[]) getParameter("somHeldPeopleRecord");
		Record[] somHeldOrganRecord = (Record[]) getParameter("somHeldOrganRecord");
		Record aspChief = (Record) getParameter("aspChief");
		
		SomAspchief somAspChief=(SomAspchief)aspChief.toBean(SomAspchief.class);
		List<SomAspchief> somAspChiefList = new ArrayList<SomAspchief>();
		somAspChiefList.add(somAspChief);
		
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
		somOrgan.setSomHeldPeopleList(somHeldPeopleList);
		somOrgan.setSomHeldOrganList(somHeldOrganList);
		somOrgan.setSomAspchiefList(somAspChiefList);
		//维护organ表中联系人与联系电话
		somOrgan.setSorgPeople(somApply.getAppPeople());
		somOrgan.setSorgPeoplePhone(somApply.getAppPhone());
		somApply.setSomOrgan(somOrgan);
		
		return somApply;
	}
	/**
	 * @title 封装设立登记信息
	 * @return SomApply
	 */
	private SomApply getBuildInfo() {
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
		somOrgan.setSomHeldPeopleList(somHeldPeopleList);
		somOrgan.setSomHeldOrganList(somHeldOrganList);
		somOrgan.setSomSession(somSession);
		somOrgan.setSomRule(somRule);
		somOrgan.setSomDutyList(somDutyList);
		//维护organ表中联系人与联系电话
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
	 * 封装变更信息
	 * @return
	 */
	private SomChangeApply getChangeInfo() {
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
		
		Record organRecord=(Record)getParameter("organRecord");
		
		Record[] somResumes=(Record[])getParameter("somResume");
		
		//封装变更信息
		for(int i=0;i<changes.length;i++){
			SomChange somChange=(SomChange)changes[i].toBean(SomChange.class);
			changeList.add(somChange);
		}
		Map<String, String> map=new HashMap<String, String>();
		//封装法定代表人信息
		if(somLegalPeople!=null){
			SomDuty somPeople=(SomDuty)somLegalPeople.toBean(SomDuty.class);
			map.put("leaPeopleId", somPeople.getDutyId());
			List<SomPeopleResume> somResumeList = new ArrayList<SomPeopleResume>();
			somPeople.setSomPeopleResumeList(somResumeList);
			if(somResumes != null){
				if(somResumes.length > 0 ){
					for (int i = 0; i < somResumes.length; i++) {
						SomPeopleResume somResume = (SomPeopleResume) somResumes[i].toBean(SomPeopleResume.class);
						somPeople.getSomPeopleResumeList().add(somResume);
					}
				}
			}
			somChangeApply.setSomLegalPeople(somPeople);
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
			SomOrgan somOrgan = (SomOrgan)organRecord.toBean(SomOrgan.class);
			somApply.setSomOrgan(somOrgan);
			somChangeApply.setSomApply(somApply);
		}
		somChangeApply.setMap(map);	
		
		return somChangeApply;
	}
	/**
	 *  封装分支变更信息
	 * @return
	 */
	private SomChangeApply getBranchChange() {
		SomChangeApply somChangeApply=new SomChangeApply();
		List<SomChange> changeList=new ArrayList<SomChange>();
		List<SomPeopleResume> legalResumeList=new ArrayList<SomPeopleResume>();
		Record[] changes=(Record[])getParameter("Changes");
		Record[] legalResumeRecords=(Record[]) getParameter("legalResumeRecords");
		Record somLegalPeople=(Record)getParameter("somLegalPeople");
		String sorgDuties=(String)getParameter("sorgDuties");
		Record somFlow=(Record)getParameter("somApply");
		Record somOrgan=(Record)getParameter("somOrganRecord");
		//封装变更信息
		for(int i=0;i<changes.length;i++){
			SomChange somChange=(SomChange)changes[i].toBean(SomChange.class);
			changeList.add(somChange);
		}
		Map<String, String> map=new HashMap<String, String>();
		//封装法定代表人信息
		if(somLegalPeople!=null){
			SomDuty somPeople=(SomDuty)somLegalPeople.toBean(SomDuty.class);
			//封装简历信息
			if(legalResumeRecords!=null){
				for(int i=0;i<legalResumeRecords.length;i++){
					SomPeopleResume somPeopleResume = (SomPeopleResume) legalResumeRecords[i].toBean(SomPeopleResume.class);
					legalResumeList.add(somPeopleResume);
				}
				somPeople.setSomPeopleResumeList(legalResumeList);
			}
			somChangeApply.setSomLegalPeople(somPeople);
			map.put("leaPeopleId", somPeople.getDutyId());
		}
		
		String legalDutyId=(String)getParameter("legalDutyId");
		map.put("legalDutyId", legalDutyId);
		map.put("sorgDuties", sorgDuties);
		somChangeApply.setSomChange(changeList);
		somChangeApply.setPeopleResumes(legalResumeList);
		SomApply somApply=(SomApply)somFlow.toBean(SomApply.class);
		map.put("taskCode1", somApply.getTaskCode());
		map.put("sorgId", somApply.getSorgId());
		somApply.setSomOrgan((SomOrgan)somOrgan.toBean(SomOrgan.class));
		somChangeApply.setSomApply(somApply);
		somChangeApply.setMap(map);	
		return somChangeApply;
		
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
	 * 封装章程信息
	 * @return
	 */
	private SomApply getRuleInfo() {
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		SomApply somApply = (SomApply) somApplyRecord.toBean(SomApply.class);
		
		Record somOrganRecord = (Record) getParameter("organRecord");
		SomOrgan somOrgan = (SomOrgan) somOrganRecord.toBean(SomOrgan.class);
		
		Record somRuleRecord = (Record) getParameter("somRuleRecord");
		SomRule somRule = (SomRule) somRuleRecord.toBean(SomRule.class);
		somOrgan.setSomRule(somRule);
		
		somApply.setSomOrgan(somOrgan);
		return somApply;
	}
	/**
	 * 封装换届事先报批
	 * @return
	 */
	private SomElection getElection() {
		Record somElectionRecord = (Record) getParameter("somElectionRecord");
		SomElection somElection = (SomElection) somElectionRecord.toBean(SomElection.class);
		
		List<SomAspchief> somAspchiefList = new ArrayList<SomAspchief>();
		Record[] somAspchiefRecord = (Record[]) getParameter("somAspchiefRecord");
		if (somAspchiefRecord != null) {
			for (int i = 0; i < somAspchiefRecord.length; i++) {
				SomAspchief somAspchief = (SomAspchief) somAspchiefRecord[i].toBean(SomAspchief.class);
				somAspchiefList.add(somAspchief);
			}
		}
		somElection.setSomAspchiefList(somAspchiefList);
		return somElection;
	}
	/**
	 * 封装延期换届选举
	 * @return
	 */
	private SomElection getElectionDelay() {
		Record somElectionRecord = (Record) getParameter("somElectionRecord");
		SomElection somElection = (SomElection) somElectionRecord.toBean(SomElection.class);
		return somElection;
	}
	/**
	 * 负责人换届备案
	 * @return
	 */
	private SomApply getSomSession() {
		Record somSessionRecord = (Record) getParameter("somSessionRecord");
		SomSession somSession = (SomSession) somSessionRecord.toBean(SomSession.class);
		List<SomDuty> somDutyList = new ArrayList<SomDuty>();
		Record[] somDutyRecord = (Record[]) getParameter("somDutyRecord");
		Record[] somResumeRecords = (Record[])getParameter("somResumeRecords");
		if (somDutyRecord != null) {
			for (int i = 0; i < somDutyRecord.length; i++) {
				SomDuty somDuty = (SomDuty) somDutyRecord[i].toBean(SomDuty.class);
				//处理个人简历
				if(somResumeRecords != null){
					List<SomPeopleResume> somPeopleResumeList = new ArrayList<SomPeopleResume>();
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
		somSession.setSomDutyList(somDutyList);
		
		
		Record somApplyRecord = (Record) getParameter("applyRecord");
		SomApply somApply = (SomApply) somApplyRecord.toBean(SomApply.class);
		Record organRecord = (Record) getParameter("organRecord");
		SomOrgan somOrgan = (SomOrgan)organRecord.toBean(SomOrgan.class);
		
		somOrgan.setSomSession(somSession);
		somApply.setSomOrgan(somOrgan);
		return somApply;
	}
}
