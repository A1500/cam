package com.inspur.cams.fis.ep.base.cmd;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.next.upload.UploadFile;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.fis.ep.base.data.FisCeme;
import com.inspur.cams.fis.ep.base.data.FisCemeAccessories;
import com.inspur.cams.fis.ep.base.data.FisCemeCheckAudit;
import com.inspur.cams.fis.ep.base.data.FisCemeCheckInfo;
import com.inspur.cams.fis.ep.base.data.FisCemeCheckResult;
import com.inspur.cams.fis.ep.base.data.FisCemeCheckScore;
import com.inspur.cams.fis.ep.base.data.FisCemeCheckWf;
import com.inspur.cams.fis.ep.base.data.FisCemeItems;
import com.inspur.cams.fis.ep.base.domain.IFisCemeCheckDomain;
import com.inspur.cams.fis.ep.base.domain.IFisCemeDomain;

/**
 * @title:InspectionCommand
 * @description:
 * @author:
 * @since:2011-11-17
 * @version:1.0
 */
public class FisCemeCheckCmd extends BaseAjaxCommand {
	IFisCemeCheckDomain service = ScaComponentFactory.getService(
			IFisCemeCheckDomain.class, "FisCemeCheckDomain/FisCemeCheckDomain");
	 IFisCemeDomain service1 = ScaComponentFactory.getService(IFisCemeDomain.class,
		"FisCemeDomain/FisCemeDomain");
	/**
	 * @Description: 上报公益性公墓 (县级年检)
	 */
	@Trans
	public void reportNoProfitCheck() {
		service.reportNoProfitCheck(getParameterSet());
	}
	
	/**
	 * @Description: 整改公益性公墓 (县级年检)
	 */
	@Trans
	public void fullChangeNoProfitCheck() {
		service.fullChangeNoProfitCheck(getParameterSet());
	}
	
	/**
	 * @Description: 上报经营性公墓 (县级检查)
	 */
	@Trans
	public void reportProfitCheck() {
		service.reportProfitCheck(getParameterSet());
	}
	
	/**
	 * @Description: 上报经营性公墓 (市级年检)
	 */
	@Trans
	public void reportProfitFinalCheck() {
		service.reportProfitFinalCheck(getParameterSet());
	}
	
	/**
	 * @Description: 整改经营性公墓 (市级年检)
	 */
	@Trans
	public void fullChangeProfitFinalCheck() {
		service.fullChangeProfitFinalCheck(getParameterSet());
	}
	
