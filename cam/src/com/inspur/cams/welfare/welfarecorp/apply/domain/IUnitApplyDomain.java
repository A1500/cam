package com.inspur.cams.welfare.welfarecorp.apply.domain;

import javax.servlet.http.HttpServletRequest;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;
/**
 * 社会福利企业资格认定
 * 
 * @author liuxin
 * @date 2013-06-08
 */
public interface IUnitApplyDomain {
	/**
	 * 资格认定信息采集第一页保存——插入业务表和信息表数据
	 */
	@Trans
	public void saveQualification(Record infoRecord,String dataSource,HttpServletRequest request);

	/**
	 * 年检信息采集第一页(根据字号回填)保存——插入业务表和信息表数据
	 */
	@Trans
	public void saveQualificationD(Record StatusRecord,String taskCode,String applyType,String dataSource);

	/**
	 * 资格认定信息采集第二页保存——基本信息
	 */
	@Trans
	public void saveQualificationInfo(Record infoRecord);
	
	/**
	 * 福利企业年检删除
	 */
	@Trans
	public void someDelete(String taskCode);

	/**
	 * 资格认定信息采集第三页保存-申请理由
	 * 
	 * @param infoRecord
	 */
	@Trans
	public void saveQualificationT(Record infoRecord);

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
	 * 保存业务信息
	 */
	@Trans
	public void saveUnitApply(ParameterSet pset);

	/**
	 * 创建并发起年审业务流程
	 */
	public void createAndSendYearlyCheck(ParameterSet pset);

	/**
	 * 发送年审业务流程
	 */
	public void sendYearlyCheck(ParameterSet pset);

}
