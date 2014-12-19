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

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.fis.ep.base.data.CemeInspection;
import com.inspur.cams.fis.ep.base.data.FisCemeAccessories;
import com.inspur.cams.fis.ep.base.data.FisCemeCheckAudit;
import com.inspur.cams.fis.ep.base.data.FisCemeCheckResult;
import com.inspur.cams.fis.ep.base.data.FisCemeCheckScore;
import com.inspur.cams.fis.ep.base.domain.ICemeInspectionDomain;


/**
 * @title:InspectionCommand
 * @description:
 * @author:
 * @since:2011-11-17
 * @version:1.0
*/
public class CemeInspectionCmd extends BaseAjaxCommand{
	ICemeInspectionDomain service = ScaComponentFactory.getService(ICemeInspectionDomain.class,
	"CemeInspectionDomain/CemeInspectionDomain");

	/**
	 * 初审时保存初审历史记录到数据库，
	 * 并将新生成的年检结果保存到数据库
	 */
	@Trans
	public void insert() {
		Record infoRecord = (Record) getParameter("infoRecord");//基本信息
		CemeInspection info=(CemeInspection)infoRecord.toBean(CemeInspection.class);
		String checknumber = (String) getParameter("checknumber");
		String oldresultId = (String) getParameter("resultId");
		//对初检不合格的数据进行标示
		if("1".equals(checknumber)){
			FisCemeCheckResult oldresult = service.getResult(oldresultId);
			oldresult.setIsTakeproof("1");
			service.updateResult(oldresult);
		}
		Record auditRecord = (Record) getParameter("auditRecord");//分数合计及年检报告
		FisCemeCheckAudit audit = (FisCemeCheckAudit) auditRecord.toBean(FisCemeCheckAudit.class);
		audit.setAuditId(IdHelp.getUUID32());
		
		Record scoreRecord = (Record) getParameter("scoreRecord");
		FisCemeCheckScore score  = (FisCemeCheckScore) scoreRecord.toBean(FisCemeCheckScore.class);
		score.setScoreId(IdHelp.getUUID32());
		
		FisCemeCheckResult result = new FisCemeCheckResult();
		result.setResultId(IdHelp.getUUID32());
		result.setCemeId(info.getCemeId());
		result.setCheckYear((String) getParameter("checkYear"));
		if("1".equals(checknumber) ){
			info.setCheckNum("2");
			result.setCheckNum("1");
		}else {
			info.setCheckNum("1");
		}
		
		if("2".equals(info.getProp())){
		//result.setFirstAnnuareport(audit.getAnnuareport());
		result.setFirstApplyId(info.getApplyId());
		result.setFirstOpinion(audit.getFirstOpinion());
		result.setFirstTime(audit.getFirstTime());
		result.setFirstTotalScore(audit.getTotalScore());
		result.setFirstUnit(audit.getFirstUnit());
		result.setFirstUnitId(audit.getFirstUnitId());
	//	if("1".equals(result.getCheckNum())){
	//		result.setCheckNum("2");
	//	}else {
	//		result.setCheckNum("1");
	//	}
		
		result.setCheckResult("3");
		}
	//	if("1".equals(result.getFirstResult())){
	//		result.setCheckResult("1");
	//	}else{
	//		result.setCheckResult("3");
	//	}
		if("1".equals(info.getProp())){
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
			if("2".equals(audit.getSecondResult())){
				result.setCheckResult("2");
			}else if("1".equals(result.getSecondResult())){
				result.setCheckResult("1");
			}
		}
		service.insert(result);
		service.save(info,audit,score);
	}
	/**
	 * 复审时，保存历史记录到数据库
	 * 并更新年检记录信息
	 */
	@Trans
	public void update(){
		
		Record infoRecord = (Record) getParameter("infoRecord");//基本信息
		CemeInspection info=(CemeInspection)infoRecord.toBean(CemeInspection.class);
		//info.setCheckNum("2");
		
		Record scoreRecord = (Record) getParameter("scoreRecord");
		FisCemeCheckScore score  = (FisCemeCheckScore) scoreRecord.toBean(FisCemeCheckScore.class);
		score.setScoreId(IdHelp.getUUID32());
		
		Record auditRecord = (Record) getParameter("auditRecord");//分数合计及年检报告
		FisCemeCheckAudit audit = (FisCemeCheckAudit) auditRecord.toBean(FisCemeCheckAudit.class);
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
		//result.setCheckNum("2");
		if("1".equals(result.getCheckNum())){
			result.setCheckNum("2");
		}else {
			result.setCheckNum("1");
		}
		if("1".equals(info.getCheckNum())){
			if("2".equals(audit.getSecondResult())){
				result.setCheckResult("4");
			}else if("1".equals(result.getSecondResult())){
				result.setCheckResult("1");
			}
		}else{
		if("2".equals(audit.getSecondResult())){
			result.setCheckResult("2");
		}else if("1".equals(result.getSecondResult())){
			result.setCheckResult("1");
		}
		}
		service.updateResult(result);
		service.save(info,audit,score);
	}
	
	/**
	 * 保存年见附件到数据库
	 */
	@Trans
	public void uploadSave(){
		
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
	public void delAccessoriesById(){
		String id = (String) getParameter("id");
		service.delAccessoriesById(id);
	}
	
	@Trans
	public void updateAll(){
		Record infoRecord = (Record) getParameter("infoRecord");//基本信息
		CemeInspection info=(CemeInspection)infoRecord.toBean(CemeInspection.class);
		service.updateInfo(info);
		
		
		Record auditRecord = (Record) getParameter("auditRecord");//分数合计及年检报告
		FisCemeCheckAudit audit = (FisCemeCheckAudit) auditRecord.toBean(FisCemeCheckAudit.class);
		service.updateAudit(audit);
		
		String checkNum = (String) getParameter("checkNum");
		
		String resultId = (String) getParameter("resultId");
		FisCemeCheckResult result = service.getResult(resultId);
		
		if("2".equals(checkNum)){
			result.setSecondAnnuareport(audit.getAnnuareport());
			result.setSecondTotalScore(audit.getTotalScore());
		}else{
			result.setFirstAnnuareport(audit.getAnnuareport());
			result.setFirstTotalScore(audit.getTotalScore());
		}
		result.setFirstOpinion(audit.getFirstOpinion());
		result.setFirstTime(audit.getFirstTime());
		
		result.setSecondOpinion(audit.getSecondOpinion());
		result.setSecondResult(audit.getSecondResult());
		result.setSecondTime(audit.getSecondTime());

		if("2".equals(audit.getSecondResult())){
			result.setCheckResult("2");
		}else if("1".equals(result.getSecondResult())){
			result.setCheckResult("1");
		}
		service.updateResult(result);
	}
}