	/**
	 * @Description: 更新经营性公墓年检信息 (市级年检)
	 */
	@Trans
	public void updateProfitFinalCheck() {
		Record infoRecord = (Record) getParameter("infoRecord");// 基本信息
		FisCemeCheckInfo info = (FisCemeCheckInfo) infoRecord.toBean(FisCemeCheckInfo.class);
		Record wfRecord = (Record) getParameter("wfRecord");	//工作流信息
		FisCemeCheckWf wf = (FisCemeCheckWf) wfRecord.toBean(FisCemeCheckWf.class);
		Record resultRecord = (Record) getParameter("resultRecord");	//年检结果信息
		FisCemeCheckResult result = (FisCemeCheckResult) resultRecord.toBean(FisCemeCheckResult.class);
		Record auditRecord = (Record) getParameter("auditRecord");	// 分数合计及年检报告
		FisCemeCheckAudit audit = (FisCemeCheckAudit) auditRecord.toBean(FisCemeCheckAudit.class);
		Record scoreRecord = (Record) getParameter("scoreRecord");	//各项分值信息
		FisCemeCheckScore score = (FisCemeCheckScore) scoreRecord.toBean(FisCemeCheckScore.class);
		String isReport = (String)getParameter("isReport");	//是否上报
		boolean isUpdate = "true".equals((String)getParameter("isUpdate"));//是否更新T/新增F子表
		
		//年检时同步更新基本表FIS_CEME_INFO
		ParameterSet pset = new ParameterSet();
		String cemeId=info.getCemeId();
		pset.setParameter("CEME_ID", cemeId);
		FisCeme ceme=(FisCeme)service1.query(pset).getRecord(0).toBean(FisCeme.class);
		ceme.setLegalPerson(info.getLegalPerson());
		ceme.setTotalStaff(info.getTotalStaff());
		ceme.setDirectorMobile(info.getDirectorMobile());
		ceme.setOfficePhone(info.getOfficePhone());
		ceme.setFixeDassets(info.getFixeDassets());
		ceme.setTotalInvestment(info.getTotalInvestment());
		ceme.setPostalcode(info.getPostalcode());
		ceme.setTotalArea(info.getTotalArea());
		ceme.setBuiltArea(info.getBuiltArea());
		ceme.setBuiltTotalArea(info.getBuiltTotalArea());
		ceme.setAddress(info.getAddress());
		ceme.setServiceScope(info.getServiceScope());
		service1.update(ceme);
		
		if("1".equals(isReport)) {
			//上报，则当前环节为省级、未编辑、最后业务ID
			wf.setCurrentOrgan("2");
			wf.setIsEdit("0");
		}else {
			//不上报，则当前环节还为市级、未编辑、最后业务ID
			wf.setCurrentOrgan("1");
			wf.setIsEdit("1");
		}
			
		wf.setIsReport(isReport);
		wf.setEndApplyId(info.getApplyId());
		wf.setReportPerson(BspUtil.getEmpOrganId());
		wf.setReportTime(DateUtil.getTime());
		wf.setCheckResult(audit.getSecondResult());
		
		//冗余信息至公墓表
		info.setIsReport(isReport);
		info.setCheckNum(wf.getCheckNum());
		info.setCheckYear(wf.getCheckYear());
		info.setReportPerson(wf.getReportPerson());
		info.setReportTime(wf.getReportTime());
		
		//更新结果表
		result.setCemeId(info.getCemeId());
		result.setCheckNum(wf.getCheckNum());
		result.setCheckYear(wf.getCheckYear());
		result.setSecondAnnuareport(audit.getAnnuareport());
		result.setSecondApplyId(info.getApplyId());
		result.setSecondOpinion(audit.getSecondOpinion());
		result.setSecondResult(audit.getSecondResult());
		result.setSecondTime(audit.getSecondTime());
		result.setSecondTotalScore(audit.getTotalScore());
		result.setSecondUnit(audit.getSecondUnit());
		result.setSecondUnitId(audit.getSecondUnitId());
		result.setIsTakeproof("0");
		
		if("1".equals(wf.getIsReport())) {
			//如果上报，才更新结果表中的年检结果、上报状态
			result.setCheckResult(wf.getCheckResult());
			result.setIsReport(wf.getIsReport());
		}
		
		wf.setFisCemeCheckInfo(info);
		wf.setFisCemeCheckAudit(audit);
		wf.setFisCemeCheckScore(score);
		wf.setFisCemeCheckResult(result);
		
		service.updateProfitCheck(wf,isUpdate);
	}
	
