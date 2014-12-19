package com.inspur.cams.drel.esurey.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.esurey.dao.ISamEsureyPeopleDao;
import com.inspur.cams.drel.esurey.data.SamEsureyBank;
import com.inspur.cams.drel.esurey.data.SamEsureyBusiness;
import com.inspur.cams.drel.esurey.data.SamEsureyCar;
import com.inspur.cams.drel.esurey.data.SamEsureyHouse;
import com.inspur.cams.drel.esurey.data.SamEsureyHousingFund;
import com.inspur.cams.drel.esurey.data.SamEsureyInsurance;
import com.inspur.cams.drel.esurey.data.SamEsureyPeople;
import com.inspur.cams.drel.esurey.data.SamEsureyPeopleEstate;
import com.inspur.cams.drel.esurey.data.SamEsureySecurities;
import com.inspur.cams.drel.esurey.data.SamEsureySocial;
import com.inspur.cams.drel.esurey.data.SamEsureyTax;
import com.inspur.cams.drel.esurey.domain.ISamEsureyBankDomain;
import com.inspur.cams.drel.esurey.domain.ISamEsureyBusinessDomain;
import com.inspur.cams.drel.esurey.domain.ISamEsureyCarDomain;
import com.inspur.cams.drel.esurey.domain.ISamEsureyFamilyDomain;
import com.inspur.cams.drel.esurey.domain.ISamEsureyHouseDomain;
import com.inspur.cams.drel.esurey.domain.ISamEsureyHousingFundDomain;
import com.inspur.cams.drel.esurey.domain.ISamEsureyInsuranceDomain;
import com.inspur.cams.drel.esurey.domain.ISamEsureyPeopleDomain;
import com.inspur.cams.drel.esurey.domain.ISamEsureyPeopleEstateDomain;
import com.inspur.cams.drel.esurey.domain.ISamEsureyRelationDomain;
import com.inspur.cams.drel.esurey.domain.ISamEsureySecuritiesDomain;
import com.inspur.cams.drel.esurey.domain.ISamEsureySocialDomain;
import com.inspur.cams.drel.esurey.domain.ISamEsureyTaxDomain;


public class SamEsureyPeopleDomain implements ISamEsureyPeopleDomain{
	
	@Reference
	private ISamEsureyFamilyDomain samEsureyFamilyDomain;
	@Reference
	private ISamEsureyPeopleDao samEsureyPeopleDao;
	@Reference 
	private ISamEsureySocialDomain samEsureySocialDomain;
	@Reference 
	private ISamEsureyRelationDomain samEsureyRelationDomain;
	@Reference 
	private ISamEsureyHouseDomain samEsureyHouseDomain;
	@Reference 
	private ISamEsureyBusinessDomain samEsureyBusinessDomain;
	@Reference 
	private ISamEsureyCarDomain samEsureyCarDomain;
	@Reference 
	private ISamEsureyTaxDomain samEsureyTaxDomain;
	@Reference 
	private ISamEsureyBankDomain samEsureyBankDomain;
	@Reference 
	private ISamEsureySecuritiesDomain samEsureySecuritiesDomain;
	@Reference 
	private ISamEsureyInsuranceDomain samEsureyInsuranceDomain;
	@Reference 
	private ISamEsureyHousingFundDomain samEsureyHousingFundDomain;
	@Reference 
	private ISamEsureyPeopleEstateDomain samEsureyPeopleEstateDomain;
	
	public void insert(SamEsureyPeople dataBean) {
		samEsureyPeopleDao.insert(dataBean);
		
	}

	public DataSet query(ParameterSet pset) {
		return samEsureyPeopleDao.query(pset);
	}

	public void update(SamEsureyPeople dataBean) {
		samEsureyPeopleDao.update(dataBean);
		
	}

