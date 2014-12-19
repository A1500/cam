package com.inspur.cams.sorg.base.domain.support;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.loushang.bsp.share.organization.bean.OrganView;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.data.RecordSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.base.dao.ISomAspchiefDao;
import com.inspur.cams.sorg.base.dao.ISomDutyDao;
import com.inspur.cams.sorg.base.dao.ISomDutyElectronicDao;
import com.inspur.cams.sorg.base.dao.ISomPeopleResumeDao;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomAspchief;
import com.inspur.cams.sorg.base.data.SomDuty;
import com.inspur.cams.sorg.base.data.SomElectronic;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.data.SomPeople;
import com.inspur.cams.sorg.base.data.SomPeopleResume;
import com.inspur.cams.sorg.base.data.SomSession;
import com.inspur.cams.sorg.base.domain.ISomApplyDomain;
import com.inspur.cams.sorg.base.domain.ISomChangeDomain;
import com.inspur.cams.sorg.base.domain.ISomDutyDomain;
import com.inspur.cams.sorg.base.domain.ISomElectronicDomain;
import com.inspur.cams.sorg.base.domain.ISomOrganDomain;
import com.inspur.cams.sorg.base.domain.ISomPeopleDomain;
import com.inspur.cams.sorg.base.domain.ISomSessionDomain;
import com.inspur.cams.sorg.util.ApplyType;
import com.inspur.cams.sorg.util.SomDutyDuties;
import com.inspur.cams.sorg.util.SomIdHelp;

/**
 * 社会组织任职信息表domain实现类
 * 
 * @author yanliangliang
 * @date 2011-9-20
 */
public class SomDutyDomain implements ISomDutyDomain {

	@Reference
	private ISomApplyDomain somApplyDomain;

	@Reference
	private ISomSessionDomain somSessionDomain;

	@Reference
	private ISomDutyDao somDutyDao;

	@Reference
	private ISomPeopleDomain somPeopleDomain;
	@Reference
	private ISomOrganDomain somOrganDomain;
	
	@Reference
	private ISomPeopleResumeDao somPeopleResumeDao;
	@Reference
	private ISomAspchiefDao somAspchiefDao;
	@Reference
	private ISomDutyElectronicDao somDutyElectronicDao;
	@Reference
	private ISomChangeDomain somChangeDomain;
	@Reference
	private ISomElectronicDomain somElectronicDomain;
	/**
	 * 查询社会组织成员
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return somDutyDao.query(pset);
	}

	/**
	 * 查询社会组织成员
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryPeople(ParameterSet pset) {
		return somDutyDao.queryPeople(pset);
	}
	
	/**
	 * 综合查询人员信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryTogether(ParameterSet pset) {
		return somDutyDao.queryTogether(pset);
	}
	
	/**
	 * 查询任职信息
	 * @param pset
	 * @return
	 */
	public DataSet queryDutyInfo(ParameterSet pset) {
		return somDutyDao.queryDutyInfo(pset);
	}

	/**
	 * 增加社会组织成员
	 * 
	 * @param somDuty
	 */
	public void insert(SomDuty somDuty) {
		somDutyDao.insert(somDuty);
	}
	
	/**
	 * 更新社会组织成员
	 * 
	 * @param dataBean
	 */
	public void update(SomDuty somDuty) {
		somDutyDao.update(somDuty);
	}
	