	/**
	 * @Description: 插入经营性公墓检查信息(县级检查)
	 */
	@Trans
	public void insertProfitCheck() {
		Record infoRecord = (Record) getParameter("infoRecord");// 基本信息
		FisCemeCheckInfo info = (FisCemeCheckInfo) infoRecord.toBean(FisCemeCheckInfo.class);
		Record wfRecord = (Record) getParameter("wfRecord");
		FisCemeCheckWf wf = (FisCemeCheckWf) wfRecord.toBean(FisCemeCheckWf.class);
		Record auditRecord = (Record) getParameter("auditRecord");// 分数合计及年检报告
		FisCemeCheckAudit audit = (FisCemeCheckAudit) auditRecord.toBean(FisCemeCheckAudit.class);
		Record scoreRecord = (Record) getParameter("scoreRecord");
		FisCemeCheckScore score = (FisCemeCheckScore) scoreRecord.toBean(FisCemeCheckScore.class);
		String isReport = (String)getParameter("isReport");
		
		//冗余信息至流程表
		wf.setAreaLevel(info.getAreaLevel());
		wf.setAreaLevelId(info.getAreaLevelId());
		wf.setCemeId(info.getCemeId());
		wf.setCemeName(info.getCemeName());
		wf.setCheckNum("1");
		wf.setManaLevel(info.getManaLevel());
		wf.setManaLevelId(info.getManaLevelId());
		wf.setProp(info.getProp());
		wf.setReportPerson(BspUtil.getEmpOrganId());
		wf.setReportTime(DateUtil.getTime());
		wf.setCheckResult(audit.getSecondResult());
		wf.setEndApplyId(info.getApplyId());
		
		//冗余信息至公墓表
		info.setCheckNum(wf.getCheckNum());
		info.setCheckYear(wf.getCheckYear());
		info.setIsReport(isReport);
		info.setReportPerson(wf.getReportPerson());
		info.setReportTime(wf.getReportTime());
		
		//第一次新建结果表，年检结果和上报状态均导入
		FisCemeCheckResult result = new FisCemeCheckResult();
		result.setResultId(IdHelp.getUUID32());
		result.setWfId(wf.getWfId());
		result.setCemeId(info.getCemeId());
		result.setCheckNum(wf.getCheckNum());
		result.setCheckYear(wf.getCheckYear());
		result.setFirstApplyId(info.getApplyId());
		result.setFirstOpinion(audit.getFirstOpinion());
		result.setFirstTime(audit.getFirstTime());
		result.setFirstTotalScore(audit.getTotalScore());
		result.setFirstUnit(audit.getFirstUnit());
		result.setFirstUnitId(audit.getFirstUnitId());
		result.setIsTakeproof("0");
		result.setIsReport("0");
		
		if("1".equals(isReport)) {
			//上报后，当前环节为市级，未编辑，最后一次年检记录
			wf.setCurrentOrgan("1");
			wf.setIsEdit("0");
		}else {
			//保存后，当前环节还为县级，已编辑，最后一次年检记录
			wf.setCurrentOrgan("0");
			wf.setIsEdit("1");
		}
		wf.setIsReport("0");
		
		wf.setFisCemeCheckInfo(info);
		wf.setFisCemeCheckAudit(audit);
		wf.setFisCemeCheckScore(score);
		wf.setFisCemeCheckResult(result);
		
		service.insertProfitCheck(wf);
	}
	
	
	/**
	 * @Description: 更新经营性公墓检查信息 (县级检查)
	 */
	@Trans
	public void updateProfitCheck() {
		
		Record infoRecord = (Record) getParameter("infoRecord");// 基本信息
		FisCemeCheckInfo info = (FisCemeCheckInfo) infoRecord.toBean(FisCemeCheckInfo.class);
		Record wfRecord = (Record) getParameter("wfRecord");	//工作流信息
		FisCemeCheckWf wf = (FisCemeCheckWf) wfRecord.toBean(FisCemeCheckWf.class);
		Record resultRecord = (Record) getParameter("resultRecord");	//年检结果信息
		FisCemeCheckResult result = (FisCemeCheckResult) resultRecord.toBean(FisCemeCheckResult.class);
		Record auditRecord = (Record) getParameter("auditRecord");	// 分数合计及年检报告
		FisCemeCheckAudit audit = (FisCemeCheckAudit) auditRecord.toBean(FisCemeCheckAudit.class);
		Record scoreRecord = (Record) getParameter("scoreRecord");	//各项分值信息
		FisCemeCheckScore score = (FisCemeCheckScore) scoreRecord.toBean(FisCemeCheckScore.class);
		String isReport = (String)getParameter("isReport");	//是否上报
		boolean isUpdate = "true".equals((String)getParameter("isUpdate"));//是否更新T/新增F子表
		
		//年检时同步更新基本表FIS_CEME_INFO
		ParameterSet pset = new ParameterSet();
		String cemeId=info.getCemeId();
		pset.setParameter("CEME_ID", cemeId);
		FisCeme ceme=(FisCeme)service1.query(pset).getRecord(0).toBean(FisCeme.class);
		ceme.setLegalPerson(info.getLegalPerson());
		ceme.setTotalStaff(info.getTotalStaff());
		ceme.setDirectorMobile(info.getDirectorMobile());
		ceme.setOfficePhone(info.getOfficePhone());
		ceme.setFixeDassets(info.getFixeDassets());
		ceme.setTotalInvestment(info.getTotalInvestment());
		ceme.setPostalcode(info.getPostalcode());
		ceme.setTotalArea(info.getTotalArea());
		ceme.setBuiltArea(info.getBuiltArea());
		ceme.setBuiltTotalArea(info.getBuiltTotalArea());
		ceme.setAddress(info.getAddress());
		ceme.setServiceScope(info.getServiceScope());
		service1.update(ceme);
		
		if("1".equals(isReport)) {
			//上报，则当前环节为市级、未编辑、最后业务ID
			wf.setCurrentOrgan("1");
			wf.setIsEdit("0");
		}else {
			//不上报，则当前环节还为县级、未编辑、最后业务ID
			wf.setCurrentOrgan("0");
			wf.setIsEdit("1");
		}
		wf.setEndApplyId(info.getApplyId());
		wf.setReportPerson(BspUtil.getEmpOrganId());
		wf.setReportTime(DateUtil.getTime());
		wf.setCheckResult(audit.getSecondResult());
		wf.setIsReport("0");
		
		//冗余信息至公墓表
		info.setIsReport(isReport);
		info.setCheckNum(wf.getCheckNum());
		info.setCheckYear(wf.getCheckYear());
		info.setReportPerson(wf.getReportPerson());
		info.setReportTime(wf.getReportTime());
		
		//更新结果表
		result.setCemeId(info.getCemeId());
		result.setCheckNum(wf.getCheckNum());
		result.setCheckYear(wf.getCheckYear());
		result.setFirstApplyId(info.getApplyId());
		result.setFirstOpinion(audit.getFirstOpinion());
		result.setFirstTime(audit.getFirstTime());
		result.setFirstTotalScore(audit.getTotalScore());
		result.setFirstUnit(audit.getFirstUnit());
		result.setFirstUnitId(audit.getFirstUnitId());
		result.setIsTakeproof("0");
		
		wf.setFisCemeCheckInfo(info);
		wf.setFisCemeCheckAudit(audit);
		wf.setFisCemeCheckScore(score);
		wf.setFisCemeCheckResult(result);
		
		service.updateProfitCheck(wf,isUpdate);
	}
	
