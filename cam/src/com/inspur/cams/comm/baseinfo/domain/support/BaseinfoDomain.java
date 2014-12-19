package com.inspur.cams.comm.baseinfo.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.comm.baseinfo.dao.IBaseinfoFamilyDao;
import com.inspur.cams.comm.baseinfo.dao.IBaseinfoPeopleDao;
import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.baseinfo.domain.IBaseinfoDomain;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 家庭与人员基础信息domain
 * @author shgtch
 * @date 2012-5-16
 */
public class BaseinfoDomain implements IBaseinfoDomain {
	@Reference
	private IBaseinfoFamilyDao baseInfoFamilyDao;
	@Reference
	private IBaseinfoPeopleDao baseinfoPeopleDao;
	/**
	 *查询家庭基本信息
	 * @return
	 */
	public BaseinfoFamily getFamily(String familyId) {
		return baseInfoFamilyDao.get(familyId);
	}
	public DataSet queryFamily(ParameterSet pset){
		return baseInfoFamilyDao.query(pset);
	}
	/**
	 * 增加家庭基本信息
	 * @param baseinfoFamily
	 */
	public void insertFamily(BaseinfoFamily baseinfoFamily) {
		baseinfoFamily.setFamilyId(IdHelp.getUUID32());
//		baseinfoFamily.setRegId(BspUtil.getEmpOrgan().getOrganId());
//		baseinfoFamily.setRegOrg(BspUtil.getCorpOrgan().getOrganId());
//	                 	baseinfoFamily.setRegOrgArea(BspUtil.getCorpOrgan().getOrganCode());
//		baseinfoFamily.setRegOrgName(BspUtil.getCorpOrgan().getOrganName());
//		baseinfoFamily.setRegPeople(BspUtil.getEmpOrgan().getOrganName());
//		baseinfoFamily.setRegTime(DateUtil.getTime());
		baseInfoFamilyDao.insert(baseinfoFamily);		
	}

	/**
	 * 更新家庭基本信息
	 * @param baseinfoFamily
	 */
	public void updateFamily(BaseinfoFamily baseinfoFamily) {
		baseinfoFamily.setModId(BspUtil.getEmpOrgan().getOrganId());
		baseinfoFamily.setModOrg(BspUtil.getCorpOrgan().getOrganId());
		baseinfoFamily.setModOrgArea(BspUtil.getCorpOrgan().getOrganCode());
		baseinfoFamily.setModOrgName(BspUtil.getCorpOrgan().getOrganName());
		baseinfoFamily.setModPeople(BspUtil.getEmpOrgan().getOrganName());
		baseinfoFamily.setModTime(DateUtil.getTime());
		baseInfoFamilyDao.update(baseinfoFamily);		
	}
	/**
	 * 根据人员月收入更新家庭收入
	 * @param familyId
	 */
	public void updateIncomeByMonth(String familyId){
		baseInfoFamilyDao.updateIncomeByMonth(familyId);		
	}
	
	/**
	 * 根据人员年收入更新家庭收入
	 * @param familyId
	 */
	public void updateIncomeByYear(String familyId){
		baseInfoFamilyDao.updateIncomeByYear(familyId);		
	}
	