	/**
	 * 增加人员
	 * 
	 * @param somDuty
	 */
	public void createPeople(SomDuty somDuty) {
		String peopleId =createPeople(somDuty.getSomPeople());
		somDuty.setDutyId(IdHelp.getUUID32());
		somDuty.setPeopleId(peopleId);
		somDuty.setMorgName(BspUtil.getCorpOrgan().getOrganName());
		somDuty.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
		somDuty.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
		somDuty.setCreateTime(DateUtil.getTime());
		somDutyDao.insert(somDuty);
	}
	/**
	 * 社会组织成立备案 somSession需填写社会组织编号、业务编号、顺序号
	 * 
	 * @param somSession
	 */
	public void regPeople(SomSession somSession){
		OrganView corpOrgan = BspUtil.getCorpOrgan();
		OrganView empOrgan = BspUtil.getEmpOrgan();
		String time = DateUtil.getTime();
		if(somSession.getSessionId().equals("")||somSession.getDealType().equals("insert")){
			if(!somSession.getDealType().equals("insert")){
				somSession.setSessionId(IdHelp.getUUID32());
			}
			somSession.setMorgName(corpOrgan.getOrganName());
			somSession.setMorgArea(corpOrgan.getOrganCode());
			somSession.setCreatePeople(empOrgan.getOrganName());
			somSession.setCreateTime(time);
			somSessionDomain.insert(somSession);
		}else{
			somSessionDomain.update(somSession);
		}
		SomDuty legalPeople = new SomDuty();
		String legalPeopleId = "";
		List<SomPeopleResume> somLegalResume=new ArrayList<SomPeopleResume>();
		
		List<SomDuty> somDutyList = somSession.getSomDutyList();
	//	somPeopleResumeDao.deleteResume(somSession.getTaskCode());
		for (int i = 0; i < somDutyList.size(); i++) {
			SomDuty somDuty = (SomDuty) somDutyList.get(i);
			if(somDuty.getDutyId() ==null || "".equals(somDuty.getDutyId())){
				continue;
			}
			if (SomDutyDuties.SOM_LEGAL_PEOPLE.equals(somDuty.getSorgDuties())) {
				legalPeople = somDuty;
				continue;
			}
			// 人员建档
			String peopleId =createPeople(somDuty.getSomPeople());
			if ("1".equals(somDuty.getIfLegal())) {
				legalPeopleId = peopleId;
			}
			// 维护任职信息
			String oldDutyId=somDuty.getDutyId();
			somPeopleResumeDao.deleteResumeByDutyId(oldDutyId);
			somDuty.setDutyId(IdHelp.getUUID32());
			if(oldDutyId!=null){
				somDutyElectronicDao.updateDutyId(oldDutyId, somDuty.getDutyId());
			}
			somDuty.setTaskCode(somSession.getTaskCode());
			somDuty.setSorgId(somSession.getSorgId());
			somDuty.setPeopleId(peopleId);
			somDuty.setSessionId(somSession.getSessionId());
			if(somDuty.getIfServe() == ""){
				somDuty.setIfServe("1");
			}
			somDuty.setIfRenew("0");
			somDuty.setRenewNum("0");
			somDuty.setRegStatus("3");
			somDuty.setMorgName(corpOrgan.getOrganName());
			somDuty.setMorgArea(corpOrgan.getOrganCode());
			somDuty.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
			somDuty.setCreateTime(DateUtil.getTime());
			somDutyDao.insert(somDuty);
			List<SomPeopleResume> somPeopleResumeList = somDuty.getSomPeopleResumeList();
			if("1".equals(somDuty.getIfLegal())){
				somLegalResume=somPeopleResumeList;
			}
			for(int j = 0; j < somPeopleResumeList.size(); j++){
				SomPeopleResume somPeopleResume = (SomPeopleResume) somPeopleResumeList.get(j);
				somPeopleResume.setId(IdHelp.getUUID32());
				somPeopleResume.setDutyId(somDuty.getDutyId());
				somPeopleResume.setPeopleId(peopleId);
				somPeopleResume.setTaskCode(somSession.getTaskCode());
				somPeopleResumeDao.insert(somPeopleResume);
			}
		}
		if(legalPeople.getName() != null){
			String oldDutyId=legalPeople.getDutyId();
			legalPeople.setDutyId(IdHelp.getUUID32());
			if(oldDutyId!=null){
				somDutyElectronicDao.updateDutyId(oldDutyId, legalPeople.getDutyId());
			}
			
			legalPeople.setTaskCode(somSession.getTaskCode());
			legalPeople.setSorgId(somSession.getSorgId());
			legalPeople.setPeopleId(legalPeopleId);
			createPeople(legalPeople.getSomPeople());// 保存法定代表人照片
			legalPeople.setSessionId(somSession.getSessionId());
			if(legalPeople.getIfServe() == ""){
				legalPeople.setIfServe("1");
			}
			legalPeople.setIfRenew("0");
			legalPeople.setRenewNum("0");
			legalPeople.setRegStatus("3");
			legalPeople.setMorgName(corpOrgan.getOrganName());
			legalPeople.setMorgArea(corpOrgan.getOrganCode());
			legalPeople.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
			legalPeople.setCreateTime(DateUtil.getTime());
			somDutyDao.insert(legalPeople);
			for(int j = 0; j < somLegalResume.size(); j++){
				SomPeopleResume somPeopleResume = (SomPeopleResume) somLegalResume.get(j);
				somPeopleResume.setId(IdHelp.getUUID32());
				somPeopleResume.setDutyId(legalPeople.getDutyId());
				somPeopleResume.setPeopleId(legalPeopleId);
				somPeopleResume.setTaskCode(somSession.getTaskCode());
				somPeopleResumeDao.insert(somPeopleResume);
			}
		}
	}
	/**
	 * 民办非企业单位保存人员
	 */
	public void regUngovPeople(SomSession somSession){
		OrganView corpOrgan = BspUtil.getCorpOrgan();
		OrganView empOrgan = BspUtil.getEmpOrgan();
		String time = DateUtil.getTime();
		if(somSession.getSessionId().equals("")){
			somSession.setSessionId(IdHelp.getUUID32());
			somSession.setMorgName(corpOrgan.getOrganName());
			somSession.setMorgArea(corpOrgan.getOrganCode());
			somSession.setCreatePeople(empOrgan.getOrganName());
			somSession.setCreateTime(time);
			somSessionDomain.insert(somSession);
		}else{
			somSessionDomain.update(somSession);
		}
		SomDuty legalPeople = new SomDuty();
		String legalPeopleId = "";
		List<SomDuty> somDutyList = somSession.getSomDutyList();
		somPeopleResumeDao.deleteResume(somSession.getTaskCode());
		for (int i = 0; i < somDutyList.size(); i++) {
			SomDuty somDuty = (SomDuty) somDutyList.get(i);
			if(somDuty.getDutyId() ==null || "".equals(somDuty.getDutyId())){
				continue;
			}
			if (SomDutyDuties.SOM_LEGAL_PEOPLE.equals(somDuty.getSorgDuties())) {
				legalPeople = somDuty;
				continue;
			}
			// 人员建档
			String peopleId =createPeople(somDuty.getSomPeople());
			if ("1".equals(somDuty.getIfLegal())) {
				legalPeopleId = peopleId;
			}
			// 维护任职信息
			String oldDutyId=somDuty.getDutyId();
			somPeopleResumeDao.deleteResumeByDutyId(oldDutyId);
			somDuty.setDutyId(IdHelp.getUUID32());
			if(oldDutyId!=null){
				somDutyElectronicDao.updateDutyId(oldDutyId, somDuty.getDutyId());
			}
			somDuty.setTaskCode(somSession.getTaskCode());
			somDuty.setSorgId(somSession.getSorgId());
			somDuty.setPeopleId(peopleId);
			somDuty.setSessionId(somSession.getSessionId());
			somDuty.setIfServe("1");
			somDuty.setIfRenew("0");
			somDuty.setRenewNum("0");
			somDuty.setRegStatus("3");
			somDuty.setMorgName(corpOrgan.getOrganName());
			somDuty.setMorgArea(corpOrgan.getOrganCode());
			somDuty.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
			somDuty.setCreateTime(DateUtil.getTime());
			somDutyDao.insert(somDuty);
		}
		if(legalPeople.getName() != null){
			String oldDutyId=legalPeople.getDutyId();
			legalPeople.setDutyId(IdHelp.getUUID32());
			if(oldDutyId!=null){
				somDutyElectronicDao.updateDutyId(oldDutyId, legalPeople.getDutyId());
			}
			
			legalPeople.setTaskCode(somSession.getTaskCode());
			legalPeople.setSorgId(somSession.getSorgId());
			legalPeople.setPeopleId(legalPeopleId);
			createPeople(legalPeople.getSomPeople());// 保存法定代表人照片
			legalPeople.setSessionId(somSession.getSessionId());
			legalPeople.setIfServe("1");
			legalPeople.setIfRenew("0");
			legalPeople.setRenewNum("0");
			legalPeople.setRegStatus("3");
			legalPeople.setMorgName(corpOrgan.getOrganName());
			legalPeople.setMorgArea(corpOrgan.getOrganCode());
			legalPeople.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
			legalPeople.setCreateTime(DateUtil.getTime());
			somDutyDao.insert(legalPeople);
			List<SomPeopleResume> somLegalResume = legalPeople.getSomPeopleResumeList();
			for(int j = 0; j < somLegalResume.size(); j++){
				SomPeopleResume somPeopleResume = (SomPeopleResume) somLegalResume.get(j);
				somPeopleResume.setId(IdHelp.getUUID32());
				somPeopleResume.setDutyId(legalPeople.getDutyId());
				somPeopleResume.setPeopleId(legalPeopleId);
				somPeopleResume.setTaskCode(somSession.getTaskCode());
				somPeopleResumeDao.insert(somPeopleResume);
			}
		}
	}
	
