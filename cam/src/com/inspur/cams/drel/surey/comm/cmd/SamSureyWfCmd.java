package com.inspur.cams.drel.surey.comm.cmd;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.persistent.transaction.PlatformTransactionManager;
import org.loushang.persistent.transaction.TransactionDefinition;
import org.loushang.persistent.transaction.TransactionStatus;
import org.loushang.persistent.transaction.support.DefaultTransactionDefinition;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.TransactionFactory;

import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.StrUtil;
import com.inspur.cams.drel.surey.assistance.data.SamSureyAssistanceResult;
import com.inspur.cams.drel.surey.assistance.data.SamSureyWfAssistanceHis;
import com.inspur.cams.drel.surey.comm.data.SamSurey;
import com.inspur.cams.drel.surey.comm.data.SamSureyWf;
import com.inspur.cams.drel.surey.comm.data.SamSureyWfHis;
import com.inspur.cams.drel.surey.comm.domain.ISamSureyWfDomain;
import com.inspur.cams.drel.surey.util.ActivityStatus;
import com.inspur.cams.drel.surey.util.SureyActivity;
/**
 * 
 * @author jiang
 *  
 */
public class SamSureyWfCmd extends BaseAjaxCommand{
	//流程结束标志--IS_FINISH=‘1’
	public static final String IS_FINISH = "1";
	//流程未结束--NOT_FINISH=‘0’
	public static final String NOT_FINISH = "0";
	//核对类型---农村低保
	public static final String MININUM="02";
	//核对类型---城市低保
	public static final String MININUM_CITY="01";
	//核对类型--低收入
	public static final String LOW_INCOME="03";
	//核对结果--非农村低保
	public static final String NOT_MININUM="12";
	//核对结果--非城市低保
	public static final String NOT_MININUM_CITY="11";
	//核对结果--非低收入
	public static final String NOT_LOW_INCOME="13";
	//处理结果--办理完结
	public static final String RESULT_END="ED";
	//处理结果--转办
	public static final String RESULT_TRANS="TR";
	//民政局单位类型---SAM_ORGAN_TYPE='A1';
	public static final String SAM_ORGAN_TYPE = "A1";
	//经济核对中心
	public static final String JJHDZX="济南市经济核对中心";
	//区县经济核对中心
	public static final String QXJJHDZX="区县经济核对中心";
	//市级民政
	public static final String BE_CITY="beCity";
	//区县民政
	public static final String BE_DISTRICT="beDistrict";
	ISamSureyWfDomain service = ScaComponentFactory.getService(ISamSureyWfDomain.class,"SamSureyWfDomain/SamSureyWfDomain");
	//核对
	@SuppressWarnings("unchecked")
	public void checkSamSurey(){
		Map<String,String> map=(Map<String,String>)getParameter("map");
		String flowId=map.get("flowId");
	
		String sureyId=map.get("sureyId");
		String surveyResult=map.get("surveyResult");
		String surveyOrganName=map.get("surveyOrganName");
		String surveyDate=map.get("surveyDate");
		String signOrgan=map.get("signOrgan");
		String signDate=map.get("signDate");
		String organId=map.get("organId");
		String userId=map.get("userId");
		String userName=map.get("userName");
		String opinionCode=map.get("opinionCode");
		String opinion=map.get("opinion");
		//更新核对流程信息
		SamSureyWf sureyWf=getSureyWfBean(flowId);
		String preActivityArea=sureyWf.getPreActivityArea();
		String surveyId=sureyWf.getSurveyId();
		sureyWf.setOpinionCode(opinionCode);
		sureyWf.setOpinion(opinion);
		sureyWf.setCurActivityOrgan(organId);
		sureyWf.setCurStatus(ActivityStatus.DONE);	
		sureyWf.setCurActivity(SureyActivity.ACT_FILLING);
		String organGrade=getOrganGrade(preActivityArea);
		//区县外部单位发来的 
		if(BE_DISTRICT.equals(organGrade)){
			SamSurey samSurey=getSamSurey(surveyId);
			sureyWf.setNextActivityArea(samSurey.getApplyOrganArea());
			sureyWf.setNextActivityOrgan(samSurey.getApplyOrgan());
			sureyWf.setNextActivityOrganName(samSurey.getApplyOrganName());
			sureyWf.setNextActivityOrganType(samSurey.getApplyOrganType());
			sureyWf.setNextActivityOrganName(service.getCenterName(sureyWf.getCurActivityArea()));
			sureyWf.setCurActivityOrganName(service.getOrganName(sureyWf.getCurActivityArea()));
			sureyWf.setPreActivityOrganName(service.getOrganName(sureyWf.getCurActivityArea()));
		}else if(BE_CITY.equals(organGrade)){
		//市民政发来的，必须办理完成，返回市民政	
			sureyWf.setNextActivity("");
			sureyWf.setNextActivityArea(sureyWf.getPreActivityArea());
			sureyWf.setNextActivityOrgan("");
			sureyWf.setNextActivityOrganName(sureyWf.getPreActivityOrganName());
			sureyWf.setNextActivityOrganType(sureyWf.getPreActivityOrganType());
			sureyWf.setPreActivityOrganName(service.getOrganName(sureyWf.getCurActivityArea()));
		}
				
		//流程历史记录
		SamSureyWfHis sureyWfHis=new SamSureyWfHis();
		sureyWfHis.setHisId(IdHelp.getUUID32());
		sureyWfHis.setFlowId(flowId);
		sureyWfHis.setActivity(sureyWf.getCurActivity());
		sureyWfHis.setOpinionCode(opinionCode);
		sureyWfHis.setOpinion(opinion);
		sureyWfHis.setActivityOrgan(organId);
		sureyWfHis.setActivityOrganName(surveyOrganName);
		sureyWfHis.setActivityOrganArea(sureyWf.getCurActivityArea());
		sureyWfHis.setActivityOrganType(sureyWf.getCurActivityOrganType());
		sureyWfHis.setActivityPeople(userId);
		sureyWfHis.setActivityPeopleName(userName);
		sureyWfHis.setActivityDealTime(DateUtil.getTime());
		sureyWfHis.setCurActivityEt(DateUtil.getTime());
		sureyWfHis.setCurActivitySt(sureyWf.getCurActivitySt());
		//流程历史结果
		SamSureyWfAssistanceHis sureyWfAssistanceHis=new SamSureyWfAssistanceHis();
		sureyWfAssistanceHis.setHisId(sureyWfHis.getHisId());
		sureyWfAssistanceHis.setSurveyResult(surveyResult);
		sureyWfAssistanceHis.setSignOrgan(signOrgan);
		sureyWfAssistanceHis.setSignDate(signDate);
		
		//根据数据源获取事务管理器。
		PlatformTransactionManager txManager = TransactionFactory.getTransactionManager("dataSource");
		//定义事务的一些属性，比如只读、隔离级别等。
		TransactionDefinition definition = new DefaultTransactionDefinition();
		//事务开始
		TransactionStatus status = txManager.getTransaction(definition);
		try{
			service.update(sureyWf);
			service.insertSureyWfHis(sureyWfHis);
			service.insertSureyWfAssistanceHis(sureyWfAssistanceHis);			
		}catch(Throwable err){
			txManager.rollback(status);
			throw new RuntimeException(err);
		}
		//事务提交。
		txManager.commit(status);
		
	}
	/**
	 * 转办
	 */
	@SuppressWarnings("unchecked")
	public void transmitOther(){  
		
		//TODO
		Map<String,String> map=(Map<String,String>)getParameter("map");
		String flowId=map.get("flowId");
		String surveyId=map.get("surveyId");
		String userGrade=map.get("userGrade");
		String organId=map.get("organId");
		String opinionCode=map.get("opinionCode");
		String opinion=map.get("opinion");
		 
		String userId=map.get("userId");
		String userName=map.get("userName");
		String organName=map.get("organName");
		String domicileCode=map.get("domicileCode");//户籍
		String apanageCode=map.get("apanageCode");//居住地
		
		
		SamSureyWf samSureyWf=getSureyWfBean(flowId);
		 
		
		SamSureyWfHis sureyWfHis=new SamSureyWfHis();
		sureyWfHis.setHisId(IdHelp.getUUID32());
		sureyWfHis.setFlowId(flowId);
		sureyWfHis.setActivity(samSureyWf.getCurActivity());
		sureyWfHis.setOpinionCode(samSureyWf.getOpinionCode());
		sureyWfHis.setOpinion(samSureyWf.getOpinion());
		sureyWfHis.setActivityOrgan(organId);
		sureyWfHis.setActivityOrganName(organName);
		sureyWfHis.setActivityOrganArea(samSureyWf.getCurActivityArea());
		sureyWfHis.setActivityOrganType(samSureyWf.getCurActivityOrganType());
		sureyWfHis.setActivityPeople(userId);
		sureyWfHis.setActivityPeopleName(userName);
		sureyWfHis.setActivityDealTime(DateUtil.getTime());
		sureyWfHis.setCurActivityEt(DateUtil.getTime());
		sureyWfHis.setCurActivitySt(samSureyWf.getCurActivitySt());
		
		if(BE_DISTRICT.equals(userGrade)){
			samSureyWf.setCurActivity(SureyActivity.ACT_FILLING);
			samSureyWf.setCurStatus(ActivityStatus.DONE);
			samSureyWf.setOpinionCode(opinionCode);
			samSureyWf.setOpinion(opinion);
			samSureyWf.setCurActivityOrgan(organId);
			String curActivityArea=samSureyWf.getCurActivityArea();
			String transmitCode=curActivityArea.substring(0, 4)+"00000000";
			samSureyWf.setNextActivity(SureyActivity.ACT_CITY_SEND);
			samSureyWf.setNextActivityArea(transmitCode);
			samSureyWf.setNextActivityOrganName(service.getCenterName(curActivityArea));
			samSureyWf.setNextActivityOrganType(SAM_ORGAN_TYPE);
			samSureyWf.setPreActivityOrganName(service.getOrganName(curActivityArea));
			samSureyWf.setCurActivityOrganName(service.getOrganName(curActivityArea));
		}else if(BE_CITY.equals(userGrade)){
			samSureyWf.setCurStatus(ActivityStatus.DONE);
		}
		
		service.update(samSureyWf);
		service.insertSureyWfHis(sureyWfHis);
	}
	/**
	 * 区转发给市
	 */
	public void districtTransmit(){
		Map<String,String> map=(Map<String,String>)getParameter("map");
		String flowId=map.get("flowId");
		String surveyId=map.get("surveyId");
		String organId=map.get("organId");
		String userId=map.get("userId");
		String userName=map.get("userName");
		String organName=map.get("organName");
		
		SamSureyWf sureyWf=getSureyWfBean(flowId);
		//流程历史记录
		SamSureyWfHis sureyWfHis=new SamSureyWfHis();
		sureyWfHis.setHisId(IdHelp.getUUID32());
		sureyWfHis.setFlowId(flowId);
		sureyWfHis.setActivity(sureyWf.getCurActivity());
		sureyWfHis.setOpinionCode(sureyWf.getOpinionCode());
		sureyWfHis.setOpinion(sureyWf.getOpinion());
		sureyWfHis.setActivityOrgan(organId);
		sureyWfHis.setActivityOrganName(sureyWf.getCurActivityOrganName());
		sureyWfHis.setActivityOrganArea(sureyWf.getCurActivityArea());
		sureyWfHis.setActivityOrganType(sureyWf.getCurActivityOrganType());
		sureyWfHis.setActivityPeople(userId);
		sureyWfHis.setActivityPeopleName(userName);
		sureyWfHis.setActivityDealTime(DateUtil.getTime());
		sureyWfHis.setCurActivityEt(DateUtil.getTime());
		sureyWfHis.setCurActivitySt(sureyWf.getCurActivitySt());
		//流程记录
		String curOrganCode=sureyWf.getCurActivityArea();
		sureyWf.setPreActivity(sureyWf.getCurActivity());
		sureyWf.setPreActivityArea(curOrganCode);
		sureyWf.setPreActivityOrgan(sureyWf.getCurActivityOrgan());
		sureyWf.setPreActivityOrganName(organName);
		sureyWf.setPreActivityOrganType(sureyWf.getCurActivityOrganType());
		sureyWf.setCurActivity(sureyWf.getNextActivity());
		sureyWf.setCurStatus(ActivityStatus.TODO);
		sureyWf.setCurActivityArea(sureyWf.getNextActivityArea());
		sureyWf.setCurActivityOrganType(sureyWf.getNextActivityOrganType());
		sureyWf.setCurActivityOrganName(sureyWf.getNextActivityOrganName());
		sureyWf.setCurActivitySt(DateUtil.getTime());
		sureyWf.setNextActivity(SureyActivity.ACT_FILLING);
		String domicileCode=sureyWf.getDomicileCode();
		String apanageCode=sureyWf.getApanageCode();
		if(!curOrganCode.equals(domicileCode)){
			sureyWf.setNextActivityArea(domicileCode);
			sureyWf.setNextActivityOrgan("");
			sureyWf.setNextActivityOrganName(service.getOrganName(domicileCode));
			sureyWf.setNextActivityOrganType(SAM_ORGAN_TYPE);
		}else if(!curOrganCode.equals(apanageCode)){
			sureyWf.setNextActivityArea(apanageCode);
			sureyWf.setNextActivityOrgan("");
			sureyWf.setNextActivityOrganName(service.getOrganName(apanageCode));
			sureyWf.setNextActivityOrganType(SAM_ORGAN_TYPE);
		}
		//根据数据源获取事务管理器。
		PlatformTransactionManager txManager = TransactionFactory.getTransactionManager("dataSource");
		//定义事务的一些属性，比如只读、隔离级别等。
		TransactionDefinition definition = new DefaultTransactionDefinition();
		//事务开始
		TransactionStatus status = txManager.getTransaction(definition);
		try{
			service.update(sureyWf);
			service.insertSureyWfHis(sureyWfHis);
		}catch(Throwable err){
			txManager.rollback(status);
			throw new RuntimeException(err);
		}
		//事务提交。
		txManager.commit(status);
	}
	/**
	 *  
	 * 区县将核对结果上报给市经济核对中心
	 */
	public void townReportToCity(){
		Map<String,String> map=(Map<String,String>)getParameter("map");
		String flowId=map.get("flowId");
		String surveyId=map.get("surveyId");
		String organId=map.get("organId");
		String userId=map.get("userId");
		String userName=map.get("userName");
		String organName=map.get("organName");
		String domicileCode=map.get("domicileCode");//户籍
		String apanageCode=map.get("apanageCode");//居住地
	 
		SamSureyWf sureyWf=getSureyWfBean(flowId);
		
		SamSurey samSurey= getSamSurey(surveyId);
		//流程历史记录
		SamSureyWfHis sureyWfHis=new SamSureyWfHis();
		sureyWfHis.setHisId(IdHelp.getUUID32());
		sureyWfHis.setFlowId(flowId);
		sureyWfHis.setActivity(sureyWf.getCurActivity());
		sureyWfHis.setOpinionCode(sureyWf.getOpinionCode());
		sureyWfHis.setOpinion(sureyWf.getOpinion());
		sureyWfHis.setActivityOrgan(organId);
		sureyWfHis.setActivityOrganName(organName);
		sureyWfHis.setActivityOrganArea(sureyWf.getCurActivityArea());
		sureyWfHis.setActivityOrganType(sureyWf.getCurActivityOrganType());
		sureyWfHis.setActivityPeople(userId);
		sureyWfHis.setActivityPeopleName(userName);
		sureyWfHis.setActivityDealTime(DateUtil.getTime());
		sureyWfHis.setCurActivityEt(DateUtil.getTime());
		sureyWfHis.setCurActivitySt(sureyWf.getCurActivitySt());	
		
		//父流程处理
		SamSureyWf sureyParWf=getSureyWfBean(sureyWf.getParentFlowId());
		
		//根据数据源获取事务管理器。
		PlatformTransactionManager txManager = TransactionFactory.getTransactionManager("dataSource");
		//定义事务的一些属性，比如只读、隔离级别等。
		TransactionDefinition definition = new DefaultTransactionDefinition();
		//事务开始
		TransactionStatus status = txManager.getTransaction(definition);
		try{
			if(isCityLevel(samSurey.getApplyOrganArea())){
				sureyWf.setCurStatus(ActivityStatus.DONE);
				sureyWf.setCurActivity(SureyActivity.ACT_FILLING);
				sureyWf.setIsFinish(IS_FINISH);
			}else{
				if(sureyWf.getCurActivityArea().equals(apanageCode)){
					sureyWf.setCurStatus(ActivityStatus.DONE);
					sureyWf.setCurActivity(SureyActivity.ACT_CITY_FILLING);
					sureyWf.setCurActivityArea(apanageCode.substring(0,4)+"00000000");
					sureyWf.setPreActivityOrganName(service.getCenterName(apanageCode));
					sureyWf.setNextActivityOrganName(service.getCenterName(domicileCode));
					sureyWf.setCurActivityOrganName(JJHDZX);
				}else{
					sureyWf.setCurStatus(ActivityStatus.DONE);
					sureyWf.setCurActivity(SureyActivity.ACT_FILLING);
					sureyWf.setIsFinish(IS_FINISH);
				}
			}
			sureyWf.setCurActivityOrgan(organId);
			service.update(sureyWf);
			service.insertSureyWfHis(sureyWfHis);
			//父流程,若子流程都结束则更新父流程，反之不操作
			if(beFinishedAllSonWf(sureyWf.getParentFlowId())){
				sureyParWf.setCurStatus(ActivityStatus.DONE);
				sureyParWf.setCurActivity(SureyActivity.ACT_CITY_CHECK);
				sureyParWf.setPreActivityOrganName(sureyParWf.getNextActivityOrganName());
				sureyParWf.setPreActivityArea(sureyParWf.getNextActivityArea());
				sureyParWf.setNextActivityOrganName(samSurey.getApplyOrganName());
			}
			service.update(sureyParWf);
		}catch(Throwable err){
			txManager.rollback(status);
			throw new RuntimeException(err);
		}
		//事务提交。
		txManager.commit(status);
	}
	/**
	 *  
	 * 市经济核对中心转发给区县的经济核对中心（地市）
	 */
	@SuppressWarnings("unchecked")
	public void cityDistribute(){
		Map<String,String> map=(Map<String,String>)getParameter("map");
		String flowId=map.get("flowId");
		String surveyId=map.get("surveyId");
		String organId=map.get("organId");
		String userId=map.get("userId");
		String userName=map.get("userName");
		String organName=map.get("organName");
		String domicileCode=map.get("domicileCode");//户籍
		String apanageCode=map.get("apanageCode");//居住地
		
		SamSureyWf sureyWf=getSureyWfBean(flowId);
		//流程历史记录
		SamSureyWfHis sureyWfHis=new SamSureyWfHis();
		sureyWfHis.setHisId(IdHelp.getUUID32());
		sureyWfHis.setFlowId(flowId);
		sureyWfHis.setActivity(sureyWf.getCurActivity());
		sureyWfHis.setOpinionCode(sureyWf.getOpinionCode());
		sureyWfHis.setOpinion(sureyWf.getOpinion());
		sureyWfHis.setActivityOrgan(organId);
		sureyWfHis.setActivityOrganName(organName);
		sureyWfHis.setActivityOrganArea(sureyWf.getCurActivityArea());
		sureyWfHis.setActivityOrganType(sureyWf.getCurActivityOrganType());
		sureyWfHis.setActivityPeople(userId);
		sureyWfHis.setActivityPeopleName(userName);
		sureyWfHis.setActivityDealTime(DateUtil.getTime());
		sureyWfHis.setCurActivityEt(DateUtil.getTime());
		sureyWfHis.setCurActivitySt(sureyWf.getCurActivitySt());		
		
		
		//根据数据源获取事务管理器。
		PlatformTransactionManager txManager = TransactionFactory.getTransactionManager("dataSource");
		//定义事务的一些属性，比如只读、隔离级别等。
		TransactionDefinition definition = new DefaultTransactionDefinition();
		//事务开始
		TransactionStatus status = txManager.getTransaction(definition);
		try{
			//子流程
			//分子流程调整：若不是人户分离则只向户籍的经济核对中心发，反之户籍和居住地的经济核对中心都发
			List<SamSureyWf> sonList=getSonSureyWfByParentSureyWf(sureyWf);
			for(int i=0;i<sonList.size();i++){
				service.insert(sonList.get(i));
			}		
			sureyWf.setCurStatus(ActivityStatus.TO_OTHER);
			sureyWf.setCurActivityOrgan(organId);
			service.update(sureyWf);
			service.insertSureyWfHis(sureyWfHis);
			
		}catch(Throwable err){
			txManager.rollback(status);
			throw new RuntimeException(err);
		}
		//事务提交。
		txManager.commit(status);
	}
	/**
	 * 
	 * 区县填报的核对结果上报给区县的经济核对中心
	 */
	@SuppressWarnings("unchecked")
	public void townReport(){
		Map<String,String> map=(Map<String,String>)getParameter("map");
		String flowId=map.get("flowId");
		String surveyId=map.get("surveyId");
		String organId=map.get("organId");
		String userId=map.get("userId");
		String userName=map.get("userName");
		String organName=map.get("organName");
		String domicileCode=map.get("domicileCode");//户籍
		String apanageCode=map.get("apanageCode");//居住地
		
		SamSureyWf sureyWf=getSureyWfBean(flowId);
		//流程历史记录
		SamSureyWfHis sureyWfHis=new SamSureyWfHis();
		sureyWfHis.setHisId(IdHelp.getUUID32());
		sureyWfHis.setFlowId(flowId);
		sureyWfHis.setActivity(sureyWf.getCurActivity());
		sureyWfHis.setOpinionCode(sureyWf.getOpinionCode());
		sureyWfHis.setOpinion(sureyWf.getOpinion());
		sureyWfHis.setActivityOrgan(organId);
		sureyWfHis.setActivityOrganName(organName);
		sureyWfHis.setActivityOrganArea(sureyWf.getCurActivityArea());
		sureyWfHis.setActivityOrganType(sureyWf.getCurActivityOrganType());
		sureyWfHis.setActivityPeople(userId);
		sureyWfHis.setActivityPeopleName(userName);
		sureyWfHis.setActivityDealTime(DateUtil.getTime());
		sureyWfHis.setCurActivityEt(DateUtil.getTime());
		sureyWfHis.setCurActivitySt(sureyWf.getCurActivitySt());		
		
		SamSurey samSurey= getSamSurey(surveyId);
		//根据数据源获取事务管理器。
		PlatformTransactionManager txManager = TransactionFactory.getTransactionManager("dataSource");
		//定义事务的一些属性，比如只读、隔离级别等。
		TransactionDefinition definition = new DefaultTransactionDefinition();
		//事务开始
		TransactionStatus status = txManager.getTransaction(definition);
		try{
			if(isCityLevel(samSurey.getApplyOrganArea())){
				sureyWf.setCurStatus(ActivityStatus.DONE);
				sureyWf.setCurActivity(SureyActivity.ACT_TOWN_REPORT);
			}else {
				sureyWf.setCurStatus(ActivityStatus.TO_OTHER);
				sureyWf.setCurActivity(SureyActivity.ACT_CHECK);
				sureyWf.setCurActivityArea(domicileCode);
			}
			
			sureyWf.setCurActivityOrgan(organId);
			sureyWf.setPreActivityOrganName(service.getOrganName(sureyWf.getCurActivityArea()));
			service.update(sureyWf);
			service.insertSureyWfHis(sureyWfHis);
			
		}catch(Throwable err){
			txManager.rollback(status);
			throw new RuntimeException(err);
		}
		//事务提交。
		txManager.commit(status);
	}
	/**
	 * 
	 * 区县填报的核对结果上报给区县的经济核对中心
	 * 
	 */
	@SuppressWarnings("unchecked")
	public void townCamsTotownCenter(){
		Map<String,String> map=(Map<String,String>)getParameter("map");
		String flowId=map.get("flowId");
		String surveyId=map.get("surveyId");
		String organId=map.get("organId");
		String userId=map.get("userId");
		String userName=map.get("userName");
		String organName=map.get("organName");
		String domicileCode=map.get("domicileCode");//户籍
		String apanageCode=map.get("apanageCode");//居住地
		
		SamSureyWf sureyWf=getSureyWfBean(flowId);
		 		
		
		SamSurey samSurey= getSamSurey(surveyId);
		//根据数据源获取事务管理器。
		PlatformTransactionManager txManager = TransactionFactory.getTransactionManager("dataSource");
		//定义事务的一些属性，比如只读、隔离级别等。
		TransactionDefinition definition = new DefaultTransactionDefinition();
		//事务开始
		TransactionStatus status = txManager.getTransaction(definition);
		try{
			if(isCityLevel(samSurey.getApplyOrganArea())){
				sureyWf.setCurStatus(ActivityStatus.DONE);
				sureyWf.setCurActivity(SureyActivity.ACT_TOWN_REPORT);
				sureyWf.setCurActivityOrganName(service.getCenterName(sureyWf.getCurActivityArea()));
				String areaCodeString = sureyWf.getCurActivityArea().substring(0,4)+"00000000";
				sureyWf.setNextActivityOrganName(service.getCenterName(areaCodeString));
			}else {
				 
				 
				if(domicileCode.equals(apanageCode)){
				 sureyWf.setCurStatus(ActivityStatus.TO_OTHER);
				 sureyWf.setCurActivity(SureyActivity.ACT_CHECK);
				 sureyWf.setCurActivityArea(domicileCode);
				 sureyWf.setNextActivityOrganName(samSurey.getApplyOrganName());
				 //填写总的核对结果
			     getSamSureyAssistanceResult(sureyWf);
				 
				}else{
					if(sureyWf.getCurActivityArea().equals(apanageCode)){
						sureyWf.setCurStatus(ActivityStatus.TODO);
						sureyWf.setCurActivity(SureyActivity.ACT_TOWN_REPORT);
						String areaCode = sureyWf.getCurActivityArea().substring(0,4)+"00000000";
						sureyWf.setNextActivityOrganName(service.getCenterName(areaCode));
						sureyWf.setNextActivityArea(areaCode);
						sureyWf.setNextActivityOrganType(SAM_ORGAN_TYPE);
					}else{
							sureyWf.setCurStatus(ActivityStatus.TO_OTHER);
							sureyWf.setCurActivity(SureyActivity.ACT_CHECK);
							sureyWf.setCurActivityArea(domicileCode);
							sureyWf.setCurActivityOrganName(sureyWf.getNextActivityOrganName());
							if(RESULT_END.equals(sureyWf.getOpinionCode())){
								sureyWf.setNextActivityOrganName(samSurey.getApplyOrganName());
								sureyWf.setNextActivityArea(samSurey.getApplyOrganArea());
								sureyWf.setNextActivityOrganType(samSurey.getApplyOrganType());
							} else {
								String areaCode = sureyWf.getCurActivityArea().substring(0,4)+"00000000";
								sureyWf.setNextActivityOrganName(service.getCenterName(areaCode));
								sureyWf.setNextActivityArea(areaCode);
								sureyWf.setNextActivityOrganType(SAM_ORGAN_TYPE);
							}
						
					}
				}
				
			}
			
			sureyWf.setCurActivityOrgan(organId);
			sureyWf.setPreActivityOrganName(service.getOrganName(sureyWf.getCurActivityArea()));
		 
			service.update(sureyWf);
			
		}catch(Throwable err){
			txManager.rollback(status);
			throw new RuntimeException(err);
		}
		//事务提交。
		txManager.commit(status);
	}
	//汇总
	@SuppressWarnings("unchecked")
	public void sureyGather(){
		Map<String,String> map=(Map<String,String>)getParameter("map");
		String flowId=map.get("flowId");
		String surveyId=map.get("surveyId");
		String organId=map.get("organId");
		String userId=map.get("userId");
		String userName=map.get("userName");
		String organName=map.get("organName");
		
		SamSureyWf sureyWf=getSureyWfBean(flowId);
		String activity=sureyWf.getCurActivity();
		
		String peopleId=service.queryPeopleId(surveyId);
		
		SamSurey samSurey=getSamSurey(surveyId);
		samSurey.setSurveyOrgan(organId);
	 
		samSurey.setSurveyDate(DateUtil.getDay());
  	
		sureyWf.setPreActivity(sureyWf.getCurActivity());
		sureyWf.setPreActivityArea(sureyWf.getCurActivityArea());
		sureyWf.setPreActivityOrgan(organId);
		sureyWf.setPreActivityOrganName(organName);
		sureyWf.setPreActivityOrganType(sureyWf.getCurActivityOrganType());
		sureyWf.setCurActivity(SureyActivity.ACT_GATHER);
		sureyWf.setCurStatus(ActivityStatus.DONE);
		sureyWf.setCurActivityOrgan(sureyWf.getNextActivityOrgan());
		sureyWf.setCurActivityArea(sureyWf.getNextActivityArea());
		sureyWf.setCurActivitySt(DateUtil.getTime());
		sureyWf.setCurActivityOrganType(sureyWf.getNextActivityOrganType());
		sureyWf.setNextActivity("");
		sureyWf.setNextActivityArea("");
		sureyWf.setNextActivityOrgan("");
		sureyWf.setNextActivityOrganName("");
		sureyWf.setNextActivityOrganType("");
		sureyWf.setIsFinish(IS_FINISH);
		//根据数据源获取事务管理器。
		PlatformTransactionManager txManager = TransactionFactory.getTransactionManager("dataSource");
		//定义事务的一些属性，比如只读、隔离级别等。
		TransactionDefinition definition = new DefaultTransactionDefinition();
		//事务开始
		TransactionStatus status = txManager.getTransaction(definition);
		try{
			service.updateSamSurey(samSurey);
			service.update(sureyWf);
			
		}catch(Throwable err){
			txManager.rollback(status);
			throw new RuntimeException(err);
		}
		//事务提交。
		txManager.commit(status);
		
	}
	/**
	 * 区填报
	 */
	@SuppressWarnings("unchecked")
	public void reporting(){
		Map<String,String> map=(Map<String,String>)getParameter("map");
		String flowId=map.get("flowId");
		String surveyId=map.get("surveyId");
		String organId=map.get("organId");
		String userId=map.get("userId");
		String userName=map.get("userName");
		String organName=map.get("organName");
		String domicileCode=map.get("domicileCode");
		String apanageCode=map.get("apanageCode");
		
		SamSureyWf sonSureyWf=getSureyWfBean(flowId);
		//获得子流程历史记录
		String activity=sonSureyWf.getCurActivity();
		SamSureyWfHis sureyWfHis=getSureyWfHis(flowId,activity);
		sureyWfHis.setActivityPeople(userId);
		sureyWfHis.setActivityPeopleName(userName);
		sureyWfHis.setActivityDealTime(DateUtil.getTime());
		sureyWfHis.setCurActivityEt(DateUtil.getTime());
		
		sonSureyWf.setIsFinish(IS_FINISH);
		//根据数据源获取事务管理器。
		PlatformTransactionManager txManager = TransactionFactory.getTransactionManager("dataSource");
		//定义事务的一些属性，比如只读、隔离级别等。
		TransactionDefinition definition = new DefaultTransactionDefinition();
		//事务开始
		TransactionStatus status = txManager.getTransaction(definition);
		try{
			service.update(sonSureyWf);
			service.updateSamSureyWfHis(sureyWfHis);
		}catch(Throwable err){
			txManager.rollback(status);
			throw new RuntimeException(err);
		}
		//事务提交。
		txManager.commit(status);	
		
		checkSonSureyWf(sonSureyWf,userId,userName);		
		
	}
	/**
	 * 区县的经济核对中心上报到市经济核对中心
	 */
	@SuppressWarnings("unchecked")
	public void centerReport(){
		Map<String,String> map=(Map<String,String>)getParameter("map");
		String flowId=map.get("flowId");
		String surveyId=map.get("surveyId");
		String organId=map.get("organId");
		String userId=map.get("userId");
		String userName=map.get("userName");
		String organName=map.get("organName");
		String domicileCode=map.get("domicileCode");
		String apanageCode=map.get("apanageCode");
		
		SamSureyWf sonSureyWf=getSureyWfBean(flowId);
		//获得子流程历史记录
		String activity=sonSureyWf.getCurActivity();
		SamSureyWfHis sureyWfHis=getSureyWfHis(flowId,activity);
		sureyWfHis.setActivityPeople(userId);
		sureyWfHis.setActivityPeopleName(userName);
		sureyWfHis.setActivityDealTime(DateUtil.getTime());
		sureyWfHis.setCurActivityEt(DateUtil.getTime());
		
		sonSureyWf.setIsFinish(NOT_FINISH);
		sonSureyWf.setCurActivity(SureyActivity.ACT_CITY_SEND);
		sonSureyWf.setCurStatus(ActivityStatus.TODO);
		//根据数据源获取事务管理器。
		PlatformTransactionManager txManager = TransactionFactory.getTransactionManager("dataSource");
		//定义事务的一些属性，比如只读、隔离级别等。
		TransactionDefinition definition = new DefaultTransactionDefinition();
		//事务开始
		TransactionStatus status = txManager.getTransaction(definition);
		try{
			service.update(sonSureyWf);
			service.updateSamSureyWfHis(sureyWfHis);
		}catch(Throwable err){
			txManager.rollback(status);
			throw new RuntimeException(err);
		}
		//事务提交。
		txManager.commit(status);	
		
		checkSonSureyWf(sonSureyWf,userId,userName);		
		
	}
	/**
	 * 区县民政局将填报的结果转发给区县经济核对中心
	 */
	@SuppressWarnings("unchecked")
	public void townCenterToCityCenter(){
		Map<String,String> map=(Map<String,String>)getParameter("map");
		String flowId=map.get("flowId");
		String surveyId=map.get("surveyId");
		String organId=map.get("organId");
		String userId=map.get("userId");
		String userName=map.get("userName");
		String organName=map.get("organName");
		String domicileCode=map.get("domicileCode");//户籍
		String apanageCode=map.get("apanageCode");//居住地
		SamSureyWf sureyWf=getSureyWfBean(flowId);
		//流程历史记录
		SamSureyWfHis sureyWfHis=new SamSureyWfHis();
		sureyWfHis.setHisId(IdHelp.getUUID32());
		sureyWfHis.setFlowId(flowId);
		sureyWfHis.setActivity(sureyWf.getCurActivity());
		sureyWfHis.setOpinionCode(sureyWf.getOpinionCode());
		sureyWfHis.setOpinion(sureyWf.getOpinion());
		sureyWfHis.setActivityOrgan(organId);
		sureyWfHis.setActivityOrganName(organName);
		sureyWfHis.setActivityOrganArea(sureyWf.getCurActivityArea());
		sureyWfHis.setActivityOrganType(sureyWf.getCurActivityOrganType());
		sureyWfHis.setActivityPeople(userId);
		sureyWfHis.setActivityPeopleName(userName);
		sureyWfHis.setActivityDealTime(DateUtil.getTime());
		sureyWfHis.setCurActivityEt(DateUtil.getTime());
		sureyWfHis.setCurActivitySt(sureyWf.getCurActivitySt());		
		
		
		//根据数据源获取事务管理器。
		PlatformTransactionManager txManager = TransactionFactory.getTransactionManager("dataSource");
		//定义事务的一些属性，比如只读、隔离级别等。
		TransactionDefinition definition = new DefaultTransactionDefinition();
		//事务开始
		TransactionStatus status = txManager.getTransaction(definition);
		try{
			sureyWf.setCurActivity(SureyActivity.ACT_CHECK);
			sureyWf.setCurStatus(ActivityStatus.TO_OTHER);
			sureyWf.setCurActivityOrgan(organId);
			sureyWf.setCurActivityArea(sureyWf.getCurActivityArea().substring(0,4)+"00000000");
			service.update(sureyWf);
			service.insertSureyWfHis(sureyWfHis);
			
		}catch(Throwable err){
			txManager.rollback(status);
			throw new RuntimeException(err);
		}
		//事务提交。
		txManager.commit(status);
	}
	/**
	 * 市经济核对中心将核对结果反馈给市外部单位
	 */
	@SuppressWarnings("unchecked")
	public void cityDistributeToApply(){
		Map<String,String> map=(Map<String,String>)getParameter("map");
		String flowId=map.get("flowId");
		String surveyId=map.get("surveyId");
		String organId=map.get("organId");
		String userId=map.get("userId");
		String userName=map.get("userName");
		String organName=map.get("organName");
		String domicileCode=map.get("domicileCode");
		String apanageCode=map.get("apanageCode");
		
		SamSureyWf sonSureyWf=getSureyWfBean(flowId);
		//获得子流程历史记录
		String activity=sonSureyWf.getCurActivity();
		SamSureyWfHis sureyWfHis=getSureyWfHis(flowId,activity);
		sureyWfHis.setActivityPeople(userId);
		sureyWfHis.setActivityPeopleName(userName);
		sureyWfHis.setActivityDealTime(DateUtil.getTime());
		sureyWfHis.setCurActivityEt(DateUtil.getTime());
		
		SamSurey samSurey=getSamSurey(surveyId);
		
		sonSureyWf.setIsFinish(IS_FINISH);
		sonSureyWf.setCurActivity(SureyActivity.ACT_GATHER);
		sonSureyWf.setCurStatus(ActivityStatus.DONE);
		sonSureyWf.setCurActivityOrganType(samSurey.getApplyOrganType());
		//根据数据源获取事务管理器。
		PlatformTransactionManager txManager = TransactionFactory.getTransactionManager("dataSource");
		//定义事务的一些属性，比如只读、隔离级别等。
		TransactionDefinition definition = new DefaultTransactionDefinition();
		//事务开始
		TransactionStatus status = txManager.getTransaction(definition);
		try{
			//填写总的核对结果
			getSamSureyAssistanceResult(sonSureyWf);
			service.update(sonSureyWf);
			service.updateSamSureyWfHis(sureyWfHis);
			
		}catch(Throwable err){
			txManager.rollback(status);
			throw new RuntimeException(err);
			
		}
		//事务提交。
		txManager.commit(status);	
		
		//checkSonSureyWf(sonSureyWf,userId,userName);		
		
	}
	/**
	 * 区县经济核对中心判断是否人户分离
	 */
	@SuppressWarnings("unchecked")
	public void centerCheckIfIdentical() {
		Map<String, String> map = (Map<String, String>) getParameter("map");
		String flowId = map.get("flowId");
		String surveyId = map.get("surveyId");
		String organId = map.get("organId");
		String userId = map.get("userId");
		String userName = map.get("userName");
		String organName = map.get("organName");
		String domicileCode = map.get("domicileCode");// 户籍
		String apanageCode = map.get("apanageCode");// 居住地
		SamSureyWf sureyWf = getSureyWfBean(flowId);
		// 流程历史记录
		SamSureyWfHis sureyWfHis = new SamSureyWfHis();
		sureyWfHis.setHisId(IdHelp.getUUID32());
		sureyWfHis.setFlowId(flowId);
		sureyWfHis.setActivity(sureyWf.getCurActivity());
		sureyWfHis.setOpinionCode(sureyWf.getOpinionCode());
		sureyWfHis.setOpinion(sureyWf.getOpinion());
		sureyWfHis.setActivityOrgan(organId);
		sureyWfHis.setActivityOrganName(organName);
		sureyWfHis.setActivityOrganArea(sureyWf.getCurActivityArea());
		sureyWfHis.setActivityOrganType(sureyWf.getCurActivityOrganType());
		sureyWfHis.setActivityPeople(userId);
		sureyWfHis.setActivityPeopleName(userName);
		sureyWfHis.setActivityDealTime(DateUtil.getTime());
		sureyWfHis.setCurActivityEt(DateUtil.getTime());
		sureyWfHis.setCurActivitySt(sureyWf.getCurActivitySt());
		SamSurey samSurey=getSamSurey(surveyId);
 
		// 根据数据源获取事务管理器。
		PlatformTransactionManager txManager = TransactionFactory
				.getTransactionManager("dataSource");
		// 定义事务的一些属性，比如只读、隔离级别等。
		TransactionDefinition definition = new DefaultTransactionDefinition();
		// 事务开始
		TransactionStatus status = txManager.getTransaction(definition);
		try {
			if (domicileCode.equals(apanageCode)) {// 若不存在人户分离
				sureyWf.setCurStatus(ActivityStatus.DONE);
				sureyWf.setCurActivity(SureyActivity.ACT_GATHER);
				sureyWf.setCurActivityOrganType(samSurey.getApplyOrganType());
				getSamSureyAssistanceTownResult(sureyWf);
				 //getSamSureyAssistanceResult();
			} else {// 若存在人户分离，在转发请求
		 
				ParameterSet newPset=new ParameterSet();
				newPset.setParameter("FLOW_ID", flowId);
				newPset.setParameter("ACTIVITY", SureyActivity.ACT_FILLING);
				SamSureyWfHis samSureyHis=(SamSureyWfHis)service.querySureyWfHis(newPset).getRecord(0).toBean(SamSureyWfHis.class);
				String opinionCode=samSureyHis.getOpinionCode();
				if("ED".equals(opinionCode)){
					 //办理完结
			       sureyWf.setCurStatus(ActivityStatus.DONE);
				   sureyWf.setCurActivity(SureyActivity.ACT_GATHER);
				   sureyWf.setCurActivityArea(domicileCode);
				   sureyWf.setCurActivityOrganType(samSurey.getApplyOrganType());
				   sureyWf.setCurActivityOrganName(sureyWf.getNextActivityOrganName());
				   getSamSureyAssistanceTownResult(sureyWf);
						 
				   }else{
			      //办理未未完结
			       sureyWf.setCurStatus(ActivityStatus.TO_OTHER);
			       sureyWf.setCurActivity(SureyActivity.ACT_FILLING);
			      //创建子流程
					List<SamSureyWf> sonList = createSureyWf(sureyWf);
					for (int i = 0; i < sonList.size(); i++) {
						service.insert(sonList.get(i));
					}
				  }
				 
			}
			sureyWf.setCurActivityOrgan(organId);
			service.update(sureyWf);
			service.insertSureyWfHis(sureyWfHis);

		} catch (Throwable err) {
			txManager.rollback(status);
			throw new RuntimeException(err);
		}
		// 事务提交。
		txManager.commit(status);
	}
	/**
	 * 查看主流程的所有子流程是否结束：没结束，什么都不做；都结束，更新主流程
	 */
	public void checkSonSureyWf(SamSureyWf sonSureyWf,String userId,String userName){
		String parentFlowId=sonSureyWf.getParentFlowId();
		String sureyId=sonSureyWf.getSurveyId();
		SamSurey samSurey=getSamSurey(sureyId);
		if(beFinishedAllSonWf(parentFlowId)){
			SamSureyWf parentSureyWf=getSureyWfBean(parentFlowId);
			
			SamSureyWfHis sureyWfHis=getSureyWfHis(parentFlowId,parentSureyWf.getCurActivity());
			sureyWfHis.setActivityPeople(userId);
			sureyWfHis.setActivityPeopleName(userName);
			sureyWfHis.setActivityDealTime(DateUtil.getTime());
			sureyWfHis.setCurActivityEt(DateUtil.getTime());
			
			parentSureyWf.setCurActivity(SureyActivity.ACT_FILLING);
			parentSureyWf.setCurStatus(ActivityStatus.DONE);
			parentSureyWf.setPreActivity("");
			parentSureyWf.setPreActivityArea(parentSureyWf.getNextActivityArea());
			parentSureyWf.setPreActivityOrganName(parentSureyWf.getNextActivityOrganName());
			parentSureyWf.setPreActivityOrganType(parentSureyWf.getNextActivityOrganType());
			if("00000000".equals(samSurey.getApplyOrganArea().substring(4,12))){
				//市外部单位
				parentSureyWf.setNextActivity(SureyActivity.ACT_GATHER);
				if("".equals(StrUtil.n2b(parentSureyWf.getPreActivityArea()))){
					parentSureyWf.setNextActivityArea(samSurey.getApplyOrganArea());
					parentSureyWf.setNextActivityOrgan(samSurey.getApplyOrgan());
					parentSureyWf.setNextActivityOrganName(samSurey.getApplyOrganName());
					parentSureyWf.setNextActivityOrganType(samSurey.getApplyOrganType());
				} else {
					parentSureyWf.setNextActivityArea(parentSureyWf.getCurActivityArea()+","+samSurey.getApplyOrganArea());
					parentSureyWf.setNextActivityOrgan(parentSureyWf.getCurActivityOrgan()+","+samSurey.getApplyOrgan());
					parentSureyWf.setNextActivityOrganName(parentSureyWf.getCurActivityOrganName()+","+samSurey.getApplyOrganName());
					parentSureyWf.setNextActivityOrganType(samSurey.getApplyOrganType());
				}
			}else if("000000".equals(samSurey.getApplyOrganArea().substring(6,12))){
				//区县外部单位
				parentSureyWf.setNextActivity(SureyActivity.ACT_CITY_FILLING);
				parentSureyWf.setNextActivityArea(samSurey.getApplyOrganArea());
				parentSureyWf.setNextActivityOrgan("");
				parentSureyWf.setNextActivityOrganName(service.getOrganName(samSurey.getApplyOrganArea()));
				parentSureyWf.setNextActivityOrganType(SAM_ORGAN_TYPE);
			}
			service.update(parentSureyWf);
			service.updateSamSureyWfHis(sureyWfHis);
			
		}
		
	}
	