	/**
	 * @Description: 插入公益性公墓年检信息 (县级年检)
	 */
	@Trans
	public void insertNoProfitCheck() {
		Record infoRecord = (Record) getParameter("infoRecord");// 基本信息
		FisCemeCheckInfo info = (FisCemeCheckInfo) infoRecord.toBean(FisCemeCheckInfo.class);
		Record wfRecord = (Record) getParameter("wfRecord");
		FisCemeCheckWf wf = (FisCemeCheckWf) wfRecord.toBean(FisCemeCheckWf.class);
		Record auditRecord = (Record) getParameter("auditRecord");// 分数合计及年检报告
		FisCemeCheckAudit audit = (FisCemeCheckAudit) auditRecord.toBean(FisCemeCheckAudit.class);
		Record scoreRecord = (Record) getParameter("scoreRecord");
		FisCemeCheckScore score = (FisCemeCheckScore) scoreRecord.toBean(FisCemeCheckScore.class);
		String isReport = (String)getParameter("isReport");
		
		audit.setFirstOpinion(audit.getAnnuareport());
		
		//冗余信息至流程表
		wf.setAreaLevel(info.getAreaLevel());
		wf.setAreaLevelId(info.getAreaLevelId());
		wf.setCemeId(info.getCemeId());
		wf.setCemeName(info.getCemeName());
		wf.setCheckNum("1");
		wf.setManaLevel(info.getManaLevel());
		wf.setManaLevelId(info.getManaLevelId());
		wf.setProp(info.getProp());
		wf.setIsReport(isReport);
		wf.setReportPerson(BspUtil.getEmpOrganId());
		wf.setReportTime(DateUtil.getTime());
		wf.setCheckResult(audit.getSecondResult());
		wf.setEndApplyId(info.getApplyId());
		
		if("1".equals(isReport)) {
			//上报后，当前环节为市级，未编辑，最后一次年检记录
			wf.setCurrentOrgan("1");
			wf.setIsEdit("0");
		}else {
			//保存后，当前环节还为县级，已编辑，最后一次年检记录
			wf.setCurrentOrgan("0");
			wf.setIsEdit("1");
		}
		
		//冗余信息至公墓表
		info.setCheckNum(wf.getCheckNum());
		info.setCheckYear(wf.getCheckYear());
		info.setIsReport(isReport);
		info.setReportPerson(wf.getReportPerson());
		info.setReportTime(wf.getReportTime());
		
		//第一次新建结果表，年检结果和上报状态均导入
		FisCemeCheckResult result = new FisCemeCheckResult();
		result.setResultId(IdHelp.getUUID32());
		result.setWfId(wf.getWfId());
		result.setCemeId(info.getCemeId());
		result.setCheckNum(wf.getCheckNum());
		result.setCheckYear(wf.getCheckYear());
		result.setCheckResult(wf.getCheckResult());
		result.setSecondAnnuareport(audit.getAnnuareport());
		result.setSecondApplyId(info.getApplyId());
		result.setSecondOpinion(audit.getSecondOpinion());
		result.setSecondResult(audit.getSecondResult());
		result.setSecondTime(audit.getSecondTime());
		result.setSecondTotalScore(audit.getTotalScore());
		result.setSecondUnit(audit.getSecondUnit());
		result.setSecondUnitId(audit.getSecondUnitId());
		result.setIsReport(isReport);	
		result.setIsTakeproof("0");
		
		wf.setFisCemeCheckInfo(info);
		wf.setFisCemeCheckAudit(audit);
		wf.setFisCemeCheckScore(score);
		wf.setFisCemeCheckResult(result);
		
		service.insertNoProfitCheck(wf);
	}
	