	public void regPeopleOnline(SomSession somSession){
		String time = DateUtil.getTime();
		if(somSession.getSessionId().equals("")){
			somSession.setSessionId(IdHelp.getUUID32());
			somSession.setCreateTime(time);
			somSessionDomain.insert(somSession);
		}else{
			somSessionDomain.update(somSession);
		}
		SomDuty legalPeople = new SomDuty();
		String legalPeopleId = "";
		List<SomPeopleResume> somLegalResume=new ArrayList<SomPeopleResume>();
		
		List<SomDuty> somDutyList = somSession.getSomDutyList();
		somPeopleResumeDao.deleteResume(somSession.getTaskCode());
		for (int i = 0; i < somDutyList.size(); i++) {
			SomDuty somDuty = (SomDuty) somDutyList.get(i);
			if(somDuty.getDutyId() ==null || "".equals(somDuty.getDutyId())){
				continue;
			}
			if (SomDutyDuties.SOM_LEGAL_PEOPLE.equals(somDuty.getSorgDuties())) {
				legalPeople = somDuty;
				continue;
			}
			// 人员建档
			String peopleId =createPeople(somDuty.getSomPeople());
			if ("1".equals(somDuty.getIfLegal())) {
				legalPeopleId = peopleId;
			}
			// 维护任职信息
			String oldDutyId=somDuty.getDutyId();
			somPeopleResumeDao.deleteResumeByDutyId(oldDutyId);
			somDuty.setDutyId(IdHelp.getUUID32());
			if(oldDutyId!=null){
				somDutyElectronicDao.updateDutyId(oldDutyId, somDuty.getDutyId());
			}
			somDuty.setTaskCode(somSession.getTaskCode());
			somDuty.setSorgId(somSession.getSorgId());
			somDuty.setPeopleId(peopleId);
			somDuty.setSessionId(somSession.getSessionId());
			somDuty.setIfServe("1");
			somDuty.setIfRenew("0");
			somDuty.setRenewNum("0");
			somDuty.setRegStatus("3");
			somDuty.setCreateTime(DateUtil.getTime());
			somDutyDao.insert(somDuty);
			List<SomPeopleResume> somPeopleResumeList = somDuty.getSomPeopleResumeList();
			if("1".equals(somDuty.getIfLegal())){
				somLegalResume=somPeopleResumeList;
			}
			for(int j = 0; j < somPeopleResumeList.size(); j++){
				SomPeopleResume somPeopleResume = (SomPeopleResume) somPeopleResumeList.get(j);
				somPeopleResume.setId(IdHelp.getUUID32());
				somPeopleResume.setDutyId(somDuty.getDutyId());
				somPeopleResume.setPeopleId(peopleId);
				somPeopleResume.setTaskCode(somSession.getTaskCode());
				somPeopleResumeDao.insert(somPeopleResume);
			}
		}
		if(legalPeople.getName() != null){
			String oldDutyId=legalPeople.getDutyId();
			legalPeople.setDutyId(IdHelp.getUUID32());
			if(oldDutyId!=null){
				somDutyElectronicDao.updateDutyId(oldDutyId, legalPeople.getDutyId());
			}
			
			legalPeople.setTaskCode(somSession.getTaskCode());
			legalPeople.setSorgId(somSession.getSorgId());
			legalPeople.setPeopleId(legalPeopleId);
			createPeople(legalPeople.getSomPeople());// 保存法定代表人照片
			legalPeople.setSessionId(somSession.getSessionId());
			legalPeople.setIfServe("1");
			legalPeople.setIfRenew("0");
			legalPeople.setRenewNum("0");
			legalPeople.setRegStatus("3");
			legalPeople.setCreateTime(DateUtil.getTime());
			somDutyDao.insert(legalPeople);
			for(int j = 0; j < somLegalResume.size(); j++){
				SomPeopleResume somPeopleResume = (SomPeopleResume) somLegalResume.get(j);
				somPeopleResume.setId(IdHelp.getUUID32());
				somPeopleResume.setDutyId(legalPeople.getDutyId());
				somPeopleResume.setPeopleId(legalPeopleId);
				somPeopleResume.setTaskCode(somSession.getTaskCode());
				somPeopleResumeDao.insert(somPeopleResume);
			}
		}
	}
	/**
	 * 保存民非外网申请人员信息
	 */
	public void regUngovPeopleOnline(SomSession somSession){
		String time = DateUtil.getTime();
		if(somSession.getSessionId().equals("")){
			somSession.setSessionId(IdHelp.getUUID32());
			somSession.setCreateTime(time);
			somSessionDomain.insert(somSession);
		}else{
			somSessionDomain.update(somSession);
		}
		SomDuty legalPeople = new SomDuty();
		String legalPeopleId = "";
		List<SomDuty> somDutyList = somSession.getSomDutyList();
		somPeopleResumeDao.deleteResume(somSession.getTaskCode());
		for (int i = 0; i < somDutyList.size(); i++) {
			SomDuty somDuty = (SomDuty) somDutyList.get(i);
			if(somDuty.getDutyId() ==null || "".equals(somDuty.getDutyId())){
				continue;
			}
			if (SomDutyDuties.SOM_LEGAL_PEOPLE.equals(somDuty.getSorgDuties())) {
				legalPeople = somDuty;
				continue;
			}
			// 人员建档
			String peopleId =createPeople(somDuty.getSomPeople());
			if ("1".equals(somDuty.getIfLegal())) {
				legalPeopleId = peopleId;
			}
			// 维护任职信息
			String oldDutyId=somDuty.getDutyId();
			somPeopleResumeDao.deleteResumeByDutyId(oldDutyId);
			somDuty.setDutyId(IdHelp.getUUID32());
			if(oldDutyId!=null){
				somDutyElectronicDao.updateDutyId(oldDutyId, somDuty.getDutyId());
			}
			somDuty.setTaskCode(somSession.getTaskCode());
			somDuty.setSorgId(somSession.getSorgId());
			somDuty.setPeopleId(peopleId);
			somDuty.setSessionId(somSession.getSessionId());
			somDuty.setIfServe("1");
			somDuty.setIfRenew("0");
			somDuty.setRenewNum("0");
			somDuty.setRegStatus("3");
			somDuty.setCreateTime(DateUtil.getTime());
			somDutyDao.insert(somDuty);
		}
		if(legalPeople.getName() != null){
			String oldDutyId=legalPeople.getDutyId();
			legalPeople.setDutyId(IdHelp.getUUID32());
			if(oldDutyId!=null){
				somDutyElectronicDao.updateDutyId(oldDutyId, legalPeople.getDutyId());
			}
			
			legalPeople.setTaskCode(somSession.getTaskCode());
			legalPeople.setSorgId(somSession.getSorgId());
			legalPeople.setPeopleId(legalPeopleId);
			createPeople(legalPeople.getSomPeople());// 保存法定代表人照片
			legalPeople.setSessionId(somSession.getSessionId());
			legalPeople.setIfServe("1");
			legalPeople.setIfRenew("0");
			legalPeople.setRenewNum("0");
			legalPeople.setRegStatus("3");
			legalPeople.setCreateTime(DateUtil.getTime());
			somDutyDao.insert(legalPeople);
			List<SomPeopleResume> somLegalResume = legalPeople.getSomPeopleResumeList();
			for(int j = 0; j < somLegalResume.size(); j++){
				SomPeopleResume somPeopleResume = (SomPeopleResume) somLegalResume.get(j);
				somPeopleResume.setId(IdHelp.getUUID32());
				somPeopleResume.setDutyId(legalPeople.getDutyId());
				somPeopleResume.setPeopleId(legalPeopleId);
				somPeopleResume.setTaskCode(somSession.getTaskCode());
				somPeopleResumeDao.insert(somPeopleResume);
			}
		}
	}
	public String createPeople(SomPeople somPeople) {
		return somPeopleDomain.create(somPeople);
	}

