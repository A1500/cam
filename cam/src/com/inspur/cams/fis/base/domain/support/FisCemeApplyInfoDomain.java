package com.inspur.cams.fis.base.domain.support;

import java.util.Iterator;
import java.math.BigDecimal; 
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.CommandContext;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.workflow.api.WfQuery;
import org.loushang.workflow.api.WfTaskRequestWrapper;
import org.loushang.workflow.util.TimeUtils;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.fis.base.dao.IFisCemeAccessoriesDao;
import com.inspur.cams.fis.base.dao.IFisCemeApplyInfoDao;
import com.inspur.cams.fis.base.dao.IFisCemeInfoDao;
import com.inspur.cams.fis.base.dao.IFisCemeCheckHistoryDao;
import com.inspur.cams.fis.base.dao.IFisCemeCheckScoreDao;
import com.inspur.cams.fis.base.data.FisCemeAccessories;
import com.inspur.cams.fis.base.data.FisCemeApplyInfo;
import com.inspur.cams.fis.base.data.FisCemeCheckHistory;
import com.inspur.cams.fis.base.data.FisCemeCheckScore;
import com.inspur.cams.fis.base.data.FisCemeChange;
import com.inspur.cams.fis.base.data.FisCemeInfo;
import com.inspur.cams.fis.base.data.FisCemeLogoff;
import com.inspur.cams.fis.base.data.FisCemeLogoffOpinion;
import com.inspur.cams.fis.base.domain.IFisCemeApplyInfoDomain;
import com.inspur.cams.fis.base.domain.IFisCemeCheckHistoryDomain;
import com.inspur.cams.fis.base.domain.IFisCemeCheckScoreDomain;
import com.inspur.cams.fis.base.domain.IFisCemeChangeDetailDomain;
import com.inspur.cams.fis.base.domain.IFisCemeChangeDomain;
import com.inspur.cams.fis.base.domain.IFisCemeInfoDomain;
import com.inspur.cams.fis.base.domain.IFisCemeLogoffDomain;
import com.inspur.cams.fis.base.domain.IFisCemeLogoffOpinionDomain;
import com.inspur.cams.fis.base.data.FisCemeExpendInfo;
import com.inspur.cams.fis.base.dao.IFisCemeExpendInfoDao;


/**
 * 公墓审批业务表domain
 * 
 * @author
 * @date 2013-08-01
 */
public class FisCemeApplyInfoDomain implements IFisCemeApplyInfoDomain {
	@Reference
	private IFisCemeApplyInfoDao fisCemeApplyInfoDao;
	@Reference
	private IFisCemeCheckScoreDomain fisCemeCheckScoreDomain;
	@Reference
	private IFisCemeCheckHistoryDomain fisCemeCheckHistoryDomain;
	
	@Reference 
	private IFisCemeInfoDomain fisCemeInfoDomain;
	@Reference
	private IFisCemeChangeDetailDomain fisCemeChangeDetailDomain;
	@Reference
	private IFisCemeChangeDomain fisCemeChangeDomain;
	
	@Reference 
	private IFisCemeLogoffDomain fisCemeLogoffDomain;
	
	@Reference 
	private IFisCemeLogoffOpinionDomain fisCemeLogoffOpinionDomain;

	@Reference 
	private IFisCemeAccessoriesDao fisCemeAccessoriesDao;
	
	@Reference 
	private IFisCemeInfoDao fisCemeInfoDao;
	
	@Reference 
	private IFisCemeExpendInfoDao fisCemeExpendInfoDao;
	/**
	 * 查询 公墓审批业务表
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return fisCemeApplyInfoDao.query(pset);
	}
	/**
	 * 查询 公墓审批业务表，外联公墓信息表FIS_CEME_INFO
	 * @param pset
	 * @return
	 */
	public DataSet queryCreate(ParameterSet pset){
		return fisCemeApplyInfoDao.queryCreate(pset);
	}
	public DataSet queryYS(ParameterSet pset){
		return fisCemeApplyInfoDao.queryYS(pset);
	}
	/**
	 * 查询 公墓审批业务表，外联公墓信息表FIS_CEME_INFO
	 * @param pset
	 * @return
	 */
	public DataSet queryExpend(ParameterSet pset){
		return fisCemeApplyInfoDao.queryExpend(pset);
	}
	

	/**
	 * 获取 公墓审批业务表
	 * 
	 * @param pset
	 * @return
	 */
	public FisCemeApplyInfo get(String cemeApplyId) {
		return fisCemeApplyInfoDao.get(cemeApplyId);
	}

	/**
	 * 增加 公墓审批业务表
	 * 
	 * @param fisCemeApplyInfo
	 */
	public void insert(FisCemeApplyInfo fisCemeApplyInfo) {
		fisCemeApplyInfoDao.insert(fisCemeApplyInfo);
	}

	/**
	 * 修改 公墓审批业务表
	 * 
	 * @param fisCemeApplyInfo
	 */
	public void update(FisCemeApplyInfo fisCemeApplyInfo) {
		fisCemeApplyInfoDao.update(fisCemeApplyInfo);
	}

	/**
	 * 删除 公墓审批业务表
	 * 
	 * @param cemeApplyId
	 */
	public void delete(String cemeApplyId) {
		fisCemeApplyInfoDao.delete(cemeApplyId);
	}
	
	
	/**
	 * 新增 经营性公墓关闭业务
	 * 
	 * @param pset
	 */
	public void insertLogoff(ParameterSet pset){
		Record alRecord = (Record) pset.getParameter("applyRecord");
		Record clRecord = (Record) pset.getParameter("logoffRecord");
		Record opRecord = (Record) pset.getParameter("opinionRecord");
		Record cemeRecord = (Record) pset.getParameter("cemeRecord");
		Record historyRecord = (Record) pset.getParameter("historyRecord");
		FisCemeInfo fisCemeInfo  =(FisCemeInfo) cemeRecord.toBean(FisCemeInfo.class);
		FisCemeApplyInfo fisCemeApplyInfo  =(FisCemeApplyInfo) alRecord.toBean(FisCemeApplyInfo.class);
		FisCemeLogoff fisCemeLogoff  =(FisCemeLogoff) clRecord.toBean(FisCemeLogoff.class);
		FisCemeLogoffOpinion fisCemeLogoffOpinion  =(FisCemeLogoffOpinion) opRecord.toBean(FisCemeLogoffOpinion.class);
		FisCemeCheckHistory fisCemeCheckHistory = (FisCemeCheckHistory) historyRecord.toBean(FisCemeCheckHistory.class);
		//设置业务表相关参数
		fisCemeApplyInfo.setRecordId(fisCemeInfo.getRecordId());
		fisCemeApplyInfo.setApplyState("0");
		fisCemeApplyInfo.setRecTime(DateUtil.getDay());
		//设置备案表相关参数
		fisCemeLogoff.setRecordId(fisCemeInfo.getRecordId());
		fisCemeLogoff.setOrganId(fisCemeInfo.getOrganId());
		fisCemeLogoff.setName(fisCemeInfo.getName());
		//执行增加操作 
		fisCemeInfoDomain.update(fisCemeInfo);
		fisCemeApplyInfoDao.insert(fisCemeApplyInfo);
		fisCemeLogoffDomain.insert(fisCemeLogoff);
		fisCemeLogoffOpinionDomain.insert(fisCemeLogoffOpinion);
		fisCemeCheckHistoryDomain.insert(fisCemeCheckHistory);
	}
	
	/**
	 * 更新 经营性公墓关闭业务
	 * 
	 * @param pset
	 */
	public void updateLogoff(ParameterSet pset){
		Record alRecord = (Record) pset.getParameter("applyRecord");
		Record clRecord = (Record) pset.getParameter("logoffRecord");
		Record opRecord = (Record) pset.getParameter("opinionRecord");
		Record cemeRecord = (Record) pset.getParameter("cemeRecord");
		Record historyRecord = (Record) pset.getParameter("historyRecord");
		FisCemeInfo fisCemeInfo  =(FisCemeInfo) cemeRecord.toBean(FisCemeInfo.class);
		FisCemeApplyInfo fisCemeApplyInfo  =(FisCemeApplyInfo) alRecord.toBean(FisCemeApplyInfo.class);
		FisCemeLogoff fisCemeLogoff  =(FisCemeLogoff) clRecord.toBean(FisCemeLogoff.class);
		FisCemeLogoffOpinion fisCemeLogoffOpinion  =(FisCemeLogoffOpinion) opRecord.toBean(FisCemeLogoffOpinion.class);
		FisCemeCheckHistory fisCemeCheckHistory = (FisCemeCheckHistory) historyRecord.toBean(FisCemeCheckHistory.class);
		fisCemeInfoDomain.update(fisCemeInfo);
		fisCemeApplyInfoDao.update(fisCemeApplyInfo);
		fisCemeLogoffDomain.update(fisCemeLogoff);
		fisCemeLogoffOpinionDomain.update(fisCemeLogoffOpinion);
		fisCemeCheckHistoryDomain.update(fisCemeCheckHistory);
	}
	//查询  待办业务
	public DataSet queryDaiban(ParameterSet pset) {
		return fisCemeApplyInfoDao.queryDaiban(pset);
	}
	
	public DataSet queryPublic(ParameterSet pset) {
		return fisCemeApplyInfoDao.queryPublic(pset);
	}
	
	//年检保存
	public void insertAll(ParameterSet pset){
		Record scoreRecord = (Record) pset.getParameter("scoreRecord");
		Record daFenRecord = (Record) pset.getParameter("daFenRecord");
		Record historyRecord = (Record) pset.getParameter("historyRecord");
		FisCemeApplyInfo fisCemeApplyInfo = (FisCemeApplyInfo) daFenRecord.toBean(FisCemeApplyInfo.class);
		FisCemeCheckScore fisCemeCheckScore = (FisCemeCheckScore) scoreRecord.toBean(FisCemeCheckScore.class);
		FisCemeCheckHistory fisCemeCheckHistory = (FisCemeCheckHistory) historyRecord.toBean(FisCemeCheckHistory.class);
		
		//获取年检年度
		SimpleDateFormat format = new SimpleDateFormat("yyyy");
		String checkYear = format.format(new Date());
		fisCemeApplyInfo.setCheckYear(checkYear);
		
		fisCemeApplyInfoDao.insert(fisCemeApplyInfo);
		fisCemeCheckScoreDomain.insert(fisCemeCheckScore);
		fisCemeCheckHistoryDomain.insert(fisCemeCheckHistory);
	}
	
