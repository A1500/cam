package com.inspur.cams.welfare.welfarecorp.apply.cmd;

import javax.servlet.http.HttpServletRequest;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.welfare.welfarecorp.apply.domain.IUnitApplyDomain;

/**
 * 社会福利企业资格认定
 * 
 * @author liuxin
 * @date 2013-06-08
 */
public class UnitApplyCmd extends BaseAjaxCommand {
	private IUnitApplyDomain unitApplyDomain = ScaComponentFactory.getService(
			IUnitApplyDomain.class, "unitApplyDomain/unitApplyDomain");

	// 资格认定信息采集第一页保存——插入业务表和信息表数据
	@Trans
	public void saveQualification() {
		Record infoRecord = (Record) getParameter("unitInfoRecord");
		String dataSource = (String) getParameter("dataSource");
		HttpServletRequest request=(HttpServletRequest)getRequest();
		unitApplyDomain.saveQualification(infoRecord,dataSource,request);
	}

	// 福利企业年检信息采集第一页(根据字号回填)保存——插入业务表和信息表数据
	public void saveQualificationD() {
		Record StatusRecord = (Record) getParameter("unitStatusRecord");
		String taskCode = (String) getParameter("taskCode");
		String applyType = (String) getParameter("applyType");
		String dataSource = (String) getParameter("dataSource");
		unitApplyDomain.saveQualificationD(StatusRecord,taskCode,applyType,dataSource);
	}

	// 资格认定信息采集第二页保存——基本信息
	@Trans
	public void saveQualificationInfo() {
		Record infoRecord = (Record) getParameter("unitInfoRecord");
		unitApplyDomain.saveQualificationInfo(infoRecord);
	}
	//福利企业年检删除
	@Trans
	public void someDelete(){
		String taskCode = (String) getParameter("taskCode");
		unitApplyDomain.someDelete(taskCode);
		
	}

	// 资格认定信息采集第三页保存-申请理由
	public void saveQualificationT(){
		Record infoRecord = (Record) getParameter("unitInfoRecord");
		unitApplyDomain.saveQualificationT(infoRecord);
	}
	/**
	 * 保存业务信息
	 */
	@Trans
	public void saveUnitApply() {
		unitApplyDomain.saveUnitApply(this.getParameterSet());
	}

	/**
	 * 创建并发起资格认定业务流程
	 */
	@Trans
	public void createAndSendQualification() {
		unitApplyDomain.createAndSendQualification(getParameterSet());
	}

	/**
	 * 发送资格认定业务流程
	 */
	@Trans
	public void sendQualification() {
		unitApplyDomain.sendQualification(getParameterSet());
	}

	/**
	 * 创建并发起年审业务流程
	 */
	@Trans
	public void createAndSendYearlyCheck() {
		unitApplyDomain.createAndSendYearlyCheck(getParameterSet());
	}

	/**
	 * 发送年审业务流程
	 */
	@Trans
	public void sendYearlyCheck() {
		unitApplyDomain.sendYearlyCheck(getParameterSet());
	}

}
