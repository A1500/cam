package com.inspur.sdmz.jzfa.cmd;

import javax.servlet.http.HttpServletRequest;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import org.osoa.sca.annotations.Reference;

import com.inspur.sdmz.jzfa.dao.jdbc.PlanDao;
import com.inspur.sdmz.jzfa.domain.IPlanDomain;

/**
 * 救助方案查询Cmd
 * @author shgtch
 * @date 2011-4-18
 */
public class PlanQueryCmd extends BaseQueryCommand{
	@Reference
	IPlanDomain planDomain = ScaComponentFactory.getService(IPlanDomain.class, "HelpDomain/HelpService");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		DataSet dataset = planDomain.jzfaQuery(pset);
		return dataset;
	}
	
	public DataSet queryExt() {
		ParameterSet pset = getParameterSet();
		DataSet dataset = planDomain.queryExt(pset);
		return dataset;
	}
	
//	public DataSet initAddWin(){
//		String orgName=BspUtil.getCorpOrgan().getOrganName();
//		Record  record= new Record();
//		record.set("planOrgName", orgName);
//		DataSet ds=new DataSet(record);
//		return ds;
//	}
	/**
	 * 救助方案统计
	 * 传organCode
	 * */
	public DataSet sjtj(){
		PlanDao dao= (PlanDao) DaoFactory.getDao(PlanDao.class);
		ParameterSet pset=getParameterSet();
		DataSet ds=dao.getJzNum(pset);
		return ds;
	}
	/**
	 * 已实施救助方案数据统计
	 * 
	 **/
	public DataSet sjtjss(){
		PlanDao dao= (PlanDao) DaoFactory.getDao(PlanDao.class);
		HttpServletRequest request=(HttpServletRequest)getRequest();
		DataSet ds=dao.getJzfassNum(getParameterSet(),request);
		return ds;
	}
	/**
	 * 救助方案分析统计
	 * 
	 * */
	public DataSet sjtjAnalyze(){
		PlanDao dao= (PlanDao) DaoFactory.getDao(PlanDao.class);
		HttpServletRequest request=(HttpServletRequest)getRequest();
		DataSet ds=dao.getJzfaAnalyze(getParameterSet(),request);
		return ds;
	}
	/**
	 * 救助方案查询
	 * 
	 * */
	public DataSet jzfaQuery(){
		ParameterSet pset = getParameterSet();
		DataSet dataset = planDomain.jzfaQuery(pset);
		dataset.getMetaData().setIdProperty("planId");
		return dataset;
	}
	/**
	 * 救助方案分析查询
	 * 
	 **/
	public DataSet analyzeJzfa(){
		ParameterSet pset = getParameterSet();
		String jzfaids=(String)pset.getParameter("planId");
		DataSet ds=planDomain.analyzeJzfa(jzfaids);
		return ds;
	}
	/**
	 * 救助方案分析
	 * 
	 * */
	
	public DataSet sjtjfxAnalyze(){
		ParameterSet pset = getParameterSet();
		String jzfaids=(String)pset.getParameter("planId");
		DataSet ds=planDomain.analyzeJzfafx(jzfaids);
		return ds;
	}
	/**
	 * 家庭救助历史信息
	 * 
	 **/
	public DataSet getFamilyAssist(){
		PlanDao dao= (PlanDao) DaoFactory.getDao(PlanDao.class);
		ParameterSet pset = getParameterSet();
		DataSet ds=dao.getFamilyAssist(pset);
		return ds;
	}
	/**
	 * 本人救助历史信息
	 * 
	 **/
	public DataSet getPersonAssist(){
		PlanDao dao= (PlanDao) DaoFactory.getDao(PlanDao.class);
		ParameterSet pset = getParameterSet();
		DataSet ds=dao.getPersonAssist(pset);
		return ds;
	}
	/**
	 * 家庭其他成员救助历史信息
	 * 
	 **/
	public DataSet getOtherPersonAssist(){
		PlanDao dao= (PlanDao) DaoFactory.getDao(PlanDao.class);
		ParameterSet pset = getParameterSet();
		DataSet ds=dao.getOtherPersonAssist(pset);
		return ds;
	}
	
}