	//年检更新
	public void updateAll(ParameterSet pset){
		Record historyRecord = (Record) pset.getParameter("historyRecord");
		Record scoreRecord = (Record) pset.getParameter("scoreRecord");
		Record daFenRecord = (Record) pset.getParameter("daFenRecord");
		String method = (String)pset.getParameter("method");
		FisCemeApplyInfo fisCemeApplyInfo = (FisCemeApplyInfo) daFenRecord.toBean(FisCemeApplyInfo.class);
		FisCemeCheckScore fisCemeCheckScore = (FisCemeCheckScore) scoreRecord.toBean(FisCemeCheckScore.class);
		FisCemeCheckHistory fisCemeCheckHistory = (FisCemeCheckHistory) historyRecord.toBean(FisCemeCheckHistory.class);
		fisCemeApplyInfoDao.update(fisCemeApplyInfo);
		if("faQiUpdate".equals(method)){
			fisCemeCheckHistoryDomain.update(fisCemeCheckHistory);
		}
		fisCemeCheckScoreDomain.update(fisCemeCheckScore);
	}
	//年检 驳回、提交 流程
	public void send(ParameterSet pset){
		Record daFenRecord = (Record) pset.getParameter("daFenRecord");
		Record scoreRecord = (Record) pset.getParameter("scoreRecord");
		Record historyRecord = (Record) pset.getParameter("historyRecord");
		
		String isReport = (String)daFenRecord.get("isReport");
		String assignmentId = (String)pset.getParameter("assignmentId");
		String organType = (String)pset.getParameter("organType");
		
		//option:1 合格，2:不合格
		String option = (String)daFenRecord.get("secondResult");
		Map context = new HashMap();
		CommandContext.setContextParameter("assignmentId",assignmentId);

		FisCemeApplyInfo fisCemeApplyInfo = (FisCemeApplyInfo) daFenRecord.toBean(FisCemeApplyInfo.class);
		FisCemeCheckScore fisCemeCheckScore = (FisCemeCheckScore) scoreRecord.toBean(FisCemeCheckScore.class);
		FisCemeCheckHistory fisCemeCheckHistory = (FisCemeCheckHistory) historyRecord.toBean(FisCemeCheckHistory.class);
		
		//市级结束流程
		if("12".equals(organType)){
			context.put("ORGANID", BspUtil.getDeptStruId());
			context.put("CONDITION", "END");
			fisCemeCheckHistory.setIsReport("1");
			fisCemeApplyInfo.setCurActivity("审批结束");
			fisCemeApplyInfo.setComTime(DateUtil.getTime());
		}
		//县级再次提交到市级
		if("13".equals(organType)){
			context.put("ORGANID", BspUtil.getParentStrId());
			context.put("CONDITION", "PASS");
			fisCemeCheckHistory.setIsReport("0");
			fisCemeApplyInfo.setIsReport("0");//上报状态为县级上报
			fisCemeApplyInfo.setCurActivity("市级审批");
			fisCemeApplyInfo.setApplyState("6");//整改上报
		}
		Map wfMap = WfTaskRequestWrapper.getInstance().send(context);
		if("true".equals((String)wfMap.get("isEnd"))&&"1".equals(option)){
			fisCemeApplyInfo.setApplyState("3");//业务装填为审批通过
			fisCemeApplyInfo.setIsReport("9");//上报状态为市级审批
			fisCemeApplyInfo.setCheckResult("1");//年检结果为合格
			
			fisCemeCheckHistory.setCheckResult("1");
		}else if("true".equals((String)wfMap.get("isEnd"))&&"2".equals(option)){
			fisCemeApplyInfo.setApplyState("4");//业务状态为审批不通过
			fisCemeApplyInfo.setCheckResult("2");//年检不合格
			fisCemeApplyInfo.setIsReport("9");//上报状态为市级审批
			fisCemeCheckHistory.setCheckResult("2");
		}
		fisCemeApplyInfoDao.update(fisCemeApplyInfo);
		fisCemeCheckScoreDomain.update(fisCemeCheckScore);
		fisCemeCheckHistoryDomain.insert(fisCemeCheckHistory);
		
	}
	//年检驳回提交流程
	public void sendMore(ParameterSet pset){
		Record daFenRecord = (Record) pset.getParameter("daFenRecord");
		Record scoreRecord = (Record) pset.getParameter("scoreRecord");
		Record historyRecord = (Record) pset.getParameter("historyRecord");
		
		String isReport = (String)daFenRecord.get("isReport");
		String taskCode=(String) daFenRecord.get("cemeApplyId");
		String assignmentId = (String)pset.getParameter("assignmentId");
		
		Map context = new HashMap();
		CommandContext.setContextParameter("assignmentId",assignmentId);
		context.put("CONDITION", "FAIL");
		Map wfMap = WfTaskRequestWrapper.getInstance().send(context);
		
		FisCemeApplyInfo fisCemeApplyInfo = (FisCemeApplyInfo) daFenRecord.toBean(FisCemeApplyInfo.class);
		fisCemeApplyInfo.setIsReport("2");//将上报状态改为市级驳回
		fisCemeApplyInfo.setCheckResult("5");//将检查结果改为整改
		fisCemeApplyInfo.setCurActivity("县级整改");
		
		FisCemeCheckScore fisCemeCheckScore = (FisCemeCheckScore) scoreRecord.toBean(FisCemeCheckScore.class);
		
		FisCemeCheckHistory fisCemeCheckHistory = (FisCemeCheckHistory) historyRecord.toBean(FisCemeCheckHistory.class);
		fisCemeCheckHistory.setIsReport("2");
		fisCemeCheckHistory.setCheckResult("5");
		
		fisCemeCheckHistory.setCheckNum("3");//将年检次数改为整改后检查
		
		fisCemeApplyInfoDao.update(fisCemeApplyInfo);
		fisCemeCheckHistoryDomain.insert(fisCemeCheckHistory);
		fisCemeCheckScoreDomain.update(fisCemeCheckScore);
		
	}
	//年检发起流程
	public void createAndSendYearlyCheck(ParameterSet pset) {
		// TODO Auto-generated method stub
		String prop = (String) pset.getParameter("prop");
		String parentOrganCode = (String) pset.getParameter("parentOrganCode");
		String parentOrganName = (String) pset.getParameter("parentOrganName");
		String organType = (String) pset.getParameter("organType");
		Record record = (Record) pset.getParameter("record");
		String taskCode=(String) record.get("CEME_APPLY_ID");
		Record hisRecord = (Record) pset.getParameter("hisRecord");
		String serviceName = "经营性公墓年检";
		// 向表CEME_APPLY_INFO表中更新记录【审批表】
		FisCemeCheckHistory fisCemeCheckHistory = (FisCemeCheckHistory) hisRecord.toBean(FisCemeCheckHistory.class);
		
		pset.clear();
		pset.setParameter("CEME_APPLY_ID", taskCode);
		FisCemeApplyInfo fisCemeApplyInfo = (FisCemeApplyInfo) fisCemeApplyInfoDao.query(pset).getRecord(0).toBean(FisCemeApplyInfo.class);
		//fisCemeApplyInfo.setRecTime(DateUtil.getTime());
		
		if("13".equals(organType)){
			fisCemeApplyInfo.setIsReport("0");//上报状态为县级已上报
			if("1".equals(prop)){//公益性的年检合格
				fisCemeApplyInfo.setComTime(DateUtil.getDay());
				if(fisCemeApplyInfo.getFirstResult().equals("1")){
					fisCemeApplyInfo.setApplyState("3");//业务状态改为审批通过
					fisCemeApplyInfo.setCheckResult("1");//年检结果为 合格
				}
				if(fisCemeApplyInfo.getFirstResult().equals("2")){
					fisCemeApplyInfo.setApplyState("4");//审批不通过
					fisCemeApplyInfo.setCheckResult("2");//年检结果为 不合格
				}
			}
			if("2".equals(prop)){//经营性的年检合格
				fisCemeApplyInfo.setCurActivity("市级审批");
				fisCemeApplyInfo.setCurOrgan(parentOrganName);
				fisCemeApplyInfo.setCurOrganCode(parentOrganCode);
				if(fisCemeApplyInfo.getFirstResult().equals("1")){
					fisCemeApplyInfo.setCheckResult("3");//年检结果为 已检查
				}
				if(fisCemeApplyInfo.getFirstResult().equals("2")){
					//fisCemeApplyInfo.setApplyState("4");
					fisCemeApplyInfo.setCheckResult("3");//年检结果为 已检查
				}
			}
		}
		if("12".equals(organType)){//市属
			fisCemeApplyInfo.setCurActivity("已年检");
			fisCemeApplyInfo.setIsReport("9");//上报状态为市级已上报
			fisCemeApplyInfo.setComTime(DateUtil.getDay());
		}
		
		fisCemeApplyInfoDao.update(fisCemeApplyInfo);
		fisCemeCheckHistoryDomain.update(fisCemeCheckHistory);
		if("2".equals(prop) && "13".equals(organType)){
		String procDefUniqueId = "4028e08140623a11014062422576004e";
		// 通过流程唯一ID获得流程第一个环节ID
		String startActDefUniqueId = (String)WfQuery.getActDefInfoByProcDefUniqueIdAndActDefId(procDefUniqueId,"act1").get("actDefUniqueId");
		//System.out.println(startActDefUniqueId);
		// 调用创建并发送流程接口
		CommandContext.setContextParameter("procDefUniqueId",procDefUniqueId);
		CommandContext.setContextParameter("startActDefUniqueId",startActDefUniqueId);
		
		Map<String, String> context = new HashMap<String, String>();
		String organId = BspUtil.getParentStrId();
		String currentOrganName = BspUtil.getCorpOrgan().getOrganName();
		//获得当前部门的上级部门的StruId
		context.put("ORGANID", BspUtil.getParentStrId());
		
		//获得当前部门的StruId
		//context.put("ORGANID", BspUtil.getDeptStruId());
		context.put("CONDITION","PASS");
		Map<String, String> map = WfTaskRequestWrapper.getInstance().createAndSend(taskCode, currentOrganName + serviceName, context);
		//String processId = map.get("processId");
		}
		
	}
	
	public void deleteAll(ParameterSet pset) {
		String cemeApplyId = (String)pset.getParameter("cemeApplyId");
		String scoreId = (String)pset.getParameter("scoreId");
		fisCemeApplyInfoDao.delete(cemeApplyId);
		fisCemeCheckScoreDomain.delete(scoreId);
		fisCemeApplyInfoDao.deleteAll(pset);
	}

	/**
	 * 更新 发起公墓撤销流程
	 * 
	 * @param pset
	 */
	public void updateAndSend(ParameterSet pset) {
		//获取传递业务记录
		String cemeApplyId =(String) pset.getParameter("cemeApplyId");
		pset.clear();
		pset.setParameter("CEME_APPLY_ID", cemeApplyId);
		DataSet applyDs = fisCemeApplyInfoDao.query(pset);
		DataSet logoffDs = fisCemeLogoffDomain.query(pset);
		FisCemeApplyInfo fisCemeApplyInfo = (FisCemeApplyInfo) applyDs.getRecord(0).toBean(FisCemeApplyInfo.class);
		FisCemeLogoff fisCemeLogoff = (FisCemeLogoff) logoffDs.getRecord(0).toBean(FisCemeLogoff.class);
		
		String procDefUniqueId="";
		String serviceName="";
		if(BspUtil.getOrganType().equals("13")){
			procDefUniqueId = "8a898ca1407091b70140710fbcb500e3";
			serviceName = "经营性公墓关闭审批流程";
			fisCemeApplyInfo.setCurActivity("公墓关闭审核");
			fisCemeApplyInfo.setIsReport("0");//上报状态改为县级已上报
		}else{
			procDefUniqueId = "8a898be940c7ad640140c7d648810051";
			serviceName = "市属公墓关闭流程";
			fisCemeApplyInfo.setCurActivity("公墓关闭审批");
			fisCemeApplyInfo.setIsReport("9");//上报状态改为县级已上报
		}
		//设置业务表相关参数
		fisCemeApplyInfo.setApplyState("0");
		fisCemeApplyInfo.setWfId(procDefUniqueId);
		fisCemeApplyInfo.setRecTime(DateUtil.getDay());
		fisCemeApplyInfo.setCurOrgan(BspUtil.getParentOrgan().getOrganName());
		fisCemeApplyInfo.setCurOrganCode(BspUtil.getParentOrgan().getOrganCode());
		//设置备案表相关参数
		fisCemeLogoff.setRegDate(DateUtil.getDay());
		//执行更新操作
		fisCemeApplyInfoDao.update(fisCemeApplyInfo);
		fisCemeLogoffDomain.update(fisCemeLogoff);
		// 通过流程唯一ID获得流程第一个环节ID
		String startActDefUniqueId = (String) WfQuery
				.getActDefInfoByProcDefUniqueIdAndActDefId(procDefUniqueId,
						"act1").get("actDefUniqueId");
		// 调用创建并发送流程接口
		CommandContext.setContextParameter("procDefUniqueId", procDefUniqueId);
		CommandContext.setContextParameter("startActDefUniqueId",
				startActDefUniqueId);
		Map<String, String> context = new HashMap<String, String>();
		String currentOrganName = BspUtil.getCorpOrgan().getOrganName();
		context.put("ORGANID", BspUtil.getParentStrId());
		context.put("CONDITION", "PASS");
		Map<String, String> map = WfTaskRequestWrapper.getInstance()
				.createAndSend(cemeApplyId, currentOrganName + serviceName,
						context);
	}

	/**
	 * 发送撤销流程
	 * @param pset
	 * */
	public void sendLogoff(ParameterSet pset){
		Record record = (Record) pset.getParameter("record");
		Record logoff = (Record) pset.getParameter("logoffRecord");
		String opinion = (String) pset.getParameter("opinion");
		String assignmentId = (String) pset.getParameter("assignmentId");
		String recTime = (String) pset.getParameter("recTime");
		Map context = new HashMap();
		context.put("ORGANID", BspUtil.getParentStrId());
		//判定流程走向
		if(!"".equals(opinion)&&"0".equals(opinion)){
			context.put("CONDITION","PASS");
		}else{
			context.put("CONDITION","FAIL");
		}
		CommandContext.setContextParameter("assignmentId", assignmentId);
		Map wfMap = WfTaskRequestWrapper.getInstance().send(context);
		FisCemeApplyInfo fisCemeApplyInfo  =(FisCemeApplyInfo) record.toBean(FisCemeApplyInfo.class);
		FisCemeLogoff fisCemeLogoff  =(FisCemeLogoff) logoff.toBean(FisCemeLogoff.class);
		if("true".equals((String)wfMap.get("isEnd"))&&"0".equals(opinion)){
			//修改业务状态标志
			fisCemeApplyInfo.setApplyState("3");//审批不通过
			fisCemeApplyInfo.setComTime(recTime);//设置处理时间
			fisCemeApplyInfo.setCurActivity("审批结束");//设置当前环节
			fisCemeApplyInfo.setIsReport("3");//设置上报状态
			
			//更新公墓信息
			ParameterSet pset1=new ParameterSet();
			pset1.setParameter("RECORD_ID", (String)record.get("recordId"));
			DataSet infoDs=fisCemeInfoDomain.query(pset1);
			if(infoDs.getCount()>0){
				Record cemeRecord= infoDs.getRecord(0);
				FisCemeInfo fisCemeInfo  =(FisCemeInfo) cemeRecord.toBean(FisCemeInfo.class);
				fisCemeInfo.setOrganState("3");
				fisCemeInfoDomain.update(fisCemeInfo);
			}
			
			fisCemeLogoff.setIfConfirm("1");
			fisCemeLogoffDomain.update(fisCemeLogoff);
		}else if("true".equals((String)wfMap.get("isEnd"))&&"1".equals(opinion)){
			fisCemeApplyInfo.setCurActivity("审批结束");
			fisCemeApplyInfo.setApplyState("4");
			fisCemeApplyInfo.setComTime(recTime);
			ParameterSet pset2 = new ParameterSet();
			pset2.setParameter("RECORD_ID", (String)record.get("recordId"));
			DataSet cemeDs=fisCemeInfoDomain.query(pset2);
			
			fisCemeLogoff.setIfConfirm("1");
			fisCemeLogoffDomain.update(fisCemeLogoff);
			if(cemeDs.getCount()>0){
				FisCemeInfo fisCemeInfo = (FisCemeInfo) cemeDs.getRecord(0).toBean(FisCemeInfo.class);
				fisCemeInfoDomain.update(fisCemeInfo);
			}
		}else if((String)wfMap.get("isEnd")==null){
			fisCemeApplyInfo.setCurActivity("公墓关闭审批");
			fisCemeApplyInfo.setSecondUnit(BspUtil.getOrganName());
			fisCemeApplyInfo.setSecondUnitId(BspUtil.getOrganCode());
			fisCemeApplyInfo.setCurOrganCode(BspUtil.getParentOrgan().getOrganCode());
			fisCemeApplyInfo.setCurOrgan(BspUtil.getParentOrgan().getOrganName());
			fisCemeApplyInfo.setIsReport("1");
			fisCemeApplyInfo.setRecTime(recTime);
		}
		fisCemeApplyInfoDao.update(fisCemeApplyInfo);
	}