	/**
	 * 更新家庭人口信息
	 * @param familyId
	 */
	public void updatePeopleNum(String familyId){
		baseInfoFamilyDao.updatePeopleNum(familyId);		
	}
	/**
	 *查询人员基本信息
	 * @return
	 */
	public BaseinfoPeople getPeople(String peopleId) {
		return baseinfoPeopleDao.get(peopleId);
	}
	/**
	 *查询人员基本信息
	 * @return
	 */
	public DataSet queryPeople(ParameterSet pset) {
		return baseinfoPeopleDao.query(pset);
	}
	/**
	 *sql查询人员基本信息
	 * @return
	 */
	public DataSet queryPeopleForSam(ParameterSet pset){
		return baseinfoPeopleDao.queryForSam(pset);
		
	}
	/**
	 * 增加人员基本信息
	 * @param baseinfoPeople
	 */
	public void insertPeople(BaseinfoPeople baseinfoPeople) {
		baseinfoPeople.setDomicileCode(BspUtil.getOrganCode());
		baseinfoPeople.setDomicileName(BspUtil.getOrganName());
		baseinfoPeople.setPeopleId(IdHelp.getUUID32());
		baseinfoPeople.setRegId(BspUtil.getEmpOrgan().getOrganId());
		baseinfoPeople.setRegOrg(BspUtil.getCorpOrgan().getOrganId());
		baseinfoPeople.setRegOrgArea(BspUtil.getCorpOrgan().getOrganCode());
		baseinfoPeople.setRegOrgName(BspUtil.getCorpOrgan().getOrganName());
		baseinfoPeople.setRegPeople(BspUtil.getEmpOrgan().getOrganName());
		baseinfoPeople.setRegTime(DateUtil.getTime());
		baseinfoPeopleDao.insert(baseinfoPeople);
	}
	/**
	 * 更新人员基本信息
	 * @param baseinfoPeople
	 */
	public void updatePeople(BaseinfoPeople baseinfoPeople) {
		baseinfoPeople.setModId(BspUtil.getEmpOrgan().getOrganId());
		baseinfoPeople.setModOrg(BspUtil.getCorpOrgan().getOrganId());
		baseinfoPeople.setModOrgArea(BspUtil.getCorpOrgan().getOrganCode());
		baseinfoPeople.setModOrgName(BspUtil.getCorpOrgan().getOrganName());
		baseinfoPeople.setModPeople(BspUtil.getEmpOrgan().getOrganName());
		baseinfoPeople.setModTime(DateUtil.getTime());
		baseinfoPeopleDao.update(baseinfoPeople);
	}
	/**
	 * 删除人员基本信息
	 * @param peopleId
	 */
	public void deletePeople(String peopleId) {
		baseinfoPeopleDao.delete(peopleId);
	}

	/**
	* @Title: querySamFamilyList
	* @Description: TODO(家庭信息列表查询，专项救助列表查询使用)
	* @param pset
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet querySamFamilyList(ParameterSet pset) {
		return baseInfoFamilyDao.querySamFamilyList(pset);
	}
	
	/**
	 * @Title: querySamBankList 
	 * @Description: TODO(银行账户维护列表查询) 
	 * @author wangziming
	 */
	public DataSet querySamBankList(ParameterSet pset) {
		// TODO Auto-generated method stub
		return baseInfoFamilyDao.querySamBankList(pset);
	}
	/**
	 * @Title: queryBaseChange 
	 * @Description: TODO(低保变动查询) 
	 * @author sunlei
	 */
	public DataSet queryBaseChange(ParameterSet pset) {
		// TODO Auto-generated method stub
		return baseInfoFamilyDao.queryBaseChange(pset);
	}
	/**
	 * @Title: querySamPeopleList 
	 * @Description: TODO(低保对象查询列表) 
	 * @author wangziming
	 */
	public DataSet querySamPeopleList(ParameterSet pset) {
		return baseinfoPeopleDao.querySamPeopleList(pset);
	}

	/**
	 * 调用存储过程把记录保存到备用表中
	 */
	public void procSamFamily(BaseinfoFamily baseinfoFamily){
		baseInfoFamilyDao.procSamFamily(baseinfoFamily);
	}	
	/**
	* @Title: insertFamilyFromEnsurey
	* @Description: TODO(从经济核对回填家庭信息)
	* @param set void  
	 * @return 
	* @throws
	* @author luguosui
	 */
	public Record insertFamilyFromEnsurey(ParameterSet set) {
		return baseInfoFamilyDao.insertFamilyFromEnsurey(set);
	}
	/**
	* @Title: insertPeoFromEnsurey
	* @Description: TODO(从经济核对回填人员信息)
	* @param set void  
	* @throws
	* @author luguosui
	 */
	public void insertPeoFromEnsurey(ParameterSet set) {
		baseinfoPeopleDao.insertFamilyFromEnsurey(set);
		
	}
	/**
	 * 可能成为五保对象的人员查询
	 * @return
	 */
	public DataSet queryMaybeFiveList(ParameterSet pset){
		return baseinfoPeopleDao.queryMaybeFiveList(pset);
	}
	/**
	 * @Title: queryBaseChangePeople 
	 * @Description:  (低保保障对象变动) 
	 * @author YLL
	 */
	public DataSet queryBaseChangePeople(ParameterSet pset) {
		return baseinfoPeopleDao.queryBaseChangePeople(pset);
	}
	
	public DataSet querySamFamilyListForRecheck(ParameterSet pset){
		return baseInfoFamilyDao.querySamFamilyListForRecheck(pset);
	}
	
	public DataSet queryCremationInfo(ParameterSet pset){
		return baseinfoPeopleDao.queryCremationInfo(pset);
	}
}
