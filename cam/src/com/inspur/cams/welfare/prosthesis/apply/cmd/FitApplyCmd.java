package com.inspur.cams.welfare.prosthesis.apply.cmd;

import javax.servlet.http.HttpServletRequest;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.welfare.prosthesis.apply.domain.IFitApplyDomain;

/**
 * 假肢业务申请cmd
 * @author zhaojin
 * @date 2011-8-23
 */
public class FitApplyCmd extends BaseAjaxCommand {
	
	private IFitApplyDomain fitApplyDomain = ScaComponentFactory
	.getService(IFitApplyDomain.class, "fitApplyDomain/fitApplyDomain");
	
	//资格认定信息采集第一页保存——插入业务表和信息表数据
	@Trans
	public void saveQualification() {
		Record infoRecord=(Record) getParameter("fitInfoRecord");
		String dataSource = (String) getParameter("dataSource");//外网保存时，传入字段：值为 ONLINE
		HttpServletRequest request=(HttpServletRequest)getRequest();
		fitApplyDomain.saveQualification(infoRecord,dataSource,request);
	}
	
	//资格认定信息采集第一页(根据字号回填)保存——插入业务表和信息表数据
	@Trans
	public void saveQualificationD() {
		Record StatusRecord=(Record) getParameter("fitStatusRecord");
		Record WorkerRd[]=(Record[]) getParameter("WorkerRd");
		Record FitDeviceRd[]=(Record[]) getParameter("FitDeviceRd");
		Record FitProductivepowerRd[]=(Record[]) getParameter("FitProductivepowerRd");
		String regDate =(String) getParameter("regDate");
		String taskCode = (String) getParameter("taskCode");
		String applyType = (String) getParameter("applyType");
		String dataSource = (String) getParameter("dataSource");//外网保存时，传入字段：值为 ONLINE
		fitApplyDomain.saveQualificationD(StatusRecord,WorkerRd,FitDeviceRd,FitProductivepowerRd,regDate,taskCode,applyType,dataSource);
	}
	
	//资格认定信息采集第二页保存——基本信息
	@Trans
	public void saveQualificationInfo(){
		Record infoRecord=(Record) getParameter("fitInfoRecord");
		Record deviceRecord[]=(Record[]) getParameter("deviceRecords");
		Record productRecord[]=(Record[]) getParameter("productRecords");
		fitApplyDomain.saveQualificationInfo(infoRecord,deviceRecord,productRecord);
	}
	
	//假肢企业年检删除
	@Trans
	public void someDelete(){
		
		fitApplyDomain.someDelete(getParameterSet());
	}
	/**
	 *保存业务信息
	 */
	@Trans
	public void saveFitApply() {
		fitApplyDomain.saveFitApply(this.getParameterSet());
	}
	
	/**
	 * 创建并发起资格认定业务流程
	 */
	@Trans
	public void createAndSendQualification() {
		
		fitApplyDomain.createAndSendQualification(getParameterSet());
	}
	/**
	 * 发送资格认定业务流程
	 */
	@Trans
	public void sendQualification() {
		fitApplyDomain.sendQualification(getParameterSet());
	}
	/**
	 * 创建并发起年审业务流程
	 */
	@Trans
	public void createAndSendYearlyCheck() {
		
		fitApplyDomain.createAndSendYearlyCheck(getParameterSet());
	}
	/**
	 * 发送年审业务流程
	 */
	@Trans
	public void sendYearlyCheck() {
		fitApplyDomain.sendYearlyCheck(getParameterSet());
	}
	/**
	 * 创建并发起换证业务流程
	 */
	@Trans
	public void createAndSendCertChange() {
		
		fitApplyDomain.createAndSendCertChange(getParameterSet());
	}
	/**
	 * 发送换证业务流程
	 */
	@Trans
	public void sendCertChange() {
		fitApplyDomain.sendCertChange(getParameterSet());
	}	
}