	public void sendChange(ParameterSet pset) {
		Record record = (Record) pset.getParameter("record");
		String opinion = (String) pset.getParameter("opinion");
		String assignmentId = (String) pset.getParameter("assignmentId");
		Map context = new HashMap();
		context.put("ORGANID", BspUtil.getParentStrId());
		// 判定流程走向
		if (!"".equals(opinion) && "0".equals(opinion)) {
			context.put("CONDITION", "PAST");
		} else {
			context.put("CONDITION", "NO");
		}
		CommandContext.setContextParameter("assignmentId", assignmentId);
		Map wfMap = WfTaskRequestWrapper.getInstance().send(context);
		FisCemeApplyInfo fisCemeApplyInfo = (FisCemeApplyInfo) record.toBean(FisCemeApplyInfo.class);
		ParameterSet pset2 = new ParameterSet();
		pset2.setParameter("CEME_APPLY_ID", (String) record.get("cemeApplyId"));
		DataSet infoDs2 = fisCemeChangeDomain.query(pset2);
		FisCemeChange changeRecordBean = (FisCemeChange) infoDs2.getRecord(0).toBean(FisCemeChange.class);
		ParameterSet pset3 = new ParameterSet();
		pset3.setParameter("CHANGE_ID@=", changeRecordBean.getChangeId());
		DataSet changeRecordDetailDs = fisCemeChangeDetailDomain.query(pset3);
		if ("true".equals((String) wfMap.get("isEnd")) && "0".equals(opinion)) {
			
			Map map = new HashMap();
			String manaLevelId = "";
			for (int i = 0; i < changeRecordDetailDs.getCount(); i++) {
				Record r = changeRecordDetailDs.getRecord(i);
				map.put(r.get("itemCode"), r.get("itemAfter"));
				if(r.get("itemCode").equals("0")){
					manaLevelId=(String)r.get("itemName");
				}
			}
			ParameterSet psStatus = new ParameterSet();
			psStatus.setParameter("RECORD_ID@=", changeRecordBean.getRecordId());
			DataSet dsStatus = fisCemeInfoDomain.query(psStatus);
			FisCemeInfo bean = (FisCemeInfo) dsStatus.getRecord(0).toBean(FisCemeInfo.class);
			Iterator it = map.entrySet().iterator();
			while (it.hasNext()) {
				Entry obj = (Entry) it.next();
				if (((String) obj.getKey()).equals("0")) {
					bean.setManaLevel((String) obj.getValue());
				} else if (((String) obj.getKey()).equals("1")) {
					bean.setOrganizer((String) obj.getValue());
				} 
			}
			if(StringUtils.isNotEmpty(manaLevelId)){
				bean.setManaLevelId(manaLevelId);
			}
			fisCemeInfoDomain.update(bean);			
			// 修改业务状态标志
			fisCemeApplyInfo.setCurActivity("公墓变更审批");
			fisCemeApplyInfo.setApplyState("3");
			fisCemeApplyInfo.setIsReport("3");
			fisCemeApplyInfo.setComTime(DateUtil.getTime());
			ParameterSet pset1 = new ParameterSet();
			pset1.setParameter("CEME_APPLY_ID", (String) record.get("cemeApplyId"));
			DataSet infoDs = fisCemeApplyInfoDao.query(pset1);
			if (infoDs.getCount() > 0) {
			}
		} else if ("true".equals((String) wfMap.get("isEnd"))&& "1".equals(opinion.substring(0, 1))) {
			fisCemeApplyInfo.setApplyState("4");
			fisCemeApplyInfo.setIsReport("2");
			fisCemeApplyInfo.setComTime(DateUtil.getTime());
		}else if((String) wfMap.get("isEnd")==null){
			fisCemeApplyInfo.setCurActivity("公墓变更审核");
			fisCemeApplyInfo.setCurOrganCode(BspUtil.getParentOrgan().getOrganCode());
			fisCemeApplyInfo.setCurOrgan(BspUtil.getParentOrgan().getOrganName());
			fisCemeApplyInfo.setComTime(DateUtil.getTime());
			fisCemeApplyInfo.setIsReport("1");
		}
		fisCemeApplyInfoDao.update(fisCemeApplyInfo);
		if ("true".equals((String) wfMap.get("isEnd"))) {
			changeRecordBean.setIfConfirm("1");	
			fisCemeChangeDomain.update(changeRecordBean);
		}
	}
    
	public DataSet queryCeme(ParameterSet pset) {
		return fisCemeApplyInfoDao.queryCeme(pset);
	}
    //公墓业务，公墓信息联查
	public DataSet queryCemeApply(ParameterSet pset) {
		return fisCemeApplyInfoDao.queryCemeApply(pset);
	}
	//公益性公墓关闭流程发起
	public void cemeLogoffUpdate(ParameterSet pset) {
		String procDefUniqueId = "8a898be941058a390141059fb12f0002";
		String serviceName = "公益性公墓关闭审批流程";
		String cemeApplyId = (String) pset.getParameter("cemeApplyId");
		pset.clear();
		pset.setParameter("CEME_APPLY_ID",cemeApplyId);
		DataSet applyDs = fisCemeApplyInfoDao.query(pset);
		FisCemeApplyInfo fisCemeApplyInfo = (FisCemeApplyInfo)applyDs.getRecord(0).toBean(FisCemeApplyInfo.class);
		DataSet logoffDs = fisCemeLogoffDomain.query(pset);
		FisCemeLogoff fisCemeLogoff = (FisCemeLogoff) logoffDs.getRecord(0).toBean(FisCemeLogoff.class);
		//设置备案表相关参数
		fisCemeLogoff.setRegDate(DateUtil.getDay());
		//设置业务表相关参数
		fisCemeApplyInfo.setCurActivity("县级审批");
		fisCemeApplyInfo.setApplyState("0");//业务状态改为‘已受理’
		fisCemeApplyInfo.setIsReport("6");//设置上报状态为乡镇以上报
		fisCemeApplyInfo.setCurOrganCode(BspUtil.getParentOrgan().getOrganCode());//设置当前处理单位为上级民政局
		fisCemeApplyInfo.setCurOrgan(BspUtil.getParentOrgan().getOrganName());
		fisCemeApplyInfo.setRecTime(DateUtil.getDay());
		fisCemeApplyInfo.setWfId(procDefUniqueId);
		fisCemeApplyInfoDao.update(fisCemeApplyInfo);
		fisCemeLogoffDomain.update(fisCemeLogoff);
		// 通过流程唯一ID获得流程第一个环节ID
		String startActDefUniqueId = (String) WfQuery
				.getActDefInfoByProcDefUniqueIdAndActDefId(procDefUniqueId,
						"act1").get("actDefUniqueId");
		// 调用创建并发送流程接口
		CommandContext.setContextParameter("procDefUniqueId", procDefUniqueId);
		CommandContext.setContextParameter("startActDefUniqueId",
				startActDefUniqueId);
		Map<String, String> context = new HashMap<String, String>();
		String currentOrganName = BspUtil.getCorpOrgan().getOrganName();
		context.put("ORGANID", BspUtil.getParentStrId());
		context.put("CONDITION", "PASS");
		Map<String, String> map = WfTaskRequestWrapper.getInstance()
				.createAndSend(cemeApplyId, currentOrganName + serviceName,
						context);
	}
	//公益性公墓关闭审批
	public void cemeLogoffSubmit(ParameterSet pset) {
		Record fisCemeApplyRecord = (Record) pset.getParameter("fisCemeApplyRecord");
		Record historyRecord = (Record) pset.getParameter("historyRecord");
		String result = (String) pset.getParameter("result");
		String assignmentId = (String) pset.getParameter("assignmentId");
		String opinion = "";
		FisCemeApplyInfo fisCemeApplyInfo = (FisCemeApplyInfo) fisCemeApplyRecord.toBean(FisCemeApplyInfo.class);
		FisCemeLogoff fisCemeLogoff = new FisCemeLogoff();
		FisCemeCheckHistory fisCemeCheckHistory = (FisCemeCheckHistory) historyRecord.toBean(FisCemeCheckHistory.class);
		Map<String, String> context = new HashMap();
		//判断驳回，审批和上报，上报判断上报结果
		if(result.equals("submit")){
			Record fisCemeLogoffRecord = (Record) pset.getParameter("fisCemeLogoffRecord");
			fisCemeLogoff = (FisCemeLogoff) fisCemeLogoffRecord.toBean(FisCemeLogoff.class);
			if(fisCemeApplyInfo.getFirstResult().equals("2")){
				context.put("CONDITION","FILL");
			}else{
				context.put("CONDITION","END");
			}
		}else if(result.equals("reject")){
			context.put("CONDITION","FILL");
		}else{
			opinion = (String)pset.getParameter("opinion");
			Record fisCemeLogoffRecord = (Record) pset.getParameter("fisCemeLogoffRecord");
			fisCemeLogoff = (FisCemeLogoff) fisCemeLogoffRecord.toBean(FisCemeLogoff.class);
			if(!"".equals(opinion)&&"0".equals(opinion)){
				context.put("CONDITION","PASS");
			}else{
				context.put("CONDITION","END");
			}
		}
		pset.clear();
		pset.setParameter("RECORD_ID",fisCemeApplyInfo.getRecordId());
		DataSet cemeDs = fisCemeInfoDomain.query(pset);
		FisCemeInfo fisCemeInfo = (FisCemeInfo) cemeDs.getRecord(0).toBean(FisCemeInfo.class);
		CommandContext.setContextParameter("assignmentId", assignmentId);
		Map wfMap = WfTaskRequestWrapper.getInstance().send(context);
		if("true".equals((String)wfMap.get("isEnd"))&&"1".equals(opinion)){//补齐补正不同意，审批结束
			fisCemeApplyInfo.setApplyState("4");//业务状态改为‘审批不通过’		
    		fisCemeLogoff.setIfConfirm("1");
            fisCemeApplyInfo.setIsReport("15");//设置上报状态为乡镇终止
            fisCemeApplyInfo.setComTime(DateUtil.getDay());
            fisCemeApplyInfo.setCurActivity("审批结束");
            fisCemeLogoffDomain.update(fisCemeLogoff);
		}else if("true".equals((String)wfMap.get("isEnd"))&&"".equals(opinion)){//县级审批，审批结束
			fisCemeApplyInfo.setComTime(DateUtil.getDay());
			if(fisCemeApplyInfo.getFirstResult().equals("0")){
				fisCemeApplyInfo.setCurActivity("审批结束");
				fisCemeApplyInfo.setIsReport("7");
        		fisCemeInfo.setOrganState("3");
        		fisCemeApplyInfo.setApplyState("3");//业务状态改为‘审批通过’
        	}else if(fisCemeApplyInfo.getFirstResult().equals("1")){
        		fisCemeApplyInfo.setCurActivity("审批结束");
        		fisCemeApplyInfo.setIsReport("7");
        		fisCemeApplyInfo.setApplyState("4");//业务状态改为‘审批不通过’
        	}
		}else if((String)wfMap.get("isEnd")==null&&"".equals(opinion)){//县级驳回
			fisCemeApplyInfo.setCurActivity("补齐补正");
			fisCemeApplyInfo.setIsReport("8");
		}else if((String)wfMap.get("isEnd")==null&&"0".equals(opinion)){//乡镇补齐补正同意
			fisCemeApplyInfo.setCurActivity("县级审批");
			fisCemeApplyInfo.setIsReport("6");//设置上报状态为乡镇已上报
			fisCemeApplyInfo.setZeroUnit(BspUtil.getOrganName());//乡镇审核单位名称
			fisCemeApplyInfo.setZeroUnitId(BspUtil.getOrganCode());//乡镇审核单位ID
			fisCemeApplyInfo.setCurOrganCode(BspUtil.getParentOrgan().getOrganCode());//设置当前处理单位为上级民政局
			fisCemeApplyInfo.setCurOrgan(BspUtil.getParentOrgan().getOrganName());
			fisCemeApplyInfo.setRecTime(DateUtil.getDay());
		}
		fisCemeCheckHistory.setCreateTime(DateUtil.getTime());
		fisCemeCheckHistoryDomain.insert(fisCemeCheckHistory);
		fisCemeInfoDomain.update(fisCemeInfo);
		fisCemeApplyInfoDao.update(fisCemeApplyInfo);
		
	}
	//公益性公墓关闭业务删除
	public void cemeLogoffDelete(ParameterSet pset) {
	    String cemeApplyId = (String) pset.getParameter("cemeApplyId");
	    fisCemeApplyInfoDao.delete(cemeApplyId);
		fisCemeApplyInfoDao.cemeLogoffDelete(pset);
	}
	/*
	 * 公益性公墓申建流程发起环节
	 * @see com.inspur.cams.fis.base.domain.IFisCemeApplyInfoDomain#startCreate(java.lang.String)
	 */
		public void startCreate(String cemeApplyId){
			
			ParameterSet pset1 = new ParameterSet();
			pset1.setParameter("CEME_APPLY_ID@=",cemeApplyId);
			
			FisCemeApplyInfo fisCemeApplyInfo  =(FisCemeApplyInfo) fisCemeApplyInfoDao.query(pset1).getRecord(0).toBean(FisCemeApplyInfo.class);
			String currentOrganName = BspUtil.getCorpOrgan().getOrganName();
			String taskCode=cemeApplyId;
			String serviceName = "";
			String procDefUniqueId = "";
			if("14".equals(BspUtil.getOrganType())){
				serviceName = "公墓新建审批流程";
				procDefUniqueId = "8a898ca2408a3c1501408a50214c0008";
				
				fisCemeApplyInfo.setApplyState("0");
				fisCemeApplyInfo.setIsReport("6");			
				fisCemeApplyInfo.setRecTime(DateUtil.getTime());
				fisCemeApplyInfo.setFillOrganCode(BspUtil.getCorpOrganId());
				fisCemeApplyInfo.setFillOrganName(BspUtil.getOrganName());
				fisCemeApplyInfo.setWfId(procDefUniqueId);
				fisCemeApplyInfo.setCurActivity("县级审批");
				fisCemeApplyInfo.setCurOrgan(BspUtil.getParentOrgan().getOrganName());
				fisCemeApplyInfo.setCurOrganCode(BspUtil.getParentOrgan().getOrganCode());
			}else{
				serviceName = "市属公墓申建审批流程";
				procDefUniqueId = "8a898ca241ca272f0141ca2e6cca0004";
				fisCemeApplyInfo.setApplyState("0");
				fisCemeApplyInfo.setIsReport("9");			
				fisCemeApplyInfo.setRecTime(DateUtil.getTime());
				fisCemeApplyInfo.setFillOrganCode(BspUtil.getCorpOrganId());
				fisCemeApplyInfo.setFillOrganName(BspUtil.getOrganName());
				fisCemeApplyInfo.setWfId(procDefUniqueId);
				fisCemeApplyInfo.setCurActivity("省级审批");
				fisCemeApplyInfo.setCurOrgan(BspUtil.getParentOrgan().getOrganName());
				fisCemeApplyInfo.setCurOrganCode(BspUtil.getParentOrgan().getOrganCode());
				System.out.println(BspUtil.getParentStrId());

			}
			
			//CommandContext.setContextParameter("assignmentId",assignmentId);
			String startActDefUniqueId = (String)WfQuery.getActDefInfoByProcDefUniqueIdAndActDefId(procDefUniqueId,"act1").get("actDefUniqueId");
			CommandContext.setContextParameter("procDefUniqueId",procDefUniqueId);
			CommandContext.setContextParameter("startActDefUniqueId",startActDefUniqueId);
			Map<String, String> context = new HashMap<String, String>();

			context.put("ORGANID", BspUtil.getParentStrId());
			context.put("CONDITION","PASS");
			Map<String, String> map = WfTaskRequestWrapper.getInstance().createAndSend(cemeApplyId, currentOrganName + serviceName, context);

			
			fisCemeApplyInfoDao.update(fisCemeApplyInfo);	
		}
		/*
		 * 公益性公墓申建流程_审批环节
		 * @see com.inspur.cams.fis.base.domain.IFisCemeApplyInfoDomain#sendOfCreate(com.inspur.cams.fis.base.data.FisCemeApplyInfo, java.lang.String, java.lang.String)
		 */
		
