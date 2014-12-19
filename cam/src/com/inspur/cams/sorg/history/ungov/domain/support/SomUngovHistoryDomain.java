package com.inspur.cams.sorg.history.ungov.domain.support;

import java.math.BigDecimal;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.data.RecordSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.base.dao.ISomDutyElectronicDao;
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
import com.inspur.cams.sorg.base.domain.ISomApplyDomain;
import com.inspur.cams.sorg.base.domain.ISomCertDomain;
import com.inspur.cams.sorg.base.domain.ISomChangeDomain;
import com.inspur.cams.sorg.base.domain.ISomDutyDomain;
import com.inspur.cams.sorg.base.domain.ISomHeldOrganDomain;
import com.inspur.cams.sorg.base.domain.ISomHeldPeopleDomain;
import com.inspur.cams.sorg.base.domain.ISomLiqpeopleDomain;
import com.inspur.cams.sorg.base.domain.ISomOfficeDomain;
import com.inspur.cams.sorg.base.domain.ISomOrganDomain;
import com.inspur.cams.sorg.base.domain.ISomPeopleDomain;
import com.inspur.cams.sorg.base.domain.ISomPeopleResumeDomain;
import com.inspur.cams.sorg.base.domain.ISomRuleDomain;
import com.inspur.cams.sorg.base.domain.ISomSignetDomain;
import com.inspur.cams.sorg.history.ungov.domain.ISomUngovHistoryDomain;
import com.inspur.cams.sorg.util.ApplyType;
import com.inspur.cams.sorg.util.SomDutyDuties;

public class SomUngovHistoryDomain implements ISomUngovHistoryDomain {
	
	@Reference
	private ISomOrganDomain somOrganDomain;
	@Reference
	private ISomApplyDomain somApplyDomain;
	@Reference
	private ISomHeldPeopleDomain somHeldPeopleDomain;
	@Reference
	private ISomHeldOrganDomain somHeldOrganDomain;
	@Reference
	private ISomOfficeDomain somOfficeDomain;
	@Reference
	private ISomRuleDomain somRuleDomain;
	@Reference
	private ISomLiqpeopleDomain somLiqpeopleDomain;
	@Reference
	private ISomDutyDomain somDutyDomain;
	//变更
	@Reference
	private ISomChangeDomain somChangeDomain;
	@Reference
	private ISomPeopleDomain somPeopleDomain;
	@Reference
	private ISomDutyElectronicDao somDutyElectronicDao;
	@Reference
	private ISomPeopleResumeDomain somPeopleResumeDomain;
	
	@Reference
	private ISomCertDomain somCertDomain;
	@Reference
	private ISomSignetDomain somSignetDomain;
	
	//当前时间 DateUtil.getTime();
	//当前日期 DateUtil.getDay();
	//登记管理机关名称 BspUtil.getCorpOrgan().getOrganName();
	//登记管理机关行政区划 BspUtil.getCorpOrgan().getOrganCode();
	//登记管理机关ID BspUtil.getCorpOrgan().getOrganId();
	//受理部门名称 BspUtil.getDeptOrgan().getOrganName();
	//受理部门ID BspUtil.getDeptOrgan().getOrganId();
	//当前登录人 BspUtil.getEmpOrgan().getOrganName();
	//当前登录人Id GetBspInfo.getBspInfo().getUserId();
	
