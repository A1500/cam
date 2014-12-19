package com.inspur.cams.drel.sam.domain.support;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.drel.sam.dao.ISamFamilyTreatmentDao;
import com.inspur.cams.drel.sam.data.SamFamilyTreatment;
import com.inspur.cams.drel.sam.data.SamTreatmentAdjust;
import com.inspur.cams.drel.sam.domain.ISamFamilyTreatmentDomain;
import com.inspur.cams.drel.sam.domain.ISamTreatmentAdjustDomain;
/**
 * @title:家庭待遇信息Domain
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public class SamFamilyTreatmentDomain implements ISamFamilyTreatmentDomain{
	@Reference
	private ISamFamilyTreatmentDao samFamilyTreatmentDao;
	@Reference
	private ISamTreatmentAdjustDomain samTreatmentAdjustDomain;

	/**
	 * 增加家庭待遇信息
	 * @param samFamilyTreatment
	 */
	public void insert(SamFamilyTreatment samFamilyTreatment) {
		samFamilyTreatmentDao.insert(samFamilyTreatment);
	}
	/**
	 * 查询家庭待遇信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samFamilyTreatmentDao.query(pset);
	}
	public DataSet queryAdjustList(ParameterSet pset){
		return samFamilyTreatmentDao.queryAdjustList(pset);
	}
	/**
	 * 更新家庭待遇信息
	 * @param samFamilyTreatment
	 */
	public void update(SamFamilyTreatment samFamilyTreatment) {
		samFamilyTreatmentDao.update(samFamilyTreatment);
	}
	/**
	 * 调整保障金
	 */
	public void updateAssistanceMoney(ParameterSet pset){
		String adjustType=(String) pset.getParameter("adjustType");//调整类型
		String adjustTarget=(String) pset.getParameter("adjustTarget");
		String adjustMoney=(String) pset.getParameter("adjustMoney");	
		String treatmentIdValue=(String)pset.getParameter("treatmentIdValue");
		String assistanceMoneyAddValue=(String)pset.getParameter("assistanceMoneyAddValue");
		List<SamTreatmentAdjust> samTreatmentAdjustList=new ArrayList<SamTreatmentAdjust>();
		String[] treatmentIdArray=null;
		String[] assistanceMoneyAddArray = null;
		if (treatmentIdValue.indexOf(',')>0) {//多条数据
			treatmentIdArray=treatmentIdValue.split(",");			
		}else{
			treatmentIdArray=new String[1];
			treatmentIdArray[0]=treatmentIdValue;
		}
		if (assistanceMoneyAddValue.indexOf(',')>0) {
			assistanceMoneyAddArray=assistanceMoneyAddValue.split(",");						
		}else{
			assistanceMoneyAddArray=new String[1];
			assistanceMoneyAddArray[0]=assistanceMoneyAddValue;
		}
		List<SamFamilyTreatment> samFamilyTreatmentList=new ArrayList<SamFamilyTreatment>();
		ParameterSet familyTreatmentPset=new ParameterSet();
		for (int i = 0; i < treatmentIdArray.length; i++) {			 
			SamFamilyTreatment samFamilyTreatment=samFamilyTreatmentDao.get(treatmentIdArray[i]);
			BigDecimal assistanceMoney=samFamilyTreatment.getAssistanceMoney();
			BigDecimal assistanceClassMoney=samFamilyTreatment.getAssistanceClassMoney();
			
			//待遇调整记录
			SamTreatmentAdjust samTreatmentAdjust=new SamTreatmentAdjust();
			samTreatmentAdjust.setTreatmentId(treatmentIdArray[i]);
			samTreatmentAdjust.setAdjustType(adjustType);
			samTreatmentAdjust.setAdjustTarget(adjustTarget);
			samTreatmentAdjust.setAdjustMoney(new BigDecimal(adjustMoney.trim()));			
			if ("01".equals(adjustType)) {//户月保障金
				samTreatmentAdjust.setAssistanceBeforeMoney(assistanceMoney);				
			}else if("02".equals(adjustType)){//分类施保金
				samTreatmentAdjust.setAssistanceBeforeMoney(assistanceClassMoney);				
			}
			
			if ("01".equals(adjustType)) {//户月保障金
				if ("01".equals(adjustTarget)) {				
					assistanceMoney=assistanceMoney.add(BigDecimal.valueOf(Double.parseDouble( adjustMoney )));			
				}else if("02".equals(adjustTarget)){
					assistanceMoney=assistanceMoney.add(BigDecimal.valueOf(Double.parseDouble( assistanceMoneyAddArray[i] )));
				}
				samTreatmentAdjust.setAssistanceMoney(assistanceMoney);				
				samFamilyTreatment.setAssistanceMoney(assistanceMoney);
			}else if("02".equals(adjustType)){//分类施保金
				if ("01".equals(adjustTarget)) {				
					assistanceClassMoney=assistanceClassMoney.add(BigDecimal.valueOf(Double.parseDouble( adjustMoney )));			
				}else if("02".equals(adjustTarget)){
					assistanceClassMoney=assistanceClassMoney.add(BigDecimal.valueOf(Double.parseDouble( assistanceMoneyAddArray[i] )));
				}				
				samTreatmentAdjust.setAssistanceMoney(assistanceClassMoney);				
				samFamilyTreatment.setAssistanceMoney(assistanceClassMoney);			
			}	
			
			samFamilyTreatment.setAdjustDate(DateUtil.getDay());
			samFamilyTreatmentList.add(samFamilyTreatment);
			samTreatmentAdjustList.add(samTreatmentAdjust);			
			familyTreatmentPset.clear();
		}			
		samFamilyTreatmentDao.batchUpdate(samFamilyTreatmentList);		
		samTreatmentAdjustDomain.batchInsert(samTreatmentAdjustList);
	}	
	/**
	 * 调整所有保障金
	 * @param pset
	 */
	public void updateAllAssistanceMoney(ParameterSet pset){		
		//获取符合条件的记录
		DataSet ds=samFamilyTreatmentDao.queryAdjustList(pset);
		List<SamTreatmentAdjust> samTreatmentAdjustList=new ArrayList<SamTreatmentAdjust>();
		String adjustType=(String) pset.getParameter("adjustType");//调整类型
		String adjustTarget=(String) pset.getParameter("adjustTarget");
		String adjustMoney=(String) pset.getParameter("adjustMoney");
		for (int i = 0; i < ds.getCount(); i++) {
			String treatmentId=(String) ds.getRecord(i).get("TREATMENT_ID");
			BigDecimal assistanceMoney=(BigDecimal) ds.getRecord(i).get("ASSISTANCE_MONEY");
			BigDecimal assistanceClassMoney=(BigDecimal) ds.getRecord(i).get("ASSISTANCE_CLASS_MONEY");
			SamTreatmentAdjust samTreatmentAdjust=new SamTreatmentAdjust();
			samTreatmentAdjust.setTreatmentId(treatmentId);
			samTreatmentAdjust.setAdjustType(adjustType);
			samTreatmentAdjust.setAdjustTarget(adjustTarget);
			samTreatmentAdjust.setAdjustMoney(new BigDecimal(adjustMoney.trim()));			
			if ("01".equals(adjustType)) {//户月保障金
				samTreatmentAdjust.setAssistanceBeforeMoney(assistanceMoney);				
			}else if("02".equals(adjustType)){//分类施保金
				samTreatmentAdjust.setAssistanceBeforeMoney(assistanceClassMoney);				
			}
			samTreatmentAdjustList.add(samTreatmentAdjust);
		}		
		samFamilyTreatmentDao.updateAllAssistanceMoney(pset);
		
		//获取符合条件的记录	
		ds=null;
		ds=samFamilyTreatmentDao.queryAdjustList(pset);
		for (int i = 0; i < ds.getCount(); i++) {
			String treatmentId=(String) ds.getRecord(i).get("TREATMENT_ID");
			BigDecimal assistanceMoney=(BigDecimal) ds.getRecord(i).get("ASSISTANCE_MONEY");
			BigDecimal assistanceClassMoney=(BigDecimal) ds.getRecord(i).get("ASSISTANCE_CLASS_MONEY");
			for (int j = 0; j < samTreatmentAdjustList.size(); j++) {
				SamTreatmentAdjust samTreatmentAdjust=samTreatmentAdjustList.get(j);
				if(treatmentId.equals( samTreatmentAdjust.getTreatmentId()) ){
					if ("01".equals(adjustType)) {//户月保障金
						samTreatmentAdjust.setAssistanceMoney(assistanceMoney);				
					}else if("02".equals(adjustType)){//分类施保金
						samTreatmentAdjust.setAssistanceMoney(assistanceClassMoney);				
					}
				}				
			}
		}		
		//批量插入待遇调整记录
		samTreatmentAdjustDomain.batchInsert(samTreatmentAdjustList);
	}
	/**
	 * 身份证校验的时候查询待遇表，看是否正在进行救助
	 * @param pset
	 * @return
	 */
	public DataSet queryForCheckIDCard(ParameterSet pset) {
		return samFamilyTreatmentDao.queryForCheckIDCard(pset);
	}
	public void deleteTreatment(String familyId) {
		samFamilyTreatmentDao.deleteTreatment(familyId);
		
	}

}