	/**
	 * @Description: 更新公益性公墓年检信息 (县级年检)
	 */
	@Trans
	public void updateNoProfitCheck() {
		Record infoRecord = (Record) getParameter("infoRecord");// 基本信息
		FisCemeCheckInfo info = (FisCemeCheckInfo) infoRecord.toBean(FisCemeCheckInfo.class);
		Record wfRecord = (Record) getParameter("wfRecord");	//工作流信息
		FisCemeCheckWf wf = (FisCemeCheckWf) wfRecord.toBean(FisCemeCheckWf.class);
		Record resultRecord = (Record) getParameter("resultRecord");	//年检结果信息
		FisCemeCheckResult result = (FisCemeCheckResult) resultRecord.toBean(FisCemeCheckResult.class);
		Record auditRecord = (Record) getParameter("auditRecord");	// 分数合计及年检报告
		FisCemeCheckAudit audit = (FisCemeCheckAudit) auditRecord.toBean(FisCemeCheckAudit.class);
		Record scoreRecord = (Record) getParameter("scoreRecord");	//各项分值信息
		FisCemeCheckScore score = (FisCemeCheckScore) scoreRecord.toBean(FisCemeCheckScore.class);
		String isReport = (String)getParameter("isReport");	//是否上报
		boolean isUpdate = "true".equals((String)getParameter("isUpdate"));//是否更新T/新增F子表
		
		//年检时同步更新基本表FIS_CEME_INFO
		ParameterSet pset = new ParameterSet();
		String cemeId=info.getCemeId();
		pset.setParameter("CEME_ID", cemeId);
		FisCeme ceme=(FisCeme)service1.query(pset).getRecord(0).toBean(FisCeme.class);
		ceme.setLegalPerson(info.getLegalPerson());
		ceme.setDirectorMobile(info.getDirectorMobile());
		ceme.setTotalArea(info.getTotalArea());
		service1.update(ceme);
		
		audit.setSecondOpinion(audit.getAnnuareport());
		
		if("1".equals(isReport)) {
			//上报，则当前环节为市级、未编辑、最后业务ID
			wf.setCurrentOrgan("1");
			wf.setIsEdit("0");
		}else {
			//不上报，则当前环节还为县级、未编辑、最后业务ID
			wf.setCurrentOrgan("0");
			wf.setIsEdit("1");
		}
			
		wf.setIsReport(isReport);
		wf.setEndApplyId(info.getApplyId());
		wf.setReportPerson(BspUtil.getEmpOrganId());
		wf.setReportTime(DateUtil.getTime());
		wf.setCheckResult(audit.getSecondResult());
		
		//冗余信息至公墓表
		info.setIsReport(isReport);
		info.setCheckNum(wf.getCheckNum());
		info.setCheckYear(wf.getCheckYear());
		info.setReportPerson(wf.getReportPerson());
		info.setReportTime(wf.getReportTime());
		
		//更新结果表
		result.setCemeId(info.getCemeId());
		result.setCheckNum(wf.getCheckNum());
		result.setCheckYear(wf.getCheckYear());
		result.setSecondAnnuareport(audit.getAnnuareport());
		result.setSecondApplyId(info.getApplyId());
		result.setSecondOpinion(audit.getSecondOpinion());
		result.setSecondResult(audit.getSecondResult());
		result.setSecondTime(audit.getSecondTime());
		result.setSecondTotalScore(audit.getTotalScore());
		result.setSecondUnit(audit.getSecondUnit());
		result.setSecondUnitId(audit.getSecondUnitId());
		result.setIsTakeproof("0");
		
		if("1".equals(wf.getIsReport())) {
			//如果上报，才更新结果表中的年检结果、上报状态
			result.setCheckResult(wf.getCheckResult());
			result.setIsReport(wf.getIsReport());
		}
		
		wf.setFisCemeCheckInfo(info);
		wf.setFisCemeCheckAudit(audit);
		wf.setFisCemeCheckScore(score);
		wf.setFisCemeCheckResult(result);
		
		service.updateNoProfitCheck(wf,isUpdate);
	}
	
