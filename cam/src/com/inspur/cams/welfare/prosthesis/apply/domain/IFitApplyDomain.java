package com.inspur.cams.welfare.prosthesis.apply.domain;

import javax.servlet.http.HttpServletRequest;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.welfare.base.data.WealFitApply;

public interface IFitApplyDomain{
	/**
	 * 资格认定信息采集第一页保存——插入业务表和信息表数据
	 */
	@Trans
	public void saveQualification(Record infoRecord,String dataSource,HttpServletRequest request);
	
	/**
	 * 资格认定信息采集第一页(根据字号回填)保存——插入业务表和信息表数据
	 */
	@Trans
	public void saveQualificationD(Record StatusRecord,Record[] WorkerRd,Record[] FitDeviceRd,Record[] FitProductivepowerRd,String regDate,String taskCode,String applyType,String dataSource);
	
	/**
	 * 资格认定信息采集第二页保存——基本信息
	 */
	@Trans
	public void saveQualificationInfo(Record infoRecord,Record[] deviceRecord,Record[] productRecord);
	/**
	 * 假肢企业年检删除
	 */
	@Trans
	public void someDelete(ParameterSet pset);
	/**
	 * 创建并发起资格认定业务流程
	 */
	@Trans
	public void createAndSendQualification(ParameterSet pset);
	/**
	 * 发送资格认定业务流程
	 */
	@Trans
	public void sendQualification(ParameterSet pset);
	/**
	 *保存业务信息
	 */
	@Trans
	public void saveFitApply(ParameterSet pset);
	
	
	/**
	 * 创建并发起年审业务流程
	 */
	public void createAndSendYearlyCheck(ParameterSet pset);
	/**
	 * 发送年审业务流程
	 */
	public void sendYearlyCheck(ParameterSet pset); 
	/**
	 * 创建并发起换证业务流程
	 */
	public void createAndSendCertChange(ParameterSet pset);
	/**
	 * 发送换证业务流程
	 */
	public void sendCertChange(ParameterSet pset); 
}