	/**
	 * 区填报 移交
	 */
	
	@SuppressWarnings("unchecked")
	public void  districtFilling(){
		Map<String,String> map=(Map<String,String>)getParameter("map");
		String flowId=map.get("flowId");
		String surveyId=map.get("surveyId");
		String organId=map.get("organId");
		String userId=map.get("userId");
		String userName=map.get("userName");
		String organName=map.get("organName");
		String domicileCode=map.get("domicileCode");
		String apanageCode=map.get("apanageCode");
		
		SamSurey samSurey=getSamSurey(surveyId);				
		SamSureyWf sureyWf=getSureyWfBean(flowId);
		//主流程历史记录
		SamSureyWfHis wfHisBean=new SamSureyWfHis();
		wfHisBean.setHisId(IdHelp.getUUID32());
		wfHisBean.setFlowId(flowId);
		wfHisBean.setActivity(sureyWf.getCurActivity());
		wfHisBean.setOpinionCode(RESULT_END);
		wfHisBean.setOpinion(sureyWf.getOpinion());
		wfHisBean.setActivityOrgan(organId);
		wfHisBean.setActivityOrganName(organName);
		wfHisBean.setActivityOrganArea(sureyWf.getCurActivityArea());
		wfHisBean.setActivityOrganType(sureyWf.getCurActivityOrganType());
		wfHisBean.setActivityPeople(userId);
		wfHisBean.setActivityPeopleName(userName);
		wfHisBean.setActivityDealTime(DateUtil.getTime());
		wfHisBean.setCurActivityEt(DateUtil.getTime());
		wfHisBean.setCurActivitySt(sureyWf.getCurActivitySt());
		String nextOrganArea=sureyWf.getNextActivityArea();
		
		//根据数据源获取事务管理器。
		PlatformTransactionManager txManager = TransactionFactory.getTransactionManager("dataSource");
		//定义事务的一些属性，比如只读、隔离级别等。
		TransactionDefinition definition = new DefaultTransactionDefinition();
		//事务开始
		TransactionStatus status = txManager.getTransaction(definition);
		try{
			service.insertSureyWfHis(wfHisBean);
			if(BE_CITY.equals(getOrganGrade(nextOrganArea))){
				//更新业务表
				samSurey.setSurveyOrgan(organId);
				//samSurey.setSurveyOrganName(organName);
				//samSurey.setSurveyOrganArea(sureyWf.getCurActivityArea());
				//samSurey.setSurveyOrganType(sureyWf.getCurActivityOrganType());
				samSurey.setSurveyDate(DateUtil.getDay());
				service.updateSamSurey(samSurey);
				
				sureyWf.setPreActivity(sureyWf.getCurActivity());
				sureyWf.setPreActivityArea(sureyWf.getCurActivityArea());
				sureyWf.setPreActivityOrgan(sureyWf.getCurActivityOrgan());
				sureyWf.setPreActivityOrganName(service.getOrganName(sureyWf.getCurActivityArea()));
				sureyWf.setPreActivityOrganType(sureyWf.getCurActivityOrganType());
				sureyWf.setOpinionCode(RESULT_END);	
				sureyWf.setOpinion("");
				sureyWf.setNextActivity("");
				sureyWf.setNextActivityArea("");
				sureyWf.setNextActivityOrgan("");
				sureyWf.setNextActivityOrganName("");
				sureyWf.setNextActivityOrganType("");
				sureyWf.setCurActivity(SureyActivity.ACT_GATHER);
				sureyWf.setCurStatus(ActivityStatus.DONE);
				sureyWf.setCurActivityArea(samSurey.getApplyOrganArea());
				sureyWf.setCurActivityOrgan(samSurey.getApplyOrgan());
				sureyWf.setCurActivityOrganType(samSurey.getApplyOrganType());
				sureyWf.setCurActivitySt(DateUtil.getTime());
				sureyWf.setIsFinish(IS_FINISH);	
				service.update(sureyWf);
				//填写总的核对结果
				getSamSureyAssistanceResult(sureyWf);
				
			}else if(BE_DISTRICT.equals(getOrganGrade(nextOrganArea))){
				sureyWf.setPreActivity(sureyWf.getCurActivity());
				sureyWf.setPreActivityArea(sureyWf.getCurActivityArea());
				sureyWf.setPreActivityOrgan(sureyWf.getCurActivityOrgan());
				sureyWf.setPreActivityOrganName(sureyWf.getCurActivityOrganName());
				sureyWf.setPreActivityOrganType(sureyWf.getCurActivityOrganType());
				sureyWf.setOpinionCode(RESULT_END);
				sureyWf.setOpinion("");
				sureyWf.setNextActivity(SureyActivity.ACT_GATHER);
				sureyWf.setNextActivityArea(samSurey.getApplyOrganArea());
				sureyWf.setNextActivityOrgan(samSurey.getApplyOrgan());
				sureyWf.setNextActivityOrganName(samSurey.getApplyOrganName());
				sureyWf.setNextActivityOrganType(samSurey.getApplyOrganType());
				sureyWf.setCurActivity(SureyActivity.ACT_CITY_FILLING);
				sureyWf.setCurStatus(ActivityStatus.DONE);
				sureyWf.setCurActivityArea(samSurey.getApplyOrganArea());
				sureyWf.setCurActivityOrgan("");
				sureyWf.setCurActivityOrganType(SAM_ORGAN_TYPE);
				sureyWf.setCurActivitySt(DateUtil.getTime());
				service.update(sureyWf);
				//主流程历史记录
				SamSureyWfHis nextWfHisBean=new SamSureyWfHis();
				nextWfHisBean.setHisId(IdHelp.getUUID32());
				nextWfHisBean.setFlowId(flowId);
				nextWfHisBean.setActivity(SureyActivity.ACT_CITY_FILLING);
				nextWfHisBean.setOpinionCode(RESULT_END);
				nextWfHisBean.setOpinion(sureyWf.getOpinion());
				nextWfHisBean.setActivityOrgan(sureyWf.getCurActivityOrgan());
				nextWfHisBean.setActivityOrganArea(sureyWf.getCurActivityArea());
				nextWfHisBean.setActivityOrganName(sureyWf.getCurActivityOrganName());
				nextWfHisBean.setActivityOrganType(SAM_ORGAN_TYPE);
				nextWfHisBean.setCurActivitySt(DateUtil.getTime());

				service.insertSureyWfHis(nextWfHisBean);
				//流程历史结果
				getSamSureyWfAssistanceHis(sureyWf,nextWfHisBean.getHisId());
			
			}	
			
		}catch(Throwable err){
			txManager.rollback(status);
			throw new RuntimeException(err);
		}
		//事务提交。
		txManager.commit(status);		
	}
	