	//---------------------------成立---------------------------
	/**
	 * 保存业务信息
	 */
	public void insertBuildInfo(SomApply applyBean) {
		//保存相关信息
		insertBuildContent(applyBean);
		somApplyDomain.insert(applyBean);
	}
	/**
	 * 更新业务信息
	 */
	public void updateBuildInfo(SomApply applyBean){
		String morgName=BspUtil.getCorpOrgan().getOrganName();
		String morgCode=BspUtil.getCorpOrgan().getOrganCode();
		String createPeople=BspUtil.getEmpOrgan().getOrganName();
		String createTime = DateUtil.getTime();
		
		SomOrgan somOrgan=applyBean.getSomOrgan();
		List<SomDuty> somDutyList = somOrgan.getSomDutyList();
		SomRule somRule=somOrgan.getSomRule();
		SomSession somSession=somOrgan.getSomSession();
		List<SomHeldPeople> heldPeopleList = somOrgan.getSomHeldPeopleList();
		List<SomHeldOrgan> somHeldOrganList = somOrgan.getSomHeldOrganList();
		List<SomOffice> somOfficeList = somOrgan.getSomOfficeList();
		
		somOrgan.setBorgName(applyBean.getBorgName());
		somOrganDomain.updateAndBuildHis(somOrgan,applyBean.getTaskCode());
		somApplyDomain.update(applyBean);
		somRuleDomain.update(somRule);
		
		for (int i = 0; i < heldPeopleList.size(); i++) {
			SomHeldPeople heldPeopleBean = heldPeopleList.get(i);
			if(heldPeopleBean.getId().equals("")){
				heldPeopleBean.setId(IdHelp.getUUID30());
				heldPeopleBean.setTaskCode(applyBean.getTaskCode());
				heldPeopleBean.setSorgId(somOrgan.getSorgId());
				heldPeopleBean.setIfChief("0");
				heldPeopleBean.setMorgName(morgName);
				heldPeopleBean.setMorgArea(morgCode);
				heldPeopleBean.setCreatePeople(createPeople);
				heldPeopleBean.setCreateTime(createTime);
				somHeldPeopleDomain.insert(heldPeopleBean);
			}else{
				if(heldPeopleBean.getState() == Record.STATE_MODIFIED){
					somHeldPeopleDomain.update(heldPeopleBean);
				}
				if(heldPeopleBean.getState() == Record.STATE_DELETED){
					somHeldPeopleDomain.delete(heldPeopleBean.getId());
				}
			}
		}
		for (int i = 0; i < somHeldOrganList.size(); i++) {
			SomHeldOrgan somHeldOrgan = somHeldOrganList.get(i);
			if(somHeldOrgan.getId().equals("")){
				somHeldOrgan.setId(IdHelp.getUUID32());
				somHeldOrgan.setTaskCode(applyBean.getTaskCode());
				somHeldOrgan.setSorgId(somOrgan.getSorgId());
				somHeldOrgan.setMorgName(morgName);
				somHeldOrgan.setMorgArea(morgCode);
				somHeldOrgan.setCreatePeople(createPeople);
				somHeldOrgan.setCreateTime(createTime);
				somHeldOrganDomain.insert(somHeldOrgan);
			}else{
				if(somHeldOrgan.getState() == Record.STATE_MODIFIED){
					somHeldOrganDomain.update(somHeldOrgan);
				}
				if(somHeldOrgan.getState() == Record.STATE_DELETED){
					somHeldOrganDomain.delete(somHeldOrgan.getId());
				}
			}
		}
		for (int i = 0; i < somOfficeList.size(); i++) {
			SomOffice somOffice = somOfficeList.get(i);
			if(somOffice.getId().equals("")){
				somOffice.setId(IdHelp.getUUID30());
				somOffice.setSorgId(somOrgan.getSorgId());
				somOffice.setTaskCode(applyBean.getTaskCode());
				somOffice.setSorgType("M");
				somOffice.setMorgName(morgName);
				somOffice.setMorgArea(morgCode);
				somOffice.setCreatePeople(createPeople);
				somOffice.setCreateTime(createTime);
				somOfficeDomain.insert(somOffice);
			}else{
				if(somOffice.getState() == Record.STATE_MODIFIED){
					somOfficeDomain.update(somOffice);
				}
				if(somOffice.getState() == Record.STATE_DELETED){
					somOfficeDomain.delete(somOffice);
				}
			}
		}
		if(somDutyList.size()>0){
			somDutyDomain.deleteByTaskCode(applyBean.getTaskCode());
			somSession.setSomDutyList(somDutyList);
			somDutyDomain.regUngovPeople(somSession);
			somDutyDomain.updateRegStatus("1",applyBean.getTaskCode());
		}
	}
	//---------------------------变更---------------------------
	/**
	 *  保存社会组织变更信息
	 * @param somChangeApply
	 */
	public void saveChange(SomChangeApply somChangeApply) {
		Map<String, String> map=somChangeApply.getMap();
		SomApply somApply=somChangeApply.getSomApply();
		somApply.setSorgId(map.get("sorgId"));
		somApply.setSorgKind(map.get("sorgKind"));
		somApply.setSorgName(map.get("cnName"));
		somApply.setIfFinish("1");
		somApply.setAcceptOrganId(BspUtil.getCorpOrgan().getOrganId());
		somApply.setAcceptArea(BspUtil.getCorpOrgan().getOrganCode());
		somApply.setAcceptOrganName(BspUtil.getCorpOrgan().getOrganName());
		somApply.setAcceptDeptName(BspUtil.getDeptOrgan().getOrganName());
		somApply.setAcceptDeptId(BspUtil.getDeptOrgan().getOrganId());
		somApply.setAcceptPeopleId(GetBspInfo.getBspInfo().getUserId());
		somApplyDomain.insert(somApply);
		
		saveChangeInfo(somChangeApply);
		
	}
	/**
	 * 更新社会组织变更信息
	 * @param somChangeApply
	 */
	public void updateChange(SomChangeApply somChangeApply) {
		Map<String, String> map=somChangeApply.getMap();
		SomApply somApply=somChangeApply.getSomApply();
		somApply.setSorgKind(map.get("sorgKind"));
		somApply.setSorgName(map.get("cnName"));
		somApplyDomain.update(somApply);
		somChangeDomain.deleteChangeByTaskCode(somApply.getTaskCode());
		somDutyDomain.reNewPeopleInfo(somApply.getTaskCode());
		saveChangeInfo(somChangeApply);
		
	}
	
