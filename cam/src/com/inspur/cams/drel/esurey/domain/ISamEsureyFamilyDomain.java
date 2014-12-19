package com.inspur.cams.drel.esurey.domain;

import java.math.BigDecimal;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.esurey.data.SamEsureyFamily;
import com.inspur.cams.drel.sam.data.SamBankAccount;


public interface ISamEsureyFamilyDomain {
	
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
	public void insert(SamEsureyFamily dataBean);
	/**
	 * 更新经济核对_家庭申报信息
	 * @param dataBean
	 */
	@Trans
	public void update(SamEsureyFamily dataBean);
	/**
	 * 社区提交信息
	 * @param familyId
	 */
	@Trans
	public void submit(String familyId,String checkOrgArea,String flag);
	@Trans
	public void delete(String familyId);
	@Trans
	public void deleteSupFamily(String familyId,String supFamilyId);
	/**
	 * 根据家庭ID数组查询家庭
	 * @param pset
	 * @return
	 */
	@Trans
	public DataSet queryByFamilyIds(ParameterSet pset);

	public DataSet familySum(String familyId);
	/**
	 * 更新家庭中的人员数和收入情况
	 */
	@Trans
	public void updateFamilyInfo(String familyId);
	/**
	 * 更新家庭户主名称和省份证号码
	 */
	@Trans
	public void updateNameOrIdCard(ParameterSet pset);
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
	 * 核对详细查询统计
	 */
	public DataSet queryStatistics(ParameterSet pset);
	/**
	 * 收入或财产统计
	 */
	public DataSet queryIncomeWorth(ParameterSet pset);
	public DataSet queryCredit(ParameterSet pset);
	/**
	 * 查询是否存在相应的信息
	 */
	public BigDecimal beExistMess(String idCard);

	/**
	 * 区县经济核对中心上报核对任务
	 * @param familyId
	 * @param checkOrgArea
	 * @param flag
	 */
	@Trans
	public void centerSubmit(String familyId, String checkOrgArea,String flag);

	public void batchInsert(List<SamEsureyFamily> bankAccountAddList);

	public void batchUpdate(List<SamEsureyFamily> bankAccountEditList);

}
