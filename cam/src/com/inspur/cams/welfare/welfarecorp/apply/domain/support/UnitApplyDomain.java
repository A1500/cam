package com.inspur.cams.welfare.welfarecorp.apply.domain.support;

import java.text.SimpleDateFormat;
import java.util.Date;
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
import com.inspur.cams.welfare.base.data.WealUnitApply;
import com.inspur.cams.welfare.base.data.WealUnitInfo;
import com.inspur.cams.welfare.base.data.WealUnitStatus;
import com.inspur.cams.welfare.base.domain.IWealCertDomain;
import com.inspur.cams.welfare.base.domain.IWealComfortNoDomain;
import com.inspur.cams.welfare.base.domain.IWealUnitApplyDomain;
import com.inspur.cams.welfare.base.domain.IWealUnitInfoDomain;
import com.inspur.cams.welfare.base.domain.IWealUnitStatusDomain;
import com.inspur.cams.welfare.base.domain.support.WealWorkerDomain;
import com.inspur.cams.welfare.welfarecorp.apply.domain.IUnitApplyDomain;
/**
 * 社会福利企业资格认定
 * 
 * @author liuxin
 * @date 2013-06-08
 */
public class UnitApplyDomain implements IUnitApplyDomain {
	@Reference
	private IWealUnitApplyDomain wealUnitApplysDomain;
	@Reference
	private IWealUnitInfoDomain wealUnitInfoDomain;
	@Reference
	private IWealUnitStatusDomain wealUnitStatusDomain;
	@Reference
	private WealWorkerDomain wealWorkerDomain;
	@Reference
	private IWealComfortNoDomain wealComfortNoDomain;
	@Reference
	private IWealCertDomain wealCertDomain;