	//获得流程信息
	private SamSureyWf getSureyWfBean(String flowId){
		ParameterSet pset=new ParameterSet();
		pset.setParameter("FLOW_ID", flowId);
		SamSureyWf bean=(SamSureyWf)service.initialQuery(pset).getRecord(0).toBean(SamSureyWf.class);
		return bean;
	}
	//获取业务信息
	private SamSurey getSamSurey(String surveyId){
		ParameterSet pset=new ParameterSet();
		pset.setParameter("SURVEY_ID", surveyId);
		SamSurey bean=(SamSurey)service.querySamSurey(pset).getRecord(0).toBean(SamSurey.class);
		return bean;
	}
	//根据流程Id和环节查历史记录
	private SamSureyWfHis getSureyWfHis(String flowId,String activity){
		ParameterSet pset=new ParameterSet();
		pset.setParameter("FLOW_ID", flowId);
		pset.setParameter("ACTIVITY", activity);
		SamSureyWfHis bean=(SamSureyWfHis)service.querySureyWfHis(pset).getRecord(0).toBean(SamSureyWfHis.class);
		return bean;
	}
	//历史处理结果
	@SuppressWarnings("unused")
	private SamSureyWfAssistanceHis getAssistanceHis(String hisId){
		ParameterSet pset=new ParameterSet();
		pset.setParameter("HIS_ID", hisId);
		SamSureyWfAssistanceHis bean=(SamSureyWfAssistanceHis)service.queryAssistanceHis(pset).getRecord(0).toBean(SamSureyWfAssistanceHis.class);
		return bean;
	}
	/**
	 * 创建子流程
	 */
	@SuppressWarnings("unused")
	private SamSureyWf getSonSamSureyWf(SamSureyWf sureyWf,String domicileCode){
		SamSureyWf bean=new SamSureyWf();
		bean.setFlowId(IdHelp.getUUID32());
		bean.setSurveyId(sureyWf.getSurveyId());
		bean.setSurveyType(sureyWf.getSurveyType());
		bean.setApplyTitle(sureyWf.getApplyTitle());
		bean.setName(sureyWf.getName());
		bean.setIdCard(sureyWf.getIdCard());
		bean.setDomicileCode(sureyWf.getDomicileCode());
		bean.setApanageCode(sureyWf.getApanageCode());
		bean.setCurActivity(SureyActivity.ACT_DISPENSE);
		bean.setCurStatus(ActivityStatus.TODO);
		bean.setCurActivityArea(domicileCode);
		bean.setCurActivityOrganType(SAM_ORGAN_TYPE);
		bean.setCurActivitySt(DateUtil.getTime());
		bean.setPreActivity(sureyWf.getCurActivity());
		bean.setPreActivityArea(sureyWf.getCurActivityArea());
		bean.setPreActivityOrgan(sureyWf.getCurActivityOrgan());
		bean.setPreActivityOrganType(sureyWf.getCurActivityOrganType());
		bean.setParentFlowId(sureyWf.getFlowId());
		bean.setIsFinish(NOT_FINISH);
		return bean;
	}
	/**
	 * 查看子流程是否都已结束
	 */
	public boolean beFinishedAllSonWf(String parentFlowId){
		ParameterSet pset=new ParameterSet();
		pset.setParameter("PARENT_FLOW_ID", parentFlowId);
		DataSet ds=service.initialQuery(pset);
		int size=ds.getCount();
		if(size>0){
			for(int i=0;i<size;i++){
				SamSureyWf bean=(SamSureyWf)ds.getRecord(i).toBean(SamSureyWf.class);
				String isFinish=bean.getIsFinish();
				if(NOT_FINISH.equals(isFinish)){
					return false;
				}
			}
			return true;
		}
		return true;
	}
	/**
	 * 查看子流程的处理结果
	 */
	public List<SamSureyWfAssistanceHis> getSonSureyWfAssistanceHis(String parentFlowId){
		List<SamSureyWfAssistanceHis> assistanceHisList=new ArrayList<SamSureyWfAssistanceHis>();
		ParameterSet pset=new ParameterSet();
		pset.setParameter("PARENT_FLOW_ID", parentFlowId);
		DataSet ds=service.initialQuery(pset);
		if(ds.getCount()>0){
			for(int i=0;i<ds.getCount();i++){
				SamSureyWf bean=(SamSureyWf)ds.getRecord(i).toBean(SamSureyWf.class);
				ParameterSet newPset=new ParameterSet();
				newPset.setParameter("FLOW_ID", bean.getFlowId());
				newPset.setParameter("ACTIVITY", SureyActivity.ACT_FILLING);
				SamSureyWfHis sureyWfHis=(SamSureyWfHis)service.querySureyWfHis(newPset).getRecord(0).toBean(SamSureyWfHis.class);
				String hisId=sureyWfHis.getHisId();
				newPset.clear();
				newPset.setParameter("HIS_ID", hisId);
				DataSet assistanceHisDs=service.queryAssistanceHis(newPset);
				if(assistanceHisDs.getCount()!=0){
					SamSureyWfAssistanceHis assistanceHisBean=(SamSureyWfAssistanceHis)assistanceHisDs.getRecord(0).toBean(SamSureyWfAssistanceHis.class);
					assistanceHisList.add(assistanceHisBean);
				}
				
			}
		}
		return assistanceHisList;
	}
	/*
	 * 判断某一行政区划等级
	 */
	public String getOrganGrade(String organArea){
		if("00000000".equals(organArea.substring(4,12))){
			return BE_CITY;
		}else if("000000".equals(organArea.substring(6,12))){
			return BE_DISTRICT;
		}else{
			return null;
		}
	}
	/**
	 * 根据主流程创建子流程
	 */
	public List<SamSureyWf> getSonSureyWfByParentSureyWf(SamSureyWf bean){
		List<SamSureyWf> list=new ArrayList<SamSureyWf>();
		String parentOrganName=bean.getCurActivityOrganName();
		String nextActivityArea=bean.getNextActivityArea();
		//判断人户是否分离 开始
		String domicileCode=bean.getDomicileCode();//户籍代码
		String apanageCode=bean.getApanageCode();//居住地代码
		//判断人户是否分离 结束
		String[] arry=nextActivityArea.split(",");
		int num=arry.length;

		if(num>1){
			for(int i=0;i<num;i++){
				SamSureyWf sonBean=new SamSureyWf();
				sonBean.setFlowId(IdHelp.getUUID32());
				sonBean.setSurveyId(bean.getSurveyId());
				sonBean.setSurveyType(bean.getSurveyType());
				sonBean.setAssistanceType(bean.getAssistanceType());
				sonBean.setApplyTitle(bean.getApplyTitle());
				sonBean.setName(bean.getName());
				sonBean.setIdCardType(bean.getIdCardType());
				sonBean.setIdCard(bean.getIdCard());
				sonBean.setDomicileCode(bean.getDomicileCode());
				sonBean.setApanageCode(bean.getApanageCode());
				sonBean.setCurActivity(SureyActivity.ACT_BOROUGH_SEND);// 需对县经核对处理
				sonBean.setCurStatus(ActivityStatus.TODO);         // 要区的济中心
				sonBean.setCurActivityOrgan("");
				sonBean.setCurActivityOrganName(service.getCenterName(arry[i]));
				sonBean.setCurActivityOrganType(bean.getCurActivityOrganType());
				sonBean.setCurActivityArea(arry[i]);
				sonBean.setCurActivitySt(DateUtil.getTime());
				sonBean.setOpinion("");
				sonBean.setOpinionCode("");
				sonBean.setPreActivity(bean.getCurActivity());
				sonBean.setPreActivityArea(bean.getCurActivityArea());
				sonBean.setPreActivityOrgan(bean.getCurActivityOrgan());
				sonBean.setPreActivityOrganName(parentOrganName);
				sonBean.setPreActivityOrganType(bean.getCurActivityOrganType());
				sonBean.setNextActivity("");
				sonBean.setNextActivityArea("");
				sonBean.setNextActivityOrgan("");
				sonBean.setNextActivityOrganName(service.getOrganName(arry[i]));
				sonBean.setNextActivityOrganType("");
				sonBean.setParentFlowId(bean.getFlowId());
				sonBean.setIsFinish(NOT_FINISH);

				list.add(sonBean);
			}
		}else if(num<=1){
			SamSureyWf sonBean=new SamSureyWf();
			sonBean.setFlowId(IdHelp.getUUID32());
			sonBean.setSurveyId(bean.getSurveyId());
			sonBean.setSurveyType(bean.getSurveyType());
			sonBean.setAssistanceType(bean.getAssistanceType());
			sonBean.setApplyTitle(bean.getApplyTitle());
			sonBean.setName(bean.getName());
			sonBean.setIdCardType(bean.getIdCardType());
			sonBean.setIdCard(bean.getIdCard());
			sonBean.setDomicileCode(bean.getDomicileCode());
			sonBean.setApanageCode(bean.getApanageCode());
			sonBean.setCurActivity(SureyActivity.ACT_BOROUGH_SEND);// 需对县经核对处理
			sonBean.setCurStatus(ActivityStatus.TODO);         // 要区的济中心
			sonBean.setCurActivityOrgan("");
			sonBean.setCurActivityOrganName(service.getCenterName(domicileCode));
			sonBean.setCurActivityOrganType(bean.getCurActivityOrganType());
			sonBean.setCurActivityArea(domicileCode);//人户分离否之情况，只发户籍的经济核对中心即可
			sonBean.setCurActivitySt(DateUtil.getTime());
			sonBean.setOpinion("");
			sonBean.setOpinionCode("");
			sonBean.setPreActivity(bean.getCurActivityArea());
			sonBean.setPreActivityArea(bean.getCurActivityArea());
			sonBean.setPreActivityOrgan(bean.getCurActivityOrgan());
			sonBean.setPreActivityOrganName(parentOrganName);
			sonBean.setPreActivityOrganType(bean.getCurActivityOrganType());
			sonBean.setNextActivity("");
			sonBean.setNextActivityArea("");
			sonBean.setNextActivityOrgan("");
			sonBean.setNextActivityOrganName(service.getOrganName(domicileCode));
			sonBean.setNextActivityOrganType("");
			sonBean.setParentFlowId(bean.getFlowId());
			sonBean.setIsFinish(NOT_FINISH);

			list.add(sonBean);

		}

		return list;
	}
	/**
	 * 区县经济核对中心转发请求到市经济核对中心创建子流程
	 */
	public List<SamSureyWf> createSureyWf(SamSureyWf bean){
		List<SamSureyWf> list=new ArrayList<SamSureyWf>();
		String parentOrganName=bean.getCurActivityOrganName();
		String nextActivityArea=bean.getNextActivityArea();
		//判断人户是否分离 开始
		String domicileCode=bean.getDomicileCode();//户籍代码
		String apanageCode=bean.getApanageCode();//居住地代码
		//判断人户是否分离 结束
		 
       
			SamSureyWf sonBean=new SamSureyWf();
			sonBean.setFlowId(IdHelp.getUUID32());
			sonBean.setSurveyId(bean.getSurveyId());
			sonBean.setSurveyType(bean.getSurveyType());
			sonBean.setAssistanceType(bean.getAssistanceType());
			sonBean.setApplyTitle(bean.getApplyTitle());
			sonBean.setName(bean.getName());
			sonBean.setIdCardType(bean.getIdCardType());
			sonBean.setIdCard(bean.getIdCard());
			sonBean.setDomicileCode(bean.getDomicileCode());
			sonBean.setApanageCode(bean.getApanageCode());
			sonBean.setCurActivity(SureyActivity.ACT_CITY_SEND);// 需对县经核对处理
			sonBean.setCurStatus(ActivityStatus.TODO);         // 要区的济中心
			sonBean.setCurActivityOrgan("");
			sonBean.setCurActivityOrganName(service.getCenterName(domicileCode));
			sonBean.setCurActivityOrganType(bean.getCurActivityOrganType());
			sonBean.setCurActivityArea(domicileCode.substring(0, 4)+"00000000");//人户分离否之情况，只发户籍的经济核对中心即可
			sonBean.setCurActivitySt(DateUtil.getTime());
			sonBean.setOpinion("");
			sonBean.setOpinionCode("");
			sonBean.setPreActivity("");
			sonBean.setPreActivityArea(bean.getCurActivityArea());
			sonBean.setPreActivityOrgan(bean.getCurActivityOrgan());
			sonBean.setPreActivityOrganName(parentOrganName);
			sonBean.setPreActivityOrganType(bean.getCurActivityOrganType());
			sonBean.setNextActivity("");
			sonBean.setNextActivityArea("");
			sonBean.setNextActivityOrgan("");
			sonBean.setNextActivityOrganName(service.getCenterName(apanageCode));
			sonBean.setNextActivityOrganType("");
			sonBean.setParentFlowId(bean.getFlowId());
			sonBean.setIsFinish(NOT_FINISH);
	
			list.add(sonBean);
 
		
		return list;
	}
	/**
	 * 汇总，核对结果
	 */
	public void getSamSureyAssistanceResult(SamSureyWf bean){
		String peopleId=service.queryPeopleId(bean.getSurveyId());
		SamSureyAssistanceResult assistanceResult=new SamSureyAssistanceResult();
		assistanceResult.setResultId(IdHelp.getUUID32());
		assistanceResult.setSurveyId(bean.getSurveyId());
		assistanceResult.setPeopleId(peopleId);
		assistanceResult.setName(bean.getName());
		assistanceResult.setIdCard(bean.getIdCard());
		List<SamSureyWfAssistanceHis> assistanceHisList=getSonSureyWfAssistanceHis(bean.getFlowId());

		if(assistanceHisList.size()>0){
			boolean isBe=false;
			String assResult="";
			for(int i=0;i<assistanceHisList.size();i++){
				 
				SamSureyWfAssistanceHis hisBean=assistanceHisList.get(i);
				String result=hisBean.getSurveyResult();
				if(MININUM.equals(result)||MININUM_CITY.equals(result)||LOW_INCOME.equals(result)){
					isBe=true;
					assistanceResult.setResult(hisBean.getSurveyResult());
					 
					assistanceResult.setSignOrgan(hisBean.getSignOrgan());
					assistanceResult.setSignDate(hisBean.getSignDate());
					
					service.insertAssistanceResult(assistanceResult);
					break;
				}
				assResult=result;
			}	
			if(!isBe){ 
				assistanceResult.setResult(assResult);
				service.insertAssistanceResult(assistanceResult);
			}
		}
	}
	/**
	 * 汇总，核对结果--区县核对
	 */
	public void getSamSureyAssistanceTownResult(SamSureyWf bean){
		String peopleId=service.queryPeopleId(bean.getSurveyId());
		SamSureyAssistanceResult assistanceResult=new SamSureyAssistanceResult();
		assistanceResult.setResultId(IdHelp.getUUID32());
		assistanceResult.setSurveyId(bean.getSurveyId());
		assistanceResult.setPeopleId(peopleId);
		assistanceResult.setName(bean.getName());
		assistanceResult.setIdCard(bean.getIdCard());
		List<SamSureyWfAssistanceHis> assistanceHisList=getSureyWfAssistanceHis(bean.getFlowId());

		if(assistanceHisList.size()>0){
			boolean isBe=false;
			String assResult="";
			for(int i=0;i<assistanceHisList.size();i++){
				 
				SamSureyWfAssistanceHis hisBean=assistanceHisList.get(i);
				String result=hisBean.getSurveyResult();
				if(MININUM.equals(result)||MININUM_CITY.equals(result)||LOW_INCOME.equals(result)){
					isBe=true;
					assistanceResult.setResult(hisBean.getSurveyResult());
					assistanceResult.setSignOrgan(hisBean.getSignOrgan());
					assistanceResult.setSignDate(hisBean.getSignDate());
					
					service.insertAssistanceResult(assistanceResult);
					break;
				}
				assResult=result;
			}	
			if(!isBe){ 
				assistanceResult.setResult(assResult);
				service.insertAssistanceResult(assistanceResult);
			}
		}
	}
	/**
	 * 查看子流程的处理结果
	 */
	public List<SamSureyWfAssistanceHis> getSureyWfAssistanceHis(String parentFlowId){
		List<SamSureyWfAssistanceHis> assistanceHisList=new ArrayList<SamSureyWfAssistanceHis>();
		ParameterSet pset=new ParameterSet();
		pset.setParameter("FLOW_ID", parentFlowId);
		DataSet ds=service.initialQuery(pset);
		if(ds.getCount()>0){
			for(int i=0;i<ds.getCount();i++){
				SamSureyWf bean=(SamSureyWf)ds.getRecord(i).toBean(SamSureyWf.class);
				ParameterSet newPset=new ParameterSet();
				newPset.setParameter("FLOW_ID", bean.getFlowId());
				newPset.setParameter("ACTIVITY", SureyActivity.ACT_FILLING);
				SamSureyWfHis sureyWfHis=(SamSureyWfHis)service.querySureyWfHis(newPset).getRecord(0).toBean(SamSureyWfHis.class);
				String hisId=sureyWfHis.getHisId();
				newPset.clear();
				newPset.setParameter("HIS_ID", hisId);
				DataSet assistanceHisDs=service.queryAssistanceHis(newPset);
				if(assistanceHisDs.getCount()!=0){
					SamSureyWfAssistanceHis assistanceHisBean=(SamSureyWfAssistanceHis)assistanceHisDs.getRecord(0).toBean(SamSureyWfAssistanceHis.class);
					assistanceHisList.add(assistanceHisBean);
				}
				
			}
		}
		return assistanceHisList;
	}
	/**
	 * 根据子流程，填写流程历史结果
	 * 
	 */
	public void getSamSureyWfAssistanceHis(SamSureyWf bean,String hisId){
		SamSureyWfAssistanceHis assistanceHis=new SamSureyWfAssistanceHis();
		assistanceHis.setHisId(hisId);
		List<SamSureyWfAssistanceHis> assistanceHisList=getSonSureyWfAssistanceHis(bean.getFlowId());
		if(assistanceHisList.size()>0){
			boolean isBe=false;
			for(int i=0;i<assistanceHisList.size();i++){
				SamSureyWfAssistanceHis hisBean=assistanceHisList.get(i);
				String result=hisBean.getSurveyResult();
				if(MININUM.equals(result)||MININUM_CITY.equals(result)||LOW_INCOME.equals(result)){
					isBe=true;
					assistanceHis.setSurveyResult(hisBean.getSurveyResult());
					assistanceHis.setSignOrgan(hisBean.getSignOrgan());
					assistanceHis.setSignDate(hisBean.getSignDate());
					
					service.insertSureyWfAssistanceHis(assistanceHis);
					break;
				}
				if(!isBe){
					assistanceHis.setSurveyResult(result);
					service.insertSureyWfAssistanceHis(assistanceHis);
				}		
			}	
		}
	}
	/**
	 * 
	 * 区县经济核对中心移交任务到所对应的区县民政局
	 */
	@SuppressWarnings("unchecked")
	public void centerDistribute(){
		Map<String,String> map=(Map<String,String>)getParameter("map");
		String flowId=map.get("flowId");
		String surveyId=map.get("surveyId");
		String organId=map.get("organId");
		String userId=map.get("userId");
		String userName=map.get("userName");
		String organName=map.get("organName");
		String domicileCode=map.get("domicileCode");//户籍
		String apanageCode=map.get("apanageCode");//居住地
		
		SamSureyWf sureyWf=getSureyWfBean(flowId);
		//区县经济核对中心往区县民政局移交任务，记录流程历史信息
		SamSureyWfHis sureyWfHis=new SamSureyWfHis();
		sureyWfHis.setHisId(IdHelp.getUUID32());
		sureyWfHis.setFlowId(flowId);
		sureyWfHis.setActivity(sureyWf.getCurActivity());
		sureyWfHis.setOpinionCode(sureyWf.getOpinionCode());
		sureyWfHis.setOpinion(sureyWf.getOpinion());
		sureyWfHis.setActivityOrgan(organId);
		sureyWfHis.setActivityOrganName(organName);
		sureyWfHis.setActivityOrganArea(sureyWf.getCurActivityArea());
		sureyWfHis.setActivityOrganType(sureyWf.getCurActivityOrganType());
		sureyWfHis.setActivityPeople(userId);
		sureyWfHis.setActivityPeopleName(userName);
		sureyWfHis.setActivityDealTime(DateUtil.getTime());
		sureyWfHis.setCurActivityEt(DateUtil.getTime());
		sureyWfHis.setCurActivitySt(sureyWf.getCurActivitySt());		
		
		
		//根据数据源获取事务管理器。
		PlatformTransactionManager txManager = TransactionFactory.getTransactionManager("dataSource");
		//定义事务的一些属性，比如只读、隔离级别等。
		TransactionDefinition definition = new DefaultTransactionDefinition();
		//事务开始
		TransactionStatus status = txManager.getTransaction(definition);
		try{
 
			sureyWf.setCurActivity(SureyActivity.ACT_FILLING);
			sureyWf.setCurStatus(ActivityStatus.TODO);
			sureyWf.setNextActivityArea(sureyWf.getCurActivityArea());
			sureyWf.setCurActivityOrgan(organId);
			sureyWf.setPreActivityOrganName(service.getCenterName(sureyWf.getCurActivityArea()));
			sureyWf.setNextActivityOrganName(sureyWf.getCurActivityOrganName());
			sureyWf.setCurActivityOrganName(service.getOrganName(sureyWf.getCurActivityArea()));
			service.update(sureyWf);//变更流程状态
			service.insertSureyWfHis(sureyWfHis);//新增历史信息
			
		}catch(Throwable err){
			txManager.rollback(status);
			throw new RuntimeException(err);
		}
		//事务提交。
		txManager.commit(status);
	}
	/**
	 * 
	 *  区县经济核对中心将区外部单位的请求发送给区民政局
	 */
	@SuppressWarnings("unchecked")
	public void centerReportToTown(){
		Map<String,String> map=(Map<String,String>)getParameter("map");
		String flowId=map.get("flowId");
		String surveyId=map.get("surveyId");
		String organId=map.get("organId");
		String userId=map.get("userId");
		String userName=map.get("userName");
		String organName=map.get("organName");
		String domicileCode=map.get("domicileCode");//户籍
		String apanageCode=map.get("apanageCode");//居住地
		
		SamSureyWf sureyWf=getSureyWfBean(flowId);
		//区县经济核对中心往区县民政局移交任务，记录流程历史信息
		SamSureyWfHis sureyWfHis=new SamSureyWfHis();
		sureyWfHis.setHisId(IdHelp.getUUID32());
		sureyWfHis.setFlowId(flowId);
		sureyWfHis.setActivity(sureyWf.getCurActivity());
		sureyWfHis.setOpinionCode(sureyWf.getOpinionCode());
		sureyWfHis.setOpinion(sureyWf.getOpinion());
		sureyWfHis.setActivityOrgan(organId);
		sureyWfHis.setActivityOrganName(organName);
		sureyWfHis.setActivityOrganArea(sureyWf.getCurActivityArea());
		sureyWfHis.setActivityOrganType(sureyWf.getCurActivityOrganType());
		sureyWfHis.setActivityPeople(userId);
		sureyWfHis.setActivityPeopleName(userName);
		sureyWfHis.setActivityDealTime(DateUtil.getTime());
		sureyWfHis.setCurActivityEt(DateUtil.getTime());
		sureyWfHis.setCurActivitySt(sureyWf.getCurActivitySt());		
		
		
		//根据数据源获取事务管理器。
		PlatformTransactionManager txManager = TransactionFactory.getTransactionManager("dataSource");
		//定义事务的一些属性，比如只读、隔离级别等。
		TransactionDefinition definition = new DefaultTransactionDefinition();
		//事务开始
		TransactionStatus status = txManager.getTransaction(definition);
		try{
			sureyWf.setPreActivityOrganName(sureyWf.getCurActivityOrganName());
			sureyWf.setCurActivity(SureyActivity.ACT_FILLING);
			sureyWf.setNextActivityOrganName(service.getOrganName(sureyWf.getCurActivityArea()));
			sureyWf.setCurStatus(ActivityStatus.TODO);
			sureyWf.setCurActivityOrgan(organId);
			service.update(sureyWf);//变更流程状态
			service.insertSureyWfHis(sureyWfHis);//新增历史信息
			
		}catch(Throwable err){
			txManager.rollback(status);
			throw new RuntimeException(err);
		}
		//事务提交。
		txManager.commit(status);
	}
	/***********************************市经济核对中心下发任务到区县经济核对中心********************/
	/**
	 *  
	 * 市经济核对中心转发给区县的经济核对中心
	 */
	@SuppressWarnings("unchecked")
	public void cityCenterToTownCenter(){
		Map<String,String> map=(Map<String,String>)getParameter("map");
		String flowId=map.get("flowId");
		String surveyId=map.get("surveyId");
		String organId=map.get("organId");
		String userId=map.get("userId");
		String userName=map.get("userName");
		String organName=map.get("organName");
		String domicileCode=map.get("domicileCode");//户籍
		String apanageCode=map.get("apanageCode");//居住地
		
		SamSureyWf sureyWf=getSureyWfBean(flowId);
		//流程历史记录
		SamSureyWfHis sureyWfHis=new SamSureyWfHis();
		sureyWfHis.setHisId(IdHelp.getUUID32());
		sureyWfHis.setFlowId(flowId);
		sureyWfHis.setActivity(sureyWf.getCurActivity());
		sureyWfHis.setOpinionCode(sureyWf.getOpinionCode());
		sureyWfHis.setOpinion(sureyWf.getOpinion());
		sureyWfHis.setActivityOrgan(organId);
		sureyWfHis.setActivityOrganName(organName);
		sureyWfHis.setActivityOrganArea(sureyWf.getCurActivityArea());
		sureyWfHis.setActivityOrganType(sureyWf.getCurActivityOrganType());
		sureyWfHis.setActivityPeople(userId);
		sureyWfHis.setActivityPeopleName(userName);
		sureyWfHis.setActivityDealTime(DateUtil.getTime());
		sureyWfHis.setCurActivityEt(DateUtil.getTime());
		sureyWfHis.setCurActivitySt(sureyWf.getCurActivitySt());		
		
		
		//根据数据源获取事务管理器。
		PlatformTransactionManager txManager = TransactionFactory.getTransactionManager("dataSource");
		//定义事务的一些属性，比如只读、隔离级别等。
		TransactionDefinition definition = new DefaultTransactionDefinition();
		//事务开始
		TransactionStatus status = txManager.getTransaction(definition);
		try{
			 
			sureyWf.setCurStatus(ActivityStatus.TODO);
			sureyWf.setCurActivityArea(apanageCode);
			sureyWf.setCurActivity(SureyActivity.ACT_DISPENSE);
			sureyWf.setPreActivityOrganName("经济核对中心");
			sureyWf.setCurActivityOrgan(organId);
			sureyWf.setNextActivityArea(apanageCode);
			sureyWf.setNextActivityOrganName(service.getOrganName(apanageCode));
			service.update(sureyWf);
			service.insertSureyWfHis(sureyWfHis);
			
		}catch(Throwable err){
			txManager.rollback(status);
			throw new RuntimeException(err);
		}
		//事务提交。
		txManager.commit(status);
	}
	/**
	 *  
	 * 市经济核对中心转发给区县的经济核对中心
	 */
	@SuppressWarnings("unchecked")
	public void cityCenterToApply(){
		Map<String,String> map=(Map<String,String>)getParameter("map");
		String flowId=map.get("flowId");
		String surveyId=map.get("surveyId");
		String organId=map.get("organId");
		String userId=map.get("userId");
		String userName=map.get("userName");
		String organName=map.get("organName");
		String domicileCode=map.get("domicileCode");//户籍
		String apanageCode=map.get("apanageCode");//居住地
		
		SamSureyWf sureyWf=getSureyWfBean(flowId);
		//流程历史记录
		SamSureyWfHis sureyWfHis=new SamSureyWfHis();
		sureyWfHis.setHisId(IdHelp.getUUID32());
		sureyWfHis.setFlowId(flowId);
		sureyWfHis.setActivity(sureyWf.getCurActivity());
		sureyWfHis.setOpinionCode(sureyWf.getOpinionCode());
		sureyWfHis.setOpinion(sureyWf.getOpinion());
		sureyWfHis.setActivityOrgan(organId);
		sureyWfHis.setActivityOrganName(organName);
		sureyWfHis.setActivityOrganArea(sureyWf.getCurActivityArea());
		sureyWfHis.setActivityOrganType(sureyWf.getCurActivityOrganType());
		sureyWfHis.setActivityPeople(userId);
		sureyWfHis.setActivityPeopleName(userName);
		sureyWfHis.setActivityDealTime(DateUtil.getTime());
		sureyWfHis.setCurActivityEt(DateUtil.getTime());
		sureyWfHis.setCurActivitySt(sureyWf.getCurActivitySt());		
		
		SamSurey samSurey= getSamSurey(surveyId);
		SamSureyWf sureyParWf=getSureyWfBean(sureyWf.getParentFlowId());//父流程
		//根据数据源获取事务管理器。
		PlatformTransactionManager txManager = TransactionFactory.getTransactionManager("dataSource");
		//定义事务的一些属性，比如只读、隔离级别等。
		TransactionDefinition definition = new DefaultTransactionDefinition();
		//事务开始
		TransactionStatus status = txManager.getTransaction(definition);
		try{
			if(isCityLevel(samSurey.getApplyOrganArea())){
				sureyWf.setCurStatus(ActivityStatus.DONE);
				sureyWf.setCurActivityArea(domicileCode);
				sureyWf.setCurActivity(SureyActivity.ACT_CHECK);
				sureyWf.setCurActivityOrgan(organId);
			}else{
				sureyParWf.setCurActivity(SureyActivity.ACT_ISSUE);
				sureyParWf.setCurStatus(ActivityStatus.TODO);
				sureyParWf.setCurActivityArea(domicileCode);
				sureyParWf.setPreActivityOrganName(sureyWf.getCurActivityOrganName());
				sureyParWf.setNextActivityOrganName(samSurey.getApplyOrganName());
				sureyWf.setIsFinish(IS_FINISH);
			}
			
			service.update(sureyParWf);
			service.update(sureyWf);
			service.insertSureyWfHis(sureyWfHis);
		}catch(Throwable err){
			txManager.rollback(status);
			throw new RuntimeException(err);
		}
		//事务提交。
		txManager.commit(status);
	}
	/**
	 *  
	 * 区县经济核对中心将市经济核对中心的请求转发给区县民政局
	 */
	@SuppressWarnings("unchecked")
	public void townCenterToTownCams(){
		Map<String,String> map=(Map<String,String>)getParameter("map");
		String flowId=map.get("flowId");
		String surveyId=map.get("surveyId");
		String organId=map.get("organId");
		String userId=map.get("userId");
		String userName=map.get("userName");
		String organName=map.get("organName");
		String domicileCode=map.get("domicileCode");//户籍
		String apanageCode=map.get("apanageCode");//居住地
		
		SamSureyWf sureyWf=getSureyWfBean(flowId);
		//流程历史记录
		SamSureyWfHis sureyWfHis=new SamSureyWfHis();
		sureyWfHis.setHisId(IdHelp.getUUID32());
		sureyWfHis.setFlowId(flowId);
		sureyWfHis.setActivity(sureyWf.getCurActivity());
		sureyWfHis.setOpinionCode(sureyWf.getOpinionCode());
		sureyWfHis.setOpinion(sureyWf.getOpinion());
		sureyWfHis.setActivityOrgan(organId);
		sureyWfHis.setActivityOrganName(organName);
		sureyWfHis.setActivityOrganArea(sureyWf.getCurActivityArea());
		sureyWfHis.setActivityOrganType(sureyWf.getCurActivityOrganType());
		sureyWfHis.setActivityPeople(userId);
		sureyWfHis.setActivityPeopleName(userName);
		sureyWfHis.setActivityDealTime(DateUtil.getTime());
		sureyWfHis.setCurActivityEt(DateUtil.getTime());
		sureyWfHis.setCurActivitySt(sureyWf.getCurActivitySt());		
		
		
		//根据数据源获取事务管理器。
		PlatformTransactionManager txManager = TransactionFactory.getTransactionManager("dataSource");
		//定义事务的一些属性，比如只读、隔离级别等。
		TransactionDefinition definition = new DefaultTransactionDefinition();
		//事务开始
		TransactionStatus status = txManager.getTransaction(definition);
		try{
			//子流程
			//分子流程调整：若不是人户分离则只向户籍的经济核对中心发，反之户籍和居住地的经济核对中心都发
			List<SamSureyWf> sonList=getSonSureyWfByParentSureyWf(sureyWf);
			for(int i=0;i<sonList.size();i++){
				service.insert(sonList.get(i));
			}		
			sureyWf.setCurStatus(ActivityStatus.TODO);
			sureyWf.setCurActivityOrgan(organId);
			sureyWf.setCurActivity(SureyActivity.ACT_FILLING);
			service.update(sureyWf);
			service.insertSureyWfHis(sureyWfHis);
			
		}catch(Throwable err){
			txManager.rollback(status);
			throw new RuntimeException(err);
		}
		//事务提交。
		txManager.commit(status);
	}
	/**
	 * 区县济核对中心将核对结果反馈给区县外部单位
	 */
	@SuppressWarnings("unchecked")
	public void townCenterDistributeToApply(){
		Map<String,String> map=(Map<String,String>)getParameter("map");
 
		String flowId=map.get("flowId");
		String surveyId=map.get("surveyId");
		String organId=map.get("organId");
		String userId=map.get("userId");
		String userName=map.get("userName");
		String organName=map.get("organName");
		String domicileCode=map.get("domicileCode");
		String apanageCode=map.get("apanageCode");
		
		SamSureyWf sonSureyWf=getSureyWfBean(flowId);
		//获得子流程历史记录
		String activity=sonSureyWf.getCurActivity();
		 
		
		SamSurey samSurey=getSamSurey(surveyId);
		
		sonSureyWf.setIsFinish(IS_FINISH);
		sonSureyWf.setCurActivity(SureyActivity.ACT_GATHER);
		sonSureyWf.setCurStatus(ActivityStatus.DONE);
		sonSureyWf.setCurActivityOrganType(samSurey.getApplyOrganType());
		//根据数据源获取事务管理器。
		PlatformTransactionManager txManager = TransactionFactory.getTransactionManager("dataSource");
		//定义事务的一些属性，比如只读、隔离级别等。
		TransactionDefinition definition = new DefaultTransactionDefinition();
		//事务开始
		TransactionStatus status = txManager.getTransaction(definition);
		try{
			getSamSureyAssistanceResult(sonSureyWf);
			service.update(sonSureyWf);
			//填写总的核对结果
			
		}catch(Throwable err){
			txManager.rollback(status);
			throw new RuntimeException(err);
		}
		//事务提交。
		txManager.commit(status);	
		
		//checkSonSureyWf(sonSureyWf,userId,userName);		
		
	}
	/**
	 * 判断是否为市级行政区划
	 * @param organArea
	 * @return
	 */
	public Boolean isCityLevel(String organArea){
		String endArea = organArea.substring(4);
		return endArea.equals("00000000");
	}
	
}

