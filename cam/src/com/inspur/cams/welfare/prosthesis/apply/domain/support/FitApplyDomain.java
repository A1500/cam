package com.inspur.cams.welfare.prosthesis.apply.domain.support;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.CommandContext;
import org.loushang.sca.transaction.Trans;
import org.loushang.workflow.api.WfQuery;
import org.loushang.workflow.api.WfTaskRequestWrapper;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.extuser.util.ExtBspInfo;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.welfare.base.data.WealCert;
import com.inspur.cams.welfare.base.data.WealFitApply;
import com.inspur.cams.welfare.base.data.WealFitDevice;
import com.inspur.cams.welfare.base.data.WealFitInfo;
import com.inspur.cams.welfare.base.data.WealFitProductivepower;
import com.inspur.cams.welfare.base.data.WealFitStatus;
import com.inspur.cams.welfare.base.data.WealWorker;
import com.inspur.cams.welfare.base.domain.IWealCertDomain;
import com.inspur.cams.welfare.base.domain.IWealComfortNoDomain;
import com.inspur.cams.welfare.base.domain.IWealFitApplyDomain;
import com.inspur.cams.welfare.base.domain.IWealFitDeviceDomain;
import com.inspur.cams.welfare.base.domain.IWealFitInfoDomain;
import com.inspur.cams.welfare.base.domain.IWealFitProductivepowerDomain;
import com.inspur.cams.welfare.base.domain.IWealFitStatusDomain;
import com.inspur.cams.welfare.base.domain.IWealWorkerDomain;
import com.inspur.cams.welfare.prosthesis.apply.domain.IFitApplyDomain;