	/**
	 * 修改负责人备案信息
	 * 
	 * @param somSession
	 */
	public void updateRegPeople(SomSession somSession) {
		OrganView corpOrgan = BspUtil.getCorpOrgan();
		OrganView empOrgan = BspUtil.getEmpOrgan();
		String time = DateUtil.getTime();
		String sorgId = somSession.getSorgId();
		ParameterSet pset=new ParameterSet();
		pset.setParameter("SORG_ID", sorgId);
		somSessionDomain.update(somSession);
		List<SomDuty> somDutyList = somSession.getSomDutyList();
		deleteDutyBySessionId(somSession.getSessionId());//先删除原来的任职信息
		for (int i = 0; i < somDutyList.size(); i++) {
			SomDuty somDuty = (SomDuty) somDutyList.get(i);
			// 人员建档
			//如果不是法定代表人的修改people信息，因为法定代表人的people信息和某个负责人相同，所以只用负责人的修改people信息就可以
			String peopleId = somDuty.getPeopleId();
			if(!somDuty.getSorgDuties().equals("00012")){
				peopleId = somPeopleDomain.create(somDuty.getSomPeople());
				somDuty.setPeopleId(peopleId);
			}
			String oldDutyId=somDuty.getDutyId();
			somDuty.setDutyId(IdHelp.getUUID32());
			if(oldDutyId!=null){
				somPeopleResumeDao.deleteResumeByDutyId(oldDutyId);
				somDutyElectronicDao.updateDutyId(oldDutyId, somDuty.getDutyId());
				somChangeDomain.updateDutyId(oldDutyId, somDuty.getDutyId());
			}
			somDuty.setSorgId(somSession.getSorgId());
			somDuty.setSessionId(somSession.getSessionId());
			somDuty.setMorgName(corpOrgan.getOrganName());
			somDuty.setMorgArea(corpOrgan.getOrganCode());
			somDuty.setCreatePeople(empOrgan.getOrganName());
			somDuty.setCreateTime(time);
			somDutyDao.insert(somDuty);
			//插入人员简历信息
			List<SomPeopleResume> somPeopleResumeList = somDuty.getSomPeopleResumeList();
			for(int j = 0; j < somPeopleResumeList.size(); j++){
				SomPeopleResume somPeopleResume = (SomPeopleResume) somPeopleResumeList.get(j);
				somPeopleResume.setId(IdHelp.getUUID32());
				somPeopleResume.setDutyId(somDuty.getDutyId());
				somPeopleResume.setPeopleId(peopleId);
				somPeopleResume.setTaskCode(somSession.getTaskCode());
				somPeopleResumeDao.insert(somPeopleResume);
			}
		}
		//网上申请的将电子档案表的sorgId更新为系统中已经存在的组织的sorgId
		ParameterSet pset2 = new ParameterSet();
		pset2.setParameter("TASK_CODE", somSession.getTaskCode());
		DataSet ds = somElectronicDomain.queryElectronicOnly(pset2);
		for(int i = 0;i<ds.getCount();i++){
			SomElectronic bean = (SomElectronic) ds.getRecord(i).toBean(SomElectronic.class);
			bean.setSorgId(somSession.getSorgId());
			somElectronicDomain.update(bean);
		}
	}