	public void delete(String delId){
		samEsureyPeopleDao.delete(delId);
	}
	/**
	 * 删除家庭下的某个成员
	 */	
	public void deletePeople(String familyId,String peopleId,String Flag){
		if("notSupport".equalsIgnoreCase(Flag)){
			samEsureySocialDomain.delete(peopleId);
			samEsureyPeopleEstateDomain.deleteByPeopleId(peopleId);
			samEsureyHouseDomain.delete(peopleId);
			samEsureyBusinessDomain.delete(peopleId);
			samEsureyCarDomain.delete(peopleId);
			samEsureyTaxDomain.delete(peopleId);
			samEsureyHousingFundDomain.delete(peopleId);
			samEsureyBankDomain.delete(peopleId);
			samEsureySecuritiesDomain.delete(peopleId);
			samEsureyInsuranceDomain.delete(peopleId);
			samEsureyPeopleDao.delete(peopleId);
		}else if("isSupport".equalsIgnoreCase(Flag)){
			samEsureySocialDomain.delete(peopleId);
			samEsureyPeopleEstateDomain.deleteByPeopleId(peopleId);
			samEsureyHouseDomain.delete(peopleId);
			samEsureyBusinessDomain.delete(peopleId);
			samEsureyCarDomain.delete(peopleId);
			samEsureyTaxDomain.delete(peopleId);
			samEsureyHousingFundDomain.delete(peopleId);
			samEsureyBankDomain.delete(peopleId);
			samEsureySecuritiesDomain.delete(peopleId);
			samEsureyInsuranceDomain.delete(peopleId);
			samEsureyPeopleDao.delete(peopleId);
			samEsureyRelationDomain.deleteByPeopleId(peopleId);
		}
		samEsureyFamilyDomain.updateFamilyInfo(familyId);
	}
	/**
	 * 社保信息
	 * 
	 */
	public void getSamEsureySocial(Record[] SamSocials, String peopleId){
		int num=SamSocials.length;
		SamEsureySocial[] Beans=new SamEsureySocial[num];
		for(int i=0;i<SamSocials.length;i++){
			Beans[i]=(SamEsureySocial)SamSocials[i].toBean(SamEsureySocial.class);
		}
		samEsureySocialDomain.getSamEsureySocial(Beans, peopleId);
	}
	/**
	 * 社保财产信息
	 */
	public void getEstateSocial(String peopleId,String familyId){
		samEsureyPeopleEstateDomain.getEstateSocial(peopleId,familyId);
	}
	/**
	 * 财产信息
	 */
	public void getSamEsureyEstate(Record[] records,String peopleId,String familyId){
		int num=records.length;
		SamEsureyPeopleEstate[] Beans=new SamEsureyPeopleEstate[num];
		for(int i=0;i<num;i++){
			Beans[i]=(SamEsureyPeopleEstate)records[i].toBean(SamEsureyPeopleEstate.class);
		}
		samEsureyPeopleEstateDomain.getSamEsureyEstate(Beans, peopleId,familyId);		
	}
	/**
	 * 保存房屋信息
	 */
	public void getSamEsureyHouse(Record[] records,String peopleId){
		int num=records.length;
		SamEsureyHouse[] Beans=new SamEsureyHouse[num];
		for(int i=0;i<num;i++){
			Beans[i]=(SamEsureyHouse)records[i].toBean(SamEsureyHouse.class);
		}
		samEsureyHouseDomain.getSamEsureyHouse(Beans, peopleId);		
	}
	/**
	 * 房屋财产信息
	 * @param peopleId
	 */
	public void getEsureyHouse(String peopleId,String familyId){
		samEsureyPeopleEstateDomain.getEsureyHouse(peopleId,familyId);
	}
	/**
	 * 工商信息
	 */
	public void getSamEsureyBusiness(Record[] records,String peopleId){
		int num=records.length;
		SamEsureyBusiness[] Beans=new SamEsureyBusiness[num];
		for(int i=0;i<num;i++){
			Beans[i]=(SamEsureyBusiness)records[i].toBean(SamEsureyBusiness.class);
		}
		samEsureyBusinessDomain.getSamEsureyBusiness(Beans, peopleId);
	}
	/**
	 * 车辆信息
	 */
	public void getSamEsureyCar(Record[] records,String peopleId){
		int num=records.length;
		SamEsureyCar[] Beans=new SamEsureyCar[num];
		for(int i=0;i<num;i++){
			Beans[i]=(SamEsureyCar)records[i].toBean(SamEsureyCar.class);
		}
		samEsureyCarDomain.getSamEsureyCar(Beans, peopleId);
	}
	/**
	 * 车辆财产信息
	 * @param peopleId
	 */
	public void getEsureyCar(String peopleId,String familyId){
		samEsureyPeopleEstateDomain.getEsureyCar(peopleId,familyId);
	}
	/*
	 * 国税信息
	 */
	public void getEsureyTaxG(Record[] records,String peopleId){
		int num=records.length;
		SamEsureyTax[] Beans=new SamEsureyTax[num];
		for(int i=0;i<num;i++){
			Beans[i]=(SamEsureyTax)records[i].toBean(SamEsureyTax.class);
		}
		samEsureyTaxDomain.getEsureyTaxG(Beans, peopleId);
	}
	/*
	 * 地税信息
	 */
	public void getEsureyTaxD(Record[] records,String peopleId){
		int num=records.length;
		SamEsureyTax[] Beans=new SamEsureyTax[num];
		for(int i=0;i<num;i++){
			Beans[i]=(SamEsureyTax)records[i].toBean(SamEsureyTax.class);
		}
		samEsureyTaxDomain.getEsureyTaxD(Beans, peopleId);
	}
	/*
	 * 公积金信息
	 */
	public void getEsureyFund(Record[] records, String peopleId) {
		int num=records.length;
		SamEsureyHousingFund[] Beans=new SamEsureyHousingFund[num];
		for(int i=0;i<num;i++){
			Beans[i]=(SamEsureyHousingFund)records[i].toBean(SamEsureyHousingFund.class);
		}
		samEsureyHousingFundDomain.getEsureyFund(Beans, peopleId);
	}
	/*
	 * 人行信息
	 */
	public void getEsureyBank(Record[] records,String peopleId){
		int num=records.length;
		SamEsureyBank[] Beans=new SamEsureyBank[num];
		for(int i=0;i<num;i++){
			Beans[i]=(SamEsureyBank)records[i].toBean(SamEsureyBank.class);
		}
		samEsureyBankDomain.getEsureyBank(Beans, peopleId);
	}