	/**
	 * 修订社会组织变更信息，只保存change表
	 * @param somChangeApply
	 */
	public void updateChangeOnly(SomChangeApply somChangeApply) {
		Map<String, String> map=somChangeApply.getMap();
		SomApply somApply=somChangeApply.getSomApply();
		somApply.setSorgKind(map.get("sorgKind"));
		somApply.setSorgName(map.get("cnName"));
		somApplyDomain.update(somApply);
		somChangeDomain.deleteChangeByTaskCode(somApply.getTaskCode());
		somDutyDomain.reNewPeopleInfo(somApply.getTaskCode());
		saveChangeOnly(somChangeApply);
		
	}
	
	private void saveChangeOnly(SomChangeApply somChangeApply) {
		Map<String, String> map=somChangeApply.getMap();
		List<SomChange> changes=somChangeApply.getSomChange();
		for(int i=0;i<changes.size();i++){
			SomChange somchange=changes.get(i);
			somchange.setTaskCode(somChangeApply.getSomApply().getTaskCode());
			somchange.setId(IdHelp.getUUID32());
			somchange.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
			somchange.setMorgName(BspUtil.getCorpOrgan().getOrganName());
			somchange.setSorgId(map.get("sorgId"));
			somchange.setChangeStatus("1");
			somChangeDomain.insert(somchange);//插入变更信息
		}
	}
	//---------------------------注销---------------------------
	/**
	 * 新增注销
	 * 
	 * @param somApply
	 */
	public void saveCancel(SomApply somApply) {
		// 修改社会组织信息
		SomOrgan somOrgan = somApply.getSomOrgan();
		somOrgan.setSorgStatus("32");

		// 保存业务信息
		somApply.setSorgId(somOrgan.getSorgId());
		somApply.setApplyType(ApplyType.SOM_UNGOV_CANCEL);
		somApply.setSorgType(somOrgan.getSorgType());
		somApply.setSorgKind(somOrgan.getSorgKind());
		somApply.setSorgName(somOrgan.getCnName());
		somApply.setBorgName(somOrgan.getBorgName());
		somApply.setIfFinish("1");
		somApply.setAcceptArea(BspUtil.getCorpOrgan().getOrganCode());
		somApply.setAcceptOrganId(BspUtil.getCorpOrgan().getOrganId());
		somApply.setAcceptArea(BspUtil.getCorpOrgan().getOrganCode());
		somApply.setAcceptOrganName(BspUtil.getCorpOrgan().getOrganName());
		somApply.setAcceptDeptName(BspUtil.getDeptOrgan().getOrganName());
		somApply.setAcceptDeptId(BspUtil.getDeptOrgan().getOrganId());
		somApply.setAcceptPeopleId(GetBspInfo.getBspInfo().getUserId());
		// somApply.setAcceptOrganId(BspUtil.getCorpOrganId());
		// somApply.setAcceptOrganName(BspUtil.getCorpOrgan().getOrganName());
		// somApply.setAcceptDeptId(BspUtil.getDeptOrganId());
		// somApply.setAcceptDeptName(BspUtil.getDeptOrgan().getOrganName());
		// somApply.setAcceptPeopleId(BspUtil.getEmpOrganId());

		// 保存所有信息
		somOrganDomain.updateAndBuildHis(somOrgan,somApply.getTaskCode());
		dealSomLiqpeople(somApply);
		somApplyDomain.insert(somApply);
		// 注销社会组织成员
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SORG_ID", somOrgan.getSorgId());
		pset.setParameter("IF_SERVE", "1");
		DataSet dutyDs = somDutyDomain.query(pset);
		for (int i = 0; i < dutyDs.getCount(); i++) {
			SomDuty somDuty = (SomDuty) dutyDs.getRecord(i).toBean(
					SomDuty.class);
			somDuty.setIfServe("0");
			somDutyDomain.update(somDuty);
		}
	}
	
