package com.inspur.cams.drel.esurey.domain.support;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.esurey.dao.ISamEsureyFamilyDao;
import com.inspur.cams.drel.esurey.dao.ISamEsureyPeopleDao;
import com.inspur.cams.drel.esurey.data.SamEsureyBank;
import com.inspur.cams.drel.esurey.data.SamEsureyBusiness;
import com.inspur.cams.drel.esurey.data.SamEsureyCar;
import com.inspur.cams.drel.esurey.data.SamEsureyFamily;
import com.inspur.cams.drel.esurey.data.SamEsureyHouse;
import com.inspur.cams.drel.esurey.data.SamEsureyHousingFund;
import com.inspur.cams.drel.esurey.data.SamEsureyInsurance;
import com.inspur.cams.drel.esurey.data.SamEsureyPeople;
import com.inspur.cams.drel.esurey.data.SamEsureyPeopleEstate;
import com.inspur.cams.drel.esurey.data.SamEsureyRelation;
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
import com.inspur.cams.drel.esurey.domain.ISamEsureyPeopleEstateDomain;
import com.inspur.cams.drel.esurey.domain.ISamEsureyRelationDomain;
import com.inspur.cams.drel.esurey.domain.ISamEsureySecuritiesDomain;
import com.inspur.cams.drel.esurey.domain.ISamEsureySocialDomain;
import com.inspur.cams.drel.esurey.domain.ISamEsureyTaxDomain;
import com.inspur.cams.drel.sam.data.SamBankAccount;



public class SamEsureyFamilyDomain implements ISamEsureyFamilyDomain {

	@Reference
	private ISamEsureyFamilyDao samEsureyFamilyDao;
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
	
	public void insert(SamEsureyFamily dataBean) {
		samEsureyFamilyDao.insert(dataBean);		
	}

	public DataSet query(ParameterSet pset) {
		
		return samEsureyFamilyDao.query(pset);
	}

	public void update(SamEsureyFamily dataBean) {
	
		samEsureyFamilyDao.update(dataBean);
	}
	/**
	 * 删除困难家庭及其相关的信息
	 */
	public void delete(String familyId){
		//查询
		ParameterSet pset=new ParameterSet();
		pset.setParameter("FAMILY_ID@=", familyId);
		int num=samEsureyRelationDomain.query(pset).getCount();
		if(num>0){
			List<String> supportIds=new ArrayList<String>();
			for(int i=0;i<num;i++){
				SamEsureyRelation relationRecord=(SamEsureyRelation)samEsureyRelationDomain.query(pset).getRecord(i).toBean(SamEsureyRelation.class);
				String supportId=relationRecord.getSupportFamilyId();
				supportIds.add(supportId);
			}
			pset.clear();
			for(int i=supportIds.size()-1;i>=0;i--){
				ParameterSet spset=new ParameterSet();
				String sfamId=supportIds.get(i);
				spset.setParameter("FAMILY_ID@=",sfamId);
				SamEsureyPeople esureyPeople=(SamEsureyPeople)samEsureyPeopleDao.query(spset).getRecord(i).toBean(SamEsureyPeople.class);
				String peopleId=esureyPeople.getPeopleId();
				//根据人员Id来删除从表
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
				//删除关系表和家庭表
				samEsureyRelationDomain.delete(sfamId);
				samEsureyFamilyDao.delete(sfamId);
				spset.clear();
			}			
		}		
		ParameterSet qpset=new ParameterSet();
		qpset.setParameter("FAMILY_ID@=", familyId);
		int pNum=samEsureyPeopleDao.query(qpset).getCount();
		for(int i=pNum-1;i>=0;i--){
			SamEsureyPeople esureyPeople=(SamEsureyPeople)samEsureyPeopleDao.query(qpset).getRecord(i).toBean(SamEsureyPeople.class);
			String peopleId=esureyPeople.getPeopleId();
			//根据人员Id来删除从表
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
		}
		samEsureyFamilyDao.delete(familyId);
	}
	/**
	 * 删除赡养家庭信息
	 * 
	 */
	public void deleteSupFamily(String familyId,String supFamilyId){
		//删除关系表
		samEsureyRelationDomain.deleteSupFamily(supFamilyId, familyId);
		//删除经济表和人员表
		ParameterSet qpset=new ParameterSet();
		qpset.setParameter("FAMILY_ID@=", supFamilyId);
		int pNum=samEsureyPeopleDao.query(qpset).getCount();
		for(int i=pNum-1;i>=0;i--){
			SamEsureyPeople esureyPeople=(SamEsureyPeople)samEsureyPeopleDao.query(qpset).getRecord(i).toBean(SamEsureyPeople.class);
			String peopleId=esureyPeople.getPeopleId();
			//根据人员Id来删除从表
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
		}
		//删除家庭表
		samEsureyFamilyDao.delete(supFamilyId);
	}
	public DataSet queryByFamilyIds(ParameterSet pset) {
		return samEsureyFamilyDao.queryByFamilyIds(pset);
	}
	
