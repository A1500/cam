package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.ParameterSet;

import java.sql.Blob;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.loushang.next.data.Record;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.next.upload.UploadFile;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.fis.base.data.FisCemeAccessories;
import com.inspur.cams.fis.base.data.FisCemeApplyInfo;
import com.inspur.cams.fis.base.data.FisCemeCheckScore;
import com.inspur.cams.fis.base.domain.IFisCemeApplyInfoDomain;
import com.inspur.cams.fis.base.domain.IFisCemeCheckHistoryDomain;
import com.inspur.cams.fis.base.domain.IFisCemeInfoDomain;

import com.inspur.cams.fis.base.data.FisCemeInfo;

import com.inspur.cams.fis.base.data.FisCemeLogoffOpinion;
import com.inspur.cams.fis.base.domain.IFisCemeLogoffOpinionDomain;

import com.inspur.cams.fis.base.data.FisCemeCheckHistory;
import com.inspur.cams.fis.base.data.FisCemeExpendInfo;
import com.inspur.cams.fis.base.domain.IFisCemeExpendInfoDomain;

/**
 * 公墓审批业务表cmd
 * @author 
 * @date 2013-08-01
 */
public class FisCemeApplyInfoCmd extends BaseAjaxCommand {

	private IFisCemeApplyInfoDomain fisCemeApplyInfoDomain = ScaComponentFactory
			.getService(IFisCemeApplyInfoDomain.class, "fisCemeApplyInfoDomain/fisCemeApplyInfoDomain");

	//公墓信息表
	private IFisCemeInfoDomain fisCemeInfoDomain = ScaComponentFactory
	.getService(IFisCemeInfoDomain.class, "fisCemeInfoDomain/fisCemeInfoDomain");

	//外管意见表
	private IFisCemeLogoffOpinionDomain fisCemeLogoffOpinionDomain = ScaComponentFactory
	.getService(IFisCemeLogoffOpinionDomain.class, "fisCemeLogoffOpinionDomain/fisCemeLogoffOpinionDomain");
	
	private IFisCemeCheckHistoryDomain fisCemeCheckHistoryDomain = ScaComponentFactory
	.getService(IFisCemeCheckHistoryDomain.class, "fisCemeCheckHistoryDomain/fisCemeCheckHistoryDomain");
	
	@Reference
	private IFisCemeExpendInfoDomain fisCemeExpendInfoDomain = ScaComponentFactory
	.getService(IFisCemeExpendInfoDomain.class, "fisCemeExpendInfoDomain/fisCemeExpendInfoDomain");
	