		public void sendOfCreate(FisCemeApplyInfo fisCemeApplyInfo,String result,String assignmentId){
			Map context = new HashMap();
			CommandContext.setContextParameter("assignmentId",assignmentId);
			String cemeApplyId=fisCemeApplyInfo.getCemeApplyId();
			ParameterSet pset1 = new ParameterSet();
			pset1.setParameter("RECORD_ID@=",fisCemeApplyInfo.getRecordId());
			FisCemeInfo fisCemeInfo  =(FisCemeInfo) fisCemeInfoDao.query(pset1).getRecord(0).toBean(FisCemeInfo.class);
	
//			ParameterSet pset1 = new ParameterSet();
			if("14".equals(BspUtil.getOrganType())){
				if("1".equals(result)){
					context.put("ORGANID", BspUtil.getParentStrId());
					context.put("CONDITION","PASS");//审批结束
					fisCemeApplyInfo.setApplyState("1");
					fisCemeApplyInfo.setIsReport("6");
					fisCemeApplyInfo.setCurOrgan(BspUtil.getParentOrgan().getOrganName());
					fisCemeApplyInfo.setCurOrganCode(BspUtil.getParentOrgan().getOrganCode());
					fisCemeApplyInfo.setCurActivity("县级审批");
				}else if("2".equals(result)){
					context.put("CONDITION","FAILD");//流程走向结束
					context.put("ORGANID", BspUtil.getDeptStruId());
					fisCemeApplyInfo.setIsReport("15");			
					fisCemeApplyInfo.setApplyState("5");
					fisCemeApplyInfo.setCurActivity("审批结束");
					fisCemeApplyInfo.setCurOrgan(BspUtil.getOrganName());
					fisCemeApplyInfo.setCurOrganCode(BspUtil.getOrganCode());
					fisCemeApplyInfo.setComTime(DateUtil.getTime());
				}				
			}else if("13".equals(BspUtil.getOrganType())){
				if("1".equals(result)){
					context.put("ORGANID", BspUtil.getParentStrId());
					context.put("CONDITION","PASS");//审批结束
					fisCemeApplyInfo.setApplyState("3");
					fisCemeApplyInfo.setIsReport("7");			
					fisCemeApplyInfo.setCurActivity("审批结束");
					fisCemeApplyInfo.setCurOrgan(BspUtil.getOrganName());
					fisCemeApplyInfo.setCurOrganCode(BspUtil.getOrganCode());
					fisCemeApplyInfo.setComTime(DateUtil.getTime());
					fisCemeInfo.setOrganState("0");
					fisCemeInfo.setApproveTime(DateUtil.getTime());
					

				}else if("2".equals(result)){
					context.put("CONDITION","FAILD");//流程走向结束
					context.put("ORGANID", BspUtil.getDeptStruId());
					fisCemeApplyInfo.setIsReport("12");			
					fisCemeApplyInfo.setApplyState("4");
					fisCemeApplyInfo.setCurActivity("审批结束");
					fisCemeApplyInfo.setCurOrgan(BspUtil.getOrganName());
					fisCemeApplyInfo.setCurOrganCode(BspUtil.getOrganCode());
					fisCemeApplyInfo.setComTime(DateUtil.getTime());

				}else if("3".equals(result)){
					
					context.put("CONDITION","BUQI");//流程走补齐补正
					/* pset1.setParameter("cemeApplyId",cemeApplyId);
					 * pset1.setParameter("actDefName","乡镇申请受理");
					 * Record OrganInfo=(Record) fisCemeApplyInfoDao.queryPreOrganId(pset1).getRecord(0);
					 * fisCemeApplyInfo.setCurOrgan((String) OrganInfo.get("ORGAN_NAME"));
					 * fisCemeApplyInfo.setCurOrganCode((String) OrganInfo.get("ORGAN_ID"));
					*/
					fisCemeApplyInfo.setCurOrganCode(fisCemeApplyInfo.getZeroUnitId());
					fisCemeApplyInfo.setCurOrgan(fisCemeApplyInfo.getZeroUnit());
					fisCemeApplyInfo.setApplyState("2");
					fisCemeApplyInfo.setIsReport("8");			
					fisCemeApplyInfo.setRecTime(DateUtil.getTime());
					fisCemeApplyInfo.setCurActivity("补齐补正");
				}
			}else if("12".equals(BspUtil.getOrganType())){
				if("1".equals(result)){
					context.put("ORGANID", BspUtil.getParentStrId());
					context.put("CONDITION","PASS");//审批结束
					fisCemeApplyInfo.setApplyState("1");
					fisCemeApplyInfo.setIsReport("1");
					fisCemeApplyInfo.setCurOrgan(BspUtil.getParentOrgan().getOrganName());
					fisCemeApplyInfo.setCurOrganCode(BspUtil.getParentOrgan().getOrganCode());
					fisCemeApplyInfo.setCurActivity("省级审批");
				}else if("2".equals(result)){
					context.put("CONDITION","FAILD");//流程走向结束
					context.put("ORGANID", BspUtil.getDeptStruId());
					fisCemeApplyInfo.setIsReport("13");			
					fisCemeApplyInfo.setApplyState("5");
					fisCemeApplyInfo.setCurActivity("审批结束");
					fisCemeApplyInfo.setCurOrgan(BspUtil.getOrganName());
					fisCemeApplyInfo.setCurOrganCode(BspUtil.getOrganCode());
					fisCemeApplyInfo.setComTime(DateUtil.getTime());
				}				
			}else if("11".equals(BspUtil.getOrganType())){
				if("1".equals(result)){
					context.put("ORGANID", BspUtil.getParentStrId());
					context.put("CONDITION","PASS");//审批结束
					fisCemeApplyInfo.setApplyState("3");
					fisCemeApplyInfo.setIsReport("3");			
					fisCemeApplyInfo.setCurActivity("审批结束");
					fisCemeApplyInfo.setCurOrgan(BspUtil.getOrganName());
					fisCemeApplyInfo.setCurOrganCode(BspUtil.getOrganCode());
					fisCemeApplyInfo.setComTime(DateUtil.getTime());
					fisCemeInfo.setOrganState("4");
					fisCemeInfo.setApproveTime(DateUtil.getTime());

				}else if("2".equals(result)){
					context.put("CONDITION","FAILD");//流程走向结束
					context.put("ORGANID", BspUtil.getDeptStruId());
					fisCemeApplyInfo.setIsReport("14");			
					fisCemeApplyInfo.setApplyState("4");
					fisCemeApplyInfo.setCurActivity("审批结束");
					fisCemeApplyInfo.setCurOrgan(BspUtil.getOrganName());
					fisCemeApplyInfo.setCurOrganCode(BspUtil.getOrganCode());
					fisCemeApplyInfo.setComTime(DateUtil.getTime());

				}else if("3".equals(result)){
					context.put("CONDITION","BUQI");//流程走补齐补正
					fisCemeApplyInfo.setCurOrganCode(fisCemeApplyInfo.getZeroUnitId());
					fisCemeApplyInfo.setCurOrgan(fisCemeApplyInfo.getZeroUnit());
					fisCemeApplyInfo.setApplyState("2");
					fisCemeApplyInfo.setIsReport("11");
					fisCemeApplyInfo.setRecTime(DateUtil.getTime());
					fisCemeApplyInfo.setCurActivity("补齐补正");
				}
			}
			
			fisCemeApplyInfo.setRecTime(DateUtil.getTime());
			Map wfMap = WfTaskRequestWrapper.getInstance().send(context);
			fisCemeApplyInfoDao.update(fisCemeApplyInfo);
			fisCemeInfoDao.update(fisCemeInfo);
			 
			
		}
		/*
		 * 经营性公墓新建流程发起环节
		 * @see com.inspur.cams.fis.base.domain.IFisCemeApplyInfoDomain#startCreateOperation(java.lang.String)
		 */
		public void startCreateOperation(String cemeApplyId){
			
			ParameterSet pset1 = new ParameterSet();
			pset1.setParameter("CEME_APPLY_ID@=",cemeApplyId);
			
			FisCemeApplyInfo fisCemeApplyInfo  =(FisCemeApplyInfo) fisCemeApplyInfoDao.query(pset1).getRecord(0).toBean(FisCemeApplyInfo.class);
			
			String taskCode=cemeApplyId;
			String serviceName = "经营性公墓新建审批流程";
			
			String procDefUniqueId = "8a898ca2409e43ab01409ea490770059";
			String startActDefUniqueId = (String)WfQuery.getActDefInfoByProcDefUniqueIdAndActDefId(procDefUniqueId,"act1").get("actDefUniqueId");
			CommandContext.setContextParameter("procDefUniqueId",procDefUniqueId);
			CommandContext.setContextParameter("startActDefUniqueId",startActDefUniqueId);

			Map<String, String> context = new HashMap<String, String>();
			String currentOrganName = BspUtil.getCorpOrgan().getOrganName();
			context.put("ORGANID", BspUtil.getParentStrId());
			context.put("CONDITION","PASS");
			Map<String, String> map = WfTaskRequestWrapper.getInstance().createAndSend(cemeApplyId, currentOrganName + serviceName, context);
			
			//fisCemeApplyInfo.setApplyState("0");
			fisCemeApplyInfo.setIsReport("0");		
			fisCemeApplyInfo.setRecTime(DateUtil.getTime());
			fisCemeApplyInfo.setFillOrganCode(BspUtil.getCorpOrganId());
			fisCemeApplyInfo.setFillOrganName(BspUtil.getOrganName());
			fisCemeApplyInfo.setWfId(procDefUniqueId);
			fisCemeApplyInfo.setCurActivity("市级审核");
			fisCemeApplyInfo.setCurOrgan(BspUtil.getParentOrgan().getOrganName());
			fisCemeApplyInfo.setCurOrganCode(BspUtil.getParentOrgan().getOrganCode());
			fisCemeApplyInfoDao.update(fisCemeApplyInfo);	
		}
		/*
		 * 经营性公墓新建流程审核_审批_驳回环节
		 * @see com.inspur.cams.fis.base.domain.IFisCemeApplyInfoDomain#sendOfCreateOperation(com.inspur.cams.fis.base.data.FisCemeApplyInfo, java.lang.String, java.lang.String)
		 */
		public void sendOfCreateOperation(FisCemeApplyInfo fisCemeApplyInfo,String result,String assignmentId){
			ParameterSet pset1 = new ParameterSet();
			pset1.setParameter("RECORD_ID@=",fisCemeApplyInfo.getRecordId());
			FisCemeInfo fisCemeInfo  =(FisCemeInfo) fisCemeInfoDao.query(pset1).getRecord(0).toBean(FisCemeInfo.class);
			
			Map context = new HashMap();
			CommandContext.setContextParameter("assignmentId",assignmentId);
			if("13".equals(BspUtil.getOrganType())){
				if("1".equals(result)){
					context.put("ORGANID", BspUtil.getParentStrId());
					context.put("CONDITION","PASS");
					fisCemeApplyInfo.setIsReport("0");		
					fisCemeApplyInfo.setApplyState("1");
					fisCemeApplyInfo.setCurActivity("市级审核");
					fisCemeApplyInfo.setCurOrgan(BspUtil.getParentOrgan().getOrganName());
					fisCemeApplyInfo.setCurOrganCode(BspUtil.getParentOrgan().getOrganCode());
				}else if("2".equals(result)){
					context.put("CONDITION","FAILD");//流程走向结束
					fisCemeApplyInfo.setApplyState("4");
					fisCemeApplyInfo.setCurActivity("审批结束");
					fisCemeApplyInfo.setIsReport("12");		

					context.put("ORGANID", BspUtil.getDeptStruId());
					fisCemeApplyInfo.setCurOrgan(fisCemeApplyInfo.getFirstUnit());
					fisCemeApplyInfo.setCurOrganCode(fisCemeApplyInfo.getFirstUnitId());
					fisCemeApplyInfo.setComTime(DateUtil.getTime());
				}					
			}
			if("12".equals(BspUtil.getOrganType())){
				if("1".equals(result)){
					context.put("ORGANID", BspUtil.getParentStrId());
					context.put("CONDITION","PASS");//审批结束
					fisCemeApplyInfo.setApplyState("1");
					fisCemeApplyInfo.setIsReport("1");		

					fisCemeApplyInfo.setCurActivity("省级审批");
					fisCemeApplyInfo.setCurOrgan(BspUtil.getParentOrgan().getOrganName());
					fisCemeApplyInfo.setCurOrganCode(BspUtil.getParentOrgan().getOrganCode());

				}else if("2".equals(result)){
					context.put("CONDITION","FAILD");//流程走向结束
					fisCemeApplyInfo.setIsReport("13");		
					fisCemeApplyInfo.setApplyState("4");
					fisCemeApplyInfo.setCurActivity("审批结束");
					context.put("ORGANID", BspUtil.getDeptStruId());
					fisCemeApplyInfo.setCurOrgan(BspUtil.getOrganName());
					fisCemeApplyInfo.setCurOrganCode(BspUtil.getOrganCode());
					fisCemeApplyInfo.setComTime(DateUtil.getTime());

				}else if("3".equals(result)){
					context.put("CONDITION","BUQI");//流程走补齐补正
					fisCemeApplyInfo.setApplyState("2");
					fisCemeApplyInfo.setIsReport("2");		
					context.put("ORGANID",BspUtil.getCorpOrgan().getOrganId());
					fisCemeApplyInfo.setCurOrgan(fisCemeApplyInfo.getFirstUnit());
					fisCemeApplyInfo.setCurOrganCode(fisCemeApplyInfo.getFirstUnitId());
					fisCemeApplyInfo.setCurActivity("县级补齐补正");
				}		
			}
			if("11".equals(BspUtil.getOrganType())){
				if("1".equals(result)){
					context.put("ORGANID", BspUtil.getParentStrId());
					context.put("CONDITION","PASS");//审批结束
					fisCemeApplyInfo.setIsReport("3");		
					fisCemeApplyInfo.setApplyState("3");
					fisCemeApplyInfo.setCurActivity("审批通过");
					fisCemeApplyInfo.setCurOrgan(BspUtil.getParentOrgan().getOrganName());
					fisCemeApplyInfo.setCurOrganCode(BspUtil.getParentOrgan().getOrganCode());
					fisCemeApplyInfo.setComTime(DateUtil.getTime());
					fisCemeInfo.setOrganState("4");
					fisCemeInfo.setApproveTime(DateUtil.getTime());

				}else if("2".equals(result)){
					context.put("CONDITION","FAILD");//流程走向结束
					fisCemeApplyInfo.setIsReport("14");		
					fisCemeApplyInfo.setApplyState("4");
					fisCemeApplyInfo.setCurActivity("审批结束");
					context.put("ORGANID", BspUtil.getDeptStruId());
					fisCemeApplyInfo.setCurOrgan(BspUtil.getOrganName());
					fisCemeApplyInfo.setCurOrganCode(BspUtil.getOrganCode());
					fisCemeApplyInfo.setComTime(DateUtil.getTime());

				}else if("3".equals(result)){
					context.put("CONDITION","BUQI");//流程走补齐补正
					fisCemeApplyInfo.setApplyState("2");
					fisCemeApplyInfo.setIsReport("11");		
					context.put("ORGANID",BspUtil.getCorpOrgan().getOrganId());
					fisCemeApplyInfo.setCurOrgan(fisCemeApplyInfo.getSecondUnit());
					fisCemeApplyInfo.setCurOrganCode(fisCemeApplyInfo.getSecondUnitId());
					fisCemeApplyInfo.setCurActivity("市级补齐补正");
				}		
			}
			fisCemeApplyInfo.setRecTime(DateUtil.getTime());		

			Map wfMap = WfTaskRequestWrapper.getInstance().send(context);
			fisCemeApplyInfoDao.update(fisCemeApplyInfo);
			fisCemeInfoDao.update(fisCemeInfo);
		}
		public void cemeChangeDelete(ParameterSet pset) {
			String cemeApplyId = (String) pset.getParameter("cemeApplyId");
			fisCemeApplyInfoDao.delete(cemeApplyId);
			pset.clear();
			pset.setParameter("CEME_APPLY_ID", cemeApplyId);
			DataSet infoDs = fisCemeChangeDomain.query(pset);
			FisCemeChange changeRecordBean = (FisCemeChange) infoDs.getRecord(0)
					.toBean(FisCemeChange.class);
			fisCemeChangeDetailDomain.deleteByChangeId(changeRecordBean.getChangeId());
			fisCemeChangeDomain.delete(changeRecordBean.getChangeId());
		}
		