	/**
	 * 社会组织换届负责人备案 
	 * 1、使用新一届的开始日期，维护上一届的结束日期，并维护上届人员任职结束的相关信息
	 * 2、增加新一届的届次信息，与人员任职信息
	 * @param somSession
	 */
	public void changeRegPeople(SomSession somSession) {
		OrganView corpOrgan = BspUtil.getCorpOrgan();
		OrganView empOrgan = BspUtil.getEmpOrgan();
		String time = DateUtil.getTime();
		
		String sorgId = somSession.getSorgId();
		String changeDate = somSession.getStartDate();
		
		// 上届信息填充结束日期
		DataSet currentSessionDataSet = somSessionDomain.getCurrentSession(sorgId);
		SomSession lastSession;

		if (currentSessionDataSet.getCount() > 0) {
			lastSession = (SomSession) currentSessionDataSet.getRecord(0).toBean(SomSession.class);
		} else {
			throw new RuntimeException("未找到该组织的任职相关信息");
		}
		lastSession.setRealEndDate(changeDate);
		int seq = Integer.parseInt(lastSession.getSeq());
		somSessionDomain.update(lastSession);
		ParameterSet lastSessionDutyPset=new ParameterSet();
		lastSessionDutyPset.setParameter("SESSION_ID",lastSession.getSessionId());
		DataSet dutyDataset = query(lastSessionDutyPset);
		for(int i=0;i<dutyDataset.getCount();i++){
			SomDuty duty=(SomDuty)dutyDataset.getRecord(i).toBean(SomDuty.class);
			duty.setRegStatus("2");
			duty.setEndDate(changeDate);
			duty.setIfServe("0");
			update(duty);//更新上届duty为历史
		}
		// 上届任职信息结束日期以及标记结束
		ParameterSet pset=new ParameterSet();
		pset.setParameter("SORG_ID", sorgId);
		SomOrgan somOrgan = queryOrganInfo(sorgId);
		String ifbranch = somOrgan.getIfBranch();
		if("0".equals(ifbranch)){
			//如果是主体负责人直接更新，分支负责人需要走变更
		}
		// 当前届次信息维护,sessionId实际和meeting表的meetingId一致，已经从前台查询并赋值
		if(somSession.getSessionId().equals("")||somSession.getSessionId()==null){
			somSession.setSessionId(IdHelp.getUUID32());
		}
		somSession.setSeq(Integer.toString(++seq));
		somSession.setMorgName(corpOrgan.getOrganName());
		somSession.setMorgArea(corpOrgan.getOrganCode());
		somSession.setCreatePeople(empOrgan.getOrganName());
		somSession.setCreateTime(time);
		somSessionDomain.insert(somSession);
		// 当前届次任职信息维护
		List<SomDuty> somDutyList = somSession.getSomDutyList();
		deleteByTaskCode(somSession.getTaskCode());//先删除原来的任职信息
		for (int i = 0; i < somDutyList.size(); i++) {
			SomDuty somDuty = (SomDuty) somDutyList.get(i);
			// 人员建档
			String oldDutyId=somDuty.getDutyId();
			somPeopleResumeDao.deleteResumeByDutyId(oldDutyId);
			somDuty.setDutyId(IdHelp.getUUID32());
			if(oldDutyId!=null){
				somDutyElectronicDao.updateDutyId(oldDutyId, somDuty.getDutyId());
			}
			String peopleId = somPeopleDomain.create(somDuty.getSomPeople());
			somDuty.setTaskCode(somSession.getTaskCode());
			somDuty.setSorgId(somSession.getSorgId());
			somDuty.setPeopleId(peopleId);
			somDuty.setSessionId(somSession.getSessionId());
			somDuty.setMorgName(corpOrgan.getOrganName());
			somDuty.setMorgArea(corpOrgan.getOrganCode());
			somDuty.setCreatePeople(empOrgan.getOrganName());
			somDuty.setCreateTime(time);
			somDutyDao.insert(somDuty);
			//插入人员简历信息
			List<SomPeopleResume> somPeopleResumeList = somDuty.getSomPeopleResumeList();
			for(int j = 0; j < somPeopleResumeList.size(); j++){
				SomPeopleResume somPeopleResume = (SomPeopleResume) somPeopleResumeList.get(j);
				somPeopleResume.setId(IdHelp.getUUID32());
				somPeopleResume.setDutyId(somDuty.getDutyId());
				somPeopleResume.setPeopleId(peopleId);
				somPeopleResume.setTaskCode(somSession.getTaskCode());
				somPeopleResumeDao.insert(somPeopleResume);
			}
		}
		//插入apply表信息
		SomApply somApply = new SomApply();
		somApply.setTaskCode(somSession.getTaskCode());
		somApply.setSorgId(sorgId);
		if ("S".equals(somOrgan.getSorgType())) {
			somApply.setApplyType(ApplyType.SOM_GROUP_CHARGER);
		} else if ("M".equals(somOrgan.getSorgType())) {
			somApply.setApplyType(ApplyType.SOM_UNGOV_CHARGER);
		} else if ("J".equals(somOrgan.getSorgType())) {
			somApply.setApplyType(ApplyType.SOM_FUND_CHARGER);
		}
		somApply.setSorgType(somOrgan.getSorgType());
		somApply.setIfFinish("1");
		somApply.setAcceptArea(BspUtil.getCorpOrgan().getOrganCode());
		somApply.setAuditTime(DateUtil.getTime());
		somApplyDomain.insert(somApply);
		
		//网上申请的将电子档案表的sorgId更新为系统中已经存在的组织的sorgId
		ParameterSet pset2 = new ParameterSet();
		pset2.setParameter("TASK_CODE", somSession.getTaskCode());
		DataSet ds = somElectronicDomain.queryElectronicOnly(pset2);
		for(int i = 0;i<ds.getCount();i++){
			SomElectronic bean = (SomElectronic) ds.getRecord(i).toBean(SomElectronic.class);
			bean.setSorgId(somSession.getSorgId());
			somElectronicDomain.update(bean);
		}
	}

	public void deleteByTaskCode(String taskCode) {
		somDutyDao.deleteDuty(taskCode);
	}
	
	public void deleteSessionAllByTaskCode(String taskCode) {
		//删除任职信息
		somDutyDao.deleteDuty(taskCode);
		//删除届次信息
		somDutyDao.deleteSessionByTaskCode(taskCode);
		//删除简历信息
		somDutyDao.deleteResumeByTaskCode(taskCode);
		//删除电子档案信息
		somDutyDao.deleteElectronicByTaskCode(taskCode);
	}
	public void deleteDutyBySessionId(String sessionId){
		somDutyDao.deleteDutyBySessionId(sessionId);
	}
	/**
	 * 根据taskcode更新备案人员的备案状态
	 * @param regStatus
	 * @param taskCode
	 */
	public void updateRegStatus(String regStatus, String taskCode) {
		somDutyDao.updateRegStatus(regStatus, taskCode);
	}
	
	public String  getLegalPeopleName(String taskCode){
		String name = "";
		String peopleId = "";
		ParameterSet pset=new ParameterSet();
		pset.setParameter("TASK_CODE@=", taskCode);
		DataSet dutyDs = somDutyDao.query(pset);
		for(int i=0;i<dutyDs.getCount();i++){
			Record rd = dutyDs.getRecord(i);
			String sorgDuties = (String)rd.get("sorgDuties");
			if (SomDutyDuties.SOM_LEGAL_PEOPLE.equals(sorgDuties)) {
				peopleId = (String)rd.get("peopleId");
			}
			
		}
		ParameterSet pset2=new ParameterSet();
		pset2.setParameter("PEOPLE_ID@=", peopleId);
		DataSet peopleDs = somPeopleDomain.query(pset2);
		Record peopleRd = peopleDs.getRecord(0);
		name = (String)peopleRd.get("name");
		return name;
	}
	
