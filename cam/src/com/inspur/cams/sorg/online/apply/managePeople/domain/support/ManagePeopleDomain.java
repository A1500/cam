package com.inspur.cams.sorg.online.apply.managePeople.domain.support;

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
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.data.SomPeople;
import com.inspur.cams.sorg.base.data.SomPeopleResume;
import com.inspur.cams.sorg.base.data.SomSession;
import com.inspur.cams.sorg.base.domain.ISomApplyDomain;
import com.inspur.cams.sorg.base.domain.ISomChangeDomain;
import com.inspur.cams.sorg.base.domain.ISomOrganDomain;
import com.inspur.cams.sorg.base.domain.ISomPeopleDomain;
import com.inspur.cams.sorg.base.domain.ISomSessionDomain;
import com.inspur.cams.sorg.online.apply.managePeople.domain.IManagePeopleDomain;
import com.inspur.cams.sorg.util.ApplyType;
import com.inspur.cams.sorg.util.SomDutyDuties;
import com.inspur.cams.sorg.util.SomIdHelp;

/**
 * 社会组织任职信息表domain实现类
 * 
 * @author 
 * @date
 */
public class ManagePeopleDomain implements IManagePeopleDomain {

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
	public String createPeople(SomPeople somPeople) {
		return somPeopleDomain.create(somPeople);
	}

	/**
	 * 修改负责人备案信息
	 * 
	 * @param somSession
	 */
	public void updateRegPeople(SomApply somApply) {
		SomOrgan somOrgan = somApply.getSomOrgan();
		SomSession somSession = somOrgan.getSomSession();
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
			String peopleId = somPeopleDomain.create(somDuty.getSomPeople());
			String oldDutyId=somDuty.getDutyId();
			somDuty.setDutyId(IdHelp.getUUID32());
			if(oldDutyId!=null){
				somPeopleResumeDao.deleteResumeByDutyId(oldDutyId);
				somDutyElectronicDao.updateDutyId(oldDutyId, somDuty.getDutyId());
				somChangeDomain.updateDutyId(oldDutyId, somDuty.getDutyId());
			}
			somDuty.setSorgId(somSession.getSorgId());
			somDuty.setPeopleId(peopleId);
			somDuty.setSessionId(somSession.getSessionId());
			somDuty.setCreateTime(time);
			somDuty.setTaskCode(somApply.getTaskCode());
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
		somApplyDomain.update(somApply);
		somOrganDomain.update(somOrgan);
	}

	/**
	 * 社会组织换届负责人备案 
	 * 1、使用新一届的开始日期，维护上一届的结束日期，并维护上届人员任职结束的相关信息
	 * 2、增加新一届的届次信息，与人员任职信息
	 * @param somSession
	 */
	public void changeRegPeople(SomApply somApply) {
		SomOrgan somOrgan = somApply.getSomOrgan();
		SomSession somSession = somOrgan.getSomSession();
		String time = DateUtil.getTime();
		String sorgId = somSession.getSorgId();
		// 当前届次信息维护
		somSession.setSessionId(IdHelp.getUUID32());
		somSession.setSeq("1");
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
		somApplyDomain.insertOnline(somApply);
		somOrganDomain.insert(somOrgan);
	}

	public void deleteByTaskCode(String taskCode) {
		somDutyDao.deleteDuty(taskCode);
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
		somDuty.setSomPeopleResumeList(somAspchief.getSomPeopleResumeList());
		somDuty.setSorgDuties(somAspchief.getSorgDuties());
		somDuty.setSorgId(somAspchief.getSorgId());
		somDuty.setState(somAspchief.getState());;
		somDuty.setRelative(somAspchief.getRelative());
		somDuty.setTaskCode(somAspchief.getTaskCode());
		somDuty.setWorkDuties(somAspchief.getWorkDuties());
		somDuty.setWorkName(somAspchief.getWorkName());
		somDuty.setIfServe("1");
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
}