		public DataSet queryAccessories(ParameterSet pset) {
			return fisCemeAccessoriesDao.queryAccessories(pset);
		}
		
		public DataSet queryAccessoryType(ParameterSet pset) {
			return fisCemeAccessoriesDao.queryAccessoryType(pset);
		}
		
		public DataSet queryAccessoriesItem(ParameterSet pset) {
			return fisCemeAccessoriesDao.queryAccessoriesItem(pset);
		}
		public void uploadSave(List<FisCemeAccessories> list) {
			fisCemeAccessoriesDao.batchInsert(list);
		}
		public void delAccessoriesById(String id) {
			fisCemeAccessoriesDao.delete(id);
		}
		public DataSet queryByCurActicity(ParameterSet pset) {
			return fisCemeApplyInfoDao.queryByCurActicity(pset);
		}
		public void deleteCreate(ParameterSet pset){
			fisCemeApplyInfoDao.deleteCreate(pset);
		}
		public void deleteExpend(ParameterSet pset){
			fisCemeApplyInfoDao.deleteExpend(pset);
		}
		/*
		 * 公益性公墓变更流程_审批_驳回环节
		 * @see com.inspur.cams.fis.base.domain.IFisCemeApplyInfoDomain#sendPublicChange
		 */
		public void sendPublicChange(ParameterSet pset) {
			Record record = (Record) pset.getParameter("record");
			String opinion = (String) pset.getParameter("opinion");
			String assignmentId = (String) pset.getParameter("assignmentId");
			FisCemeApplyInfo fisCemeApplyInfo = (FisCemeApplyInfo) record.toBean(FisCemeApplyInfo.class);
			Map context = new HashMap();
			context.put("ORGANID", BspUtil.getParentStrId());
			// 判定流程走向
			if (!"".equals(opinion) && "0".equals(opinion)) {
				context.put("CONDITION", "PAST");
			} else if("1".equals(opinion)){
				context.put("CONDITION", "NO");
			}else if("3".equals(opinion)){
				context.put("CONDITION", "BUQI");
			}
			CommandContext.setContextParameter("assignmentId", assignmentId);
			Map wfMap = WfTaskRequestWrapper.getInstance().send(context);
			
			ParameterSet pset2 = new ParameterSet();
			pset2.setParameter("CEME_APPLY_ID", (String) record.get("cemeApplyId"));
			DataSet infoDs2 = fisCemeChangeDomain.query(pset2);
			FisCemeChange changeRecordBean = (FisCemeChange) infoDs2.getRecord(0).toBean(FisCemeChange.class);
			ParameterSet pset3 = new ParameterSet();
			pset3.setParameter("CHANGE_ID@=", changeRecordBean.getChangeId());
			DataSet changeRecordDetailDs = fisCemeChangeDetailDomain.query(pset3);
			
			if ("true".equals((String) wfMap.get("isEnd")) && "0".equals(opinion)) {
				
				Map map = new HashMap();
				String manaLevelId = "";
				for (int i = 0; i < changeRecordDetailDs.getCount(); i++) {
					Record r = changeRecordDetailDs.getRecord(i);
					map.put(r.get("itemCode"), r.get("itemAfter"));
					if(r.get("itemCode").equals("0")){
						manaLevelId=(String)r.get("itemName");
					}
				}
				ParameterSet psStatus = new ParameterSet();
				psStatus.setParameter("RECORD_ID@=", changeRecordBean.getRecordId());
				DataSet dsStatus = fisCemeInfoDomain.query(psStatus);
				FisCemeInfo bean = (FisCemeInfo) dsStatus.getRecord(0).toBean(FisCemeInfo.class);
				Iterator it = map.entrySet().iterator();
				while (it.hasNext()) {
					Entry obj = (Entry) it.next();
					if (((String) obj.getKey()).equals("0")) {
						bean.setManaLevel((String) obj.getValue());
					} else if (((String) obj.getKey()).equals("1")) {
						bean.setOrganizer((String) obj.getValue());
					} 
				}
				if(StringUtils.isNotEmpty(manaLevelId)){
					bean.setManaLevelId(manaLevelId);
				}
				fisCemeInfoDomain.update(bean);			
				// 修改业务状态标志
				fisCemeApplyInfo.setCurActivity("审批结束");
				fisCemeApplyInfo.setApplyState("3");//审批通过
				fisCemeApplyInfo.setIsReport("7");//县级已审批
				fisCemeApplyInfo.setComTime(DateUtil.getTime());
				fisCemeApplyInfo.setCurOrganCode(BspUtil.getOrganCode());
				fisCemeApplyInfo.setCurOrgan(BspUtil.getOrganName());
				ParameterSet pset1 = new ParameterSet();
				pset1.setParameter("CEME_APPLY_ID", (String) record.get("cemeApplyId"));
				DataSet infoDs = fisCemeApplyInfoDao.query(pset1);
				if (infoDs.getCount() > 0) {
				}
			} else if ("true".equals((String) wfMap.get("isEnd"))&& "1".equals(opinion.substring(0, 1))) {
				fisCemeApplyInfo.setCurActivity("审批结束");
				fisCemeApplyInfo.setCurOrganCode(BspUtil.getOrganCode());
				fisCemeApplyInfo.setCurOrgan(BspUtil.getOrganName());
				fisCemeApplyInfo.setApplyState("4");//审批未通过
				if("13".equals(BspUtil.getOrganType())){
					fisCemeApplyInfo.setIsReport("12");//县级终止
				}else{
					fisCemeApplyInfo.setIsReport("15");//县级终止
				}
				fisCemeApplyInfo.setComTime(DateUtil.getTime());
			}else if((String) wfMap.get("isEnd")==null&& "3".equals(opinion.substring(0, 1))){
				fisCemeApplyInfo.setCurActivity("乡镇补齐补正");
				fisCemeApplyInfo.setCurOrganCode(fisCemeApplyInfo.getFirstUnitId());
				fisCemeApplyInfo.setCurOrgan(fisCemeApplyInfo.getZeroUnit());
				fisCemeApplyInfo.setComTime(DateUtil.getTime());
				fisCemeApplyInfo.setIsReport("8");//县级已驳回
				fisCemeApplyInfo.setApplyState("4");//审批未通过
			}else if((String) wfMap.get("isEnd")==null&& "0".equals(opinion.substring(0, 1))){
				fisCemeApplyInfo.setCurActivity("县级审批");
				fisCemeApplyInfo.setCurOrganCode(BspUtil.getParentOrgan().getOrganCode());
				fisCemeApplyInfo.setCurOrgan(BspUtil.getParentOrgan().getOrganName());
				fisCemeApplyInfo.setComTime(DateUtil.getTime());
				fisCemeApplyInfo.setIsReport("6");//乡镇已上报
				fisCemeApplyInfo.setApplyState("1");//检查通过

			}
			fisCemeApplyInfoDao.update(fisCemeApplyInfo);
			if ("true".equals((String) wfMap.get("isEnd"))) {
				changeRecordBean.setIfConfirm("1");	
				fisCemeChangeDomain.update(changeRecordBean);
			}
		}
		