	/**
	 * 分支代表机构根据主体登记证号获取法定代表人姓名
	 * @param mainSorgId
	 * @return
	 */
	public String  getBranchChargePeopleName(String taskCode){
		String name = "";
		String peopleId = "";
		ParameterSet pset=new ParameterSet();
		pset.setParameter("TASK_CODE@=", taskCode);
		DataSet dutyDs = somDutyDao.query(pset);
		Record rd = dutyDs.getRecord(0);
		peopleId = (String)rd.get("peopleId");
		ParameterSet pset2=new ParameterSet();
		pset2.setParameter("PEOPLE_ID@=", peopleId);
		DataSet peopleDs = somPeopleDomain.query(pset2);
		Record peopleRd = peopleDs.getRecord(0);
		name = (String)peopleRd.get("name");
		return name;
	}
	/**
	 * 通过社会组织ID获取法定代表人姓名
	 * @param sorgId
	 * @return
	 */
	public String getLegalPeopleNameBySorgId(String sorgId){
		String name="";
//		String peopleId = "";
		ParameterSet pset=new ParameterSet();
		pset.setParameter("SORG_ID@=", sorgId);
		DataSet organDS=somOrganDomain.query(pset);
		SomOrgan somOrgan=(SomOrgan)organDS.getRecord(0).toBean(SomOrgan.class);
		String ifBranch=somOrgan.getIfBranch();//是否为分支
		if("1".equals(ifBranch)){
			sorgId=somOrgan.getMainSorgId();//如果是分支，直接查找主体的法定代表人
			pset.clear();
			pset.setParameter("SORG_ID@=", sorgId);
			DataSet organDSMain=somOrganDomain.query(pset);
			SomOrgan somOrganMain=(SomOrgan)organDSMain.getRecord(0).toBean(SomOrgan.class);
			name = somOrganMain.getLegalPeople();
		}else{
			name = somOrgan.getLegalPeople();
		}
		return name;
	}
	/**通过社会组织ID分支负责人姓名
	  * @param sorgId
	 */
	public String getBranchPeopleNameBySorgId(String sorgId){
		ParameterSet pset=new ParameterSet();
		pset.setParameter("SORG_ID", sorgId);
		pset.setParameter("IF_SERVE", "1");//在任
		pset.setParameter("REG_STATUS", "1");//备案状态为有效
		String name="";
		DataSet dutyDs = somDutyDao.queryPeople(pset);
		for(int i=0;i<dutyDs.getCount();i++){
			Record rd = dutyDs.getRecord(i);
			String sorgDuties = (String)rd.get("sorgDuties");
			if (SomDutyDuties.SOM_LEGAL_PEOPLE.equals(sorgDuties)) {
				name = (String)rd.get("name");
			}	
		}
		return name;
	}
	/**
	 * 通过人员Id和社会组织类型查询此人是否已经是该类型下的法定代表人
	 * @param peopleId
	 * @param sorgType
	 * @return
	 */
	public String checkLegalPeopleRepeat(String peopleId, String sorgType,String sorgId) {
		ParameterSet pset=new ParameterSet();
		String flag="true";
		pset.setParameter("PEOPLE_ID",peopleId);
		pset.setParameter("SORG_TYPE",sorgType);
		pset.setParameter("IF_SERVE", "1");//在任
		pset.setParameter("REG_STATUS@in", "1,3");//备案状态为有效和审批中
		pset.setParameter("SORG_DUTIES",SomDutyDuties.SOM_LEGAL_PEOPLE);//职务为法定代表人
		DataSet ds=query(pset);
		for(int i=0;i<ds.getCount();i++){
			StringBuffer buffer = new StringBuffer();
			Record rd = ds.getRecord(i);
			String sorgId1 = (String)rd.get("sorgId");
			if(sorgId1.equals(sorgId)){
				continue;
			}
			ParameterSet organPset=new ParameterSet();
			organPset.setParameter("SORG_ID", sorgId1);
			DataSet organDS=somOrganDomain.query(organPset);
			SomOrgan somOrgan=(SomOrgan)organDS.getRecord(0).toBean(SomOrgan.class);
			String sorgName=somOrgan.getCnName();
			String sorgCode=somOrgan.getSorgCode();
			if("1".equals(rd.get("regStatus"))){
				buffer.append("在名为\""+sorgName+"\"(登记证号为："+sorgCode+")担任法定代表人 ");
			}else if("3".equals(rd.get("regStatus"))){
				buffer.append("在名为\""+sorgName+"\"(登记证号为："+sorgCode+")担任法定代表人状态为：审批中 ");
			}
			flag=buffer.toString();
		}
		return flag;
	}

	public ISomPeopleResumeDao getSomPeopleResumeDao() {
		return somPeopleResumeDao;
	}

	public void setSomPeopleResumeDao(ISomPeopleResumeDao somPeopleResumeDao) {
		this.somPeopleResumeDao = somPeopleResumeDao;
	}
	/**
	 * 变更业务中更新法定代表人的信息(在update中更换的情况)
	 * @param taskCode
	 */
	public void reNewPeopleInfo(String taskCode) {
		ParameterSet pset=new ParameterSet();
		pset.setParameter("TASK_CODE",taskCode);
		DataSet ds=query(pset);
		RecordSet records=ds.getRecordSet();
		Iterator<Record> peoples= records.iterator();
		while(peoples.hasNext()){
			Record duty=(Record)peoples.next();
			SomDuty somduty=(SomDuty)duty.toBean(SomDuty.class);
			if(SomDutyDuties.SOM_LEGAL_PEOPLE.equals(somduty.getSorgDuties())){
				somDutyDao.delete(somduty.getDutyId());
			}
		}
	}
	/**
	 * 查询社会组织是否为分支
	 * @param sorgId
	 * @return
	 */
	public String queryOrganIfBranch(String sorgId){
		ParameterSet pset=new ParameterSet();
		pset.setParameter("SORG_ID@=", sorgId);
		DataSet organDS=somOrganDomain.query(pset);
		SomOrgan somOrgan=(SomOrgan)organDS.getRecord(0).toBean(SomOrgan.class);
		String ifBranch=somOrgan.getIfBranch();//是否为分支
		return ifBranch;
	}
	
	/**
	 * 社会组织信息
	 * @param sorgId
	 * @return
	 */
	public SomOrgan queryOrganInfo(String sorgId){
		ParameterSet pset=new ParameterSet();
		pset.setParameter("SORG_ID@=", sorgId);
		DataSet organDS=somOrganDomain.query(pset);
		SomOrgan somOrgan=(SomOrgan)organDS.getRecord(0).toBean(SomOrgan.class);
		String ifBranch=somOrgan.getIfBranch();//是否为分支
		return somOrgan;
	}
	