public class FitApplyDomain implements IFitApplyDomain{
	@Reference
	private IWealFitApplyDomain wealFitApplysDomain;
	@Reference
	private IWealFitInfoDomain wealFitInfoDomain;
	@Reference
	private IWealFitDeviceDomain wealFitDeviceDomain;
	@Reference
	private IWealFitProductivepowerDomain wealFitProductivepowerDomain;
	@Reference
	private IWealComfortNoDomain wealComfortNoDomain;
	@Reference
	private IWealFitStatusDomain wealFitStatusDomain;
	@Reference
	private IWealCertDomain wealCertDomain;
	@Reference
	private IWealWorkerDomain wealWorkerDomain;
	//资格认定信息采集第一页保存——插入业务表和信息表数据
	public void saveQualification(Record infoRecord,String dataSource,HttpServletRequest request){
		WealFitInfo infoBean=(WealFitInfo)infoRecord.toBean(WealFitInfo.class);
		ParameterSet pset1=new ParameterSet();
		pset1.setParameter("TASK_CODE@=", infoBean.getTaskCode());
		DataSet infoDs=wealFitInfoDomain.query(pset1);
		if(infoDs.getCount()<1){
			wealFitInfoDomain.insert(infoBean);
		}else{
			wealFitInfoDomain.update(infoBean);
		}
		
		WealFitApply applyBean=new WealFitApply();
		DataSet applyDs=wealFitApplysDomain.query(pset1);
		if(applyDs.getCount()<1){
			applyBean.setTaskCode(infoBean.getTaskCode());
			applyBean.setApplyType(infoBean.getApplyType());
			applyBean.setFitId(IdHelp.getUUID32());
			if("ONLINE".equals(dataSource)){
				applyBean.setDataSource("ONLINE");
				applyBean.setApplyStauts("1");//外网保存
				applyBean.setMorgArea(ExtBspInfo.getUserInfo(request).getAreaCode());//当前登录用户，即为企业地区区划
				applyBean.setMorgName(ExtBspInfo.getUserInfo(request).getAreaName());
			}else{
				applyBean.setDataSource("LOCAL");
				applyBean.setApplyStauts("0");//内网保存
				applyBean.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());//当前登录用户，即为企业地区区划
				applyBean.setMorgName(BspUtil.getCorpOrgan().getOrganName());
			}
			applyBean.setRegDate(infoBean.getRegDate());
			wealFitApplysDomain.insert(applyBean);
		}else{
			wealFitApplysDomain.update(applyBean);
		}
	}
	//资格认定信息采集第一页(根据字号回填)保存——插入业务表和信息表数据
	public void saveQualificationD(Record StatusRecord,Record[] WorkerRd,Record[] FitDeviceRd,Record[] FitProductivepowerRd,String regDate,String taskCode,String applyType,String dataSource){
		WealFitStatus StatusBean = (WealFitStatus)StatusRecord.toBean(WealFitStatus.class);
		ParameterSet pset1=new ParameterSet();
		pset1.setParameter("TASK_CODE@=",taskCode);
		
		WealFitInfo infoBean = new WealFitInfo();
		DataSet infoDs = wealFitInfoDomain.query(pset1);
		//将状态表信息维护到业务表
		if(infoDs.getCount()<1){
			infoBean.setTaskCode(taskCode);
			infoBean.setAddress(StatusBean.getAddress());
			infoBean.setCompanyName(StatusBean.getCompanyName());
			infoBean.setRegDate(regDate);
			infoBean.setSerialNum(StatusBean.getSerialNum());
			infoBean.setPostCode(StatusBean.getPostCode());
			//法人代表
			infoBean.setLegalPeople(StatusBean.getLegalPeople());
			infoBean.setLegalIdCard(StatusBean.getLegalIdCard());
			infoBean.setLegalPhone(StatusBean.getLegalPhone());
			infoBean.setLegalEmail(StatusBean.getLegalEmail());
			infoBean.setLegalTelphone(StatusBean.getLegalTelphone());
			//经办人
			infoBean.setAgentEmail(StatusBean.getAgentEmail());
			infoBean.setAgentIdCard(StatusBean.getAgentIdCard());
			infoBean.setAgentPeople(StatusBean.getAgentPeople());
			infoBean.setAgentPhone(StatusBean.getAgentPhone());
			infoBean.setAgentTelphone(StatusBean.getAgentTelphone());
			
			infoBean.setWebAddress(StatusBean.getWebAddress());
			//经济性质
			infoBean.setEconomicNatureCode(StatusBean.getEconomicNatureCode());
			infoBean.setEconomicNatureName(StatusBean.getEconomicNatureName());
			
			infoBean.setOrganCode(StatusBean.getOrganCode());
			infoBean.setLicenseCode(StatusBean.getLicenseCode());
			infoBean.setRegistrationCode(StatusBean.getRegistrationCode());
			//活动面积
			infoBean.setOperateArea(StatusBean.getOperateArea());
			infoBean.setProductArea(StatusBean.getProductArea());
			infoBean.setRecoveryArea(StatusBean.getRecoveryArea());
			infoBean.setReceptionArea(StatusBean.getReceptionArea());
			infoBean.setTrainArea(StatusBean.getTreatmentArea());
			infoBean.setTreatmentArea(StatusBean.getTreatmentArea());
			infoBean.setWorkArea(StatusBean.getWorkArea());
			infoBean.setLeisureArea(StatusBean.getLeisureArea());
			infoBean.setOtherArea(StatusBean.getOtherArea());
			//注册资金
			infoBean.setRegFund(StatusBean.getRegFund());
			//业务类型
			if("3".equals(applyType)){
				infoBean.setApplyType("3");//在换证的时候传递此参数applyType=3
				infoBean.setApplyYear(StatusBean.getNextChagneCert());//根据下一次换证年度，维护info表中年度字段
			}else{
				infoBean.setApplyType("2");
				infoBean.setApplyYear(StatusBean.getNextCheck());//根据下一次年检年度，维护info表中年度字段
			}
			//初次认定时间
			infoBean.setCognizanceDate(StatusBean.getCognizanceDate());
			
			wealFitInfoDomain.insert(infoBean);
		}else{
			wealFitInfoDomain.update(infoBean);
		}
		
		//设施表维护
		DataSet deviceDs=wealFitDeviceDomain.query(pset1);
		if(FitDeviceRd!=null){
			if(deviceDs.getCount()<1){
				for(int i=0;i<FitDeviceRd.length;i++){
					WealFitDevice deviceBean=(WealFitDevice)FitDeviceRd[i].toBean(WealFitDevice.class);
					deviceBean.setTaskCode(taskCode);
					deviceBean.setDeviceId(IdHelp.getUUID32());
					wealFitDeviceDomain.insert(deviceBean);
				}
			}
		}
		
		//生产能力信息
		DataSet productDs=wealFitProductivepowerDomain.query(pset1);
		if(FitProductivepowerRd!=null){
			if(productDs.getCount()<1){
				for(int i=0;i<FitProductivepowerRd.length;i++){
					WealFitProductivepower productBean=(WealFitProductivepower)FitProductivepowerRd[i].toBean(WealFitProductivepower.class);
					productBean.setTaskCode(taskCode);
					productBean.setProduceId(IdHelp.getUUID32());
					wealFitProductivepowerDomain.insert(productBean);
				}
			}
			
		}
		
		//人员信息维护
		if(WorkerRd!=null){
			for(int i=0;i<WorkerRd.length;i++){
				WealWorker workerBean = (WealWorker)WorkerRd[i].toBean(WealWorker.class);
				workerBean.setTaskCode(taskCode);
				workerBean.setWorkerId(IdHelp.getUUID32());
				wealWorkerDomain.insert(workerBean);
			}
			
		}
		
		//装配企业维护
		WealFitApply applyBean=new WealFitApply();
		DataSet applyDs=wealFitApplysDomain.query(pset1);
		if(applyDs.getCount()<1){
			applyBean.setTaskCode(taskCode);
			applyBean.setFitId(StatusBean.getFitId());
			if("ONLINE".equals(dataSource)){
				applyBean.setDataSource("ONLINE");
				applyBean.setApplyStauts("1");//外网保存
			}else{
				applyBean.setDataSource("LOCAL");
				applyBean.setApplyStauts("0");//内网保存
			}
			if("3".equals(applyType)){
				applyBean.setApplyType("3");//在换证的时候传递此参数applyType=3
			}else{
				applyBean.setApplyType("2");
			}
			applyBean.setMorgArea(StatusBean.getMorgArea());
			applyBean.setMorgName(StatusBean.getMorgName());
			applyBean.setRegDate(regDate);
			wealFitApplysDomain.insert(applyBean);
		}else{
			wealFitApplysDomain.update(applyBean);
		}
	}
	/**
	 * 资格认定信息采集第二页保存——基本信息
	 */
	public void saveQualificationInfo(Record infoRecord,Record[] deviceRecord,Record[] productRecord){
		WealFitInfo infoBean=(WealFitInfo)infoRecord.toBean(WealFitInfo.class);
		ParameterSet pset1=new ParameterSet();
		pset1.setParameter("TASK_CODE@=", infoBean.getTaskCode());
		DataSet infoDs=wealFitInfoDomain.query(pset1);
		if(infoDs.getCount()<1){
			wealFitInfoDomain.insert(infoBean);
		}else{
			wealFitInfoDomain.update(infoBean);
		}
		//设施信息
		if(deviceRecord!=null){
			for(int i=0;i<deviceRecord.length;i++){
				WealFitDevice deviceBean=(WealFitDevice)deviceRecord[i].toBean(WealFitDevice.class);
				if(!"".equals(deviceBean.getDeviceId())){
					wealFitDeviceDomain.update(deviceBean);
				}else{
					deviceBean.setDeviceId(IdHelp.getUUID32());
					wealFitDeviceDomain.insert(deviceBean);
				}
				
				
			}
		}
		//生产能力信息
		if(productRecord!=null){
			for(int i=0;i<productRecord.length;i++){
				WealFitProductivepower productBean=(WealFitProductivepower)productRecord[i].toBean(WealFitProductivepower.class);
				if(!"".equals(productBean.getProduceId())){
					wealFitProductivepowerDomain.update(productBean);
				}else{
					productBean.setProduceId(IdHelp.getUUID32());
					wealFitProductivepowerDomain.insert(productBean);
				}
				
			}
		}
	}
	
	//假肢企业年检删除
	public void someDelete(ParameterSet pset){
		String infoId = (String) pset.getParameter("infoId");
		String[] applyIds = (String[]) pset.getParameter("applyIds");
		String[] workerIds = (String[]) pset.getParameter("workerIds");
		String[] deviceIds = (String[]) pset.getParameter("deviceIds");
		String[] productIds = (String[]) pset.getParameter("productIds");
		//信息表删除
		wealFitInfoDomain.delete(infoId);
		//业务表删除
		for(int i=0;i<applyIds.length;i++){
			wealFitApplysDomain.delete(applyIds[i]);
		}
		//人员信息表删除
		if(workerIds!=null){
			for(int i=0;i<workerIds.length;i++){
				wealWorkerDomain.delete(workerIds[i]);
			}
		}
		//设施表删除
		if(deviceIds!=null){
			for(int i=0;i<deviceIds.length;i++){
				wealFitDeviceDomain.delete(deviceIds[i]);
			}
		}
		//生产能力信息表删除
		if(productIds!=null){
			for(int i=0;i<productIds.length;i++){
				wealFitProductivepowerDomain.delete(productIds[i]);
			}
		}
		
	}
	/**
	 *保存业务信息
	 */
	public void saveFitApply(ParameterSet pset) {
		Record record = (Record) pset.getParameter("record");
		WealFitApply wealFitApply  =(WealFitApply) record.toBean(WealFitApply.class);
		wealFitApplysDomain.update(wealFitApply);
	}
	/**
	 * 创建并发起资格认定业务流程
	 */
	public void createAndSendQualification(ParameterSet pset) {
		
		Record record = (Record) pset.getParameter("record");
		String taskCode=(String) record.get("TASK_CODE");
		
		String serviceName = "假肢和矫形器企业资格认定";
		
		// 向表WEAL_FIT_APPLY表中更新记录【审批表】
		pset.clear();
		pset.setParameter("TASK_CODE", taskCode);
		WealFitApply wealFitApply  =(WealFitApply) wealFitApplysDomain.query(pset).getRecord(0).toBean(WealFitApply.class);
		wealFitApply.setAcceptAddOpinion("");
		wealFitApply.setAcceptBaseOpinion("");
		wealFitApply.setAcceptTime(DateUtil.getTime());
		wealFitApply.setApplyStauts("3");
		wealFitApplysDomain.update(wealFitApply);

		String procDefUniqueId = "8a898bd33e647fb6013e648af603000a";
		// 通过流程唯一ID获得流程第一个环节ID
		String startActDefUniqueId = (String)WfQuery.getActDefInfoByProcDefUniqueIdAndActDefId(procDefUniqueId,"act8").get("actDefUniqueId");
		//String startActDefUniqueId ="8a898bd33e4f0ac3013e4fa35dcc03fe";
		// 调用创建并发送流程接口
		CommandContext.setContextParameter("procDefUniqueId",procDefUniqueId);
		CommandContext.setContextParameter("startActDefUniqueId",startActDefUniqueId);
		
		Map<String, String> context = new HashMap<String, String>();
		String organId = BspUtil.getParentStrId();
		String currentOrganName = BspUtil.getCorpOrgan().getOrganName();
		context.put("ORGANID", BspUtil.getDeptStruId());
		context.put("CONDITION","PASS");
		Map<String, String> map = WfTaskRequestWrapper.getInstance().createAndSend(taskCode, currentOrganName + serviceName, context);
		//String processId = map.get("processId");
	}
	/**
	 * 发送资格认定业务流程
	 */
	public void sendQualification(ParameterSet pset) {
		Record record = (Record) pset.getParameter("record");
		String option = (String) pset.getParameter("option");
		Map context = new HashMap();
		context.put("ORGANID", BspUtil.getDeptStruId());
		//判定流程走向
		if(!"".equals(option)&&"0".equals(option.substring(0, 1))){
			context.put("CONDITION","PASS");
		}else if(!"".equals(option)&&"1".equals(option.substring(0, 1))){
			context.put("CONDITION","END");
		}else if(!"".equals(option)&&"2".equals(option.substring(0, 1))){
			context.put("CONDITION","FILL");
		}else{
			context.put("CONDITION","PASS");
		}
		
		
		Map wfMap = WfTaskRequestWrapper.getInstance().send(context);
		WealFitApply wealFitApply  =(WealFitApply) record.toBean(WealFitApply.class);
		if("true".equals((String)wfMap.get("isEnd"))&&"0".equals(option.substring(0, 1))){
			//修改业务状态标志
			wealFitApply.setApplyStauts("4");
			wealFitApply.setApproveDate(DateUtil.getDay());
			ParameterSet pset1=new ParameterSet();
			pset1.setParameter("TASK_CODE@=", (String)record.get("taskCode"));
			DataSet infoDs=wealFitInfoDomain.query(pset1);
			if(infoDs.getCount()>0){
				int year=Integer.parseInt(DateUtil.getDay().substring(0, 4));
				//插入字号
				WealFitInfo infoBean=(WealFitInfo)infoDs.getRecord(0).toBean(WealFitInfo.class);
				infoBean.setSerialNum(wealComfortNoDomain.getNO("Q", BspUtil.getCorpOrgan().getOrganCode()));
				infoBean.setApplyYear(year+"");
				infoBean.setCognizanceDate(wealFitApply.getDirectorTime());
				wealFitInfoDomain.update(infoBean);
				
				//插入状态表信息
				WealFitStatus walFitStatus=(WealFitStatus)infoDs.getRecord(0).toBean(WealFitStatus.class);
				walFitStatus.setFitId(wealFitApply.getFitId());
				
				//String moday= DateUtil.getDay().substring(4);
				walFitStatus.setNextChagneCert(year+3+"");
				walFitStatus.setNextCheck(year+1+"");
				walFitStatus.setApplyYear(year+"");
				walFitStatus.setState(1);
				walFitStatus.setStatus("1");
				walFitStatus.setSerialNum(infoBean.getSerialNum());
				walFitStatus.setTaskCode((String)record.get("taskCode"));
				walFitStatus.setMorgArea(wealFitApply.getMorgArea());//存入业务表中的行政区划，即为企业的地区
				walFitStatus.setMorgName(wealFitApply.getMorgName());
				//初次认定时间为厅长审批时间
				walFitStatus.setCognizanceDate(wealFitApply.getDirectorTime());
				wealFitStatusDomain.insert(walFitStatus);
				//插入证书信息
				WealCert wealCert = new WealCert();
				wealCert.setTaskCode((String)record.get("taskCode"));
				wealCert.setCompanyType("1");
				wealCert.setCertType("1");
				wealCert.setSerialNum(infoBean.getSerialNum());
				wealCert.setCompanyName(infoBean.getCompanyName());
				wealCert.setCompanyAddress(infoBean.getAddress());
				wealCert.setLegalPeople(infoBean.getLegalPeople());
				wealCert.setOrganType(infoBean.getEconomicNatureCode());
				wealCert.setSiteArea(infoBean.getOperateArea());
				wealCert.setCertStatus("1");
				wealCert.setBusinessScope(infoBean.getBusinessScope());
				wealCert.setApproveDate(wealFitApply.getApproveDate());
				wealCertDomain.insert(wealCert);
				
			}
			
		}else if("true".equals((String)wfMap.get("isEnd"))&&"1".equals(option.substring(0, 1))){
			wealFitApply.setApplyStauts("5");
		}
		wealFitApplysDomain.update(wealFitApply);
		
	}
	
	/**
	 * 创建并发起年审业务流程
	 */
	public void createAndSendYearlyCheck(ParameterSet pset) {
		
		Record record = (Record) pset.getParameter("record");
		String taskCode=(String) record.get("TASK_CODE");
		
		String serviceName = "假肢和矫形器企业年度检查";
		
		// 向表WEAL_FIT_APPLY表中更新记录【审批表】
		pset.clear();
		pset.setParameter("TASK_CODE", taskCode);
		WealFitApply wealFitApply  =(WealFitApply) wealFitApplysDomain.query(pset).getRecord(0).toBean(WealFitApply.class);
		wealFitApply.setAcceptAddOpinion("");
		wealFitApply.setAcceptBaseOpinion("");
		wealFitApply.setAcceptTime(DateUtil.getTime());
		wealFitApply.setApplyStauts("3");
		wealFitApplysDomain.update(wealFitApply);

		String procDefUniqueId = "8a898bd33ebf6d92013ebf9582d80027";
		// 通过流程唯一ID获得流程第一个环节ID
		String startActDefUniqueId = (String)WfQuery.getActDefInfoByProcDefUniqueIdAndActDefId(procDefUniqueId,"act5").get("actDefUniqueId");
		//String startActDefUniqueId ="8a898bd33e4f0ac3013e4fa35dcc03fe";
		// 调用创建并发送流程接口
		CommandContext.setContextParameter("procDefUniqueId",procDefUniqueId);
		CommandContext.setContextParameter("startActDefUniqueId",startActDefUniqueId);
		
		Map<String, String> context = new HashMap<String, String>();
		String organId = BspUtil.getParentStrId();
		String currentOrganName = BspUtil.getCorpOrgan().getOrganName();
		context.put("ORGANID", BspUtil.getDeptStruId());
		context.put("CONDITION","PASS");
		Map<String, String> map = WfTaskRequestWrapper.getInstance().createAndSend(taskCode, currentOrganName + serviceName, context);
		//String processId = map.get("processId");
	}
	/**
	 * 发送年审业务流程
	 */
	public void sendYearlyCheck(ParameterSet pset) {
		Record record = (Record) pset.getParameter("record");
		String option = (String) pset.getParameter("option");
		Map context = new HashMap();
		context.put("ORGANID", BspUtil.getDeptStruId());
		//判定流程走向
		if(!"".equals(option)&&"0".equals(option.substring(0, 1))){
			context.put("CONDITION","PASS");
		}else if(!"".equals(option)&&"1".equals(option.substring(0, 1))){
			context.put("CONDITION","END");
		}else if(!"".equals(option)&&"2".equals(option.substring(0, 1))){
			context.put("CONDITION","FILL");
		}else{
			context.put("CONDITION","PASS");
		}
		
		
		Map wfMap = WfTaskRequestWrapper.getInstance().send(context);
		WealFitApply wealFitApply  =(WealFitApply) record.toBean(WealFitApply.class);
		if("true".equals((String)wfMap.get("isEnd"))&&"0".equals(option.substring(0, 1))){
			//修改业务状态标志
			wealFitApply.setApplyStauts("4");
			wealFitApply.setApproveDate(DateUtil.getDay());
			ParameterSet pset1=new ParameterSet();
			pset1.setParameter("TASK_CODE@=", (String)record.get("taskCode"));
			DataSet infoDs=wealFitInfoDomain.query(pset1);
			WealFitInfo wealFitInfo=new WealFitInfo();
			if(infoDs.getCount()>0){
				wealFitInfo=(WealFitInfo)infoDs.getRecord(0).toBean(WealFitInfo.class);
			}
			ParameterSet pset2=new ParameterSet();
			pset2.setParameter("FIT_ID@=", wealFitApply.getFitId());
			DataSet sds = wealFitStatusDomain.query(pset2);
			if(sds.getCount()>0){
				
				//插入状态表信息
				WealFitStatus walFitStatus=(WealFitStatus)sds.getRecord(0).toBean(WealFitStatus.class);
				walFitStatus.setTaskCode((String)record.get("taskCode"));
				int year=Integer.parseInt(walFitStatus.getNextCheck())+1;
				walFitStatus.setNextCheck(year+"");//每次年检流程之后，状态表下次年检加1;
				//通过信息表更新状态表信息
				walFitStatus.setApplyYear(wealFitInfo.getApplyYear());//更新状态表年度
				walFitStatus.setCompanyName(wealFitInfo.getCompanyName());
				walFitStatus.setAddress(wealFitInfo.getAddress());
				walFitStatus.setPostCode(wealFitInfo.getPostCode());
				walFitStatus.setLegalPeople(wealFitInfo.getLegalPeople());
				walFitStatus.setLegalIdCard(wealFitInfo.getLegalIdCard());
				walFitStatus.setLegalPhone(wealFitInfo.getLegalPhone());
				walFitStatus.setLegalTelphone(wealFitInfo.getLegalTelphone());
				walFitStatus.setLegalEmail(wealFitInfo.getLegalEmail());
				walFitStatus.setAgentPeople(wealFitInfo.getAgentPeople());
				walFitStatus.setAgentIdCard(wealFitInfo.getAgentIdCard());
				walFitStatus.setAgentPhone(wealFitInfo.getAgentPhone());
				walFitStatus.setAgentTelphone(wealFitInfo.getAgentTelphone());
				walFitStatus.setAgentEmail(wealFitInfo.getAgentEmail());
				walFitStatus.setWebAddress(wealFitInfo.getWebAddress());
				walFitStatus.setEconomicNatureCode(wealFitInfo.getEconomicNatureCode());
				walFitStatus.setEconomicNatureName(wealFitInfo.getEconomicNatureName());
				walFitStatus.setOrganCode(wealFitInfo.getOrganCode());
				walFitStatus.setLicenseCode(wealFitInfo.getLicenseCode());
				walFitStatus.setRegistrationCode(wealFitInfo.getRegistrationCode());
				walFitStatus.setOperateArea(wealFitInfo.getOperateArea());
				walFitStatus.setProductArea(wealFitInfo.getProductArea());
				walFitStatus.setRecoveryArea(wealFitInfo.getRecoveryArea());
				walFitStatus.setReceptionArea(wealFitInfo.getReceptionArea());
				walFitStatus.setTrainArea(wealFitInfo.getTrainArea());
				walFitStatus.setTreatmentArea(wealFitInfo.getTreatmentArea());
				walFitStatus.setWorkArea(wealFitInfo.getWorkArea());
				walFitStatus.setLeisureArea(wealFitInfo.getLeisureArea());
				walFitStatus.setOtherArea(wealFitInfo.getOtherArea());
				walFitStatus.setRegFund(wealFitInfo.getRegFund());
				walFitStatus.setBusinessScope(wealFitInfo.getBusinessScope());
				walFitStatus.setMorgArea(wealFitApply.getMorgArea());//存入业务表中的行政区划，即为企业的地区
				walFitStatus.setMorgName(wealFitApply.getMorgName());
				
				wealFitStatusDomain.update(walFitStatus);
			}
			
		}else if("true".equals((String)wfMap.get("isEnd"))&&"1".equals(option.substring(0, 1))){
			wealFitApply.setApplyStauts("5");
		}
		wealFitApplysDomain.update(wealFitApply);
		
		
	}
	/**
	 * 创建并发起换证业务流程
	 */
	public void createAndSendCertChange(ParameterSet pset) {
		Record record = (Record) pset.getParameter("record");
		String taskCode=(String) record.get("TASK_CODE");
		
		String serviceName = "假肢和矫形器企业换证";
		
		// 向表WEAL_FIT_APPLY表中更新记录【审批表】
		pset.clear();
		pset.setParameter("TASK_CODE", taskCode);
		WealFitApply wealFitApply  =(WealFitApply) wealFitApplysDomain.query(pset).getRecord(0).toBean(WealFitApply.class);
		wealFitApply.setAcceptAddOpinion("");
		wealFitApply.setAcceptBaseOpinion("");
		wealFitApply.setAcceptTime(DateUtil.getTime());
		wealFitApply.setApplyStauts("3");
		wealFitApplysDomain.update(wealFitApply);

		String procDefUniqueId = "8a898bf33f4080cd013f408cbf770006";
		// 通过流程唯一ID获得流程第一个环节ID
		String startActDefUniqueId = (String)WfQuery.getActDefInfoByProcDefUniqueIdAndActDefId(procDefUniqueId,"act1").get("actDefUniqueId");
		//String startActDefUniqueId ="8a898bd33e4f0ac3013e4fa35dcc03fe";
		// 调用创建并发送流程接口
		CommandContext.setContextParameter("procDefUniqueId",procDefUniqueId);
		CommandContext.setContextParameter("startActDefUniqueId",startActDefUniqueId);
		
		Map<String, String> context = new HashMap<String, String>();
		String organId = BspUtil.getParentStrId();
		String currentOrganName = BspUtil.getCorpOrgan().getOrganName();
		context.put("ORGANID", BspUtil.getDeptStruId());
		context.put("CONDITION","PASS");
		Map<String, String> map = WfTaskRequestWrapper.getInstance().createAndSend(taskCode, currentOrganName + serviceName, context);
		//String processId = map.get("processId");
	}
	/**
	 * 发送换证业务流程
	 */
	public void sendCertChange(ParameterSet pset) {
		Record record = (Record) pset.getParameter("record");
		String option = (String) pset.getParameter("option");
		Map context = new HashMap();
		context.put("ORGANID", BspUtil.getDeptStruId());
		//判定流程走向
		if(!"".equals(option)&&"0".equals(option.substring(0, 1))){
			context.put("CONDITION","PASS");
		}else if(!"".equals(option)&&"1".equals(option.substring(0, 1))){
			context.put("CONDITION","END");
		}else if(!"".equals(option)&&"2".equals(option.substring(0, 1))){
			context.put("CONDITION","FILL");
		}else{
			context.put("CONDITION","PASS");
		}
		
		
		Map wfMap = WfTaskRequestWrapper.getInstance().send(context);
		WealFitApply wealFitApply  =(WealFitApply) record.toBean(WealFitApply.class);
		if("true".equals((String)wfMap.get("isEnd"))&&"0".equals(option.substring(0, 1))){
			//修改业务状态标志
			wealFitApply.setApplyStauts("4");
			wealFitApply.setApproveDate(DateUtil.getDay());
			ParameterSet pset1=new ParameterSet();
			pset1.setParameter("TASK_CODE@=", (String)record.get("taskCode"));
			DataSet infoDs=wealFitInfoDomain.query(pset1);
			WealFitInfo wealFitInfo=new WealFitInfo();
			if(infoDs.getCount()>0){
				wealFitInfo=(WealFitInfo)infoDs.getRecord(0).toBean(WealFitInfo.class);
			}
			ParameterSet pset2=new ParameterSet();
			pset2.setParameter("FIT_ID@=", wealFitApply.getFitId());
			DataSet sds = wealFitStatusDomain.query(pset2);
			if(sds.getCount()>0){
				
				//插入状态表信息
				WealFitStatus walFitStatus=(WealFitStatus)sds.getRecord(0).toBean(WealFitStatus.class);
				walFitStatus.setTaskCode((String)record.get("taskCode"));
				int year=Integer.parseInt(walFitStatus.getNextChagneCert())+3;
				walFitStatus.setNextChagneCert(year+"");//每次换证流程之后，状态表下次换证年份加3;
				//通过信息表更新状态表信息
				walFitStatus.setApplyYear(wealFitInfo.getApplyYear());//更新状态表年度
				walFitStatus.setCompanyName(wealFitInfo.getCompanyName());
				walFitStatus.setAddress(wealFitInfo.getAddress());
				walFitStatus.setPostCode(wealFitInfo.getPostCode());
				walFitStatus.setLegalPeople(wealFitInfo.getLegalPeople());
				walFitStatus.setLegalIdCard(wealFitInfo.getLegalIdCard());
				walFitStatus.setLegalPhone(wealFitInfo.getLegalPhone());
				walFitStatus.setLegalTelphone(wealFitInfo.getLegalTelphone());
				walFitStatus.setLegalEmail(wealFitInfo.getLegalEmail());
				walFitStatus.setAgentPeople(wealFitInfo.getAgentPeople());
				walFitStatus.setAgentIdCard(wealFitInfo.getAgentIdCard());
				walFitStatus.setAgentPhone(wealFitInfo.getAgentPhone());
				walFitStatus.setAgentTelphone(wealFitInfo.getAgentTelphone());
				walFitStatus.setAgentEmail(wealFitInfo.getAgentEmail());
				walFitStatus.setWebAddress(wealFitInfo.getWebAddress());
				walFitStatus.setEconomicNatureCode(wealFitInfo.getEconomicNatureCode());
				walFitStatus.setEconomicNatureName(wealFitInfo.getEconomicNatureName());
				walFitStatus.setOrganCode(wealFitInfo.getOrganCode());
				walFitStatus.setLicenseCode(wealFitInfo.getLicenseCode());
				walFitStatus.setRegistrationCode(wealFitInfo.getRegistrationCode());
				walFitStatus.setOperateArea(wealFitInfo.getOperateArea());
				walFitStatus.setProductArea(wealFitInfo.getProductArea());
				walFitStatus.setRecoveryArea(wealFitInfo.getRecoveryArea());
				walFitStatus.setReceptionArea(wealFitInfo.getReceptionArea());
				walFitStatus.setTrainArea(wealFitInfo.getTrainArea());
				walFitStatus.setTreatmentArea(wealFitInfo.getTreatmentArea());
				walFitStatus.setWorkArea(wealFitInfo.getWorkArea());
				walFitStatus.setLeisureArea(wealFitInfo.getLeisureArea());
				walFitStatus.setOtherArea(wealFitInfo.getOtherArea());
				walFitStatus.setRegFund(wealFitInfo.getRegFund());
				walFitStatus.setBusinessScope(wealFitInfo.getBusinessScope());
				walFitStatus.setMorgArea(wealFitApply.getMorgArea());//存入业务表中的行政区划，即为企业的地区
				walFitStatus.setMorgName(wealFitApply.getMorgName());
				wealFitStatusDomain.update(walFitStatus);
			}
			//插入证书信息
			WealCert wealCert = new WealCert();
			wealCert.setTaskCode((String)record.get("taskCode"));
			wealCert.setCompanyType("1");
			wealCert.setCertType("3");//3：每3年换证
			wealCert.setSerialNum(wealFitInfo.getSerialNum());
			wealCert.setCompanyName(wealFitInfo.getCompanyName());
			wealCert.setCompanyAddress(wealFitInfo.getAddress());
			wealCert.setLegalPeople(wealFitInfo.getLegalPeople());
			wealCert.setOrganType(wealFitInfo.getEconomicNatureCode());
			wealCert.setSiteArea(wealFitInfo.getOperateArea());
			wealCert.setCertStatus("1");
			wealCert.setBusinessScope(wealFitInfo.getBusinessScope());
			wealCert.setApproveDate(wealFitApply.getApproveDate());
			wealCertDomain.insert(wealCert);
			
		}else if("true".equals((String)wfMap.get("isEnd"))&&"1".equals(option.substring(0, 1))){
			wealFitApply.setApplyStauts("5");
		}
		wealFitApplysDomain.update(wealFitApply);
	}
	
}