		public void startCreateExpendOp(String cemeApplyId){
			ParameterSet pset1 = new ParameterSet();
			pset1.setParameter("CEME_APPLY_ID@=",cemeApplyId);
			
			FisCemeApplyInfo fisCemeApplyInfo  =(FisCemeApplyInfo) fisCemeApplyInfoDao.query(pset1).getRecord(0).toBean(FisCemeApplyInfo.class);
			/*将公墓的OrganState 置成5 ，申请扩建*/
			pset1.clear();
			pset1.setParameter("RECORD_ID@=",fisCemeApplyInfo.getRecordId());
			FisCemeExpendInfo fisCemeExpendInfo =(FisCemeExpendInfo) fisCemeExpendInfoDao.query(pset1).getRecord(0).toBean(FisCemeExpendInfo.class);
			pset1.clear();
			pset1.setParameter("RECORD_ID@=",fisCemeExpendInfo.getCemeId());
			FisCemeInfo fisCemeInfo  =(FisCemeInfo) fisCemeInfoDao.query(pset1).getRecord(0).toBean(FisCemeInfo.class);
			
			String taskCode=cemeApplyId;
			String serviceName = "县属经营性公墓扩建审批流程";
			
			String procDefUniqueId = "8a898ca2416d56a701416d62af490006";
			String startActDefUniqueId = (String)WfQuery.getActDefInfoByProcDefUniqueIdAndActDefId(procDefUniqueId,"act1").get("actDefUniqueId");
			CommandContext.setContextParameter("procDefUniqueId",procDefUniqueId);
			CommandContext.setContextParameter("startActDefUniqueId",startActDefUniqueId);

			Map<String, String> context = new HashMap<String, String>();
			String currentOrganName = BspUtil.getCorpOrgan().getOrganName();
			context.put("ORGANID", BspUtil.getParentStrId());
			context.put("CONDITION","PASS");
			Map<String, String> map = WfTaskRequestWrapper.getInstance().createAndSend(cemeApplyId, currentOrganName + serviceName, context);
			
			//fisCemeApplyInfo.setApplyState("0");
			fisCemeApplyInfo.setIsReport("0");		
			fisCemeApplyInfo.setRecTime(DateUtil.getTime());
			fisCemeApplyInfo.setFillOrganCode(BspUtil.getCorpOrganId());
			fisCemeApplyInfo.setFillOrganName(BspUtil.getOrganName());
			fisCemeApplyInfo.setWfId(procDefUniqueId);
			fisCemeApplyInfo.setCurActivity("市级审核");
			fisCemeApplyInfo.setCurOrgan(BspUtil.getParentOrgan().getOrganName());
			fisCemeApplyInfo.setCurOrganCode(BspUtil.getParentOrgan().getOrganCode());
			fisCemeApplyInfoDao.update(fisCemeApplyInfo);	
			
			fisCemeInfo.setOrganState("5");
			fisCemeInfoDao.update(fisCemeInfo);
		}
		/*
		 * 经营性公墓新建流程审核_审批_驳回环节
		 * @see com.inspur.cams.fis.base.domain.IFisCemeApplyInfoDomain#sendOfCreateOperation(com.inspur.cams.fis.base.data.FisCemeApplyInfo, java.lang.String, java.lang.String)
		 */
		public void sendOfExpendOp(FisCemeApplyInfo fisCemeApplyInfo,String result,String assignmentId){
			Map context = new HashMap();
			CommandContext.setContextParameter("assignmentId",assignmentId);
			if("13".equals(BspUtil.getOrganType())){
				if("1".equals(result)){
					context.put("ORGANID", BspUtil.getParentStrId());
					context.put("CONDITION","PASS");
					fisCemeApplyInfo.setIsReport("0");		
					fisCemeApplyInfo.setApplyState("1");
					fisCemeApplyInfo.setCurActivity("市级审核");
					fisCemeApplyInfo.setCurOrgan(BspUtil.getParentOrgan().getOrganName());
					fisCemeApplyInfo.setCurOrganCode(BspUtil.getParentOrgan().getOrganCode());
				}else if("2".equals(result)){
					context.put("CONDITION","FAILD");//流程走向结束
					fisCemeApplyInfo.setApplyState("4");
					fisCemeApplyInfo.setCurActivity("审批结束");
					fisCemeApplyInfo.setIsReport("12");		

					context.put("ORGANID", BspUtil.getDeptStruId());
					fisCemeApplyInfo.setCurOrgan(fisCemeApplyInfo.getFirstUnit());
					fisCemeApplyInfo.setCurOrganCode(fisCemeApplyInfo.getFirstUnitId());
					fisCemeApplyInfo.setComTime(DateUtil.getTime());
				}					
			}
			if("12".equals(BspUtil.getOrganType())){
				if("1".equals(result)){
					context.put("ORGANID", BspUtil.getParentStrId());
					context.put("CONDITION","PASS");//审批结束
					fisCemeApplyInfo.setApplyState("1");
					fisCemeApplyInfo.setIsReport("1");		

					fisCemeApplyInfo.setCurActivity("省级审批");
					fisCemeApplyInfo.setCurOrgan(BspUtil.getParentOrgan().getOrganName());
					fisCemeApplyInfo.setCurOrganCode(BspUtil.getParentOrgan().getOrganCode());

				}else if("2".equals(result)){
					context.put("CONDITION","FAILD");//流程走向结束
					fisCemeApplyInfo.setIsReport("13");		
					fisCemeApplyInfo.setApplyState("4");
					fisCemeApplyInfo.setCurActivity("审批结束");
					context.put("ORGANID", BspUtil.getDeptStruId());
					fisCemeApplyInfo.setCurOrgan(BspUtil.getOrganName());
					fisCemeApplyInfo.setCurOrganCode(BspUtil.getOrganCode());
					fisCemeApplyInfo.setComTime(DateUtil.getTime());

				}else if("3".equals(result)){
					context.put("CONDITION","BUQI");//流程走补齐补正
					fisCemeApplyInfo.setApplyState("2");
					fisCemeApplyInfo.setIsReport("2");		
					context.put("ORGANID",BspUtil.getCorpOrgan().getOrganId());
					fisCemeApplyInfo.setCurOrgan(fisCemeApplyInfo.getFirstUnit());
					fisCemeApplyInfo.setCurOrganCode(fisCemeApplyInfo.getFirstUnitId());
					fisCemeApplyInfo.setCurActivity("县级补齐补正");
				}		
			}
			if("11".equals(BspUtil.getOrganType())){
				if("1".equals(result)){
					context.put("ORGANID", BspUtil.getParentStrId());
					context.put("CONDITION","PASS");//审批结束
					fisCemeApplyInfo.setIsReport("3");		
					fisCemeApplyInfo.setApplyState("3");
					fisCemeApplyInfo.setCurActivity("审批结束");
					fisCemeApplyInfo.setCurOrgan(BspUtil.getParentOrgan().getOrganName());
					fisCemeApplyInfo.setCurOrganCode(BspUtil.getParentOrgan().getOrganCode());
					fisCemeApplyInfo.setComTime(DateUtil.getTime());
//					addCeme(fisCemeApplyInfo.getRecordId());
//					fisCemeInfo.setOrganState("0");
					/*将公墓的OrganState 置成6 ，正在扩建*/
					ParameterSet pset1 = new ParameterSet();
					pset1.setParameter("RECORD_ID@=",fisCemeApplyInfo.getRecordId());
					FisCemeExpendInfo fisCemeExpendInfo =(FisCemeExpendInfo) fisCemeExpendInfoDao.query(pset1).getRecord(0).toBean(FisCemeExpendInfo.class);
					fisCemeExpendInfo.setOrganState("6");
					fisCemeExpendInfoDao.update(fisCemeExpendInfo);
					pset1.clear();
					pset1.setParameter("RECORD_ID@=",fisCemeExpendInfo.getCemeId());
					FisCemeInfo fisCemeInfo  =(FisCemeInfo) fisCemeInfoDao.query(pset1).getRecord(0).toBean(FisCemeInfo.class);
					fisCemeInfo.setOrganState("6");
					fisCemeInfoDao.update(fisCemeInfo);

				}else if("2".equals(result)){
					context.put("CONDITION","FAILD");//流程走向结束
					fisCemeApplyInfo.setIsReport("14");		
					fisCemeApplyInfo.setApplyState("4");
					fisCemeApplyInfo.setCurActivity("审批结束");
					context.put("ORGANID", BspUtil.getDeptStruId());
					fisCemeApplyInfo.setCurOrgan(BspUtil.getOrganName());
					fisCemeApplyInfo.setCurOrganCode(BspUtil.getOrganCode());
					fisCemeApplyInfo.setComTime(DateUtil.getTime());

				}else if("3".equals(result)){
					context.put("CONDITION","BUQI");//流程走补齐补正
					fisCemeApplyInfo.setApplyState("2");
					fisCemeApplyInfo.setIsReport("11");		
					context.put("ORGANID",BspUtil.getCorpOrgan().getOrganId());
					fisCemeApplyInfo.setCurOrgan(fisCemeApplyInfo.getSecondUnit());
					fisCemeApplyInfo.setCurOrganCode(fisCemeApplyInfo.getSecondUnitId());
					fisCemeApplyInfo.setCurActivity("市级补齐补正");
				}		
			}
			fisCemeApplyInfo.setRecTime(DateUtil.getTime());		

			Map wfMap = WfTaskRequestWrapper.getInstance().send(context);
			fisCemeApplyInfoDao.update(fisCemeApplyInfo);
		}
		
		/*
		 * 公益性公墓+经营性公墓 扩建流程发起环节
		 * @see com.inspur.cams.fis.base.domain.IFisCemeApplyInfoDomain#startOfExpend(java.lang.String)
		 */
			public void startOfExpend(String cemeApplyId){
				
				ParameterSet pset1 = new ParameterSet();
				pset1.setParameter("CEME_APPLY_ID@=",cemeApplyId);
				
				FisCemeApplyInfo fisCemeApplyInfo  =(FisCemeApplyInfo) fisCemeApplyInfoDao.query(pset1).getRecord(0).toBean(FisCemeApplyInfo.class);
				pset1.clear();
				pset1.setParameter("RECORD_ID@=",fisCemeApplyInfo.getRecordId());
				FisCemeExpendInfo fisCemeExpendInfo =(FisCemeExpendInfo) fisCemeExpendInfoDao.query(pset1).getRecord(0).toBean(FisCemeExpendInfo.class);
				pset1.clear();
				pset1.setParameter("RECORD_ID@=",fisCemeExpendInfo.getCemeId());
				FisCemeInfo fisCemeInfo  =(FisCemeInfo) fisCemeInfoDao.query(pset1).getRecord(0).toBean(FisCemeInfo.class);
				
				
				String currentOrganName=BspUtil.getOrganName();
				
				String taskCode=cemeApplyId;
				String serviceName = "";
				String procDefUniqueId = "";
				if("14".equals(BspUtil.getOrganType())){
					serviceName = "公益性公墓扩建审批流程";
					procDefUniqueId = "8a898ca241a0046c0141a0204514000e";
					
					fisCemeApplyInfo.setApplyState("0");
					fisCemeApplyInfo.setIsReport("6");			
					fisCemeApplyInfo.setRecTime(DateUtil.getTime());
					fisCemeApplyInfo.setFillOrganCode(BspUtil.getCorpOrganId());
					fisCemeApplyInfo.setFillOrganName(BspUtil.getOrganName());
					fisCemeApplyInfo.setWfId(procDefUniqueId);
					fisCemeApplyInfo.setCurActivity("县级审批");
					fisCemeApplyInfo.setCurOrgan(BspUtil.getParentOrgan().getOrganName());
					fisCemeApplyInfo.setCurOrganCode(BspUtil.getParentOrgan().getOrganCode());
				}else{
					serviceName = "市属公墓扩建审核审批流程";
					procDefUniqueId = "8a898ca2416d56a701416d6fc5310096";
					fisCemeApplyInfo.setApplyState("0");
					fisCemeApplyInfo.setIsReport("9");			
					fisCemeApplyInfo.setRecTime(DateUtil.getTime());
					fisCemeApplyInfo.setFillOrganCode(BspUtil.getCorpOrganId());
					fisCemeApplyInfo.setFillOrganName(BspUtil.getOrganName());
					fisCemeApplyInfo.setWfId(procDefUniqueId);
					fisCemeApplyInfo.setCurActivity("省级审批");
					fisCemeApplyInfo.setCurOrgan(BspUtil.getParentOrgan().getOrganName());
					fisCemeApplyInfo.setCurOrganCode(BspUtil.getParentOrgan().getOrganCode());
					System.out.println(BspUtil.getParentStrId());
				}
				
				//CommandContext.setContextParameter("assignmentId",assignmentId);
				String startActDefUniqueId = (String)WfQuery.getActDefInfoByProcDefUniqueIdAndActDefId(procDefUniqueId,"act1").get("actDefUniqueId");
				CommandContext.setContextParameter("procDefUniqueId",procDefUniqueId);
				CommandContext.setContextParameter("startActDefUniqueId",startActDefUniqueId);
				Map<String, String> context = new HashMap<String, String>();
				context.put("ORGANID", BspUtil.getParentStrId());
				
				context.put("CONDITION","PASS");
				Map<String, String> map = WfTaskRequestWrapper.getInstance().createAndSend(cemeApplyId, currentOrganName + serviceName, context);

				
				fisCemeApplyInfoDao.update(fisCemeApplyInfo);
				fisCemeInfo.setOrganState("5");
				fisCemeInfoDao.update(fisCemeInfo);
			}
			/*
			 * 公益性公墓和市属经营性公墓扩建流程_审批环节
			 * @see com.inspur.cams.fis.base.domain.IFisCemeApplyInfoDomain#sendOfCreate(com.inspur.cams.fis.base.data.FisCemeApplyInfo, java.lang.String, java.lang.String)
			 */
			