	/**
	 * 根据社会组织种类生成taskCode
	 * @param taskCode
	 * @param sorgType
	 */
	public String creatTaskCode(String taskCode,String sorgType){
		if("S".equals(sorgType)){
			return taskCode = SomIdHelp.getGroupTaskCode();
		}
		if("M".equals(sorgType)){
			return taskCode = SomIdHelp.getUngovTaskCode();
		}
		if("J".equals(sorgType)){
			return taskCode = SomIdHelp.getFundTaskCode();
		}
		return "";
	}
	public DataSet queryAspchief(ParameterSet pset) {
		DataSet dutyDataset=queryPeople(pset);
		if(dutyDataset.getCount() == 0){
			DataSet aspchiefDataset=somAspchiefDao.query(pset);
			if(aspchiefDataset.getCount() != 0){
				for(int i=0;i<aspchiefDataset.getCount();i++){
					SomAspchief somAspchief=(SomAspchief)aspchiefDataset.getRecord(i).toBean(SomAspchief.class);
					SomDuty somduty=shiftSomDuty(somAspchief);
					dutyDataset.addRecord(somduty);		
				}
				dutyDataset.setTotalCount(aspchiefDataset.getTotalCount());
			}
		}
		return dutyDataset;
	}
	/**
	 * 把一个拟任负责人转换成一个duty信息
	 * @param somAspchief
	 */
	private SomDuty shiftSomDuty(SomAspchief somAspchief) {
		SomDuty somDuty=new SomDuty();
		somDuty.setAdds(somAspchief.getPopulace());//家庭住址
		somDuty.setBirthday(somAspchief.getBirthday());
		somDuty.setCardType(somAspchief.getCardType());
		somDuty.setCreatePeople(somAspchief.getCreatePeople());
		somDuty.setCreateTime(somAspchief.getCreateTime());
		somDuty.setDutyId(somAspchief.getId());
		somDuty.setFolk(somAspchief.getFolk());
		somDuty.setIdCard(somAspchief.getIdCard());
		somDuty.setIfFulltime(somAspchief.getIfFulltime());
		somDuty.setIfRetire(somAspchief.getIfRetire());
		somDuty.setMorgArea(somAspchief.getMorgArea());
		somDuty.setMorgName(somAspchief.getMorgName());
		somDuty.setName(somAspchief.getName());
		somDuty.setOtherDuties(somAspchief.getOtherDuties());
		somDuty.setPhone(somAspchief.getPhone());
		somDuty.setPolitics(somAspchief.getPolitics());
		somDuty.setPostCode(somAspchief.getPostCode());
		somDuty.setPromiseCode(somAspchief.getPromiseCode());
		somDuty.setPromiseDate(somAspchief.getPromiseDate());
		somDuty.setPromiseOrgan(somAspchief.getPromiseOrgan());
		somDuty.setSex(somAspchief.getSex());
		somDuty.setNation(somAspchief.getCitizenship());
		somDuty.setSomPeopleResumeList(somAspchief.getSomPeopleResumeList());
		somDuty.setSorgDuties(somAspchief.getSorgDuties());
		somDuty.setSorgId(somAspchief.getSorgId());
		somDuty.setState(somAspchief.getState());;
		somDuty.setRelative(somAspchief.getRelative());
		somDuty.setTaskCode(somAspchief.getTaskCode());
		somDuty.setWorkDuties(somAspchief.getWorkDuties());
		somDuty.setWorkName(somAspchief.getWorkName());
		somDuty.setIfServe("1");
		somDuty.setRegStatus("1");
		return somDuty;
	}
	/**
	 *  基金会分支负责人备案时的保存
	 * @param somDuty
	 */
	public void saveBranchPeople(SomDuty somDuty) {
		if(somDuty.getSorgId() !=null && !"".equals(somDuty.getSorgId()) ){
			deleteByRegStatus(somDuty.getSorgId(),"3");
		}
		OrganView corpOrgan = BspUtil.getCorpOrgan();
		OrganView empOrgan = BspUtil.getEmpOrgan();
		String time = DateUtil.getTime();
		String peopleId = somPeopleDomain.create(somDuty.getSomPeople());
		String oldDutyId=somDuty.getDutyId();
		somDuty.setDutyId(IdHelp.getUUID32());
		if(oldDutyId!=null){
			somDutyElectronicDao.updateDutyId(oldDutyId, somDuty.getDutyId());
			somChangeDomain.updateDutyId(oldDutyId, somDuty.getDutyId());
		}
		somDuty.setPeopleId(peopleId);
		//somDuty.setSessionId(somSession.getSessionId());
		somDuty.setMorgName(corpOrgan.getOrganName());
		somDuty.setMorgArea(corpOrgan.getOrganCode());
		somDuty.setCreatePeople(empOrgan.getOrganName());
		somDuty.setCreateTime(time);
		somDutyDao.insert(somDuty);
		somPeopleResumeDao.deleteResumeByDutyId(oldDutyId);
		List<SomPeopleResume> somPeopleResumeList = somDuty.getSomPeopleResumeList();
		if(somPeopleResumeList != null ){
			for(int j = 0; j < somPeopleResumeList.size(); j++){
				SomPeopleResume somPeopleResume = (SomPeopleResume) somPeopleResumeList.get(j);
				somPeopleResume.setId(IdHelp.getUUID32());
				somPeopleResume.setDutyId(somDuty.getDutyId());
				somPeopleResume.setPeopleId(peopleId);
				somPeopleResume.setTaskCode(somDuty.getTaskCode());
				somPeopleResumeDao.insert(somPeopleResume);
			}
		}	
	}
	/**
	 * 通过任职状态删除任职信息
	 * @param regStatus
	 * @param sorgId
	 */
	public void deleteByRegStatus(String sorgId, String regStatus) {
		somDutyDao.deleteByRegStatus(sorgId,regStatus);
	}
	/**
	 * 更新somDutyElectronic表中人员的dutyId
	 * @param somDuty
	 */
	public void changeOldDutyIdToNew(SomDuty somDuty){
		String oldDutyId=somDuty.getDutyId();
		somDuty.setDutyId(IdHelp.getUUID32());
		if(oldDutyId!=null){
			somDutyElectronicDao.updateDutyId(oldDutyId, somDuty.getDutyId());
		}
		
	}
	/**
	 * 获取当前届次任职信息
	 */
	public DataSet queryCurDuty(String sorgId){
		DataSet dset=somSessionDomain.getCurrentSession(sorgId);
		if (dset==null||dset.getCount()<1) {
			return null;
		}
		SomSession somSession=(SomSession)dset.getRecord(0).toBean(SomSession.class);
		ParameterSet pset=new ParameterSet();
		pset.setParameter("SESSION_ID", somSession.getSessionId());
		pset.setParameter("IF_SERVE", "1");
		dset=somDutyDao.queryPeople(pset);		
		return dset;
	}
	