	/**
	 * 初审时保存初审历史记录到数据库， 并将新生成的年检结果保存到数据库
	 */
	@Trans
	public void insert() {
		Record infoRecord = (Record) getParameter("infoRecord");// 基本信息
		FisCemeCheckInfo info = (FisCemeCheckInfo) infoRecord
				.toBean(FisCemeCheckInfo.class);
		String checknumber = (String) getParameter("checknumber");
		String oldresultId = (String) getParameter("resultId");
		// 对初检不合格的数据进行标示
		if ("1".equals(checknumber)) {
			FisCemeCheckResult oldresult = service.getResult(oldresultId);
			oldresult.setIsTakeproof("1");
			service.updateResult(oldresult);
		}
		Record auditRecord = (Record) getParameter("auditRecord");// 分数合计及年检报告
		FisCemeCheckAudit audit = (FisCemeCheckAudit) auditRecord
				.toBean(FisCemeCheckAudit.class);
		audit.setAuditId(IdHelp.getUUID32());

		Record scoreRecord = (Record) getParameter("scoreRecord");
		FisCemeCheckScore score = (FisCemeCheckScore) scoreRecord
				.toBean(FisCemeCheckScore.class);
		score.setScoreId(IdHelp.getUUID32());

		FisCemeCheckResult result = new FisCemeCheckResult();
		result.setResultId(IdHelp.getUUID32());
		result.setCemeId(info.getCemeId());
		result.setCheckYear((String) getParameter("checkYear"));
		if ("1".equals(checknumber)) {
			info.setCheckNum("2");
			result.setCheckNum("1");
		} else {
			info.setCheckNum("1");
		}

		if ("2".equals(info.getProp())) {
			// result.setFirstAnnuareport(audit.getAnnuareport());
			result.setFirstApplyId(info.getApplyId());
			result.setFirstOpinion(audit.getFirstOpinion());
			result.setFirstTime(audit.getFirstTime());
			result.setFirstTotalScore(audit.getTotalScore());
			result.setFirstUnit(audit.getFirstUnit());
			result.setFirstUnitId(audit.getFirstUnitId());
			// if("1".equals(result.getCheckNum())){
			// result.setCheckNum("2");
			// }else {
			// result.setCheckNum("1");
			// }

			result.setCheckResult("3");
		}
		// if("1".equals(result.getFirstResult())){
		// result.setCheckResult("1");
		// }else{
		// result.setCheckResult("3");
		// }
		if ("1".equals(info.getProp())) {
			result.setSecondAnnuareport(audit.getAnnuareport());
			result.setSecondApplyId(info.getApplyId());
			result.setSecondOpinion(audit.getSecondOpinion());
			result.setSecondResult(audit.getSecondResult());
			result.setSecondTime(audit.getSecondTime());
			result.setSecondTotalScore(audit.getTotalScore());
			result.setSecondUnit(audit.getSecondUnit());
			result.setSecondUnitId(audit.getSecondUnitId());
			result.setCheckNum("2");
			info.setCheckNum("2");
			if ("2".equals(audit.getSecondResult())) {
				result.setCheckResult("2");
			} else if ("1".equals(result.getSecondResult())) {
				result.setCheckResult("1");
			}
		}
		service.insert(result);
		service.save(info, audit, score);
	}

