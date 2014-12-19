package com.inspur.cams.marry.application.domain.support;

import org.loushang.bsp.security.context.impl.Bsp5GetBspInfo;
import org.loushang.sca.ScaComponentFactory;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.marry.application.domain.IMrmLevelApplyDomain;
import com.inspur.cams.marry.base.data.MrmOrganStandardApply;
import com.inspur.cams.marry.base.domain.IMrmElectronicDomain;
import com.inspur.cams.marry.base.domain.IMrmOrganStandardApplyDomain;
import com.inspur.cams.marry.base.domain.IMrmRegisOrganInfoDomain;
import com.inspur.cams.marry.util.CheckStatus;
import com.inspur.cams.marry.util.MrmApplyType;

/**
 * 婚姻登记机关等级评定申报domain
 */
public class MrmLevelApplyDomain implements IMrmLevelApplyDomain {

	@Reference
	private IMrmOrganStandardApplyDomain mrmOrganStandardApplyDomain;
	@Reference
	private IMrmRegisOrganInfoDomain mrmRegisOrganInfoDomain;
	@Reference
	private IMrmElectronicDomain mrmElectronicDomain;
	/**
	 * 新增业务信息
	 */
	public String insert(MrmOrganStandardApply mrmOrganStandardApply){
		if(MrmApplyType.MRM_RECTIFICATION.equals(mrmOrganStandardApply.getApplyType())  || 
				MrmApplyType.MRM_CANCEL.equals(mrmOrganStandardApply.getApplyType())	){
			mrmOrganStandardApply.setCurOrganCode(BspUtil.getOrganCode());
			mrmOrganStandardApply.setCurOrganName(BspUtil.getOrganName());
		}else{
			mrmOrganStandardApply.setCurOrganCode(mrmOrganStandardApply.getOrganCode());
			mrmOrganStandardApply.setCurOrganName(mrmOrganStandardApply.getOrganName());
		}
		mrmOrganStandardApply.setCheckStatus(CheckStatus.DJC_BC);// 保存
		mrmOrganStandardApply.setAuditResult("0");// 审批结果
		mrmOrganStandardApply.setIfFinish("0");// 审批是否结束
		if(MrmApplyType.MRM_RECTIFICATION.equals(mrmOrganStandardApply.getApplyType())){
			if("12".equals(mrmOrganStandardApply.getCorrectOrganLevel())){
				mrmOrganStandardApply.setCorrectOrganCode(BspUtil.getParentOrgan().getOrganCode());
				mrmOrganStandardApply.setCorrectOrgan(BspUtil.getParentOrgan().getOrganName());
			}else if("11".equals(mrmOrganStandardApply.getCorrectOrganLevel())){
				mrmOrganStandardApply.setCorrectOrganCode("370000000000");
				mrmOrganStandardApply.setCorrectOrgan("山东省民政厅");
			}
			
		}
		String organType=mrmOrganStandardApply.getDealOrganType();
		if("13".equals(organType)){
			mrmOrganStandardApply.setTownOrganCode(BspUtil.getOrganCode());
			mrmOrganStandardApply.setTownAuditTime(DateUtil.getDay());
		}else if ("12".equals(organType)) {
			mrmOrganStandardApply.setCityOrganCode(BspUtil.getOrganCode());
			mrmOrganStandardApply.setCityAuditTime(DateUtil.getDay());
		}else if ("11".equals(organType)) {
			mrmOrganStandardApply.setProvinceOrganCode(BspUtil.getOrganCode());
			mrmOrganStandardApply.setProvinceAuditTime(DateUtil.getDay());
		}else if ("0".equals(organType)){//部
			mrmOrganStandardApply.setDepartmentOrganCode("999");
			mrmOrganStandardApply.setDepartmentAuditTime(DateUtil.getDay());
		}
		mrmOrganStandardApplyDomain.insert(mrmOrganStandardApply);			
		return mrmOrganStandardApply.getApplyId();
	}
	public String insertu(MrmOrganStandardApply mrmOrganStandardApply){
		if(MrmApplyType.MRM_RECTIFICATION.equals(mrmOrganStandardApply.getApplyType())  || 
				MrmApplyType.MRM_CANCEL.equals(mrmOrganStandardApply.getApplyType())	){
			mrmOrganStandardApply.setCurOrganCode(BspUtil.getOrganCode());
			mrmOrganStandardApply.setCurOrganName(BspUtil.getOrganName());
		}else{
			mrmOrganStandardApply.setCurOrganCode(mrmOrganStandardApply.getOrganCode());
			mrmOrganStandardApply.setCurOrganName(mrmOrganStandardApply.getOrganName());
		}
		mrmOrganStandardApply.setCheckStatus(CheckStatus.DJC_BC);// 保存
		mrmOrganStandardApply.setAuditResult("0");// 审批结果
		mrmOrganStandardApply.setIfFinish("0");// 审批是否结束
		mrmOrganStandardApplyDomain.update(mrmOrganStandardApply);		
		return mrmOrganStandardApply.getApplyId();
	}
	/**
	 * 新增并提交
	 */
	public void insertAndSend(MrmOrganStandardApply mrmOrganStandardApply){
		insert(mrmOrganStandardApply);
		String organType=mrmOrganStandardApply.getDealOrganType();
		if(MrmApplyType.MRM_RECTIFICATION.equals(mrmOrganStandardApply.getApplyType())  || 
				MrmApplyType.MRM_CANCEL.equals(mrmOrganStandardApply.getApplyType())	){
			if("0".equals(organType)){
				mrmOrganStandardApply.setCurOrganCode("999");
				mrmOrganStandardApply.setCurOrganName("中华人民共和国民政部");
				updateAndSend(mrmOrganStandardApply);
			}else{
				mrmOrganStandardApply.setCurOrganCode(BspUtil.getParentOrgan().getOrganCode());
				mrmOrganStandardApply.setCurOrganName(BspUtil.getParentOrgan().getOrganName());
			}
		}else{
			mrmOrganStandardApply.setCurOrganCode(BspUtil.getOrganCode());
			mrmOrganStandardApply.setCurOrganName(BspUtil.getOrganName());
		}
		if(!"0".equals(organType)){
			mrmOrganStandardApply.setCheckStatus(CheckStatus.DJC_SB);// 已上报
		} 
		mrmOrganStandardApplyDomain.update(mrmOrganStandardApply);		
	}
	public void insertuAndSend(MrmOrganStandardApply mrmOrganStandardApply){
		insertu(mrmOrganStandardApply);
		if(MrmApplyType.MRM_RECTIFICATION.equals(mrmOrganStandardApply.getApplyType())  || 
				MrmApplyType.MRM_CANCEL.equals(mrmOrganStandardApply.getApplyType())	){
			mrmOrganStandardApply.setCurOrganCode(BspUtil.getParentOrgan().getOrganCode());
			mrmOrganStandardApply.setCurOrganName(BspUtil.getParentOrgan().getOrganName());
		}else{
			mrmOrganStandardApply.setCurOrganCode(BspUtil.getOrganCode());
			mrmOrganStandardApply.setCurOrganName(BspUtil.getOrganName());
		}
		mrmOrganStandardApply.setCheckStatus(CheckStatus.DJC_SB);// 已上报
		mrmOrganStandardApplyDomain.update(mrmOrganStandardApply);		
	}
	/**
	 * 修改业务信息
	 */
	public void update(MrmOrganStandardApply mrmOrganStandardApply){
		String organType=mrmOrganStandardApply.getDealOrganType();
		if("13".equals(organType)){
			mrmOrganStandardApply.setTownOrganCode(BspUtil.getOrganCode());
			mrmOrganStandardApply.setTownAuditTime(DateUtil.getDay());
		}else if ("12".equals(organType)) {
			mrmOrganStandardApply.setCityOrganCode(BspUtil.getOrganCode());
			mrmOrganStandardApply.setCityAuditTime(DateUtil.getDay());
		}else if ("11".equals(organType)) {
			mrmOrganStandardApply.setProvinceOrganCode(BspUtil.getOrganCode());
			mrmOrganStandardApply.setProvinceAuditTime(DateUtil.getDay());
		}else if ("0".equals(organType)){
			mrmOrganStandardApply.setDepartmentOrganCode("999");
			mrmOrganStandardApply.setDepartmentAuditTime(DateUtil.getDay());
		}
		mrmOrganStandardApplyDomain.update(mrmOrganStandardApply);			
	}
	/**
	 * 修改并提交
	 */
	public void updateAndSend(MrmOrganStandardApply mrmOrganStandardApply){
		update(mrmOrganStandardApply);
		String organType=mrmOrganStandardApply.getDealOrganType();
		String applyType=mrmOrganStandardApply.getApplyType();
		String opinionId;
		if("13".equals(organType)){//区县级
			opinionId=mrmOrganStandardApply.getTownOpinionId();
			if("1".equals(opinionId)){
				mrmOrganStandardApply.setCheckStatus(CheckStatus.QX_TG);
				mrmOrganStandardApply.setCurOrganCode(BspUtil.getParentOrgan().getOrganCode());
				mrmOrganStandardApply.setCurOrganName(BspUtil.getParentOrgan().getOrganName());
			}else if("2".equals(opinionId)){
				mrmOrganStandardApply.setCurOrganCode(mrmOrganStandardApply.getOrganCode());
				mrmOrganStandardApply.setCurOrganName(mrmOrganStandardApply.getOrganName());
				mrmOrganStandardApply.setCheckStatus(CheckStatus.QX_TH);
			}else{
				mrmOrganStandardApply.setCurOrganCode(BspUtil.getOrganCode());
				mrmOrganStandardApply.setCurOrganName(BspUtil.getOrganName());
				mrmOrganStandardApply.setCheckStatus(CheckStatus.QX_WTG);
				mrmOrganStandardApply.setAuditResult("2");// 审批结果
				mrmOrganStandardApply.setIfFinish("1");// 审批是否结束
			}
		}else if ("12".equals(organType)) {//市级
			opinionId=mrmOrganStandardApply.getCityOpinionId();	
			if("1".equals(opinionId)){
				mrmOrganStandardApply.setCheckStatus(CheckStatus.DS_TG);
				mrmOrganStandardApply.setCurOrganCode(BspUtil.getParentOrgan().getOrganCode());
				mrmOrganStandardApply.setCurOrganName(BspUtil.getParentOrgan().getOrganName());
				if(MrmApplyType.MRM_RECTIFICATION.equals(mrmOrganStandardApply.getApplyType())){
					if("12".equals(mrmOrganStandardApply.getCorrectOrganLevel())){
						mrmOrganStandardApply.setIfFinish("1");// 审批是否结束
						mrmOrganStandardApply.setAuditResult("1");// 审批结果
						mrmOrganStandardApply.setCurOrganCode(BspUtil.getOrganCode());
						mrmOrganStandardApply.setCurOrganName(BspUtil.getOrganName());
					}
				}
			}else if("2".equals(opinionId)){
				mrmOrganStandardApply.setCurOrganCode(mrmOrganStandardApply.getTownOrganCode());
				mrmOrganStandardApply.setCurOrganName(mrmOrganStandardApply.getTownOrganName());
				mrmOrganStandardApply.setCheckStatus(CheckStatus.DS_TH);
				
			}else{
				mrmOrganStandardApply.setCurOrganCode(mrmOrganStandardApply.getCityOrganCode());
				mrmOrganStandardApply.setCurOrganName(mrmOrganStandardApply.getCityOrganName());
				mrmOrganStandardApply.setCheckStatus(CheckStatus.DS_WTG);
				mrmOrganStandardApply.setIfFinish("1");// 审批是否结束
				mrmOrganStandardApply.setAuditResult("2");// 审批结果
			}
		}else if ("11".equals(organType)) {//省级 
			opinionId=mrmOrganStandardApply.getProvinceOpinionId();	
			if("1".equals(opinionId)){
				mrmOrganStandardApply.setCheckStatus(CheckStatus.S_TG);
				mrmOrganStandardApply.setCurOrganCode("999");
				mrmOrganStandardApply.setCurOrganName("中华人民共和国民政部");
				if(MrmApplyType.MRM_RECTIFICATION.equals(mrmOrganStandardApply.getApplyType())){
					if("11".equals(mrmOrganStandardApply.getCorrectOrganLevel())){
						mrmOrganStandardApply.setIfFinish("1");// 审批是否结束
						mrmOrganStandardApply.setAuditResult("1");// 审批结果
						mrmOrganStandardApply.setCurOrganCode(BspUtil.getOrganCode());
						mrmOrganStandardApply.setCurOrganName(BspUtil.getOrganName());
					}
				}
				
			}else if("2".equals(opinionId)) {
				mrmOrganStandardApply.setCurOrganCode(mrmOrganStandardApply.getCityOrganCode());
				mrmOrganStandardApply.setCurOrganName(mrmOrganStandardApply.getCityOrganName());
				mrmOrganStandardApply.setCheckStatus(CheckStatus.S_TH);
			}else{
				mrmOrganStandardApply.setCurOrganCode(mrmOrganStandardApply.getProvinceOrganCode());
				mrmOrganStandardApply.setCurOrganName(mrmOrganStandardApply.getProvinceOrganName());
				mrmOrganStandardApply.setCheckStatus(CheckStatus.S_WTG);
				mrmOrganStandardApply.setAuditResult("2");// 审批结果
				mrmOrganStandardApply.setIfFinish("1");// 审批是否结束
			}		
		}else {//民政部
			opinionId=mrmOrganStandardApply.getDepartmentOpinionId();	
			if("1".equals(opinionId)){
				mrmOrganStandardApply.setCheckStatus(CheckStatus.B_TG);
				mrmOrganStandardApply.setAuditResult("1");// 审批结果
				mrmOrganStandardApply.setIfFinish("1");// 审批是否结束
				if("1".equals(applyType)||"2".equals(applyType)){
			      try {
			      	  mrmRegisOrganInfoDomain.setLevel(mrmOrganStandardApply.getApplyLevel(),mrmOrganStandardApply.getOrganCode());
			      } catch (Exception e) {
				      e.printStackTrace();
			      }
				}else{
				  try {
			      	  mrmRegisOrganInfoDomain.setLevel("00",mrmOrganStandardApply.getOrganCode());
			      } catch (Exception e) {
				      e.printStackTrace();
			      }
				}
			}else if("2".equals(opinionId)){
				mrmOrganStandardApply.setCurOrganCode(mrmOrganStandardApply.getProvinceOrganCode());
				mrmOrganStandardApply.setCurOrganName(mrmOrganStandardApply.getProvinceOrganName());
				mrmOrganStandardApply.setCheckStatus(CheckStatus.B_TH);
				
			}else{
				mrmOrganStandardApply.setCurOrganCode(mrmOrganStandardApply.getCurOrganCode());
				mrmOrganStandardApply.setCurOrganName(mrmOrganStandardApply.getCurOrganName());
				mrmOrganStandardApply.setCheckStatus(CheckStatus.B_WTG);
				mrmOrganStandardApply.setIfFinish("1");// 审批是否结束
				mrmOrganStandardApply.setAuditResult("2");// 审批结果
			}			
		}
		mrmOrganStandardApplyDomain.update(mrmOrganStandardApply);				
	}
	/**
	 * 删除业务信息
	 */
	public void delete(String applyId){
		mrmOrganStandardApplyDomain.delete(applyId);
		mrmElectronicDomain.delByApplyId(applyId);
	}
	/**
	 * 删除冗余电子附件
	 */
	public void deleteElec(String applyId){
		mrmElectronicDomain.delByApplyId(applyId);
	}
}