	// 资格认定信息采集第一页保存——插入业务表和信息表数据
	public void saveQualification(Record infoRecord,String dataSource,HttpServletRequest request) {
		WealUnitInfo wealUnitInfo = (WealUnitInfo) infoRecord
				.toBean(WealUnitInfo.class);
		ParameterSet pset1 = new ParameterSet();
		pset1.setParameter("TASK_CODE@=", wealUnitInfo.getTaskCode());
		DataSet infoDs = wealUnitInfoDomain.query(pset1);
		if (infoDs.getCount() < 1) {
			wealUnitInfoDomain.insert(wealUnitInfo);
		} else {
			wealUnitInfoDomain.update(wealUnitInfo);
		}
		WealUnitApply wealUnitApply = new WealUnitApply();
		DataSet applyDs = wealUnitApplysDomain.query(pset1);
		if (applyDs.getCount() < 1) {
			wealUnitApply.setTaskCode(wealUnitInfo.getTaskCode());
			wealUnitApply.setApplyType(wealUnitInfo.getApplyType());
			wealUnitApply.setUnitId(IdHelp.getUUID32());
			if("ONLINE".equals(dataSource)){
				wealUnitApply.setDataSource("ONLINE");
				wealUnitApply.setApplyStauts("1");
				wealUnitApply.setMorgArea(ExtBspInfo.getUserInfo(request).getAreaCode());//当前登录用户，即为企业地区区划
				wealUnitApply.setMorgName(ExtBspInfo.getUserInfo(request).getAreaName());
			}else{
				wealUnitApply.setDataSource("LOCAL");
				wealUnitApply.setApplyStauts("0");
				wealUnitApply.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());//当前登录用户，即为企业地区区划
				wealUnitApply.setMorgName(BspUtil.getCorpOrgan().getOrganName());
			}
			
			wealUnitApply.setRegDate(wealUnitInfo.getRegDate());
			wealUnitApplysDomain.insert(wealUnitApply);
		} else {
			wealUnitApplysDomain.update(wealUnitApply);
		}
	}

	// 年检信息采集第一页(根据字号回填)保存——插入业务表和信息表数据
	public void saveQualificationD(Record StatusRecord,String taskCode,String applyType,String dataSource) {
		WealUnitStatus statusBean = (WealUnitStatus) StatusRecord
				.toBean(WealUnitStatus.class);
		ParameterSet pset1 = new ParameterSet();
		pset1.setParameter("TASK_CODE@=", taskCode);
		WealUnitInfo infoBean = new WealUnitInfo();
		DataSet infoDs = wealUnitInfoDomain.query(pset1);
		
		//获取当前时间作为填表时间
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String regDate = format.format(new Date());
		// 将状态表信息维护到业务表
		if (infoDs.getCount() < 1) {
			infoBean.setTaskCode(taskCode);
			infoBean.setSerialNum(statusBean.getSerialNum());
			// 时间
			infoBean.setRegDate(regDate);
			// 企业名称
			infoBean.setCompanyName(statusBean.getCompanyName());
			// 通讯地址
			infoBean.setAddress(statusBean.getAddress());
			// 邮编
			infoBean.setPostCode(statusBean.getPostCode());
			// 法定代表人
			infoBean.setLegalPeople(statusBean.getLegalPeople());
			infoBean.setLegalIdCard(statusBean.getLegalIdCard());
			infoBean.setLegalPhone(statusBean.getLegalPhone());
			infoBean.setLegalTelphone(statusBean.getLegalTelphone());
			// 经办人
			infoBean.setAgentPeople(statusBean.getAgentPeople());
			// 联系电话
			infoBean.setAgentPhone(statusBean.getAgentPhone());
			// 电子邮箱
			infoBean.setAgentEmail(statusBean.getAgentEmail());
			// 网站地址
			infoBean.setWebAddress(statusBean.getWebAddress());
			// 经济性质
			infoBean.setEconomicNatureCode(statusBean.getEconomicNatureCode());
			infoBean.setEconomicNatureName(statusBean.getEconomicNatureName());
			// 组织机构代码
			infoBean.setOrganCode(statusBean.getOrganCode());
			// 营业执照编号
			infoBean.setLicenseCode(statusBean.getLicenseCode());
			// 税务登记编号
			infoBean.setRegistrationCode(statusBean.getRegistrationCode());
			// 业务类型
			infoBean.setApplyType("2");
			// 经营范围 主营
			infoBean.setFirstScope(statusBean.getFirstScope());
			// 经营范围 兼营
			infoBean.setSecondScope(statusBean.getSecondScope());
			// 注册资金
			infoBean.setRegFund(statusBean.getRegFund());
			//年度
			infoBean.setApplyYear(statusBean.getNextCheck());//根据下一次年检年度，维护info表中年度字段
			wealUnitInfoDomain.insert(infoBean);
		} else {
			wealUnitInfoDomain.update(infoBean);
		}
		
		//业务表维护
		WealUnitApply applyBean=new WealUnitApply();
		DataSet applyDs=wealUnitApplysDomain.query(pset1);
		if(applyDs.getCount()<1){
			applyBean.setTaskCode(taskCode);
			applyBean.setUnitId(statusBean.getUnitId());
			if("ONLINE".equals(dataSource)){
				applyBean.setDataSource("ONLINE");
				applyBean.setApplyStauts("1");
			}else{
				applyBean.setDataSource("LOCAL");
				applyBean.setApplyStauts("0");
			}
			
			if("3".equals(applyType)){
				applyBean.setApplyType("3");//在换证的时候传递此参数applyType=3
			}else{
				applyBean.setApplyType("2");
			}
			applyBean.setMorgArea(statusBean.getMorgArea());
			applyBean.setMorgName(statusBean.getMorgName());
			applyBean.setRegDate(regDate);
			wealUnitApplysDomain.insert(applyBean);
		}else{
			wealUnitApplysDomain.update(applyBean);
		}

	}

	// 资格认定信息采集第二页保存——基本信息
	public void saveQualificationInfo(Record infoRecord) {
		WealUnitInfo infoBean = (WealUnitInfo) infoRecord
				.toBean(WealUnitInfo.class);
		ParameterSet pset1 = new ParameterSet();
		pset1.setParameter("TASK_CODE@=", infoBean.getTaskCode());
		DataSet infoDs = wealUnitInfoDomain.query(pset1);
		if (infoDs.getCount() < 1) {
			wealUnitInfoDomain.insert(infoBean);
		} else {
			wealUnitInfoDomain.update(infoBean);
		}
		
		//业务表维护
		WealUnitApply applyBean=new WealUnitApply();
		DataSet applyDs=wealUnitApplysDomain.query(pset1);
		if(applyDs.getCount()<1){
			applyBean.setTaskCode(infoBean.getTaskCode());
			applyBean.setUnitId(IdHelp.getUUID32());
			applyBean.setDataSource("LOCAL");
			applyBean.setApplyStauts("0");
			applyBean.setApplyType(infoBean.getApplyType());
			applyBean.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
			applyBean.setMorgName(BspUtil.getCorpOrgan().getOrganName());
			applyBean.setRegDate(infoBean.getRegDate());
			wealUnitApplysDomain.insert(applyBean);
		}else{
			wealUnitApplysDomain.update(applyBean);
		}
	}
	
	/**
	 * 福利企业年检删除
	 */
	@Trans
	public void someDelete(String taskCode){
		//信息表删除
		wealUnitInfoDomain.delete(taskCode);
		//业务表删除
		wealUnitApplysDomain.delete(taskCode);
	}

	// 资格认定信息采集第三页保存——申请理由
	public void saveQualificationT(Record infoRecord) {
		WealUnitInfo infoBean = (WealUnitInfo) infoRecord
				.toBean(WealUnitInfo.class);
		ParameterSet pset1 = new ParameterSet();
		pset1.setParameter("TASK_CODE@=", infoBean.getTaskCode());
		DataSet infoDs = wealUnitInfoDomain.query(pset1);
		if (infoDs.getCount() < 1) {
			wealUnitInfoDomain.insert(infoBean);
		} else {
			wealUnitInfoDomain.update(infoBean);
		}
	}

	// 保存业务信息
	public void saveUnitApply(ParameterSet pset) {
		Record record = (Record) pset.getParameter("record");
		WealUnitApply wealUnitApply = (WealUnitApply) record
				.toBean(WealUnitApply.class);
		wealUnitApplysDomain.update(wealUnitApply);
	}

	public void createAndSendQualification(ParameterSet pset) {
		Record record = (Record) pset.getParameter("record");
		String taskCode=(String) record.get("TASK_CODE");
		
		String serviceName = "福利企业资格认定";
		
		// 向表WEAL_UNIT_APPLY表中更新记录【审批表】
		pset.clear();
		pset.setParameter("TASK_CODE", taskCode);
		WealUnitApply wealUnitApply  =(WealUnitApply) wealUnitApplysDomain.query(pset).getRecord(0).toBean(WealUnitApply.class);
		wealUnitApply.setAcceptAddOpinion("");
		wealUnitApply.setAcceptBaseOpinion("");
		wealUnitApply.setAcceptTime(DateUtil.getTime());
		wealUnitApply.setApplyStauts("3");
		wealUnitApplysDomain.update(wealUnitApply);

		String procDefUniqueId = "8a898bf33f79d6a1013f7a542ea6000a";
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
		//context.put("CONDITION","PASS");
		Map<String, String> map = WfTaskRequestWrapper.getInstance().createAndSend(taskCode, currentOrganName + serviceName, context);
		//String processId = map.get("processId");
	}

	public void sendQualification(ParameterSet pset) {
		// TODO Auto-generated method stub
		Record record = (Record) pset.getParameter("record");
		String option = (String) pset.getParameter("option");
		String actDefName = (String)pset.getParameter("actDefName");
		Map context = new HashMap();
		if (actDefName.equals("县级局长审批"))
	      context.put("ORGANID", BspUtil.getParentStrId());
	    else {
	      context.put("ORGANID", BspUtil.getDeptStruId());
	    }
		//判定流程走向
		/*if(!"".equals(option)&&"0".equals(option.substring(0, 1))){
			context.put("CONDITION","PASS");
		}else if(!"".equals(option)&&"1".equals(option.substring(0, 1))){
			context.put("CONDITION","END");
		}else if(!"".equals(option)&&"2".equals(option.substring(0, 1))){
			context.put("CONDITION","FILL");
		}else{
			context.put("CONDITION","PASS");
		}*/
		String direction = (String) pset.getParameter("direction");
		if("1".equals(direction)){
			context.put("CONDITION","PASS");//流程走向市级
		}else if("0".equals(direction)){
			context.put("CONDITION","END");//流程走向结束
		}
		Map wfMap = WfTaskRequestWrapper.getInstance().send(context);
		WealUnitApply wealUnitApply  =(WealUnitApply) record.toBean(WealUnitApply.class);
		if("true".equals((String)wfMap.get("isEnd"))&&"0".equals(option.substring(0, 1))){
			//修改业务状态标志
			wealUnitApply.setApplyStauts("4");
			//wealUnitApply.setApproveDate(DateUtil.getDay());
			ParameterSet pset1=new ParameterSet();
			pset1.setParameter("TASK_CODE@=", (String)record.get("taskCode"));
			DataSet infoDs=wealUnitInfoDomain.query(pset1);
			if(infoDs.getCount()>0){
				int year=Integer.parseInt(DateUtil.getDay().substring(0, 4));
				//插入字号
				WealUnitInfo infoBean=(WealUnitInfo)infoDs.getRecord(0).toBean(WealUnitInfo.class);
				infoBean.setSerialNum(wealComfortNoDomain.getNO("F", BspUtil.getCorpOrgan().getOrganCode()));
				infoBean.setApplyYear(year+"");
				wealUnitInfoDomain.update(infoBean);
				
				//插入状态表信息
				WealUnitStatus walUnitStatus=(WealUnitStatus)infoDs.getRecord(0).toBean(WealUnitStatus.class);
				walUnitStatus.setUnitId(wealUnitApply.getUnitId());
				walUnitStatus.setApplyYear(year+"");
				//String moday= DateUtil.getDay().substring(4);
				walUnitStatus.setNextCheck(year+1+"");
				walUnitStatus.setState(1);
				walUnitStatus.setStatus("1");
				walUnitStatus.setSerialNum(infoBean.getSerialNum());
				walUnitStatus.setTaskCode((String)record.get("taskCode"));
				//批准时间为县级或市级局长审批时间
				if("1".equals(direction)){
					walUnitStatus.setApproveDate(wealUnitApply.getCityChiefTime());
				}else{
					walUnitStatus.setApproveDate(wealUnitApply.getCountyChiefTime());
				}
				walUnitStatus.setMorgArea(wealUnitApply.getMorgArea());//存入业务表中的行政区划，即为企业的地区
				walUnitStatus.setMorgName(wealUnitApply.getMorgName());
				wealUnitStatusDomain.insert(walUnitStatus);
				//插入证书信息
				WealCert wealCert = new WealCert();
				wealCert.setTaskCode((String)record.get("taskCode"));
				wealCert.setCompanyType("2");
				wealCert.setCertType("1");
				wealCert.setSerialNum(infoBean.getSerialNum());
				wealCert.setCompanyName(infoBean.getCompanyName());
				wealCert.setCompanyAddress(infoBean.getAddress());
				wealCert.setLegalPeople(infoBean.getLegalPeople());
				wealCert.setOrganType(infoBean.getEconomicNatureCode());
				wealCert.setCertStatus("1");
				wealCert.setBusinessScope(infoBean.getFirstScope());
				wealCert.setApproveDate(walUnitStatus.getApproveDate());
				wealCertDomain.insert(wealCert);
				
			}
			
		}else if("true".equals((String)wfMap.get("isEnd"))&&"1".equals(option.substring(0, 1))){
			wealUnitApply.setApplyStauts("5");
		}
		wealUnitApplysDomain.update(wealUnitApply);
	}
	

	public void createAndSendYearlyCheck(ParameterSet pset) {
		Record record = (Record) pset.getParameter("record");
		String taskCode=(String) record.get("TASK_CODE");
		
		String serviceName = "福利企业资格认定";
		
		// 向表WEAL_UNIT_APPLY表中更新记录【审批表】
		pset.clear();
		pset.setParameter("TASK_CODE", taskCode);
		WealUnitApply wealUnitApply  =(WealUnitApply) wealUnitApplysDomain.query(pset).getRecord(0).toBean(WealUnitApply.class);
		wealUnitApply.setAcceptAddOpinion("");
		wealUnitApply.setAcceptBaseOpinion("");
		wealUnitApply.setAcceptTime(DateUtil.getTime());
		wealUnitApply.setApplyStauts("3");
		wealUnitApplysDomain.update(wealUnitApply);

		String procDefUniqueId = "8a898bf33f8326e5013f833f3f6e0001";
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
		//context.put("CONDITION","PASS");
		Map<String, String> map = WfTaskRequestWrapper.getInstance().createAndSend(taskCode, currentOrganName + serviceName, context);
		//String processId = map.get("processId");

	}

	
	public void sendYearlyCheck(ParameterSet pset) {
		// TODO Auto-generated method stub
		Record record = (Record) pset.getParameter("record");
		String option = (String) pset.getParameter("option");
		String actDefName = (String)pset.getParameter("actDefName");
		Map context = new HashMap();
		if(actDefName.equals("县级局长审批")){
			 context.put("ORGANID", BspUtil.getParentStrId());
		}else{
			 context.put("ORGANID", BspUtil.getDeptStruId());
		}
		//判定流程走向
		/*if(!"".equals(option)&&"0".equals(option.substring(0, 1))){
			context.put("CONDITION","PASS");
		}else if(!"".equals(option)&&"1".equals(option.substring(0, 1))){
			context.put("CONDITION","END");
		}else if(!"".equals(option)&&"2".equals(option.substring(0, 1))){
			context.put("CONDITION","FILL");
		}else{
			context.put("CONDITION","PASS");
		}*/
		String direction = (String) pset.getParameter("direction");
		if("1".equals(direction)){
			context.put("CONDITION","PASS");//流程走向市级
		}else if("0".equals(direction)){
			context.put("CONDITION","END");//流程走向结束
		}
		Map wfMap = WfTaskRequestWrapper.getInstance().send(context);
		WealUnitApply wealUnitApply  =(WealUnitApply) record.toBean(WealUnitApply.class);
		if("true".equals((String)wfMap.get("isEnd"))&&"0".equals(option.substring(0, 1))){
			//修改业务状态标志
			wealUnitApply.setApplyStauts("4");
			//wealUnitApply.setApproveDate(DateUtil.getDay());
			ParameterSet pset1=new ParameterSet();
			pset1.setParameter("TASK_CODE@=", (String)record.get("taskCode"));
			DataSet infoDs=wealUnitInfoDomain.query(pset1);
			WealUnitInfo infoBean=new WealUnitInfo();
			if(infoDs.getCount()>0){
			
				infoBean=(WealUnitInfo)infoDs.getRecord(0).toBean(WealUnitInfo.class);
			}
			ParameterSet pset2=new ParameterSet();
			pset2.setParameter("UNIT_ID@=", wealUnitApply.getUnitId());
			DataSet sds = wealUnitStatusDomain.query(pset2);
			if(sds.getCount()>0){
				
				//插入状态表信息
				WealUnitStatus wealUnitStatus=(WealUnitStatus)sds.getRecord(0).toBean(WealUnitStatus.class);
				int year=Integer.parseInt(wealUnitStatus.getNextCheck())+1;
				wealUnitStatus.setNextCheck(year+"");//每次年检流程之后，状态表下次年检加1;
				wealUnitStatus.setTaskCode((String)record.get("taskCode"));
				//通过信息表更新状态表信息
				wealUnitStatus.setApplyYear(infoBean.getApplyYear());//更新状态表年度
				wealUnitStatus.setSerialNum(infoBean.getSerialNum());
				wealUnitStatus.setCompanyName(infoBean.getCompanyName());
				wealUnitStatus.setLegalPeople(infoBean.getLegalPeople());
				wealUnitStatus.setAddress(infoBean.getAddress());
				wealUnitStatus.setPostCode(infoBean.getPostCode());
				wealUnitStatus.setAgentPeople(infoBean.getAgentPeople());
				wealUnitStatus.setAgentPhone(infoBean.getAgentPhone());
				wealUnitStatus.setAgentEmail(infoBean.getAgentEmail());
				wealUnitStatus.setWebAddress(infoBean.getWebAddress());
				wealUnitStatus.setEconomicNatureCode(infoBean.getEconomicNatureCode());
				wealUnitStatus.setEconomicNatureName(infoBean.getEconomicNatureName());
				wealUnitStatus.setOrganCode(infoBean.getOrganCode());
				wealUnitStatus.setLicenseCode(infoBean.getLicenseCode());
				wealUnitStatus.setRegistrationCode(infoBean.getRegistrationCode());
				wealUnitStatus.setRegFund(infoBean.getRegFund());
				wealUnitStatus.setFirstScope(infoBean.getFirstScope());
				wealUnitStatus.setSecondScope(infoBean.getSecondScope());
				//批准时间为县级或市级局长审批时间
				/*if("1".equals(direction)){
					wealUnitStatus.setApproveDate(wealUnitApply.getCityChiefTime());
				}else{
					wealUnitStatus.setApproveDate(wealUnitApply.getCountyChiefTime());
				}*/
				wealUnitStatus.setMorgArea(wealUnitApply.getMorgArea());//存入业务表中的行政区划，即为企业的地区
				wealUnitStatus.setMorgName(wealUnitApply.getMorgName());
				wealUnitStatusDomain.update(wealUnitStatus);
			}
			
		}else if("true".equals((String)wfMap.get("isEnd"))&&"1".equals(option.substring(0, 1))){
			wealUnitApply.setApplyStauts("5");
		}
		wealUnitApplysDomain.update(wealUnitApply);
	}

}