	/**
	 * 修改注销
	 * 
	 * @param somApply
	 */
	public void updateCancel(SomApply somApply) {
		SomOrgan somOrgan = somApply.getSomOrgan();
		// 保存所有信息
		somOrganDomain.updateAndBuildHis(somOrgan,somApply.getTaskCode());
		dealSomLiqpeople(somApply);
		somApplyDomain.update(somApply);
	}
	
	/**
	 * 处理清算组织人员
	 * 
	 * @param somApply
	 */	
	private void dealSomLiqpeople(SomApply somApply) {
		SomOrgan somOrgan = somApply.getSomOrgan();
		List<SomLiqpeople> somHeldPeopleList = somOrgan.getSomLiqpeopleList();
		for (int i = 0; i < somHeldPeopleList.size(); i++) {
			SomLiqpeople somLiqpeople = somHeldPeopleList.get(i);
			if (somLiqpeople.getState() == Record.STATE_NEW) {
				somLiqpeople.setId(IdHelp.getUUID30());
				somLiqpeople.setSorgId(somOrgan.getSorgId());
				somLiqpeopleDomain.insert(somLiqpeople);
			} else if (somLiqpeople.getState() == Record.STATE_MODIFIED) {
				somLiqpeopleDomain.update(somLiqpeople);
			} else if (somLiqpeople.getState() == Record.STATE_DELETED) {
				somLiqpeopleDomain.delete(somLiqpeople.getId());
			}
		}
	}
	//-----------------------------------------私有方法-----------------------------------------------
	/**
	 * 保存业务信息
	 */
	private void insertBuildContent(SomApply applyBean) {	
		SomOrgan somOrgan=applyBean.getSomOrgan();
		List<SomDuty> somDutyList = somOrgan.getSomDutyList();
		List<SomHeldPeople> somHeldPeopleList = somOrgan.getSomHeldPeopleList();
		List<SomHeldOrgan> somHeldOrganList = somOrgan.getSomHeldOrganList();
		List<SomOffice> somOfficeList = somOrgan.getSomOfficeList();
		SomRule somRule=somOrgan.getSomRule();
		SomSession somSession=new SomSession();
		somSession.setSessionId("");
		
		String morgName=BspUtil.getCorpOrgan().getOrganName();
		String morgCode=BspUtil.getCorpOrgan().getOrganCode();
		String createPeople=BspUtil.getEmpOrgan().getOrganName();
		String createTime = DateUtil.getTime();
		String taskCode=applyBean.getTaskCode();
		String sorgId=somOrgan.getSorgId();		
		
		somOrgan.setSorgStatus("22");
		somOrgan.setSorgType("M");
		somOrgan.setIfBranch("0");
		somOrgan.setMorgName(BspUtil.getCorpOrgan().getOrganName());
		somOrgan.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
		somOrgan.setBorgName(applyBean.getBorgName());
		somOrganDomain.insertAndBuildHis(somOrgan,applyBean.getTaskCode());
		somSession.setTaskCode(taskCode);
		somSession.setSorgId(sorgId);
		somSession.setSeq("1");//顺序号
		somSession.setSomDutyList(somDutyList);
		if(somDutyList.size()>0){
			somDutyDomain.regUngovPeople(somSession);
			somDutyDomain.updateRegStatus("1",applyBean.getTaskCode());
		}
		for(int i=0;i<somHeldPeopleList.size();i++){
			SomHeldPeople somHeldPeople=somHeldPeopleList.get(i);
			if(somHeldPeople.getState() == Record.STATE_DELETED){
				continue;
			}
			somHeldPeople.setId(IdHelp.getUUID32());
			somHeldPeople.setTaskCode(taskCode);
			somHeldPeople.setSorgId(sorgId);
			somHeldPeople.setIfChief("0");
			somHeldPeople.setMorgName(morgName);
			somHeldPeople.setMorgArea(morgCode);
			somHeldPeople.setCreatePeople(createPeople);
			somHeldPeople.setCreateTime(createTime);
			somHeldPeopleDomain.insert(somHeldPeople);
		}
		for(int i=0;i<somHeldOrganList.size();i++){
			SomHeldOrgan somHeldOrgan=somHeldOrganList.get(i);
			if(somHeldOrgan.getState() == Record.STATE_DELETED){
				continue;
			}
			somHeldOrgan.setId(IdHelp.getUUID32());
			somHeldOrgan.setTaskCode(taskCode);
			somHeldOrgan.setSorgId(sorgId);
			somHeldOrgan.setMorgName(morgName);
			somHeldOrgan.setMorgArea(morgCode);
			somHeldOrgan.setCreatePeople(createPeople);
			somHeldOrgan.setCreateTime(createTime);
			somHeldOrganDomain.insert(somHeldOrgan);
		}
		for(int i=0;i<somOfficeList.size();i++){
			SomOffice somOffice=somOfficeList.get(i);
			somOffice.setSorgId(sorgId);
			somOffice.setTaskCode(taskCode);
			somOffice.setSorgType("M");
			somOfficeDomain.insert(somOffice);
		}
		somRule.setSorgId(sorgId);
		somRule.setTaskCode(taskCode);
		somRule.setRegStatus("1");//有效
		somRule.setIfDraft("0");
		somRuleDomain.insert(somRule);
		applyBean.setSorgId(sorgId);
		applyBean.setSorgType("M");
		applyBean.setSorgKind(somOrgan.getSorgKind());
		applyBean.setSorgName(somOrgan.getCnName());
		applyBean.setIfFinish("1");
		applyBean.setDataSource("MEND");
		applyBean.setAcceptOrganId(BspUtil.getCorpOrganId());
		applyBean.setAcceptOrganName(BspUtil.getCorpOrgan().getOrganName());
		applyBean.setAcceptArea(morgCode);
		applyBean.setAcceptDeptId(BspUtil.getDeptOrganId());
		applyBean.setAcceptDeptName(BspUtil.getDeptOrgan().getOrganName());
		applyBean.setAcceptPeopleId(GetBspInfo.getBspInfo().getUserId());
	}
	