	/**
	 * 复审时，保存历史记录到数据库 并更新年检记录信息
	 */
	@Trans
	public void update() {

		Record infoRecord = (Record) getParameter("infoRecord");// 基本信息
		FisCemeCheckInfo info = (FisCemeCheckInfo) infoRecord
				.toBean(FisCemeCheckInfo.class);
		// info.setCheckNum("2");

		Record scoreRecord = (Record) getParameter("scoreRecord");
		FisCemeCheckScore score = (FisCemeCheckScore) scoreRecord
				.toBean(FisCemeCheckScore.class);
		score.setScoreId(IdHelp.getUUID32());

		Record auditRecord = (Record) getParameter("auditRecord");// 分数合计及年检报告
		FisCemeCheckAudit audit = (FisCemeCheckAudit) auditRecord
				.toBean(FisCemeCheckAudit.class);
		audit.setAuditId(IdHelp.getUUID32());

		String resultId = (String) getParameter("resultId");
		FisCemeCheckResult result = service.getResult(resultId);
		result.setSecondAnnuareport(audit.getAnnuareport());
		result.setSecondApplyId(info.getApplyId());
		result.setSecondOpinion(audit.getSecondOpinion());
		result.setSecondResult(audit.getSecondResult());
		result.setSecondTime(audit.getSecondTime());
		result.setSecondTotalScore(audit.getTotalScore());
		result.setSecondUnit(audit.getSecondUnit());
		result.setSecondUnitId(audit.getSecondUnitId());
		// result.setCheckNum("2");
		if ("1".equals(result.getCheckNum())) {
			result.setCheckNum("2");
		} else {
			result.setCheckNum("1");
		}
		if ("1".equals(info.getCheckNum())) {
			if ("2".equals(audit.getSecondResult())) {
				result.setCheckResult("4");
			} else if ("1".equals(result.getSecondResult())) {
				result.setCheckResult("1");
			}
		} else {
			if ("2".equals(audit.getSecondResult())) {
				result.setCheckResult("2");
			} else if ("1".equals(result.getSecondResult())) {
				result.setCheckResult("1");
			}
		}
		service.updateResult(result);
		service.save(info, audit, score);
	}