	public DataSet familySum(String familyId){
		return null;
		
	}
	public void submit(String familyId,String checkOrgArea,String flag) {
		samEsureyFamilyDao.submit(familyId,checkOrgArea,flag);
	}	
	/**
	 * 更新家庭信息中的人员数和经济收入
	 */
	public void updateFamilyInfo(String familyId){
		ParameterSet pset=new ParameterSet();
		pset.setParameter("FAMILY_ID", familyId);
		int num=samEsureyPeopleDao.query(pset).getCount();
		float yearIncome=0;
		float monthIncome=0;
		for(int i=0;i<num;i++){
			SamEsureyPeople peopleBean=(SamEsureyPeople)samEsureyPeopleDao.query(pset).getRecord(i).toBean(SamEsureyPeople.class);
			String pyear=peopleBean.getIncomeYear();
			String pmonth=peopleBean.getIncomeMonth();
			yearIncome=yearIncome+Float.parseFloat(pyear);
			monthIncome=monthIncome+Float.parseFloat(pmonth);
		}
		float yearAverageIncome=Math.round(yearIncome/num*100)/100;
		float monthAverageIncome=Math.round(monthIncome/num*100)/100;
		SamEsureyFamily bean=(SamEsureyFamily)samEsureyFamilyDao.query(pset).getRecord(0).toBean(SamEsureyFamily.class);
		if(num>0){
			bean.setPeopleNum(num+"");
			bean.setYearIncome(Float.toString(yearIncome));
			bean.setYearAverageIncome(Float.toString(yearAverageIncome));
			bean.setMonthIncome(Float.toString(monthIncome));
			bean.setMonthAverageIncome(Float.toString(monthAverageIncome));
		}else{
			bean.setPeopleNum("0");
			bean.setYearIncome("0");
			bean.setYearAverageIncome("0");
			bean.setMonthIncome("0");
			bean.setMonthAverageIncome("0");			
		}
		samEsureyFamilyDao.update(bean);		
	}
	/**
	 * 通过户主信息更新家庭信息
	 */

	public void updateNameOrIdCard(ParameterSet pset) {
		samEsureyFamilyDao.	updateNameOrIdCard(pset);
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
	 * 查询统计
	 */

	public DataSet queryStatistics(ParameterSet pset) {
		return samEsureyFamilyDao.queryStatistics(pset);
	}
	/**
	 * 收入或财产统计
	 */
	public DataSet queryIncomeWorth(ParameterSet pset){
		return samEsureyFamilyDao.queryIncomeWorth(pset);
	}
	public DataSet queryCredit(ParameterSet pset) {
		// TODO Auto-generated method stub
		return samEsureyFamilyDao.queryCredit(pset);
	}
	/**
	 * 查询是否存在相应的信息
	 */
	public BigDecimal beExistMess(String idCard){
		
		return samEsureyFamilyDao.beExistMess(idCard);
	}
   /**
    * 
    * 2-区县经济核对中心上报核对任务
    */
	public void centerSubmit(String familyId, String checkOrgArea,String flag) {
		samEsureyFamilyDao.centerSubmit(familyId,checkOrgArea,flag);
	}
	
	@Trans
	public void batchInsert(List<SamEsureyFamily> list) {
		samEsureyFamilyDao.batchInsert(list);
	}

	@Trans
	public void batchUpdate(List<SamEsureyFamily> list) {
		samEsureyFamilyDao.batchUpdate(list);
	}
}
