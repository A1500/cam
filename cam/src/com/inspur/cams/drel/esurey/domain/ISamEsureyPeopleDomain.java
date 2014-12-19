package com.inspur.cams.drel.esurey.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.esurey.data.SamEsureyPeople;

public interface ISamEsureyPeopleDomain {
	/**
	 * 批量保存成员信息
	 */
	public void batchInsert(List<SamEsureyPeople> list);
	/**
	 * 查询经济核对_家庭申报信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	
	/**
	 * 增加经济核对_家庭申报信息
	 * @param dataBean
	 */
	@Trans
	public void insert(SamEsureyPeople dataBean);
	
	/**
	 * 更新经济核对_家庭申报信息
	 * @param dataBean
	 */
	@Trans
	public void update(SamEsureyPeople dataBean);
	@Trans
	public void delete(String delId);
	/**
	 * 删除家庭下的某个成员
	 */	
	@Trans
	public void deletePeople(String familyId,String peopleId,String Flag);
	/**
	 * 社保信息
	 */
	public void getSamEsureySocial(Record[] SamSocials,String peopleId);
	/**
	 * 社保财产信息
	 */
	public void getEstateSocial(String peopleId,String familyId);
	/**
	 * 财产信息
	 */
	public void getSamEsureyEstate(Record[] records,String peopleId,String familyId);
	/**
	 * 保存房屋信息
	 */
	public void getSamEsureyHouse(Record[] records,String peopleId);
	/**
	 * 房屋财产信息
	 * @param peopleId
	 */
	public void getEsureyHouse(String peopleId,String familyId);
	/**
	 * 工商信息
	 */
	public void getSamEsureyBusiness(Record[] records,String peopleId);
	/**
	 * 车辆信息
	 */
	public void getSamEsureyCar(Record[] records,String peopleId);
	/**
	 * 车辆财产信息
	 * @param peopleId
	 */
	public void getEsureyCar(String peopleId,String familyId);
	/*
	 * 国税信息
	 */
	public void getEsureyTaxG(Record[] records,String peopleId);
	/*
	 * 地税信息
	 */
	public void getEsureyTaxD(Record[] records,String peopleId);
	/*
	 * 公积金信息
	 */
	public void getEsureyFund(Record[] records,String peopleId);
	/*
	 * 人行信息
	 */
	public void getEsureyBank(Record[] records,String peopleId);

	/**
	 * 银行财产信息
	 * @param peopleId
	 */
	public  void getBankEstate(String peopleId,String familyId);
	/*
	 * 证监信息
	 */
	public void getEsureySecurities(Record[] records,String peopleId);
	/**
	 * 有价证券信息
	 * @param peopleId
	 */
	public void getSecuritiesEstate(String peopleId,String familyId);
	/*
	 * 保监信息
	 */
	public void getEsureyInsurance(Record[] records,String peopleId);
	/**
	 * 根据familyId查询赡养人员
	 */
	public DataSet querySupportPeople(ParameterSet pset);
	/**
	 * 根据peopleId查询信息
	 */
	public DataSet queryPeopleById(ParameterSet pset);
	/**
	 * 检查家庭成员中身份证的唯一性
	 */
	public String queryUnqiue(ParameterSet pset);
}
