package com.inspur.cams.drel.sam.domain.support;

import java.math.BigDecimal;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.domain.IBaseinfoDomain;
import com.inspur.cams.drel.sam.dao.ISamApplyInfoDao;
import com.inspur.cams.drel.sam.data.SamApplyInfo;
import com.inspur.cams.drel.sam.domain.ISamApplyInfoDomain;
import com.inspur.cams.drel.sam.domain.ISamFamilyTreatmentDomain;
/**
 * @title:低保申请审批信息Domain
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public class SamApplyInfoDomain implements ISamApplyInfoDomain {
	@Reference
	private ISamApplyInfoDao samApplyInfoDao;
	@Reference
	private IBaseinfoDomain baseinfoDomain;
	@Reference
	private ISamFamilyTreatmentDomain samFamilyTreatmentDomain;
	
	public void insert(SamApplyInfo samApplyInfo) {
		samApplyInfoDao.insert(samApplyInfo);
	}

	public DataSet query(ParameterSet pset) {
		return samApplyInfoDao.query(pset);
	}

	public void update(SamApplyInfo samApplyInfo) {
		samApplyInfoDao.update(samApplyInfo);
	}

	public String updatePhoto(String photoId, String photoText) {
		return samApplyInfoDao.updatePhoto(photoId, photoText);
	}

	public DataSet queryDaiBan(ParameterSet pset) {
		return samApplyInfoDao.queryDaiBanAndEnsure(pset);
	}

	
	public DataSet queryExport(ParameterSet pset) {
		return samApplyInfoDao.queryExport(pset);
	}
	
	
	public  DataSet queryForExportPeople(ParameterSet pset) {
		return samApplyInfoDao.queryForExportPeople(pset);
	}

	
	
	public DataSet queryEnd(ParameterSet pset) {
		return samApplyInfoDao.queryEnd(pset);
	}

	public DataSet queryYiBan(ParameterSet pset) {
		return samApplyInfoDao.queryYiBan(pset);
	}
	public DataSet queryHis(ParameterSet pset){
		return samApplyInfoDao.queryHis(pset);
	}
	/**
	 * 获取一条家庭和待遇信息关联的家庭信息
	 * @param FAMILY_ID
	 */
	public DataSet getSamFamily(ParameterSet pset) {
		DataSet ds=samFamilyTreatmentDomain.query(pset);
		DataSet ds1=baseinfoDomain.queryFamily(pset);
		if(ds.getCount() == 1){
			if(ds1.getCount() == 1){
				ds1.getRecord(0).set("assistanceMode", ds.getRecord(0).get("assistanceMode"));
				ds1.getRecord(0).set("assistanceMoney", ds.getRecord(0).get("assistanceMoney"));
				ds1.getRecord(0).set("assistanceClassMoney", ds.getRecord(0).get("assistanceClassMoney"));
				ds1.getRecord(0).set("treatmentId", ds.getRecord(0).get("treatmentId"));
			}
		}
		return ds1;
	}
	/**
	 * 调用存储过程把记录保存到备用表中
	 */
	public void toDuplicateRecord(SamApplyInfo applyInfo) {
		samApplyInfoDao.toDuplicateRecord(applyInfo);
	}
	/**
	 * 根据主键删除业务信息
	 * @param applyId
	 */
	public void deleteSamApply(String applyId) {
		if(applyId != null && !"".equals(applyId)){
			samApplyInfoDao.deleteSamApply(applyId);
		}
	}
	/**
	* @Title: insertApplyFromEnsurey
	* @Description: (从经济核对回填业务信息)
	* @param set void  
	* @throws
	* @author luguosui
	 */
	public void insertApplyFromEnsurey(ParameterSet set) {
		
	}

	/**
	* @Title: addCheck
	* @Description:(审批时发起核对方法) void  
	* @param set
	* @throws
	* @author luguosui
	 */
	public void addCheck(ParameterSet set) {
		samApplyInfoDao.addCheck(set);
	}
	/**
	 * 调用存储过程删除历史采集的信息
	 */
	public void deleteHisInfoByApplyAndFamilyId(String applyId, String familyId) {
		samApplyInfoDao.deleteHisInfoByApplyAndFamilyId(applyId,familyId);
	}

	public DataSet queryNoticePrintData(ParameterSet pset) {
		return samApplyInfoDao.queryNoticePrintData(pset);
	}
	/**
	 * 获取最低生活保障标准
	 * @param pset
	 */ 
	public BigDecimal getAssistanceMoney(ParameterSet pset) {
		return samApplyInfoDao.getAssistanceMoney(pset);
	}
	/**
	 * 计算城市户月保障金
	 * @param baseinfoFamily
	 * @return
	 */
	public BigDecimal getCityAssistanceMoney(BaseinfoFamily baseinfoFamily) {
		//户月保障金=最低生活标准*保障人口数-所有家庭成员收入
		ParameterSet pset =new ParameterSet();
		pset.setParameter("assitanceType", "01");
		BigDecimal lowStandards=getAssistanceMoney(pset);
		if(lowStandards ==null){
			lowStandards=new BigDecimal("0");
		}
		BigDecimal assistanceMoney=new BigDecimal("0");
		if("0".equals(baseinfoFamily.getAssistancePeopleNum().toString())){
			assistanceMoney  =new BigDecimal("0");
		}else{
			assistanceMoney=lowStandards.multiply(baseinfoFamily.getAssistancePeopleNum())
			.subtract(baseinfoFamily.getMonthIncome());
		}
		if(assistanceMoney.compareTo(new BigDecimal(0)) == -1){//如果值小于0
			assistanceMoney=new BigDecimal("0");
		}
		return assistanceMoney;
	}
	/**
	 * 计算农村户月保障金
	 * @param baseinfoFamily
	 * @return
	 */
	public BigDecimal getCountryAssistanceMoney(BaseinfoFamily baseinfoFamily){
		//户月保障金=最低生活标准*保障人口数-所有家庭成员收入
		ParameterSet pset =new ParameterSet();
		pset.clear();
		pset.setParameter("assitanceType", "02");
		BigDecimal lowStandards=getAssistanceMoney(pset);
		if(lowStandards ==null){
			lowStandards=new BigDecimal("0");
		}
		
		BigDecimal assistanceMoney=new BigDecimal("0");
		if("0".equals(baseinfoFamily.getAssistancePeopleNum().toString())){
			assistanceMoney  =new BigDecimal("0");
		}else{
			assistanceMoney=lowStandards.multiply(
					baseinfoFamily.getAssistancePeopleNum())
			.subtract(baseinfoFamily.getYearIncome());
		}
		if(assistanceMoney.compareTo(new BigDecimal("0")) == -1){//如果值小于0
			assistanceMoney=new BigDecimal("0");
		}
		
		assistanceMoney=assistanceMoney.divide(new BigDecimal("12"),2,BigDecimal.ROUND_HALF_UP);
//		BigDecimal totle=new BigDecimal("153.1");
//		System.out.println("正常数字=" +totle.divide(new BigDecimal(100)));
//		System.out.println("四舍五入保留2位小数=" +totle.divide(new BigDecimal(100),2,BigDecimal.ROUND_HALF_UP));
//		System.out.println("四舍五入保留0位小数=" +totle.divide(new BigDecimal(100),0,BigDecimal.ROUND_HALF_UP));
//		System.out.println("舍掉小数=" +totle.divide(new BigDecimal("100")).setScale(0,BigDecimal.ROUND_DOWN));
//		System.out.println("舍掉2位后面的数小数=" +totle.divide(new BigDecimal("100")).setScale(2,BigDecimal.ROUND_DOWN));
//		System.out.println("小数点后面有值就进位=" +totle.divide(new BigDecimal("100")).setScale(2,BigDecimal.ROUND_UP));
		return assistanceMoney;
	}

	public void deleteHisPeople(String peopleId, String familyId) {
		samApplyInfoDao.deleteHisPeople(peopleId,familyId);
		
	}
	/**
	 * 
	 */
	public void updateCurActId(String struId, String applyId) {
		samApplyInfoDao.updateCurActId(struId,applyId);
	}
	
	
	public void updateFamilyArchive(SamApplyInfo applyInfo) {
		// TODO Auto-generated method stub
		samApplyInfoDao.updateFamilyArchive(applyInfo);		
	}
	
	public DataSet queryRecheckToChange(ParameterSet pset) {
		// TODO Auto-generated method stub
		return samApplyInfoDao.queryEnd(pset);
	}
	
	
	public  DataSet queryForPeopleDetail(ParameterSet pset){
		return samApplyInfoDao.queryForPeopleDetail(pset);
	}
	
	
	public  DataSet queryInTheWarranty(ParameterSet pset){
		return samApplyInfoDao.queryInTheWarranty(pset);
	}
	
	public  DataSet queryInAssitanceDetail(ParameterSet pset){
		return samApplyInfoDao.queryInAssitanceDetail(pset);
	}
	
	//批量保存
	public void batchInsert(List list){
		 samApplyInfoDao.batchInsert(list);
	}
}
