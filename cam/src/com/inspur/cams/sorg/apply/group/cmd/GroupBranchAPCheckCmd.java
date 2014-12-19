package com.inspur.cams.sorg.apply.group.cmd;

import java.util.HashMap;
import java.util.Map;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.apply.group.domain.IGroupBranchAPCheckDomain;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomOrgan;
public class GroupBranchAPCheckCmd extends BaseAjaxCommand {
	// 获取SCA组件
	private IGroupBranchAPCheckDomain service = ScaComponentFactory.getService(IGroupBranchAPCheckDomain.class, "groupBranchAPCheckDomain/groupBranchAPCheckDomain");
	
	/**
	 * 社会组织主表查询
	 */
	public DataSet queryOrgan(){
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryOrgan(pset);
		return ds;
	}
	/**
	 * 业务流程意见表查询
	 */
	public void queryFlow(){
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryFlow(pset);
		setReturn("flowDataSet", ds);
	}
	/**
	 * 保存业务信息
	 */
	public void insertBuildInfo() {	
		
		service.insertBuildInfo(getSomApply());		
	}
	/**
	 * 业务信息保存创建并发送
	 */
	public void saveAndSendBuild(){
		service.saveAndSendBuild(getSomApply());
	}
	/**
	 * 更新业务信息
	 */
	public void updateBuildInfo(){
		service.updateBuildInfo(getSomApply());
		
	}
	/**
	 * 更新业务信息并发送
	 */
	public void updateForSend(){
		service.updateForSend(getSomApply());
	}
	/**
	 * 更新业务意见信息
	 */
	public void updateApply(){
		//获取前台业务意见信息
		Record applyRd = (Record) getParameter("somApplyRecord");
		SomApply applyBean = (SomApply) applyRd.toBean(SomApply.class);
		service.updateApply(applyBean);
	}
	
	/**
	 *  保存并发送
	 */
	public void send(){
		//根据环节定义获取环节信息
		Record applyRd = (Record) getParameter("somApplyRecord");
		SomApply applyBean = (SomApply) applyRd.toBean(SomApply.class);
		Map<String, String> map=new HashMap<String, String>();
		applyBean.setMap(map);
		service.send(applyBean);
	}
	
	
	/**
	 * 获取最后环节processId
	 */
	public String getProcessId(String id){
		return service.queryProcessId(id);
	}
	
	/**
	 * 通过processId获取taskCode
	 */
	public SomApply getTaskCode(String processId){
		return service.queryTaskCode(processId);
	}
	
	
	/**
	 * 从后台获取数据
	 */
	private SomApply getSomApply() {
		Record organRecord = (Record) getParameter("organRecord");
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		SomOrgan somOrgan=(SomOrgan)organRecord.toBean(SomOrgan.class);	
		SomApply somApply=(SomApply)somApplyRecord.toBean(SomApply.class);
		somApply.setSomOrgan(somOrgan);
		return somApply;
	}
}