	/**
	 * 保存年见附件到数据库
	 */
	@Trans
	public void uploadSave() {

		ParameterSet pset = getParameterSet();
		String applayId = (String) pset.getParameter("applyId");
		String note = (String) pset.getParameter("note");
		String code = (String) pset.getParameter("code");

		MultipartRequestWrapper wrapRequest = (MultipartRequestWrapper) getRequest();// 获取包装后的request
		Map<String, UploadFile> map = wrapRequest.getUploadFiles();// 获取所有上传的文件
		Set<Entry<String, UploadFile>> set = map.entrySet();
		Iterator<Entry<String, UploadFile>> iterator = set.iterator();
		UploadFile uploadfile = null;
		// 遍历Map，封装成_InformAttachment对象，并放入List中。
		List<FisCemeAccessories> list = new ArrayList<FisCemeAccessories>();
		while (iterator.hasNext()) {
			uploadfile = iterator.next().getValue();
			if (uploadfile.getFileSize() > 5 * 1024 * 1024) {
				throw new RuntimeException(uploadfile.getFileName() + "  文件过大！");
			}
			// 如果为空，则不在进行对象封装，继续遍历下一条记录。
			if (uploadfile == null) {
				continue;
			}
			FisCemeAccessories accessories = new FisCemeAccessories();
			accessories.setAccessoriesId(IdHelp.getUUID32());
			accessories.setItemId(applayId);
			accessories.setNote(note);
			accessories.setCode(code);
			accessories.setAccessories(uploadfile);
			accessories.setAccessoriesName(uploadfile.getFileName());
			list.add(accessories);
		}
		service.uploadSave(list);

	}

	/**
	 * 根据Id从数据库中删除附件
	 */
	@Trans
	public void delAccessoriesById() {
		String id = (String) getParameter("id");
		service.delAccessoriesById(id);
	}

	@Trans
	public void updateAll() {
		Record infoRecord = (Record) getParameter("infoRecord");// 基本信息
		FisCemeCheckInfo info = (FisCemeCheckInfo) infoRecord
				.toBean(FisCemeCheckInfo.class);
		service.updateInfo(info);

		Record auditRecord = (Record) getParameter("auditRecord");// 分数合计及年检报告
		FisCemeCheckAudit audit = (FisCemeCheckAudit) auditRecord
				.toBean(FisCemeCheckAudit.class);
		service.updateAudit(audit);

		String checkNum = (String) getParameter("checkNum");

		String resultId = (String) getParameter("resultId");
		FisCemeCheckResult result = service.getResult(resultId);

		if ("2".equals(checkNum)) {
			result.setSecondAnnuareport(audit.getAnnuareport());
			result.setSecondTotalScore(audit.getTotalScore());
		} else {
			result.setFirstAnnuareport(audit.getAnnuareport());
			result.setFirstTotalScore(audit.getTotalScore());
		}
		result.setFirstOpinion(audit.getFirstOpinion());
		result.setFirstTime(audit.getFirstTime());

		result.setSecondOpinion(audit.getSecondOpinion());
		result.setSecondResult(audit.getSecondResult());
		result.setSecondTime(audit.getSecondTime());

		if ("2".equals(audit.getSecondResult())) {
			result.setCheckResult("2");
		} else if ("1".equals(result.getSecondResult())) {
			result.setCheckResult("1");
		}
		service.updateResult(result);
	}
	
	public void queryForPrint(){
		ParameterSet pset = getParameterSet();
		String str= service.queryPrint(pset);
		setReturn("str",str);
	}
	
	public void queryForJYPrint(){
		ParameterSet pset = getParameterSet();
		String addstr= service.queryJYPrint(pset);
		setReturn("addstr",addstr);
	}
	
}