	public void insert() {
		
		Record record = (Record) getParameter("record");
		FisCemeApplyInfo fisCemeApplyInfo = (FisCemeApplyInfo) record.toBean(FisCemeApplyInfo.class);
		fisCemeApplyInfoDomain.insert(fisCemeApplyInfo);
	}
	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		FisCemeApplyInfo fisCemeApplyInfo = (FisCemeApplyInfo) record.toBean(FisCemeApplyInfo.class);
		fisCemeApplyInfoDomain.update(fisCemeApplyInfo);
		
	}
	
	// 删除
	public void delete() {
		String cemeApplyId = (String) getParameter("cemeApplyId");
		fisCemeApplyInfoDomain.delete(cemeApplyId);
		
	}
	//年检业务、打分保存
	public void insertAll() {
		ParameterSet pset = getParameterSet();
		fisCemeApplyInfoDomain.insertAll(pset);
	}
	//年检业务、打分更新
	public void updateAll() {
		ParameterSet pset = getParameterSet();
		fisCemeApplyInfoDomain.updateAll(pset);
	}
	//年检发起流程
	public void createAndSendYearlyCheck() {
		fisCemeApplyInfoDomain.createAndSendYearlyCheck(getParameterSet());
	}
	//年检、提交、流程
	public void send() {
		fisCemeApplyInfoDomain.send(getParameterSet());
	}
	//年检驳回 提交流程
	public void sendMore() {
		fisCemeApplyInfoDomain.sendMore(getParameterSet());
	}
	// 删除
	public void deleteAll() {
		ParameterSet pset = getParameterSet();
		fisCemeApplyInfoDomain.deleteAll(pset);
		
	}
	//更新发起流程
	public void updateAndSend(){
		ParameterSet pset = getParameterSet();
		fisCemeApplyInfoDomain.updateAndSend(pset);
	}
	//提交经营性公墓关闭流程
	public void sendLogoff(){
		ParameterSet pset = getParameterSet();
		fisCemeApplyInfoDomain.sendLogoff(pset);
	}
	//公益性公墓关闭业务更新
	public void cemeLogoffUpdate(){
		ParameterSet pset = getParameterSet();
		fisCemeApplyInfoDomain.cemeLogoffUpdate(pset);
	}
	//公益性公墓关闭业务审批
	public void cemeLogoffSubmit(){
		ParameterSet pset = getParameterSet();
		fisCemeApplyInfoDomain.cemeLogoffSubmit(pset);
	}
	//新增 经营性公墓关闭流程
	public void insertLogoff(){
		ParameterSet pset = getParameterSet();
		fisCemeApplyInfoDomain.insertLogoff(pset);
	}
	//提交流程
	public void sendChange(){
		ParameterSet pset = getParameterSet();
		fisCemeApplyInfoDomain.sendChange(pset);
	}
	//更新 公墓关闭流程
	public void updateLogoff(){
		ParameterSet pset = getParameterSet();
		fisCemeApplyInfoDomain.updateLogoff(pset);
	}
	//删除 经营性公墓关闭流程
	public void cemeLogoffDelete(){
		ParameterSet pset = getParameterSet();
		fisCemeApplyInfoDomain.cemeLogoffDelete(pset);
	}
		
	public void startCreate(){
		String cemeApplyId=(String) getParameter("cemeApplyId");
		fisCemeApplyInfoDomain.startCreate(cemeApplyId);
	}
	public void sendOfCreate(){
		Record record = (Record) getParameter("record");
		String result=(String) getParameter("result");
		String assignmentId=(String) getParameter("assignmentId");
		
		FisCemeApplyInfo fisCemeApplyInfo = (FisCemeApplyInfo) record.toBean(FisCemeApplyInfo.class);
		fisCemeApplyInfoDomain.sendOfCreate(fisCemeApplyInfo,result,assignmentId);
	}
	@Trans
	public void sendOfCreateAll(){
		/*
		 * commandSubmit.setParameter("hisID",recordHistory.get("HIS_ID"));
		 * 	commandSubmit.setParameter("opinion",recordApply.get("firstOpinion"));
		 */
		Record recordApply = (Record) getParameter("recordApply");
		String result=(String) getParameter("result");
		String assignmentId=(String) getParameter("assignmentId");
		Record recordHistory = (Record) getParameter("recordHistory");
    		
		FisCemeApplyInfo fisCemeApplyInfo = (FisCemeApplyInfo) recordApply.toBean(FisCemeApplyInfo.class);
		fisCemeApplyInfoDomain.sendOfCreate(fisCemeApplyInfo,result,assignmentId);
		
		FisCemeCheckHistory fisCemeCheckHistory = (FisCemeCheckHistory) recordHistory.toBean(FisCemeCheckHistory.class);
		fisCemeCheckHistoryDomain.insert(fisCemeCheckHistory);
	}
	
	@Trans
	public void sendOfCreateBH(){
		
		Record recordApply = (Record) getParameter("recordApply");
		Record recordHistory = (Record) getParameter("recordHistory");
		Record recordOpinion = (Record) getParameter("recordOpinion");
		Record recordCeme = (Record) getParameter("recordCeme");

		String result=(String) getParameter("result");
		String assignmentId=(String) getParameter("assignmentId");
		
		FisCemeInfo fisCemeInfo = (FisCemeInfo) recordCeme.toBean(FisCemeInfo.class);
		fisCemeInfoDomain.update(fisCemeInfo);
		
		FisCemeLogoffOpinion fisCemeLogoffOpinion = (FisCemeLogoffOpinion) recordOpinion.toBean(FisCemeLogoffOpinion.class);
		fisCemeLogoffOpinionDomain.update(fisCemeLogoffOpinion);		

		FisCemeCheckHistory fisCemeCheckHistory = (FisCemeCheckHistory) recordHistory.toBean(FisCemeCheckHistory.class);
		fisCemeCheckHistoryDomain.insert(fisCemeCheckHistory);
		
		FisCemeApplyInfo fisCemeApplyInfo = (FisCemeApplyInfo) recordApply.toBean(FisCemeApplyInfo.class);
		fisCemeApplyInfoDomain.sendOfCreate(fisCemeApplyInfo,result,assignmentId);
	}
	public void startCreateOperation(){
		String cemeApplyId=(String) getParameter("cemeApplyId");
		fisCemeApplyInfoDomain.startCreateOperation(cemeApplyId);
	}
	// 增加
	@Trans
	public void insertAllForCreate() {
		Record recordApply = (Record) getParameter("recordApply");
		FisCemeApplyInfo fisCemeApplyInfo = (FisCemeApplyInfo) recordApply.toBean(FisCemeApplyInfo.class);
		fisCemeApplyInfoDomain.insert(fisCemeApplyInfo);
		
		Record recordCeme = (Record) getParameter("recordCeme");
		FisCemeInfo fisCemeInfo = (FisCemeInfo) recordCeme.toBean(FisCemeInfo.class);
		fisCemeInfoDomain.insert(fisCemeInfo);
		
		Record recordOpinion = (Record) getParameter("recordOpinion");
		FisCemeLogoffOpinion fisCemeLogoffOpinion = (FisCemeLogoffOpinion) recordOpinion.toBean(FisCemeLogoffOpinion.class);
		fisCemeLogoffOpinionDomain.insert(fisCemeLogoffOpinion);
		
		Record recordHistory = (Record) getParameter("recordHistory");
		FisCemeCheckHistory fisCemeCheckHistory = (FisCemeCheckHistory) recordHistory.toBean(FisCemeCheckHistory.class);
		fisCemeCheckHistoryDomain.insert(fisCemeCheckHistory);
	}

	// 修改
	@Trans
	public void updateAllForCreate() {
		Record recordApply = (Record) getParameter("recordApply");
		FisCemeApplyInfo fisCemeApplyInfo = (FisCemeApplyInfo) recordApply.toBean(FisCemeApplyInfo.class);
		fisCemeApplyInfoDomain.update(fisCemeApplyInfo);
		
		Record recordCeme = (Record) getParameter("recordCeme");
		FisCemeInfo fisCemeInfo = (FisCemeInfo) recordCeme.toBean(FisCemeInfo.class);
		fisCemeInfoDomain.update(fisCemeInfo);
		
		Record recordOpinion = (Record) getParameter("recordOpinion");
		FisCemeLogoffOpinion fisCemeLogoffOpinion = (FisCemeLogoffOpinion) recordOpinion.toBean(FisCemeLogoffOpinion.class);
		fisCemeLogoffOpinionDomain.update(fisCemeLogoffOpinion);
		
		Record recordHistory = (Record) getParameter("recordHistory");
		FisCemeCheckHistory fisCemeCheckHistory = (FisCemeCheckHistory) recordHistory.toBean(FisCemeCheckHistory.class);
		fisCemeCheckHistoryDomain.update(fisCemeCheckHistory);
	}
	
	@Trans
	public void sendOfCreateJY(){

		Record recordApply = (Record) getParameter("recordApply");
		String result=(String) getParameter("result");
		String assignmentId=(String) getParameter("assignmentId");
		Record recordHistory = (Record) getParameter("recordHistory");
		
		FisCemeApplyInfo fisCemeApplyInfo = (FisCemeApplyInfo) recordApply.toBean(FisCemeApplyInfo.class);
		fisCemeApplyInfoDomain.sendOfCreateOperation(fisCemeApplyInfo,result,assignmentId);
		
		FisCemeCheckHistory fisCemeCheckHistory = (FisCemeCheckHistory) recordHistory.toBean(FisCemeCheckHistory.class);
		fisCemeCheckHistoryDomain.insert(fisCemeCheckHistory);
	}
	
	@Trans
	public void sendOfCreateJYBH(){
		
		Record recordApply = (Record) getParameter("recordApply");
		Record recordHistory = (Record) getParameter("recordHistory");
		Record recordOpinion = (Record) getParameter("recordOpinion");
		Record recordCeme = (Record) getParameter("recordCeme");

		String result=(String) getParameter("result");
		String assignmentId=(String) getParameter("assignmentId");
		
		FisCemeInfo fisCemeInfo = (FisCemeInfo) recordCeme.toBean(FisCemeInfo.class);
		fisCemeInfoDomain.update(fisCemeInfo);
		
		FisCemeLogoffOpinion fisCemeLogoffOpinion = (FisCemeLogoffOpinion) recordOpinion.toBean(FisCemeLogoffOpinion.class);
		fisCemeLogoffOpinionDomain.update(fisCemeLogoffOpinion);		

		FisCemeCheckHistory fisCemeCheckHistory = (FisCemeCheckHistory) recordHistory.toBean(FisCemeCheckHistory.class);
		fisCemeCheckHistoryDomain.insert(fisCemeCheckHistory);
		
		FisCemeApplyInfo fisCemeApplyInfo = (FisCemeApplyInfo) recordApply.toBean(FisCemeApplyInfo.class);
		fisCemeApplyInfoDomain.sendOfCreateOperation(fisCemeApplyInfo,result,assignmentId);
	}
	//删除 经营性公墓变更流程
	public void cemeChangeDelete(){
		ParameterSet pset = getParameterSet();
		fisCemeApplyInfoDomain.cemeChangeDelete(pset);
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
		fisCemeApplyInfoDomain.uploadSave(list);

	}
	
	/**
	 * 根据Id从数据库中删除附件
	 */
	@Trans
	public void delAccessoriesById() {
		String id = (String) getParameter("id");
		fisCemeApplyInfoDomain.delAccessoriesById(id);
	}
	// 删除 申建所有信息
	public void deleteCreate() {
		ParameterSet pset = getParameterSet();
		fisCemeApplyInfoDomain.deleteCreate(pset);
		
	}
	/*
	 * 公益性公墓变更流程_审批_驳回环节
	 * @param ParameterSet
	 */
	@Trans
	public void sendPublicChange(){
		ParameterSet pset = getParameterSet();
		fisCemeApplyInfoDomain.sendPublicChange(pset);
	}
	
	// 增加
	@Trans
	public void insertAllForExpend() {
		Record recordApply = (Record) getParameter("recordApply");
		FisCemeApplyInfo fisCemeApplyInfo = (FisCemeApplyInfo) recordApply.toBean(FisCemeApplyInfo.class);
		fisCemeApplyInfoDomain.insert(fisCemeApplyInfo);
		
		Record recordCeme = (Record) getParameter("recordCeme");
		FisCemeExpendInfo fisCemeExpendInfo = (FisCemeExpendInfo) recordCeme.toBean(FisCemeExpendInfo.class);
		fisCemeExpendInfoDomain.insert(fisCemeExpendInfo);
		
		Record recordOpinion = (Record) getParameter("recordOpinion");
		FisCemeLogoffOpinion fisCemeLogoffOpinion = (FisCemeLogoffOpinion) recordOpinion.toBean(FisCemeLogoffOpinion.class);
		fisCemeLogoffOpinionDomain.insert(fisCemeLogoffOpinion);
		
		Record recordHistory = (Record) getParameter("recordHistory");
		FisCemeCheckHistory fisCemeCheckHistory = (FisCemeCheckHistory) recordHistory.toBean(FisCemeCheckHistory.class);
		fisCemeCheckHistoryDomain.insert(fisCemeCheckHistory);
	}
	// 增加
	@Trans
	public void updateAllForExpend() {
		Record recordApply = (Record) getParameter("recordApply");
		FisCemeApplyInfo fisCemeApplyInfo = (FisCemeApplyInfo) recordApply.toBean(FisCemeApplyInfo.class);
		fisCemeApplyInfoDomain.update(fisCemeApplyInfo);
		
		Record recordCeme = (Record) getParameter("recordCeme");
		FisCemeExpendInfo fisCemeExpendInfo = (FisCemeExpendInfo) recordCeme.toBean(FisCemeExpendInfo.class);
		fisCemeExpendInfoDomain.update(fisCemeExpendInfo);
		
		Record recordOpinion = (Record) getParameter("recordOpinion");
		FisCemeLogoffOpinion fisCemeLogoffOpinion = (FisCemeLogoffOpinion) recordOpinion.toBean(FisCemeLogoffOpinion.class);
		fisCemeLogoffOpinionDomain.update(fisCemeLogoffOpinion);
		
		Record recordHistory = (Record) getParameter("recordHistory");
		FisCemeCheckHistory fisCemeCheckHistory = (FisCemeCheckHistory) recordHistory.toBean(FisCemeCheckHistory.class);
		fisCemeCheckHistoryDomain.update(fisCemeCheckHistory);
	}
	public void startCreateExpendOp(){
		String cemeApplyId=(String) getParameter("cemeApplyId");
		fisCemeApplyInfoDomain.startCreateExpendOp(cemeApplyId);
	}
	@Trans
	public void sendOfExpendOp(){

		Record recordApply = (Record) getParameter("recordApply");
		String result=(String) getParameter("result");
		String assignmentId=(String) getParameter("assignmentId");
		Record recordHistory = (Record) getParameter("recordHistory");
		
		FisCemeApplyInfo fisCemeApplyInfo = (FisCemeApplyInfo) recordApply.toBean(FisCemeApplyInfo.class);
		fisCemeApplyInfoDomain.sendOfExpendOp(fisCemeApplyInfo,result,assignmentId);
		
		FisCemeCheckHistory fisCemeCheckHistory = (FisCemeCheckHistory) recordHistory.toBean(FisCemeCheckHistory.class);
		fisCemeCheckHistoryDomain.insert(fisCemeCheckHistory);
	}
	@Trans
	public void sendOfExpendOpBQ(){

		Record recordApply = (Record) getParameter("recordApply");
		Record recordHistory = (Record) getParameter("recordHistory");
		Record recordOpinion = (Record) getParameter("recordOpinion");
		Record recordCeme = (Record) getParameter("recordCeme");

		String result=(String) getParameter("result");
		String assignmentId=(String) getParameter("assignmentId");
		
		FisCemeExpendInfo fisCemeExpendInfo = (FisCemeExpendInfo) recordCeme.toBean(FisCemeExpendInfo.class);
		fisCemeExpendInfoDomain.update(fisCemeExpendInfo);
		
		FisCemeLogoffOpinion fisCemeLogoffOpinion = (FisCemeLogoffOpinion) recordOpinion.toBean(FisCemeLogoffOpinion.class);
		fisCemeLogoffOpinionDomain.update(fisCemeLogoffOpinion);		

		FisCemeCheckHistory fisCemeCheckHistory = (FisCemeCheckHistory) recordHistory.toBean(FisCemeCheckHistory.class);
		fisCemeCheckHistoryDomain.insert(fisCemeCheckHistory);
		
		FisCemeApplyInfo fisCemeApplyInfo = (FisCemeApplyInfo) recordApply.toBean(FisCemeApplyInfo.class);
		fisCemeApplyInfoDomain.sendOfExpendOp(fisCemeApplyInfo,result,assignmentId);
	}
	@Trans
	public void startOfExpend(){
		String cemeApplyId=(String) getParameter("cemeApplyId");
		fisCemeApplyInfoDomain.startOfExpend(cemeApplyId);
	}
	@Trans
	public void sendOfExpend(){
		/*
		 * commandSubmit.setParameter("hisID",recordHistory.get("HIS_ID"));
		 * 	commandSubmit.setParameter("opinion",recordApply.get("firstOpinion"));
		 */
		Record recordApply = (Record) getParameter("recordApply");
		String result=(String) getParameter("result");
		String assignmentId=(String) getParameter("assignmentId");
		Record recordHistory = (Record) getParameter("recordHistory");
    		
		FisCemeApplyInfo fisCemeApplyInfo = (FisCemeApplyInfo) recordApply.toBean(FisCemeApplyInfo.class);
		fisCemeApplyInfoDomain.sendOfExpend(fisCemeApplyInfo,result,assignmentId);
		
		FisCemeCheckHistory fisCemeCheckHistory = (FisCemeCheckHistory) recordHistory.toBean(FisCemeCheckHistory.class);
		fisCemeCheckHistoryDomain.insert(fisCemeCheckHistory);
	}
	@Trans
	public void sendOfExpendBQ(){

		Record recordApply = (Record) getParameter("recordApply");
		Record recordHistory = (Record) getParameter("recordHistory");
		Record recordOpinion = (Record) getParameter("recordOpinion");
		Record recordCeme = (Record) getParameter("recordCeme");

		String result=(String) getParameter("result");
		String assignmentId=(String) getParameter("assignmentId");
		
		FisCemeExpendInfo fisCemeExpendInfo = (FisCemeExpendInfo) recordCeme.toBean(FisCemeExpendInfo.class);
		fisCemeExpendInfoDomain.update(fisCemeExpendInfo);
		
		FisCemeLogoffOpinion fisCemeLogoffOpinion = (FisCemeLogoffOpinion) recordOpinion.toBean(FisCemeLogoffOpinion.class);
		fisCemeLogoffOpinionDomain.update(fisCemeLogoffOpinion);		

		FisCemeCheckHistory fisCemeCheckHistory = (FisCemeCheckHistory) recordHistory.toBean(FisCemeCheckHistory.class);
		fisCemeCheckHistoryDomain.insert(fisCemeCheckHistory);
		
		FisCemeApplyInfo fisCemeApplyInfo = (FisCemeApplyInfo) recordApply.toBean(FisCemeApplyInfo.class);
		fisCemeApplyInfoDomain.sendOfExpend(fisCemeApplyInfo,result,assignmentId);
	}
	// 删除 扩建所有信息
	public void deleteExpend() {
		ParameterSet pset = getParameterSet();
		fisCemeApplyInfoDomain.deleteExpend(pset);
		
	}
	//新增 经营性公墓验收流程
	public void insertAcceptance(){
		ParameterSet pset = getParameterSet();
		fisCemeApplyInfoDomain.insertAcceptance(pset);
	}
	//新增 经营性公墓验收流程
	public void insertAcceptanceForExpend(){
		ParameterSet pset = getParameterSet();
		fisCemeApplyInfoDomain.insertAcceptanceForExpend(pset);
	}	
	@Trans
	public void updateAcceptance() {
		Record applyRecord = (Record) getParameter("applyInfoRecord");
		Record cemeRecord = (Record) getParameter("cemeRecord");
		Record historyRecord = (Record) getParameter("historyRecord");//applyInfoRecord、cemeRecord、historyRecord为前台js文件传过来的var cemeRecord = fisCemeDataSet.getCurrent();
		FisCemeApplyInfo fisCemeApplyInfo = (FisCemeApplyInfo) applyRecord.toBean(FisCemeApplyInfo.class);
		fisCemeApplyInfoDomain.update(fisCemeApplyInfo);
		FisCemeInfo fisCemeInfo = (FisCemeInfo) cemeRecord.toBean(FisCemeInfo.class);
		fisCemeInfoDomain.update(fisCemeInfo);
		FisCemeCheckHistory fisCemeCheckHistory = (FisCemeCheckHistory) historyRecord.toBean(FisCemeCheckHistory.class);
		fisCemeCheckHistoryDomain.update(fisCemeCheckHistory);
		 
	}
	@Trans
	public void updateAcceptanceForExpend() {
		Record applyRecord = (Record) getParameter("applyInfoRecord");
		Record cemeRecord = (Record) getParameter("cemeRecord");
		Record historyRecord = (Record) getParameter("historyRecord");//applyInfoRecord、cemeRecord、historyRecord为前台js文件传过来的var cemeRecord = fisCemeDataSet.getCurrent();
		FisCemeApplyInfo fisCemeApplyInfo = (FisCemeApplyInfo) applyRecord.toBean(FisCemeApplyInfo.class);
		fisCemeApplyInfoDomain.update(fisCemeApplyInfo);
		FisCemeExpendInfo fisCemeInfo  =(FisCemeExpendInfo) cemeRecord.toBean(FisCemeExpendInfo.class);
		fisCemeExpendInfoDomain.update(fisCemeInfo);
		FisCemeCheckHistory fisCemeCheckHistory = (FisCemeCheckHistory) historyRecord.toBean(FisCemeCheckHistory.class);
		fisCemeCheckHistoryDomain.update(fisCemeCheckHistory);
		 
	}
	
	@Trans
	public void sendCemeAcceptance(){
		Record recordApply = (Record) getParameter("recordApply");
		String result=(String) getParameter("result");
		String assignmentId=(String) getParameter("assignmentId");
		Record recordHistory = (Record) getParameter("recordHistory");
		Record recordCeme = (Record) getParameter("recordCeme");

		FisCemeInfo fisCemeInfo = (FisCemeInfo) recordCeme.toBean(FisCemeInfo.class);
		fisCemeInfoDomain.update(fisCemeInfo);	
		
		FisCemeApplyInfo fisCemeApplyInfo = (FisCemeApplyInfo) recordApply.toBean(FisCemeApplyInfo.class);
		fisCemeApplyInfoDomain.sendCemeAcceptance(fisCemeApplyInfo,result,assignmentId);
		
		FisCemeCheckHistory fisCemeCheckHistory = (FisCemeCheckHistory) recordHistory.toBean(FisCemeCheckHistory.class);
		fisCemeCheckHistoryDomain.insert(fisCemeCheckHistory);
		
		
	}
	@Trans
	public void sendCemeAcceptanceZD(){
		
		Record recordApply = (Record) getParameter("recordApply");
		Record recordHistory = (Record) getParameter("recordHistory");
		Record recordCeme = (Record) getParameter("recordCeme");
		String isKj = (String) getParameter("isKj");
		String result=(String) getParameter("result");
		String assignmentId=(String) getParameter("assignmentId");
		
		if("1".equals(isKj)){
			FisCemeExpendInfo fisCemeExpendInfo = (FisCemeExpendInfo) recordCeme.toBean(FisCemeExpendInfo.class);
			fisCemeExpendInfoDomain.update(fisCemeExpendInfo);
		}else if("0".equals(isKj)){
			FisCemeInfo fisCemeInfo = (FisCemeInfo) recordCeme.toBean(FisCemeInfo.class);
			fisCemeInfoDomain.update(fisCemeInfo);	
		}

		FisCemeCheckHistory fisCemeCheckHistory = (FisCemeCheckHistory) recordHistory.toBean(FisCemeCheckHistory.class);
		fisCemeCheckHistoryDomain.insert(fisCemeCheckHistory);
		
		FisCemeApplyInfo fisCemeApplyInfo = (FisCemeApplyInfo) recordApply.toBean(FisCemeApplyInfo.class);
		fisCemeApplyInfoDomain.sendCemeAcceptance(fisCemeApplyInfo,result,assignmentId);
	}
	
		
   /*
    * 验收任务删除
    */
	public void deleteAcceptance(){
		ParameterSet pset=getParameterSet();
		fisCemeApplyInfoDomain.deleteAcceptance(pset);
	}
	/*
	 *经营性公墓验收发起流程 
	 */
	 @Trans
	 public void startCemeAcceptance(){
		 String cemeApplyId=(String) getParameter("cemeApplyId");
			fisCemeApplyInfoDomain.startCemeAcceptance(cemeApplyId);
	 }
	 @Trans
	 public void saveCemeAcceptance(){
		 	Record recordApply = (Record) getParameter("recordApply");
			Record recordCeme = (Record) getParameter("recordCeme");

			String isKj=(String) getParameter("isKj");
			if("1".equals(isKj)){
				FisCemeExpendInfo fisCemeExpendInfo = (FisCemeExpendInfo) recordCeme.toBean(FisCemeExpendInfo.class);
				fisCemeExpendInfoDomain.update(fisCemeExpendInfo);
			}else if("0".equals(isKj)){
				FisCemeInfo fisCemeInfo = (FisCemeInfo) recordCeme.toBean(FisCemeInfo.class);
				fisCemeInfoDomain.update(fisCemeInfo);	
			}
			FisCemeApplyInfo fisCemeApplyInfo = (FisCemeApplyInfo) recordApply.toBean(FisCemeApplyInfo.class);
			fisCemeApplyInfoDomain.update(fisCemeApplyInfo);
			
	 }
		@Trans
		public void sendCemeAcceptanceCity(){
			Record recordApply = (Record) getParameter("recordApply");
			String result=(String) getParameter("result");
			String assignmentId=(String) getParameter("assignmentId");
			Record recordHistory = (Record) getParameter("recordHistory");
			Record recordCeme = (Record) getParameter("recordCeme");

			FisCemeInfo fisCemeInfo = (FisCemeInfo) recordCeme.toBean(FisCemeInfo.class);
			fisCemeInfoDomain.update(fisCemeInfo);	
			
			FisCemeApplyInfo fisCemeApplyInfo = (FisCemeApplyInfo) recordApply.toBean(FisCemeApplyInfo.class);
			fisCemeApplyInfoDomain.sendCemeAcceptanceCity(fisCemeApplyInfo,result,assignmentId);
			
			FisCemeCheckHistory fisCemeCheckHistory = (FisCemeCheckHistory) recordHistory.toBean(FisCemeCheckHistory.class);
			fisCemeCheckHistoryDomain.insert(fisCemeCheckHistory);
			
			
		}
		@Trans
		public void sendCemeAcceptanceZDCity(){
			
			Record recordApply = (Record) getParameter("recordApply");
			Record recordHistory = (Record) getParameter("recordHistory");
			Record recordCeme = (Record) getParameter("recordCeme");
			String isKj = (String) getParameter("isKj");
			String result=(String) getParameter("result");
			String assignmentId=(String) getParameter("assignmentId");
			
			if("1".equals(isKj)){
				FisCemeExpendInfo fisCemeExpendInfo = (FisCemeExpendInfo) recordCeme.toBean(FisCemeExpendInfo.class);
				fisCemeExpendInfoDomain.update(fisCemeExpendInfo);
			}else if("0".equals(isKj)){
				FisCemeInfo fisCemeInfo = (FisCemeInfo) recordCeme.toBean(FisCemeInfo.class);
				fisCemeInfoDomain.update(fisCemeInfo);	
			}

			FisCemeCheckHistory fisCemeCheckHistory = (FisCemeCheckHistory) recordHistory.toBean(FisCemeCheckHistory.class);
			fisCemeCheckHistoryDomain.insert(fisCemeCheckHistory);
			
			FisCemeApplyInfo fisCemeApplyInfo = (FisCemeApplyInfo) recordApply.toBean(FisCemeApplyInfo.class);
			fisCemeApplyInfoDomain.sendCemeAcceptanceCity(fisCemeApplyInfo,result,assignmentId);
		}
	
}