	private void saveChangeInfo(SomChangeApply somChangeApply) {
		Map<String, String> map=somChangeApply.getMap();
		List<SomChange> changes=somChangeApply.getSomChange();
		List<SomPeopleResume> peopleResumes=somChangeApply.getPeopleResumes();
		ParameterSet pset=new ParameterSet();
		pset.setParameter("SORG_ID",map.get("sorgId"));
		DataSet DataSet = somOrganDomain.query(pset);
		Record record =(Record)  DataSet.getRecord(0);
		SomOrgan somOrgan= (SomOrgan) record.toBean(SomOrgan.class);//社会组织
		for(int i=0;i<changes.size();i++){
			SomChange somchange=changes.get(i);
			somchange.setTaskCode(somChangeApply.getSomApply().getTaskCode());
			somchange.setId(IdHelp.getUUID32());
			somchange.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
			somchange.setMorgName(BspUtil.getCorpOrgan().getOrganName());
			somchange.setSorgId(map.get("sorgId"));
			somchange.setChangeStatus("1");
			somChangeDomain.insert(somchange);//插入变更信息
			//对社会组织进行更新
			if(somchange.getChangeItem().equals("0")){//名称
				somOrgan.setCnName(somchange.getChangeAfter());
				somApplyDomain.updateSomApplyInfo(somOrgan);//
			}else if(somchange.getChangeItem().equals("1")){ //住所变更
				String[] s=somchange.getChangeAfter().split(";",-1);
				if(s[0]!=null &&!"".equals(s[0])){
					somOrgan.setResideSource(s[0]);//住所来源,
				}if(s[1]!=null &&!"".equals(s[1])){
					somOrgan.setResidence(s[1]);//变更住所
				}if(s[2]!=null &&!"".equals(s[2])){
					somOrgan.setHousingOrgan(s[2]);//产权单位 
				}if(s[3]!=null &&!"".equals(s[3])){
					somOrgan.setHousingArea(new BigDecimal(s[3]));//用房面积
				}if(s[4]!=null &&!"".equals(s[4])){
					somOrgan.setLeasePeriod(s[4]);//租借期限
				}	
			}else if(somchange.getChangeItem().equals("2")){//变更法定代表人
				somOrgan.setLegalPeople(somchange.getChangeAfter());
			}else if(somchange.getChangeItem().equals("3")){//变更业务范围
				somOrgan.setBusiness(somchange.getChangeAfter());//变更业务范围
			}else if(somchange.getChangeItem().equals("4")){ //资金变更
				String[] s=somchange.getChangeAfter().split(";",-1);
				if(s[0]!=null &&!"".equals(s[0])){
					somOrgan.setMoneySource(s[0]);//资金来源
				}if(s[1]!=null &&!"".equals(s[1])){
					somOrgan.setRegMon(s[1]);//变更注册资金
				}
			}else if(somchange.getChangeItem().equals("5")){//变更业务主管单位
				somOrgan.setBorgName(somchange.getChangeAfter());
			}else if(somchange.getChangeItem().equals("6")){//变更出资人
				somOrgan.setFundingPeople(somchange.getChangeAfter());
			}
		}
		somOrganDomain.updateAndBuildHis(somOrgan,somChangeApply.getSomApply().getTaskCode());
		
		SomDuty people=somChangeApply.getSomLegalPeople();
		if(people != null){
			//把在任的法定代表人维护为卸任
			pset.clear();
			pset.setParameter("SORG_ID",map.get("sorgId"));
			pset.setParameter("IF_SERVE", "1");
			pset.setParameter("REG_STATUS", "1");//有效的
			pset.setParameter("SORG_DUTIES", SomDutyDuties.SOM_LEGAL_PEOPLE);
			DataSet memberDatasets=somDutyDomain.queryPeople(pset);
			RecordSet memrecords=memberDatasets.getRecordSet();
			Iterator<Record> mems= memrecords.iterator();//变更
			while(mems.hasNext()){
				SomDuty somDuty=(SomDuty)mems.next().toBean(SomDuty.class);
				somDuty.setIfServe("0");//卸任
				somDuty.setRegStatus("2");//备案状态为历史
				somDuty.setEndDate(DateUtil.getDay());
				somDutyDomain.update(somDuty);
			}
			
			String peopleId=somPeopleDomain.create(people.getSomPeople());
			// 维护任职信息
			String oldDutyId=map.get("legalDutyId");
			people.setDutyId(IdHelp.getUUID32());
			if(oldDutyId!=null){
				somDutyElectronicDao.updateDutyId(oldDutyId, people.getDutyId());
			}
			people.setTaskCode(map.get("taskCode1"));
			people.setSorgId(map.get("sorgId"));
			people.setPeopleId(peopleId);
			people.setRegStatus("1");
			people.setIfServe("1");
			people.setSorgType("M");//民非
			people.setSorgDuties(SomDutyDuties.SOM_LEGAL_PEOPLE);
			people.setCreateTime(DateUtil.getTime());
			people.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
			people.setMorgName(BspUtil.getCorpOrgan().getOrganName());
			people.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
			somDutyDomain.insert(people);
		}	
		somPeopleResumeDomain.deleteResume(map.get("taskCode1"));//清空人员简历信息
		if(peopleResumes!=null){
			for (int i = 0; i < peopleResumes.size(); i++) {
				SomPeopleResume somPeopleResume = peopleResumes.get(i);
				somPeopleResume.setId(IdHelp.getUUID32());
				somPeopleResume.setTaskCode(map.get("taskCode1"));
				somPeopleResume.setDutyId(map.get("legalDutyId"));
				somPeopleResumeDomain.insert(somPeopleResume);
			}
		}
	}
}