			public void sendOfExpend(FisCemeApplyInfo fisCemeApplyInfo,String result,String assignmentId){
				Map context = new HashMap();
				CommandContext.setContextParameter("assignmentId",assignmentId);
				if("14".equals(BspUtil.getOrganType())){
					if("1".equals(result)){
						context.put("ORGANID", BspUtil.getParentStrId());
						context.put("CONDITION","PASS");//审批结束
						fisCemeApplyInfo.setApplyState("1");
						fisCemeApplyInfo.setIsReport("6");
						fisCemeApplyInfo.setCurOrgan(BspUtil.getParentOrgan().getOrganName());
						fisCemeApplyInfo.setCurOrganCode(BspUtil.getParentOrgan().getOrganCode());
						fisCemeApplyInfo.setCurActivity("县级审批");
					}else if("2".equals(result)){
						context.put("CONDITION","FAILD");//流程走向结束
						context.put("ORGANID", BspUtil.getDeptStruId());
						fisCemeApplyInfo.setIsReport("15");			
						fisCemeApplyInfo.setApplyState("5");
						fisCemeApplyInfo.setCurActivity("审批结束");
						fisCemeApplyInfo.setCurOrgan(BspUtil.getOrganName());
						fisCemeApplyInfo.setCurOrganCode(BspUtil.getOrganCode());
						fisCemeApplyInfo.setComTime(DateUtil.getTime());
					}				
				}else if("13".equals(BspUtil.getOrganType())){
					if("1".equals(result)){
						context.put("ORGANID", BspUtil.getParentStrId());
						context.put("CONDITION","PASS");//审批结束
						fisCemeApplyInfo.setApplyState("3");
						fisCemeApplyInfo.setIsReport("7");			
						fisCemeApplyInfo.setCurActivity("审批结束");
						fisCemeApplyInfo.setCurOrgan(BspUtil.getOrganName());
						fisCemeApplyInfo.setCurOrganCode(BspUtil.getOrganCode());
						fisCemeApplyInfo.setComTime(DateUtil.getTime());
						/*将公墓的OrganState 置成0 ，正在经营，公益性公墓扩建不需要验收*/
						ParameterSet pset1 = new ParameterSet();
						pset1.setParameter("RECORD_ID@=",fisCemeApplyInfo.getRecordId());
						FisCemeExpendInfo fisCemeExpendInfo =(FisCemeExpendInfo) fisCemeExpendInfoDao.query(pset1).getRecord(0).toBean(FisCemeExpendInfo.class);
						pset1.clear();
						pset1.setParameter("RECORD_ID@=",fisCemeExpendInfo.getCemeId());
						FisCemeInfo fisCemeInfo  =(FisCemeInfo) fisCemeInfoDao.query(pset1).getRecord(0).toBean(FisCemeInfo.class);
						fisCemeInfo.setOrganState("0");
						fisCemeInfoDao.update(fisCemeInfo);
					}else if("2".equals(result)){
						context.put("CONDITION","FAILD");//流程走向结束
						context.put("ORGANID", BspUtil.getDeptStruId());
						fisCemeApplyInfo.setIsReport("12");			
						fisCemeApplyInfo.setApplyState("4");
						fisCemeApplyInfo.setCurActivity("审批结束");
						fisCemeApplyInfo.setCurOrgan(BspUtil.getOrganName());
						fisCemeApplyInfo.setCurOrganCode(BspUtil.getOrganCode());
						fisCemeApplyInfo.setComTime(DateUtil.getTime());

					}else if("3".equals(result)){
						
						context.put("CONDITION","BUQI");//流程走补齐补正
						fisCemeApplyInfo.setCurOrganCode(fisCemeApplyInfo.getZeroUnitId());
						fisCemeApplyInfo.setCurOrgan(fisCemeApplyInfo.getZeroUnit());
						fisCemeApplyInfo.setApplyState("2");
						fisCemeApplyInfo.setIsReport("8");			
						fisCemeApplyInfo.setRecTime(DateUtil.getTime());
						fisCemeApplyInfo.setCurActivity("补齐补正");
					}
				}else if("12".equals(BspUtil.getOrganType())){
					if("1".equals(result)){
						context.put("ORGANID", BspUtil.getParentStrId());
						context.put("CONDITION","PASS");//审批结束
						fisCemeApplyInfo.setApplyState("1");
						fisCemeApplyInfo.setIsReport("1");
						fisCemeApplyInfo.setCurOrgan(BspUtil.getParentOrgan().getOrganName());
						fisCemeApplyInfo.setCurOrganCode(BspUtil.getParentOrgan().getOrganCode());
						fisCemeApplyInfo.setCurActivity("省级审批");
					}else if("2".equals(result)){
						context.put("CONDITION","FAILD");//流程走向结束
						context.put("ORGANID", BspUtil.getDeptStruId());
						fisCemeApplyInfo.setIsReport("13");			
						fisCemeApplyInfo.setApplyState("5");
						fisCemeApplyInfo.setCurActivity("审批结束");
						fisCemeApplyInfo.setCurOrgan(BspUtil.getOrganName());
						fisCemeApplyInfo.setCurOrganCode(BspUtil.getOrganCode());
						fisCemeApplyInfo.setComTime(DateUtil.getTime());
					}				
				}else if("11".equals(BspUtil.getOrganType())){
					if("1".equals(result)){
						context.put("ORGANID", BspUtil.getParentStrId());
						context.put("CONDITION","PASS");//审批结束
						fisCemeApplyInfo.setApplyState("3");
						fisCemeApplyInfo.setIsReport("3");			
						fisCemeApplyInfo.setCurActivity("审批结束");
						fisCemeApplyInfo.setCurOrgan(BspUtil.getOrganName());
						fisCemeApplyInfo.setCurOrganCode(BspUtil.getOrganCode());
						fisCemeApplyInfo.setComTime(DateUtil.getTime());
						/*将扩建信息添加到原公墓信息中*/
//						addCeme(fisCemeApplyInfo.getRecordId());
						/*将公墓的OrganState 置成6 ，正在扩建*/
						ParameterSet pset1 = new ParameterSet();
						pset1.setParameter("RECORD_ID@=",fisCemeApplyInfo.getRecordId());
						FisCemeExpendInfo fisCemeExpendInfo =(FisCemeExpendInfo) fisCemeExpendInfoDao.query(pset1).getRecord(0).toBean(FisCemeExpendInfo.class);
						fisCemeExpendInfo.setOrganState("6");
						fisCemeExpendInfoDao.update(fisCemeExpendInfo);
						pset1.clear();
						pset1.setParameter("RECORD_ID@=",fisCemeExpendInfo.getCemeId());
						FisCemeInfo fisCemeInfo  =(FisCemeInfo) fisCemeInfoDao.query(pset1).getRecord(0).toBean(FisCemeInfo.class);
						fisCemeInfo.setOrganState("6");
						fisCemeInfoDao.update(fisCemeInfo);

					}else if("2".equals(result)){
						context.put("CONDITION","FAILD");//流程走向结束
						context.put("ORGANID", BspUtil.getDeptStruId());
						fisCemeApplyInfo.setIsReport("14");			
						fisCemeApplyInfo.setApplyState("4");
						fisCemeApplyInfo.setCurActivity("审批结束");
						fisCemeApplyInfo.setCurOrgan(BspUtil.getOrganName());
						fisCemeApplyInfo.setCurOrganCode(BspUtil.getOrganCode());
						fisCemeApplyInfo.setComTime(DateUtil.getTime());

					}else if("3".equals(result)){
						context.put("CONDITION","BUQI");//流程走补齐补正
						fisCemeApplyInfo.setCurOrganCode(fisCemeApplyInfo.getZeroUnitId());
						fisCemeApplyInfo.setCurOrgan(fisCemeApplyInfo.getZeroUnit());
						fisCemeApplyInfo.setApplyState("2");
						fisCemeApplyInfo.setIsReport("11");
						fisCemeApplyInfo.setRecTime(DateUtil.getTime());
						fisCemeApplyInfo.setCurActivity("补齐补正");
					}
				}
				fisCemeApplyInfo.setRecTime(DateUtil.getTime());
				Map wfMap = WfTaskRequestWrapper.getInstance().send(context);
				fisCemeApplyInfoDao.update(fisCemeApplyInfo);
			}
			
			
			public void insertAcceptance(ParameterSet pset) {
				// TODO Auto-generated method stub
				Record applyRecord = (Record) pset.getParameter("applyInfoRecord");
				Record cemeRecord = (Record) pset.getParameter("cemeRecord");
				Record historyRecord = (Record) pset.getParameter("historyRecord");
				FisCemeInfo fisCemeInfo  =(FisCemeInfo) cemeRecord.toBean(FisCemeInfo.class);
				FisCemeApplyInfo fisCemeApplyInfo  =(FisCemeApplyInfo) applyRecord.toBean(FisCemeApplyInfo.class);						
				FisCemeCheckHistory fisCemeCheckHistory = (FisCemeCheckHistory) historyRecord.toBean(FisCemeCheckHistory.class);
				fisCemeInfoDomain.update(fisCemeInfo);
				fisCemeApplyInfoDao.insert(fisCemeApplyInfo);
				fisCemeCheckHistoryDomain.insert(fisCemeCheckHistory);		

			}
			public void insertAcceptanceForExpend(ParameterSet pset) {
				// TODO Auto-generated method stub
				Record applyRecord = (Record) pset.getParameter("applyInfoRecord");
				Record cemeRecord = (Record) pset.getParameter("cemeRecord");
				Record historyRecord = (Record) pset.getParameter("historyRecord");
				FisCemeExpendInfo fisCemeInfo  =(FisCemeExpendInfo) cemeRecord.toBean(FisCemeExpendInfo.class);
				FisCemeApplyInfo fisCemeApplyInfo  =(FisCemeApplyInfo) applyRecord.toBean(FisCemeApplyInfo.class);						
				FisCemeCheckHistory fisCemeCheckHistory = (FisCemeCheckHistory) historyRecord.toBean(FisCemeCheckHistory.class);
				fisCemeExpendInfoDao.update(fisCemeInfo);
				fisCemeApplyInfoDao.insert(fisCemeApplyInfo);
				fisCemeCheckHistoryDomain.insert(fisCemeCheckHistory);		

			}
			
			/*
			 * 经营性公墓验收流程发起(non-Javadoc)
			 * @see com.inspur.cams.fis.base.domain.IFisCemeApplyInfoDomain#startCemeAcceptance(org.loushang.next.data.ParameterSet)
			 */
	       public void startCemeAcceptance(String cemeApplyId){
	    	   ParameterSet pset1 = new ParameterSet();
				pset1.setParameter("CEME_APPLY_ID@=",cemeApplyId);
				
				FisCemeApplyInfo fisCemeApplyInfo  =(FisCemeApplyInfo) fisCemeApplyInfoDao.query(pset1).getRecord(0).toBean(FisCemeApplyInfo.class);
				
				String taskCode=cemeApplyId;
				String serviceName = "";
				
				String procDefUniqueId="";
				if("13".equals(BspUtil.getOrganType())){
					serviceName = "经营性公墓验收流程";
					procDefUniqueId = "8a898c8641625cc50141625cc5730000";
					fisCemeApplyInfo.setCurActivity("市级审核");
					fisCemeApplyInfo.setIsReport("0");		

				}else if("12".equals(BspUtil.getOrganType())){
					serviceName = "市属经营性公墓验收审批流程";
					procDefUniqueId = "8a898ca241b690630141b6cf54e80022";
					fisCemeApplyInfo.setCurActivity("省级审批");
					fisCemeApplyInfo.setIsReport("9");		

				}
				
				String startActDefUniqueId = (String)WfQuery.getActDefInfoByProcDefUniqueIdAndActDefId(procDefUniqueId,"act1").get("actDefUniqueId");
				CommandContext.setContextParameter("procDefUniqueId",procDefUniqueId);
				CommandContext.setContextParameter("startActDefUniqueId",startActDefUniqueId);

				Map<String, String> context = new HashMap<String, String>();
				String currentOrganName = BspUtil.getCorpOrgan().getOrganName();
				context.put("ORGANID", BspUtil.getParentStrId());
				context.put("CONDITION","PASS");
				Map<String, String> map = WfTaskRequestWrapper.getInstance().createAndSend(cemeApplyId, currentOrganName + serviceName, context);
				
				//fisCemeApplyInfo.setApplyState("0");
				fisCemeApplyInfo.setRecTime(DateUtil.getTime());
				fisCemeApplyInfo.setFillOrganCode(BspUtil.getCorpOrganId());
				fisCemeApplyInfo.setFillOrganName(BspUtil.getOrganName());
				fisCemeApplyInfo.setWfId(procDefUniqueId);
				fisCemeApplyInfo.setCurOrgan(BspUtil.getParentOrgan().getOrganName());
				fisCemeApplyInfo.setCurOrganCode(BspUtil.getParentOrgan().getOrganCode());
				fisCemeApplyInfoDao.update(fisCemeApplyInfo);	
	       }
	       