	/**
	 * 银行财产信息
	 * @param peopleId
	 */
	public  void getBankEstate(String peopleId,String familyId){
		samEsureyPeopleEstateDomain.getBankEstate(peopleId,familyId);
	}
	/*
	 * 证监信息
	 */
	public void getEsureySecurities(Record[] records,String peopleId){
		int num=records.length;
		SamEsureySecurities[] Beans=new SamEsureySecurities[num];
		for(int i=0;i<num;i++){
			Beans[i]=(SamEsureySecurities)records[i].toBean(SamEsureySecurities.class);
		}
		samEsureySecuritiesDomain.getEsureySecurities(Beans, peopleId);
	}
	/**
	 * 有价证券信息
	 * @param peopleId
	 */
	public void getSecuritiesEstate(String peopleId,String familyId){
		samEsureyPeopleEstateDomain.getSecuritiesEstate(peopleId,familyId);
	}
	/*
	 * 保监信息
	 */
	public void getEsureyInsurance(Record[] records,String peopleId){
		int num=records.length;
		SamEsureyInsurance[] Beans=new SamEsureyInsurance[num];
		for(int i=0;i<num;i++){
			Beans[i]=(SamEsureyInsurance)records[i].toBean(SamEsureyInsurance.class);
		}
		samEsureyInsuranceDomain.getEsureyInsurance(Beans, peopleId);
	}
	/**
	 * 根据familyId查询赡养人员
	 */
	public DataSet querySupportPeople(ParameterSet pset){
		return samEsureyPeopleDao.querySupportPeople(pset);
	}
	/**
	 * 根据peopleId查询信息
	 */
	public DataSet queryPeopleById(ParameterSet pset){
		return samEsureyPeopleDao.queryPeopleById(pset);
	}
	/**
	 * 检查家庭成员中身份证的唯一性
	 */
	public String queryUnqiue(ParameterSet pset){
		return samEsureyPeopleDao.queryUnqiue(pset);
	}
	
	/**
	 * 批量保存成员信息
	 */
	public void batchInsert(List<SamEsureyPeople> list){
		samEsureyPeopleDao.batchInsert(list);
	}
}
