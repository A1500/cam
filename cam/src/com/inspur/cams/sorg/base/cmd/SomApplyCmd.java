package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.domain.ISomApplyDomain;

/**
 * 业务信息保存和修改
 * @author zhangjian
 * @date 2011-11-4
 */
public class SomApplyCmd extends BaseAjaxCommand {

	ISomApplyDomain somApplyDomain = ScaComponentFactory.getService(ISomApplyDomain.class, "SomApplyDomain/SomApplyDomain");

	public void queryApplyAccept() {
		ParameterSet pset = getParameterSet();
		SomApply somApply= (SomApply)somApplyDomain.query(pset).getRecord(0).toBean(SomApply.class);
		//String applyType=somApply.getApplyType();
		String sorgName=somApply.getSorgName();
		//String appPeople=somApply.getAppPeople();
		String appDate=somApply.getAppDate();
		String[] appDateStr={"","",""};
		if (appDate!=null&&!("".equals(appDate))) {
			appDateStr=somApply.getAppDate().split("-");			
		}
		String acceptDeptName="";
		if (somApply.getAcceptDeptName()!=null&&!("".equals(somApply.getAcceptDeptName()))) {
			acceptDeptName=somApply.getAcceptDeptName();
		}
		String cnName="";
		cnName=sorgName;
		/*if ("001".equals(applyType)||"002".equals(applyType)||"101".equals(applyType)||"201".equals(applyType)) {
			cnName=appPeople;
		}else{
			cnName=sorgName;
		}*/
		setReturn("cnName",cnName);		
		setReturn("appDateY", appDateStr[0]);
		setReturn("appDateM", appDateStr[1]);
		setReturn("appDateD", appDateStr[2]);
		setReturn("sendAddress", acceptDeptName);
	}
	
	public void queryApplyNoAccept() {
		ParameterSet pset = getParameterSet();
		SomApply somApply= (SomApply)somApplyDomain.query(pset).getRecord(0).toBean(SomApply.class);
		//String applyType=somApply.getApplyType();
		String sorgName=somApply.getSorgName();
		//String appPeople=somApply.getAppPeople();
		String appDate=somApply.getAppDate();
		String[] appDateStr={"","",""};
		if (appDate!=null&&!("".equals(appDate))) {
			appDateStr=somApply.getAppDate().split("-");			
		}
		String acceptDeptName="";
		if (somApply.getAcceptDeptName()!=null&&!("".equals(somApply.getAcceptDeptName()))) {
			acceptDeptName=somApply.getAcceptDeptName();
		}
		String cnName="";
		cnName=sorgName;
		/*if ("001".equals(applyType)||"002".equals(applyType)||"101".equals(applyType)||"201".equals(applyType)) {
			cnName=appPeople;
		}else{
			cnName=sorgName;
		}*/
		setReturn("cnName",cnName);		
		setReturn("appDateY", appDateStr[0]);
		setReturn("appDateM", appDateStr[1]);
		setReturn("appDateD", appDateStr[2]);
		setReturn("sendAddress", acceptDeptName);
	}
	
	public void updateSomApply() {
		Record SomApplyRecord = (Record) getParameter("SomApplyRecord");
		SomApply somApply= (SomApply)SomApplyRecord.toBean(SomApply.class);
		somApplyDomain.update(somApply);
	}
}