	       /*
			 * 经营性公墓验收流程审核_审批_整顿环节
			 */
			public void sendCemeAcceptance(FisCemeApplyInfo fisCemeApplyInfo,String result,String assignmentId){
				Map context = new HashMap();
				CommandContext.setContextParameter("assignmentId",assignmentId);
				if("13".equals(BspUtil.getOrganType())){
					if("1".equals(result)){
						context.put("ORGANID", BspUtil.getParentStrId());
						context.put("CONDITION","PASS");
						fisCemeApplyInfo.setIsReport("0");		
						fisCemeApplyInfo.setApplyState("1");
						fisCemeApplyInfo.setCurActivity("市级审核");
						fisCemeApplyInfo.setCurOrgan(BspUtil.getParentOrgan().getOrganName());
						fisCemeApplyInfo.setCurOrganCode(BspUtil.getParentOrgan().getOrganCode());
					}else if("2".equals(result)){
						context.put("CONDITION","FAILED");//流程走向结束
						fisCemeApplyInfo.setApplyState("4");
						fisCemeApplyInfo.setCurActivity("结束");
						fisCemeApplyInfo.setIsReport("12");		

						context.put("ORGANID", BspUtil.getDeptStruId());
						fisCemeApplyInfo.setCurOrgan(fisCemeApplyInfo.getFirstUnit());
						fisCemeApplyInfo.setCurOrganCode(fisCemeApplyInfo.getFirstUnitId());
						fisCemeApplyInfo.setComTime(DateUtil.getTime());
						failedYS(fisCemeApplyInfo.getRecordId());
					}					
				}
				if("12".equals(BspUtil.getOrganType())){
					if("1".equals(result)){
						context.put("ORGANID", BspUtil.getParentStrId());
						context.put("CONDITION","PASS");//审批结束
						fisCemeApplyInfo.setApplyState("1");
						fisCemeApplyInfo.setIsReport("1");		

						fisCemeApplyInfo.setCurActivity("省级审批");
						fisCemeApplyInfo.setCurOrgan(BspUtil.getParentOrgan().getOrganName());
						fisCemeApplyInfo.setCurOrganCode(BspUtil.getParentOrgan().getOrganCode());

					}else if("2".equals(result)){
						context.put("CONDITION","FAILED");//流程走向结束
						fisCemeApplyInfo.setIsReport("13");		
						fisCemeApplyInfo.setApplyState("4");
						fisCemeApplyInfo.setCurActivity("结束");
						context.put("ORGANID", BspUtil.getDeptStruId());
						fisCemeApplyInfo.setCurOrgan(BspUtil.getOrganName());
						fisCemeApplyInfo.setCurOrganCode(BspUtil.getOrganCode());
						fisCemeApplyInfo.setComTime(DateUtil.getTime());
						failedYS(fisCemeApplyInfo.getRecordId());
					}
				}
				if("11".equals(BspUtil.getOrganType())){
					if("1".equals(result)){
						context.put("ORGANID", BspUtil.getParentStrId());
						context.put("CONDITION","PASS");//审批结束
						fisCemeApplyInfo.setIsReport("3");		
						fisCemeApplyInfo.setApplyState("3");
						fisCemeApplyInfo.setCurActivity("结束");
						fisCemeApplyInfo.setCurOrgan(BspUtil.getParentOrgan().getOrganName());
						fisCemeApplyInfo.setCurOrganCode(BspUtil.getParentOrgan().getOrganCode());
						fisCemeApplyInfo.setComTime(DateUtil.getTime());
						succeedYS(fisCemeApplyInfo.getRecordId());
					}else if("2".equals(result)){
						context.put("CONDITION","PASS");//流程走向结束
						fisCemeApplyInfo.setIsReport("14");		
						fisCemeApplyInfo.setApplyState("4");
						fisCemeApplyInfo.setCurActivity("结束");
						context.put("ORGANID", BspUtil.getDeptStruId());
						fisCemeApplyInfo.setCurOrgan(BspUtil.getOrganName());
						fisCemeApplyInfo.setCurOrganCode(BspUtil.getOrganCode());
						fisCemeApplyInfo.setComTime(DateUtil.getTime());
						failedYS(fisCemeApplyInfo.getRecordId());
					}else if("3".equals(result)){
						context.put("CONDITION","ZHENGDUN");//流程走整顿环节
						fisCemeApplyInfo.setApplyState("2");
						fisCemeApplyInfo.setIsReport("11");		
						context.put("ORGANID",BspUtil.getCorpOrgan().getOrganId());
						fisCemeApplyInfo.setCurOrgan(fisCemeApplyInfo.getSecondUnit());
						fisCemeApplyInfo.setCurOrganCode(fisCemeApplyInfo.getSecondUnitId());
						fisCemeApplyInfo.setCurActivity("县级整顿");
					}		
				}
				fisCemeApplyInfo.setRecTime(DateUtil.getTime());		

				Map wfMap = WfTaskRequestWrapper.getInstance().send(context);
				fisCemeApplyInfoDao.update(fisCemeApplyInfo);
			}
			  /*
			 * 经营性公墓验收流程审核_审批_整顿环节
			 */
			public void sendCemeAcceptanceCity(FisCemeApplyInfo fisCemeApplyInfo,String result,String assignmentId){
				Map context = new HashMap();
				CommandContext.setContextParameter("assignmentId",assignmentId);
				
				if("12".equals(BspUtil.getOrganType())){
					if("1".equals(result)){
						context.put("ORGANID", BspUtil.getParentStrId());
						context.put("CONDITION","PASS");//
						fisCemeApplyInfo.setApplyState("1");
						fisCemeApplyInfo.setIsReport("1");		

						fisCemeApplyInfo.setCurActivity("省级审批");
						fisCemeApplyInfo.setCurOrgan(BspUtil.getParentOrgan().getOrganName());
						fisCemeApplyInfo.setCurOrganCode(BspUtil.getParentOrgan().getOrganCode());

					}else if("2".equals(result)){
						context.put("CONDITION","FAILED");//流程走向结束
						fisCemeApplyInfo.setIsReport("13");		
						fisCemeApplyInfo.setApplyState("4");
						fisCemeApplyInfo.setCurActivity("结束");
						context.put("ORGANID", BspUtil.getDeptStruId());
						fisCemeApplyInfo.setCurOrgan(BspUtil.getOrganName());
						fisCemeApplyInfo.setCurOrganCode(BspUtil.getOrganCode());
						fisCemeApplyInfo.setComTime(DateUtil.getTime());
						failedYS(fisCemeApplyInfo.getRecordId());
					}
				}
				if("11".equals(BspUtil.getOrganType())){
					if("1".equals(result)){
						context.put("ORGANID", BspUtil.getParentStrId());
						context.put("CONDITION","PASS");//审批结束
						fisCemeApplyInfo.setIsReport("3");		
						fisCemeApplyInfo.setApplyState("3");
						fisCemeApplyInfo.setCurActivity("审批结束");
						fisCemeApplyInfo.setCurOrgan(BspUtil.getParentOrgan().getOrganName());
						fisCemeApplyInfo.setCurOrganCode(BspUtil.getParentOrgan().getOrganCode());
						fisCemeApplyInfo.setComTime(DateUtil.getTime());
						succeedYS(fisCemeApplyInfo.getRecordId());
					}else if("2".equals(result)){
						context.put("CONDITION","PASS");//流程走向结束
						fisCemeApplyInfo.setIsReport("14");		
						fisCemeApplyInfo.setApplyState("4");
						fisCemeApplyInfo.setCurActivity("审批结束");
						context.put("ORGANID", BspUtil.getDeptStruId());
						fisCemeApplyInfo.setCurOrgan(BspUtil.getOrganName());
						fisCemeApplyInfo.setCurOrganCode(BspUtil.getOrganCode());
						fisCemeApplyInfo.setComTime(DateUtil.getTime());
						failedYS(fisCemeApplyInfo.getRecordId());
					}else if("3".equals(result)){
						context.put("CONDITION","ZHENGDUN");//流程走整顿环节
						fisCemeApplyInfo.setApplyState("2");
						fisCemeApplyInfo.setIsReport("11");		
						context.put("ORGANID",BspUtil.getCorpOrgan().getOrganId());
						fisCemeApplyInfo.setCurOrgan(fisCemeApplyInfo.getSecondUnit());
						fisCemeApplyInfo.setCurOrganCode(fisCemeApplyInfo.getSecondUnitId());
						fisCemeApplyInfo.setCurActivity("市级整顿");
					}		
				}
				fisCemeApplyInfo.setRecTime(DateUtil.getTime());		

				Map wfMap = WfTaskRequestWrapper.getInstance().send(context);
				fisCemeApplyInfoDao.update(fisCemeApplyInfo);
			}
			public void deleteAcceptance(ParameterSet pset) {
				// TODO Auto-generated method stub
				fisCemeApplyInfoDao.deleteAcceptance(pset);
			}
			/*
			 * 将公墓扩建表中的数据加载到公墓表中
			 * @see com.inspur.cams.fis.base.domain.IFisCemeApplyInfoDomain#sendOfCreateOperation(com.inspur.cams.fis.base.data.FisCemeApplyInfo, java.lang.String, java.lang.String)
			 */
			public void addCeme(FisCemeExpendInfo fisCemeExpendInfo){
				ParameterSet pset1 = new ParameterSet();
				pset1.setParameter("RECORD_ID@=",fisCemeExpendInfo.getCemeId());
				FisCemeInfo fisCemeInfo  =(FisCemeInfo) fisCemeInfoDao.query(pset1).getRecord(0).toBean(FisCemeInfo.class);
				
				fisCemeInfo.setAddress(addString(fisCemeExpendInfo.getAddress(),fisCemeInfo.getAddress()));//所在位置
				fisCemeInfo.setLandProperties(addString(fisCemeExpendInfo.getLandProperties(),fisCemeInfo.getLandProperties()));//占用土地性质
				fisCemeInfo.setTotalArea(addNumberBigDecimal(fisCemeExpendInfo.getTotalArea(),fisCemeInfo.getTotalArea()));//占地面积
				fisCemeInfo.setBuiltTotalArea(addNumberBigDecimal(fisCemeExpendInfo.getBuiltTotalArea(),fisCemeInfo.getBuiltTotalArea()));//建筑面积
				fisCemeInfo.setBuiltArea(addNumberBigDecimal(fisCemeExpendInfo.getBuiltArea(),fisCemeInfo.getBuiltArea()));//墓地建成面积
				fisCemeInfo.setGreenArea(addNumberBigDecimal(fisCemeExpendInfo.getGreenArea(),fisCemeInfo.getGreenArea()));//绿地面积
				/*墓穴*/
				fisCemeInfo.setSinceHoleNum(addNumberInt(fisCemeExpendInfo.getSinceHoleNum(),fisCemeInfo.getSinceHoleNum()));
				fisCemeInfo.setCageHoleNum(addNumberInt(fisCemeExpendInfo.getCageHoleNum(),fisCemeInfo.getCageHoleNum()));
				fisCemeInfo.setSingleHole(addNumberInt(fisCemeExpendInfo.getSingleHole(),fisCemeInfo.getSingleHole()));
				fisCemeInfo.setDoubleHole(addNumberInt(fisCemeExpendInfo.getDoubleHole(),fisCemeInfo.getDoubleHole()));
				fisCemeInfo.setMoreHole(addNumberInt(fisCemeExpendInfo.getMoreHole(),fisCemeInfo.getMoreHole()));
				fisCemeInfo.setEcologicalHoleNum(addNumberInt(fisCemeExpendInfo.getEcologicalHoleNum(),fisCemeInfo.getEcologicalHoleNum()));
				/*建设资金来源*/
				fisCemeInfo.setFundSources(addString(fisCemeInfo.getFundSources(),fisCemeExpendInfo.getFundSources()));
				fisCemeInfo.setFundTotal(addNumberBigDecimal(fisCemeExpendInfo.getFundTotal(),fisCemeInfo.getFundTotal()));
				fisCemeInfo.setFundFinance(addNumberBigDecimal(fisCemeExpendInfo.getFundFinance(),fisCemeInfo.getFundFinance()));
				fisCemeInfo.setFundHigher(addNumberBigDecimal(fisCemeExpendInfo.getFundHigher(),fisCemeInfo.getFundHigher()));
				fisCemeInfo.setFundLottery(addNumberBigDecimal(fisCemeExpendInfo.getFundLottery(),fisCemeInfo.getFundLottery()));
				fisCemeInfo.setFundOther(addNumberBigDecimal(fisCemeExpendInfo.getFundOther(),fisCemeInfo.getFundOther()));
				//申请建设事由
				fisCemeInfo.setNote(addString(fisCemeInfo.getNote(),fisCemeExpendInfo.getNote()));
				//服务范围
				//主办单位申请时间
				//维护管理办法
				//计划使用年限
				fisCemeInfo.setYearPlanto(compareYear(fisCemeExpendInfo.getYearPlanto(),fisCemeInfo.getYearPlanto()));
				//绿化覆盖率
				fisCemeInfo.setGreenRatio(getSumRadio(fisCemeInfo.getBuiltTotalArea(),fisCemeInfo.getGreenRatio(),fisCemeExpendInfo.getBuiltTotalArea(),fisCemeExpendInfo.getGreenRatio()));
				fisCemeInfo.setOrganState("0");
				fisCemeInfoDao.update(fisCemeInfo);
			}
			//将两个String以整形(int)相加，并返回一个String
			public String addNumberInt(String str1, String str2){
				if(str1==null ||"".equals(str1)){
					str1="0";
				}
					if(str2==null || "".equals(str2)){
					str2="0";
				}
					int tempValue=Integer.valueOf(str1).intValue()+Integer.valueOf(str2).intValue();
					return Integer.toString(tempValue);
			}
			//将两个BigeDecimal数据相加
			public BigDecimal addNumberBigDecimal(BigDecimal big1, BigDecimal big2){
				if(big1==null ||"".equals(big1)){
					big1=new BigDecimal(0);
				}
				if(big2==null || "".equals(big2)){
					big2=new BigDecimal(0);
				}
					return big1.add(big2);
			}
			//将两个String数据相加
			public String addString(String str1, String str2){
				if(str1!=null&&!"".equals(str1)){
					if(str2==null||"".equals(str2)){
						return str1;
					}else{
						return str1+"; "+str2;
					}
				}else{
					if(str2==null||"".equals(str2)){
						return "";
					}else{
						return str2;
					}
				}
			}
			//比较两个计划使用年限，并取其中较大的值
			public String compareYear(String str1, String str2){
				if(str1==null ||"".equals(str1)){
					str1="0";
				}
					if(str2==null || "".equals(str2)){
					str2="0";
				}
					int tempValue=Math.max(Integer.valueOf(str1).intValue(), Integer.valueOf(str2).intValue());
					return Integer.toString(tempValue);
			}
			//将两个BigeDecimal数据相加
			public BigDecimal getSumRadio(BigDecimal big1, BigDecimal radio1,BigDecimal big2, BigDecimal radio2){
				if((big1==null ||"".equals(big1))&&(big2==null || "".equals(big2))){
					return (radio1.add(radio2)).divide(new BigDecimal(2)); 
				}
				if(big1==null ||"".equals(big1)){
					big1=new BigDecimal(0);
				}
				if(big2==null || "".equals(big2)){
					big2=new BigDecimal(0);
				}
				if(radio1==null || "".equals(radio1)){
					radio1=new BigDecimal(0);
				}
				if(radio2==null || "".equals(radio2)){
					radio2=new BigDecimal(0);
				}

				BigDecimal valueAbove=new BigDecimal(0);
				BigDecimal valueBelow=new BigDecimal(0);
				valueAbove=big1.multiply(radio1).add(big2.multiply(radio2));
				valueBelow=big1.add(big2);
				return valueAbove.divide(valueBelow,2,BigDecimal.ROUND_HALF_UP);
			}
			/*
			 * 验收通过
			 * */
			void succeedYS(String recordId){
				ParameterSet pset1 = new ParameterSet();
				
				pset1.setParameter("RECORD_ID@=",recordId);
				DataSet ds1 =(DataSet) fisCemeExpendInfoDao.query(pset1);
				if(ds1.getCount()==0){
					pset1.clear();
					pset1.setParameter("RECORD_ID@=",recordId);
					FisCemeInfo fisCemeInfo  =(FisCemeInfo) fisCemeInfoDao.query(pset1).getRecord(0).toBean(FisCemeInfo.class);
					fisCemeInfo.setOrganState("0");
					fisCemeInfo.setGestionTime(DateUtil.getTime());
					fisCemeInfoDao.update(fisCemeInfo);
				}else{
					FisCemeExpendInfo fisCemeExpendInfo=(FisCemeExpendInfo)ds1.getRecord(0).toBean(FisCemeExpendInfo.class);
					addCeme(fisCemeExpendInfo);
					fisCemeExpendInfo.setOrganState("0");
					fisCemeExpendInfoDao.update(fisCemeExpendInfo);
					
				}						
			}
			void failedYS(String recordId){
				
				ParameterSet pset1 = new ParameterSet();
				pset1.setParameter("RECORD_ID@=",recordId);
				DataSet ds1 =(DataSet) fisCemeExpendInfoDao.query(pset1);
				if(ds1.getCount()==0){
					pset1.clear();
					pset1.setParameter("RECORD_ID@=",recordId);
					FisCemeInfo fisCemeInfo  =(FisCemeInfo) fisCemeInfoDao.query(pset1).getRecord(0).toBean(FisCemeInfo.class);
					fisCemeInfo.setOrganState("4");
					fisCemeInfoDao.update(fisCemeInfo);
				}else{
					FisCemeExpendInfo fisCemeExpendInfo=(FisCemeExpendInfo)ds1.getRecord(0).toBean(FisCemeExpendInfo.class);
					fisCemeExpendInfo.setOrganState("6");
					fisCemeExpendInfoDao.update(fisCemeExpendInfo);
					pset1.clear();
					pset1.setParameter("RECORD_ID@=",fisCemeExpendInfo.getCemeId());
					FisCemeInfo fisCemeInfo  =(FisCemeInfo) fisCemeInfoDao.query(pset1).getRecord(0).toBean(FisCemeInfo.class);
					fisCemeInfo.setOrganState("6");
					fisCemeInfoDao.update(fisCemeInfo);
				}						
			}

}