	public DataSet queryPeopleByName(ParameterSet pset){
		return somDutyDao.queryPeopleByName(pset);
	}

	public void insertSomPeopleResume(SomPeopleResume somResume) {
		somPeopleResumeDao.insert(somResume);
	}

	public void deletePeopleResumeByTaskCode(String taskCode) {
		somPeopleResumeDao.deleteResume(taskCode);
	}
	/**
	 * 换届备案外网申请受理
	 */ 
	public void changeRegPeopleOnline(SomApply somApply, SomSession somSession) {
		OrganView corpOrgan = BspUtil.getCorpOrgan();
		OrganView empOrgan = BspUtil.getEmpOrgan();
		String time = DateUtil.getTime();
		
		String sorgId = somSession.getSorgId();
		String changeDate = somSession.getStartDate();
		
		// 上届信息填充结束日期
		DataSet currentSessionDataSet = somSessionDomain.getCurrentSession(sorgId);
		SomSession lastSession;

		if (currentSessionDataSet.getCount() > 0) {
			lastSession = (SomSession) currentSessionDataSet.getRecord(0).toBean(SomSession.class);
		} else {
			throw new RuntimeException("未找到该组织的任职相关信息");
		}
		lastSession.setRealEndDate(changeDate);
		int seq = Integer.parseInt(lastSession.getSeq());
		somSessionDomain.update(lastSession);
		ParameterSet lastSessionDutyPset=new ParameterSet();
		lastSessionDutyPset.setParameter("SESSION_ID",lastSession.getSessionId());
		DataSet dutyDataset = query(lastSessionDutyPset);
		for(int i=0;i<dutyDataset.getCount();i++){
			SomDuty duty=(SomDuty)dutyDataset.getRecord(i).toBean(SomDuty.class);
			duty.setRegStatus("2");
			duty.setEndDate(changeDate);
			duty.setIfServe("0");
			update(duty);//更新上届duty为历史
		}
		// 上届任职信息结束日期以及标记结束
		ParameterSet pset=new ParameterSet();
		pset.setParameter("SORG_ID", sorgId);
		SomOrgan somOrgan = queryOrganInfo(sorgId);
		String ifbranch = somOrgan.getIfBranch();
		if("0".equals(ifbranch)){
			//如果是主体负责人直接更新，分支负责人需要走变更
		}
		// 当前届次信息维护
		somSession.setSessionId(IdHelp.getUUID32());
		somSession.setSeq(Integer.toString(++seq));
		somSession.setMorgName(corpOrgan.getOrganName());
		somSession.setMorgArea(corpOrgan.getOrganCode());
		somSession.setCreatePeople(empOrgan.getOrganName());
		somSession.setCreateTime(time);
		somSessionDomain.insert(somSession);
		// 当前届次任职信息维护
		List<SomDuty> somDutyList = somSession.getSomDutyList();
		deleteByTaskCode(somSession.getTaskCode());//先删除原来的任职信息
		for (int i = 0; i < somDutyList.size(); i++) {
			SomDuty somDuty = (SomDuty) somDutyList.get(i);
			// 人员建档
			String oldDutyId=somDuty.getDutyId();
			somPeopleResumeDao.deleteResumeByDutyId(oldDutyId);
			somDuty.setDutyId(IdHelp.getUUID32());
			if(oldDutyId!=null){
				somDutyElectronicDao.updateDutyId(oldDutyId, somDuty.getDutyId());
			}
			String peopleId = somPeopleDomain.create(somDuty.getSomPeople());
			somDuty.setTaskCode(somSession.getTaskCode());
			somDuty.setSorgId(somSession.getSorgId());
			somDuty.setPeopleId(peopleId);
			somDuty.setSessionId(somSession.getSessionId());
			somDuty.setMorgName(corpOrgan.getOrganName());
			somDuty.setMorgArea(corpOrgan.getOrganCode());
			somDuty.setCreatePeople(empOrgan.getOrganName());
			somDuty.setCreateTime(time);
			somDutyDao.insert(somDuty);
			//插入人员简历信息
			List<SomPeopleResume> somPeopleResumeList = somDuty.getSomPeopleResumeList();
			for(int j = 0; j < somPeopleResumeList.size(); j++){
				SomPeopleResume somPeopleResume = (SomPeopleResume) somPeopleResumeList.get(j);
				somPeopleResume.setId(IdHelp.getUUID32());
				somPeopleResume.setDutyId(somDuty.getDutyId());
				somPeopleResume.setPeopleId(peopleId);
				somPeopleResume.setTaskCode(somSession.getTaskCode());
				somPeopleResumeDao.insert(somPeopleResume);
			}
		}
		//插入apply表信息
		somApply.setSorgId(sorgId);
		if ("S".equals(somOrgan.getSorgType())) {
			somApply.setApplyType(ApplyType.SOM_GROUP_CHARGER);
		} else if ("M".equals(somOrgan.getSorgType())) {
			somApply.setApplyType(ApplyType.SOM_UNGOV_CHARGER);
		} else if ("J".equals(somOrgan.getSorgType())) {
			somApply.setApplyType(ApplyType.SOM_FUND_CHARGER);
		}
		somApply.setSorgType(somOrgan.getSorgType());
		somApply.setIfFinish("1");
		somApply.setAcceptArea(BspUtil.getCorpOrgan().getOrganCode());
		somApply.setAuditTime(DateUtil.getTime());
		somApplyDomain.insert(somApply);
		
		//网上申请的将电子档案表的sorgId更新为系统中已经存在的组织的sorgId
		ParameterSet somElectronicDomainPset = new ParameterSet();
		somElectronicDomainPset.setParameter("TASK_CODE", somApply.getTaskCode());
		DataSet ds = somElectronicDomain.queryElectronicOnly(somElectronicDomainPset);
		for(int i = 0;i<ds.getCount();i++){
			SomElectronic bean = (SomElectronic) ds.getRecord(i).toBean(SomElectronic.class);
			bean.setSorgId(somApply.getSorgId());
			somElectronicDomain.update(bean);
		}
		
	}
}
