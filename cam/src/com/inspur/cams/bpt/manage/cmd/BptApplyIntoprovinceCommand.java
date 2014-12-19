package com.inspur.cams.bpt.manage.cmd;

import java.util.HashMap;
import java.util.Map;

import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.next.web.cmd.CommandContext;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;
import org.loushang.workflow.api.WfQuery;
import org.loushang.workflow.api.WfTaskRequestWrapper;

import com.inspur.cams.bpt.base.data.BptApplyDisabilityNotice;
import com.inspur.cams.bpt.base.data.BptApplyHistory;
import com.inspur.cams.bpt.base.data.BptApplyIntoprovince;
import com.inspur.cams.bpt.base.data.BptPeople;
import com.inspur.cams.bpt.base.data.BptPeopleDemobilized;
import com.inspur.cams.bpt.base.data.BptPeopleDemobilizedIllness;
import com.inspur.cams.bpt.base.data.BptPeopleDependant;
import com.inspur.cams.bpt.base.data.BptPeopleDisability;
import com.inspur.cams.bpt.base.data.BptPeopleTested;
import com.inspur.cams.bpt.base.data.BptPeopleWar;
import com.inspur.cams.bpt.base.data.BptStateChange;
import com.inspur.cams.bpt.base.data.DisabilityIdentification;
import com.inspur.cams.bpt.base.data.WfProcessBusiness;
import com.inspur.cams.bpt.base.domain.IBptApplyHistoryDomain;
import com.inspur.cams.bpt.base.domain.IBptApplyIntoprovinceDomain;
import com.inspur.cams.bpt.base.domain.IBptComfortNoDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDemobilizedDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDemobilizedIllnessDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDependantDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDisabilityDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleTestedDomain;
import com.inspur.cams.bpt.base.domain.IBptStateChangeDomain;
import com.inspur.cams.bpt.base.domain.IWarDomain;
import com.inspur.cams.bpt.base.domain.IWfProcessBusinessDomain;
import com.inspur.cams.bpt.base.domain.support.BptComfortNoDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.bpt.util.BptConstant;
import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.PhotoUtil;

/**
 * @description:外省优抚人员抚恤关系迁入我省
 * @author:
 * @since:2011-07-14
 * @version:1.0
 */
public class BptApplyIntoprovinceCommand extends BaseAjaxCommand {

	// 状态变更接口
	private IBptStateChangeDomain stateChangeService = ScaComponentFactory
			.getService(IBptStateChangeDomain.class,
					"bptStateChangeDomain/bptStateChangeDomain");

	IBptGroupDomain service = ScaComponentFactory.getService(
			IBptGroupDomain.class, "bptGroupDomain/bptGroupDomain");

	/**
	 * 获得【外省优抚人员抚恤关系迁入我省】服务接口
	 */
	private IBptApplyIntoprovinceDomain bptApplyIntoprovinceService = ScaComponentFactory
			.getService(IBptApplyIntoprovinceDomain.class,
					"BptApplyIntoprovinceDomain/BptApplyIntoprovinceDomain");

	/**
	 * 获得优抚人员服务接口
	 */
	IBptPeopleDomain bptPeopleService = ScaComponentFactory.getService(
			IBptPeopleDomain.class, "bptPeopleDomain/bptPeopleDomain");

	/**
	 * 工作流信息服务接口
	 */
	IWfProcessBusinessDomain wfProcessBusinessService = ScaComponentFactory
			.getService(IWfProcessBusinessDomain.class,
					"wfProcessBusinessDomain/wfProcessBusinessDomain");

	/**
	 * 获得参试人员服务接口
	 */
	IBptPeopleTestedDomain bptPeopleTestedService = ScaComponentFactory
			.getService(IBptPeopleTestedDomain.class,
					"bptPeopleTestedDomain/bptPeopleTestedDomain");

	IBptPeopleDemobilizedIllnessDomain demobilizedIllnessService = ScaComponentFactory
			.getService(IBptPeopleDemobilizedIllnessDomain.class,
					"demobilizedIllnessDomain/demobilizedIllnessDomain");

	/**
	 * 审批记录历史服务接口
	 */
	IBptApplyHistoryDomain bptApplyHistoryService = ScaComponentFactory
			.getService(IBptApplyHistoryDomain.class,
					"BptApplyHistoryDomain/BptApplyHistoryDomain");
	/**
	 * 获得生成证书编号接口
	 * 
	 */
	IBptComfortNoDomain NOService = ScaComponentFactory.getService(BptComfortNoDomain.class,"bptComfortNoDomain/bptComfortNoDomain");
	/**
	 * 获取伤残审批信息判定是否提交
	 * 
	 * @return
	 */
	public void queryApplyInfo() {
		ParameterSet pset = getParameterSet();
		DataSet ds = bptApplyIntoprovinceService.query(pset);
		if (ds.getCount() > 0) {
			String townAduitIncharge = (String) ds.getRecord(0).get(
					"townAduitIncharge");
			this.setReturn("townAduitIncharge", townAduitIncharge);
		}
	}

	/**
	 * 添加一条记录
	 */
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		BptApplyIntoprovince dataBean = (BptApplyIntoprovince) record
				.toBean(BptApplyIntoprovince.class);
		bptApplyIntoprovinceService.insert(dataBean);
	}

	/**
	 * 修改一条记录
	 */
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		BptApplyIntoprovince dataBean = (BptApplyIntoprovince) record
				.toBean(BptApplyIntoprovince.class);
		bptApplyIntoprovinceService.update(dataBean);
	}

	/**
	 * 删除抚恤关系跨省迁入
	 * 
	 * @param pset
	 * @return
	 */
	@Trans
	public void deleteIntoprovince() {
		Record[] records = (Record[]) getParameter("records");
		ParameterSet pset = new ParameterSet();
		for (Record record : records) {
			String applyId = (String) record.get("APPLY_ID");
			String peopleId = (String) record.get("PEOPLE_ID");
			String type = (String) record.get("SERVICE_TYPE");
			pset.setParameter("applyId", applyId);
			pset.setParameter("peopleId", peopleId);
			pset.setParameter("type", type);
			bptApplyIntoprovinceService.deleteIntoprovince(pset);
		}
	}

	/**
	 * 发起外省优抚人员抚恤关系迁入流程
	 */
	@SuppressWarnings("unchecked")
	@Trans
	public void createAndSendIntoProvince(){
		String applyId;
		String peopleId;
		String serviceType;
		Record intoProvinceRecord = (Record) getParameter("record");
		if (intoProvinceRecord != null && !"".equals(intoProvinceRecord)) {
			applyId = intoProvinceRecord.get("APPLY_ID").toString();
			peopleId = intoProvinceRecord.get("PEOPLE_ID").toString();
			serviceType = intoProvinceRecord.get("SERVICE_TYPE").toString();
		} else {
			applyId = (String)getParameter("applyId");
			peopleId = (String)getParameter("peopleId");
			serviceType = (String)getParameter("serviceType");
		}
		String contion = (String)getParameter("contion");
		ParameterSet pset = getParameterSet();
		String serviceName = new String();
		ParameterSet pset1 = new ParameterSet();
		pset1.setParameter("PEOPLE_ID", peopleId);
		BaseinfoPeople baseinfoPeople = (BaseinfoPeople) service.queryPeople(
				pset1).getRecord(0).toBean(BaseinfoPeople.class);
		
		String state="";
		
		//伤残
		if((BptConstant.BPT_DISABILITY_INGOINGPROVINCE).equals(serviceType)){
			serviceName = BptConstant.BPT_DISABILITY_INGOINGPROVINCE_NA;
			state = baseinfoPeople.getDisabilityStateCode();
			baseinfoPeople.setDisabilityStateCode("5"); // 将伤残状态改为迁移
		}
		//三属
		if((BptConstant.BPT_DEPENDANT_INGOINGPROVINCE).equals(serviceType)){
			serviceName = BptConstant.BPT_DEPENDANT_INGOINGPROVINCE_NA;
			state = baseinfoPeople.getDependantStateCode();
			baseinfoPeople.setDependantStateCode("5"); // 将三属状态改为迁移
		}
		//在乡
		if((BptConstant.BPT_DEMOBILIZED_INGOINGPROVINCE).equals(serviceType)){
			serviceName = BptConstant.BPT_DEMOBILIZED_INGOINGPROVINCE_NA;
			state = baseinfoPeople.getDemobilizedStateCode();
			baseinfoPeople.setDemobilizedStateCode("5"); // 将在乡状态改为迁移
		}
		//带病回乡
		if((BptConstant.BPT_DEMOBILIZEDILLNESS_INGOINGPROVINCE).equals(serviceType)){
			serviceName = BptConstant.BPT_DEMOBILIZEDILLNESS_INGOINGPROVINCE_NA;
			state = baseinfoPeople.getDemobilizedStateCode();
			baseinfoPeople.setDemobilizedStateCode("5"); // 将带病回乡状态改为迁移
		}
		//参战
		if((BptConstant.BPT_WAR_INGOINGPROVINCE).equals(serviceType)){
			serviceName = BptConstant.BPT_WAR_INGOINGPROVINCE_NA;
			state = baseinfoPeople.getWarStateCode();
			baseinfoPeople.setWarStateCode("5");// 将参战状态改为迁移
		}
		//参试
		if((BptConstant.BPT_TESTED_INGOINGPROVINCE).equals(serviceType)){
			serviceName = BptConstant.BPT_TESTED_INGOINGPROVINCE_NA;
			state = baseinfoPeople.getWarStateCode();
			baseinfoPeople.setWarStateCode("5");// 将参试状态改为迁移
		}
		// 60周岁退役士兵
		if ("82".equals(serviceType)) {
			serviceName = "年满60周岁农村籍退役士兵定补关系跨省迁入";
			state = baseinfoPeople.getRetiredStateCode();
			baseinfoPeople.setRetiredStateCode("5");// 
		}
		// 部分烈士（错杀被平反人员）子女定补关系迁入
		if ("B2".equals(serviceType)) {
			serviceName = "部分烈士（错杀被平反人员）子女定补关系跨省迁入";
			state = baseinfoPeople.getMartyrOffspringStateCode();
			baseinfoPeople.setMartyrOffspringStateCode("5");// 
		}
		service.updateBaseinfoPeople(baseinfoPeople);
		//insertStateChange( baseinfoPeople , state, "5", serviceType);
		
		//向审批表中更新记录【审批表】
		pset.clear();
		pset.setParameter("APPLY_ID", applyId);
		BptApplyIntoprovince applyDisabilityIntoprovi = (BptApplyIntoprovince)bptApplyIntoprovinceService.query(pset).getRecord(0).toBean(BptApplyIntoprovince.class);
		applyDisabilityIntoprovi.setApplyDate(DateUtil.getDay());
		applyDisabilityIntoprovi.setApplyOrganization(BspUtil.getOrganName());
		applyDisabilityIntoprovi.setTownCheckDate(DateUtil.getDay());
		applyDisabilityIntoprovi.setTownCheckPeopleId(GetBspInfo.getBspInfo().getUserName());
		applyDisabilityIntoprovi.setCommitFlag(BptConstant.COMMIT_FLAG);
		bptApplyIntoprovinceService.update(applyDisabilityIntoprovi);
		
		// 插入审批记录历史表
		BptApplyHistory bptApplyHistory = new BptApplyHistory();
		bptApplyHistory.setHistoryId(IdHelp.getUUID30());
		bptApplyHistory.setActdefName("县级审核");
		bptApplyHistory.setCreateTime(DateUtil.getTime());
		bptApplyHistory.setApplyAdvice(applyDisabilityIntoprovi.getTownAduitAdvice());
		bptApplyHistory.setApplyIncharge(applyDisabilityIntoprovi.getTownAduitIncharge());
		bptApplyHistory.setApplyTime(applyDisabilityIntoprovi.getTownAduitApproveDate());
		bptApplyHistory.setApplyId(applyId);
		bptApplyHistoryService.insert(bptApplyHistory);
		
		//调用BPM的接口发起流程
		//通过流程唯一ID获得流程第一个环节ID
		String procDefUniqueId = "8a898bd73130876e013130c83e28000d";
		String startActDefUniqueId = (String)WfQuery.getActDefInfoByProcDefUniqueIdAndActDefId(procDefUniqueId,"act2").get("actDefUniqueId");
		CommandContext.setContextParameter("procDefUniqueId",procDefUniqueId);
		CommandContext.setContextParameter("startActDefUniqueId",startActDefUniqueId);
		Map<String,String> context = new HashMap<String,String>();
		//String town_OrganId = BspUtil.getCorpStruId();
		String town_OrganId = BspUtil.getParentStrId();
		String currentOrganName =  BspUtil.getCorpOrgan().getOrganName();
		context.put("City_OrganId", town_OrganId);
		context.put("Contion", contion);
		Map<String,String> map=WfTaskRequestWrapper.getInstance().createAndSend(applyId, currentOrganName+serviceName, context);
		String processId = map.get("processId");
		
		//向表WF_PROCESS_BUSINESS【流程与业务关联表】表中添加一条记录
		WfProcessBusiness wfProcessBusiness = new WfProcessBusiness();
		wfProcessBusiness.setProcessId(processId);
		wfProcessBusiness.setBusinessId(applyId);
		wfProcessBusiness.setConnectId(peopleId);
		wfProcessBusiness.setBusinessType(serviceType);
		wfProcessBusiness.setIfback("n");
		wfProcessBusinessService.insert(wfProcessBusiness);
	}


	/**
	 * 获取人员信息
	 */
	public BaseinfoPeople getPeopleInfo() {
		Record baseinfoPeopleRecord = (Record) getParameter("BaseinfoPeopleRecord");
		BaseinfoPeople bean = (BaseinfoPeople) baseinfoPeopleRecord
				.toBean(BaseinfoPeople.class);
		bean.setRegId(BspUtil.getEmpOrganId());
		bean.setRegTime(DateUtil.getTime());
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		bean.setPersonalStatsTag("0");
		return bean;
	}

	/**
	 * *获取家庭信息
	 */
	public BaseinfoFamily getBaseinfoFamily() {
		Record baseinfoPeopleRecord = (Record) getParameter("BaseinfoPeopleRecord");
		BaseinfoFamily bean = new BaseinfoFamily();
		bean.setFamilyId(baseinfoPeopleRecord.get("familyId").toString());
		bean.setFamilyName(baseinfoPeopleRecord.get("name").toString());
		bean.setFamilyCardNo(baseinfoPeopleRecord.get("idCard").toString());
		bean.setDomicileCode(baseinfoPeopleRecord.get("domicileCode")
				.toString());
		bean.setApanageCode(baseinfoPeopleRecord.get("apanageCode").toString());
		bean.setFamilyCardType("0");
		bean.setFamilyStateFlag("0");
		bean.setRegId(BspUtil.getEmpOrganId());
		bean.setRegTime(DateUtil.getTime());
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		return bean;
	}

	/**
	 * 取得外省优抚人员抚恤关系迁入审批表DataBean
	 * 
	 * @return BptApplyIntoprovince
	 */
	public BptApplyIntoprovince getDisabilityIntoprovi() {
		Record bptCategoryRecord = (Record) getParameter("BptCategoryRecord");
		BptApplyIntoprovince dataBean = new BptApplyIntoprovince();
		dataBean.setApplyId(IdHelp.getUUID30());
		dataBean.setPeopleId(bptCategoryRecord.get("peopleId").toString());
		dataBean
				.setServiceType(bptCategoryRecord.get("serviceType").toString());
		dataBean.setIngoingAddress(bptCategoryRecord.get("ingoingAddress")
				.toString());
		dataBean.setIngoingReason(bptCategoryRecord.get("ingoingReason")
				.toString());
		dataBean.setOldPaperNo(bptCategoryRecord.get("oldPaperNo").toString());
		dataBean.setAllowanceMonth(bptCategoryRecord.get("allowanceMonth")
				.toString());
		dataBean.setIngoingCode((String) bptCategoryRecord.get("ingoingCode"));
		dataBean.setCommitFlag(BptConstant.UN_COMMIT_FLAG);
		return dataBean;
	}

	/**
	 * ********************************************【伤残抚恤关系迁入我省
	 * START】*****************************************************
	 */
	/**
	 * 伤残人员信息服务接口
	 */
	IBptPeopleDisabilityDomain disabilityService = ScaComponentFactory
			.getService(IBptPeopleDisabilityDomain.class,
					"bptPeopleDisabilityDomain/bptPeopleDisabilityDomain");

	/**
	 * 保存外省残疾人员抚恤关系迁入我省人员信息
	 */
	@Trans
	public void insertIngoingProvince(){
		
		Record bptCategoryRecord = (Record) getParameter("BptCategoryRecord");
		//获得受理通知书服务接口
		//IDisabilityNoticeDomain noticeService = ScaComponentFactory.getService(IDisabilityNoticeDomain.class,"disabilityNoticeDomain/disabilityNoticeDomain");
		//获得伤残鉴定介绍信服务接口
		//IDisabilityIdentificationDomain identiLetterService = ScaComponentFactory.getService(IDisabilityIdentificationDomain.class, "disabilityIdentificationDomain/disabilityIdentificationDomain");
		//获得人员信息
		BaseinfoPeople baseinfoPeople = getPeopleInfo();
		//获得家庭信息
		BaseinfoFamily baseinfoFamily = getBaseinfoFamily();
		//获取伤残信息
		BptPeopleDisability bptPeopleDisability = getDisabilityInfo();
		//获取人员优抚信息
		// 获取人员优抚信息
		BptPeople bptPeople = (BptPeople) bptCategoryRecord
				.toBean(BptPeople.class);
		bptPeople.setDependantTypeCode("00");
		bptPeople.setRedaTypeCode("00");
		bptPeople.setWarTypeCode("00");
		bptPeople.setDemobilizedTyepCode("00");
		bptPeople.setRetiredTypeCode("00");
		bptPeople.setMartyrOffspringCode("00");
		//获取绍信实体Bean和受理通知书实体Bean
		//BptApplyDisabilityNotice disabilityNotice = getNoticeInfo();
		//DisabilityIdentification identiLetterBean = getIntroLetter();
		//获取外省残疾人员抚恤关系迁入DataBean
		BptApplyIntoprovince disabilityIntoprovi = getDisabilityIntoprovi();
		
		String peoplePhotoTemp=baseinfoPeople.getPhotoTemp();
		String nowTime = DateUtil.getTime();
		String areaCode=baseinfoPeople.getRegOrgArea();
		String employeeName=baseinfoPeople.getRegPeople();
		dealPhotoC(baseinfoPeople, nowTime, areaCode, employeeName,peoplePhotoTemp);//处理照片
		
		String peopleId = IdHelp.getUUID30();
		String familyId = IdHelp.getUUID30();
		String applyId = IdHelp.getUUID30();
		
		disabilityIntoprovi.setApplyId(applyId);
		
		String flag = (String)getParameter("flag");
		if("1".equals(flag)) { // 添加
			
			baseinfoPeople.setPeopleId(peopleId);
			baseinfoPeople.setFamilyId(familyId);
			baseinfoFamily.setFamilyId(familyId);
			bptPeople.setPeopleId(peopleId);
			bptPeopleDisability.setPeopleId(peopleId);
			disabilityIntoprovi.setPeopleId(peopleId);
			
			service.insertBaseinfo(baseinfoPeople, baseinfoFamily);
			service.insertBptPeople(bptPeople);
		} else { // 修改
			service.updateBaseinfo(baseinfoPeople, baseinfoFamily);
			String peopleIdOld = baseinfoPeople.getPeopleId();
			ParameterSet pset = new ParameterSet();
			pset.setParameter("PEOPLE_ID", peopleIdOld);
			bptPeople.setPeopleId(peopleIdOld);
			
			DataSet ds = service.queryBptPeople(pset);
			if(ds.getCount() > 0 ) {
				BptPeople bptPeopleQuery = (BptPeople)ds.getRecord(0).toBean(BptPeople.class);
				bptPeople.setDependantTypeCode(bptPeopleQuery.getDependantTypeCode());
				bptPeople.setRedaTypeCode(bptPeopleQuery.getRedaTypeCode());
				bptPeople.setWarTypeCode(bptPeopleQuery.getWarTypeCode());
				bptPeople.setDemobilizedTyepCode(bptPeopleQuery.getDemobilizedTyepCode());
				bptPeople.setRetiredTypeCode(bptPeopleQuery.getRetiredTypeCode());
				bptPeople.setMartyrOffspringCode(bptPeopleQuery.getMartyrOffspringCode());
				service.update(bptPeople);
			} else {
				service.insertBptPeople(bptPeople);
			}
			
			bptPeopleDisability.setPeopleId(peopleIdOld);
			disabilityIntoprovi.setPeopleId(peopleIdOld);
		}
		service.insertDisabilityInfo(bptPeopleDisability);
		bptApplyIntoprovinceService.insert(disabilityIntoprovi);
		setReturn("peopleId", baseinfoPeople.getPeopleId());
		setReturn("familyId", baseinfoPeople.getFamilyId());
		setReturn("applyId", applyId);
	}

	/**
	 * 获得伤残信息
	 */
	public BptPeopleDisability getDisabilityInfo() {
		Record bptCategoryRecord = (Record) getParameter("BptCategoryRecord");
		BptPeopleDisability bean = (BptPeopleDisability) bptCategoryRecord
				.toBean(BptPeopleDisability.class);
		bean.setRegId(BspUtil.getEmpOrganId());
		bean.setRegTime(DateUtil.getTime());
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		return bean;
	}

	/**
	 * 获得优抚人员信息
	 * 
	 * @return BptPeople
	 */
	public BptPeople getBptPeople() {
		Record bptCategoryRecord = (Record) getParameter("BptCategoryRecord");
		BptPeople bptPeople = (BptPeople) bptCategoryRecord
				.toBean(BptPeople.class);
		bptPeople.setDependantTypeCode("00");
		bptPeople.setRedaTypeCode("00");
		bptPeople.setDemobilizedTyepCode("00");
		bptPeople.setWarTypeCode("00");
		return bptPeople;
	}

	/**
	 * 获得介绍信实体Bean
	 */
	public DisabilityIdentification getIntroLetter() {
		DisabilityIdentification dataBean = new DisabilityIdentification();
		Record BptCategoryRecord = (Record) getParameter("BptCategoryRecord");
		Record baseinfoPeopleRecord = (Record) getParameter("BaseinfoPeopleRecord");
		dataBean.setPeopleId(baseinfoPeopleRecord.get("peopleId").toString());
		dataBean.setName(baseinfoPeopleRecord.get("name").toString());
		dataBean.setSex(baseinfoPeopleRecord.get("sex").toString());
		dataBean.setBirthday(baseinfoPeopleRecord.get("birthday").toString());
		dataBean.setDomicileCode(baseinfoPeopleRecord.get("domicileCode")
				.toString());
		dataBean.setIdCard(baseinfoPeopleRecord.get("idCard").toString());
		dataBean.setAddress(baseinfoPeopleRecord.get("address").toString());
		dataBean.setWorkUnitName(baseinfoPeopleRecord.get("workUnitName")
				.toString());
		dataBean.setDisabilityDate(BptCategoryRecord.get("disabilityDate")
				.toString());
		dataBean.setDisabilityReason(BptCategoryRecord.get("disabilityReason")
				.toString());
		dataBean.setDisabilityBody(BptCategoryRecord.get("disabilityBody")
				.toString());
		return dataBean;
	}

	/**
	 * 获得受理通知书实体Bean
	 */
	public BptApplyDisabilityNotice getNoticeInfo() {
		BptApplyDisabilityNotice dataBean = new BptApplyDisabilityNotice();
		Record baseinfoPeopleRecord = (Record) getParameter("BaseinfoPeopleRecord");
		dataBean.setPeopleId(baseinfoPeopleRecord.get("peopleId").toString());
		dataBean.setName(baseinfoPeopleRecord.get("name").toString());
		dataBean.setServiceType("0");
		return dataBean;
	}

	/**
	 * 修改类别信息
	 */
	@Trans
	public void updateDisaIntoProvince() {
		Record bptPeopleDisabilityRecord = (Record) getParameter("BptPeopleDisabilityRecord");
		String peopleId = bptPeopleDisabilityRecord.get("peopleId").toString();
		ParameterSet pset = getParameterSet();
		pset.clear();
		pset.setParameter("PEOPLE_ID", peopleId);

		// 获得人员实体
		BaseinfoPeople baseinfoPeople = (BaseinfoPeople) service.queryPeople(
				pset).getRecord(0).toBean(BaseinfoPeople.class);
		baseinfoPeople.setDisabilityLevelCode(bptPeopleDisabilityRecord.get(
				"disabilityLevelCode").toString());
		baseinfoPeople.setDisabilityCaseCode(bptPeopleDisabilityRecord.get(
				"disabilityCaseCode").toString());
		baseinfoPeople.setDisabilityStateCode(bptPeopleDisabilityRecord.get(
				"disabilityStateCode").toString());
		baseinfoPeople.setDisabilityNo(bptPeopleDisabilityRecord.get(
				"oldPaperNo").toString());

		// 获得伤残信息实体
		BptPeopleDisability bptPeopleDisability = (BptPeopleDisability) bptPeopleDisabilityRecord
				.toBean(BptPeopleDisability.class);

		// 获得优抚人员实体
		BptPeople bptPeople = (BptPeople) bptPeopleService.query(pset)
				.getRecord(0).toBean(BptPeople.class);
		bptPeople.setDisabilityTypeCode(bptPeopleDisabilityRecord.get(
				"disabilityTypeCode").toString());
		bptPeople.setInsanityFlag(bptPeopleDisabilityRecord.get("insanityFlag")
				.toString());
		bptPeople.setOldLonelyFlag(bptPeopleDisabilityRecord.get(
				"oldLonelyFlag").toString());
		bptPeople.setWorkAbilityCode(bptPeopleDisabilityRecord.get(
				"workAbilityCode").toString());
		bptPeople.setWorkAbilityDescribe(bptPeopleDisabilityRecord.get(
				"workAbilityDescribe").toString());
		bptPeople.setViabilityCode(bptPeopleDisabilityRecord.get(
				"viabilityCode").toString());
		bptPeople.setSupportPattern(bptPeopleDisabilityRecord.get(
				"supportPattern").toString());
		bptPeople.setJobStatusDescribe(bptPeopleDisabilityRecord.get(
				"jobStatusDescribe").toString());
		bptPeople.setBank(bptPeopleDisabilityRecord.get("bank").toString());
		bptPeople.setAccountCode(bptPeopleDisabilityRecord.get("accountCode")
				.toString());
		bptPeople.setAccountName(bptPeopleDisabilityRecord.get("accountName")
				.toString());

		// 获得外省残疾人员抚恤关系迁入实体
		BptApplyIntoprovince disabilityIntoprovi = (BptApplyIntoprovince) bptApplyIntoprovinceService
				.query(pset).getRecord(0).toBean(BptApplyIntoprovince.class);
		disabilityIntoprovi.setIngoingAddress(bptPeopleDisabilityRecord.get(
				"ingoingAddress").toString());
		disabilityIntoprovi.setIngoingReason(bptPeopleDisabilityRecord.get(
				"ingoingReason").toString());
		disabilityIntoprovi.setOldPaperNo(bptPeopleDisabilityRecord.get(
				"oldPaperNo").toString());
		disabilityIntoprovi.setAllowanceMonth(bptPeopleDisabilityRecord.get(
				"allowanceMonth").toString());
		disabilityIntoprovi.setIngoingCode(bptPeopleDisabilityRecord.get(
				"ingoingCode").toString());
		service.updateBaseinfoPeople(baseinfoPeople);
		service.updatePeopleDisability(bptPeopleDisability);
		service.update(bptPeople);
		bptApplyIntoprovinceService.update(disabilityIntoprovi);
	}

	/**
	 * ********************************************【伤残抚恤关系迁入我省
	 * END】*****************************************************
	 */

	/**
	 * 获得三属信息
	 * 
	 * @return
	 */
	public BptPeopleDependant getDependant() {
		Record bptCategoryRecord = (Record) getParameter("BptCategoryRecord");
		BptPeopleDependant bean = (BptPeopleDependant) bptCategoryRecord
				.toBean(BptPeopleDependant.class);
		bean.setRegId(BspUtil.getEmpOrganId());
		bean.setRegTime(DateUtil.getTime());
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		return bean;
	}

	/**
	 * 添加外省迁入我省三属信息
	 */
	@Trans
	public void insertDependInProvice() {

		Record bptCategoryRecord = (Record) getParameter("BptCategoryRecord");
		// 获得人员信息
		BaseinfoPeople baseinfoPeople = getPeopleInfo();
		baseinfoPeople.setHandicapFlag((String) bptCategoryRecord
				.get("handicapFlag"));

		// 获得家庭信息
		BaseinfoFamily baseinfoFamily = getBaseinfoFamily();
		// 获取三属信息
		BptPeopleDependant bptPeopleDedendant = getDependant();

		// 获取人员优抚信息
		BptPeople bptPeople = (BptPeople) bptCategoryRecord
				.toBean(BptPeople.class);
		bptPeople.setInsanityFlag("0");
		bptPeople.setDisabilityTypeCode("00");
		bptPeople.setRedaTypeCode("00");
		bptPeople.setWarTypeCode("00");
		bptPeople.setDemobilizedTyepCode("00");
		bptPeople.setRetiredTypeCode("00");
		bptPeople.setMartyrOffspringCode("00");

		// 获取外省三属人员抚恤关系
		BptApplyIntoprovince disabilityIntoprovi = getDisabilityIntoprovi();

		String peoplePhotoTemp = baseinfoPeople.getPhotoTemp();
		String nowTime = DateUtil.getTime();
		String areaCode = baseinfoPeople.getRegOrgArea();
		String employeeName = baseinfoPeople.getRegPeople();
		dealPhotoC(baseinfoPeople, nowTime, areaCode, employeeName,
				peoplePhotoTemp);// 处理照片

		String peopleId = IdHelp.getUUID30();
		String familyId = IdHelp.getUUID30();
		String applyId = IdHelp.getUUID30();

		disabilityIntoprovi.setApplyId(applyId);

		String flag = (String) getParameter("flag");
		if ("1".equals(flag)) { // 添加

			baseinfoPeople.setPeopleId(peopleId);
			baseinfoPeople.setFamilyId(familyId);
			baseinfoFamily.setFamilyId(familyId);
			bptPeople.setPeopleId(peopleId);
			bptPeopleDedendant.setPeopleId(peopleId);
			disabilityIntoprovi.setPeopleId(peopleId);

			service.insertBaseinfo(baseinfoPeople, baseinfoFamily);
			service.insertBptPeople(bptPeople);
		} else { // 修改
			service.updateBaseinfo(baseinfoPeople, baseinfoFamily);
			String peopleIdOld = baseinfoPeople.getPeopleId();
			ParameterSet pset = new ParameterSet();
			pset.setParameter("PEOPLE_ID", peopleIdOld);
			bptPeople.setPeopleId(peopleIdOld);
			
			DataSet ds = service.queryBptPeople(pset);
			if (ds.getCount() > 0) {
				BptPeople bptPeopleQuery = (BptPeople) ds.getRecord(0).toBean(
						BptPeople.class);
				bptPeople.setDisabilityTypeCode(bptPeopleQuery
						.getDisabilityTypeCode());
				bptPeople.setRedaTypeCode(bptPeopleQuery.getRedaTypeCode());
				bptPeople.setWarTypeCode(bptPeopleQuery.getWarTypeCode());
				bptPeople.setDemobilizedTyepCode(bptPeopleQuery
						.getDemobilizedTyepCode());
				bptPeople.setInsanityFlag(bptPeopleQuery.getInsanityFlag());
				bptPeople.setRetiredTypeCode(bptPeopleQuery.getRetiredTypeCode());
				bptPeople.setMartyrOffspringCode(bptPeopleQuery.getMartyrOffspringCode());
				service.update(bptPeople);
			} else {
				service.insertBptPeople(bptPeople);
			}

			bptPeopleDedendant.setPeopleId(peopleIdOld);
			disabilityIntoprovi.setPeopleId(peopleIdOld);
		}
		service.insertPeopleDependant(bptPeopleDedendant);
		bptApplyIntoprovinceService.insert(disabilityIntoprovi);
		setReturn("peopleId", baseinfoPeople.getPeopleId());
		setReturn("familyId", baseinfoPeople.getFamilyId());
		setReturn("applyId", applyId);

	}

	/**
	 * 修改外省迁入我省三属信息
	 */
	@Trans
	public void updateDependInProvice() {
		ParameterSet pset = getParameterSet();
		Record record = (Record) getParameter("record");
		String applyId = (String) getParameter("applyId");
		pset.clear();

		// 修改人员基本信息
		pset.setParameter("PEOPLE_ID", (String) record.get("peopleId"));
		DataSet baseDs = service.queryPeople(pset);
		if (baseDs.getCount() != 0) {
			BaseinfoPeople baseinfoPeople = (BaseinfoPeople) baseDs
					.getRecord(0).toBean(BaseinfoPeople.class);
			baseinfoPeople.setHandicapFlag((String) record.get("handicapFlag"));
			baseinfoPeople.setDependantStateCode((String) record
					.get("dependantStateCode"));
			baseinfoPeople.setDependantNo((String) record.get("oldPaperNo"));
			service.updateBaseinfoPeople(baseinfoPeople);
		}

		// 修改三属人员信息
		BptPeopleDependant bptPeopleDependant = (BptPeopleDependant) record
				.toBean(BptPeopleDependant.class);

		/** 三属人员服务接口 */
		IBptPeopleDependantDomain dependantService = ScaComponentFactory
				.getService(IBptPeopleDependantDomain.class,
						"bptPeopleDependantDomain/bptPeopleDependantDomain");
		dependantService.update(bptPeopleDependant);

		// 修改优抚人员信息
		DataSet bptDs = service.queryBptPeople(pset);
		if (bptDs.getCount() != 0) {
			BptPeople bptPeople = (BptPeople) bptDs.getRecord(0).toBean(
					BptPeople.class);
			bptPeople.setDependantTypeCode((String) record
					.get("dependantTypeCode"));
			bptPeople.setBank((String) record.get("bank"));
			bptPeople.setAccountName((String) record.get("accountName"));
			bptPeople.setAccountCode((String) record.get("accountCode"));
			bptPeople.setOldLonelyFlag((String) record.get("oldLonelyFlag"));
			bptPeople.setOrphanFlag((String) record.get("orphanFlag"));
			bptPeople
					.setWorkAbilityCode((String) record.get("workAbilityCode"));
			bptPeople.setWorkAbilityDescribe((String) record
					.get("workAbilityDescribe"));
			bptPeople.setViabilityCode((String) record.get("viabilityCode"));
			bptPeople.setSupportPattern((String) record.get("supportPattern"));
			bptPeople.setJobStatusDescribe((String) record
					.get("jobStatusDescribe"));
			service.update(bptPeople);
		}

		// 修改外省三属人员迁入我省信息
		pset.clear();
		pset.setParameter("APPLY_ID", applyId);
		DataSet ingoDependantDs = bptApplyIntoprovinceService.query(pset);
		if (ingoDependantDs.getCount() != 0) {
			BptApplyIntoprovince bptApplyIntoprovince = (BptApplyIntoprovince) ingoDependantDs
					.getRecord(0).toBean(BptApplyIntoprovince.class);
			bptApplyIntoprovince.setAllowanceMonth((String) record
					.get("allowanceMonth"));
			bptApplyIntoprovince.setIngoingAddress((String) record
					.get("ingoingAddress"));
			bptApplyIntoprovince.setIngoingReason((String) record
					.get("ingoingReason"));
			bptApplyIntoprovince.setOldPaperNo((String) record
					.get("oldPaperNo"));
			bptApplyIntoprovince.setIngoingCode((String) record
					.get("ingoingCode"));

			bptApplyIntoprovinceService.update(bptApplyIntoprovince);
		}

	}

	/**
	 * ********************************************【参战抚恤关系迁入我省
	 * START】*****************************************************
	 */
	/**
	 * 保存外省参战人员抚恤关系迁入我省人员信息
	 */
	@Trans
	public void insertWarIngoingProvince() {
		Record bptCategoryRecord = (Record) getParameter("BptCategoryRecord");

		// 获得人员信息
		BaseinfoPeople baseinfoPeople = getPeopleInfo();
		// 获得家庭信息
		BaseinfoFamily baseinfoFamily = getBaseinfoFamily();
		// 获取参战信息
		BptPeopleWar bptPeopleWar = getWarInfo();
		// 获取人员优抚信息
		BptPeople bptPeople = (BptPeople) bptCategoryRecord
				.toBean(BptPeople.class);
		bptPeople.setDependantTypeCode("00");
		bptPeople.setRedaTypeCode("00");
		bptPeople.setDemobilizedTyepCode("00");
		bptPeople.setDisabilityTypeCode("00");
		bptPeople.setWarTypeCode("51");
		bptPeople.setRetiredTypeCode("00");
		bptPeople.setMartyrOffspringCode("00");
		// 获取外省人员抚恤关系迁入DataBean
		BptApplyIntoprovince Intoprovi = getIntoprovi();

		String peoplePhotoTemp = baseinfoPeople.getPhotoTemp();
		String nowTime = DateUtil.getTime();
		String areaCode = baseinfoPeople.getRegOrgArea();
		String employeeName = baseinfoPeople.getRegPeople();
		dealPhotoC(baseinfoPeople, nowTime, areaCode, employeeName,
				peoplePhotoTemp);// 处理照片

		String peopleId = IdHelp.getUUID30();
		String familyId = IdHelp.getUUID30();
		String applyId = IdHelp.getUUID30();

		Intoprovi.setApplyId(applyId);

		String flag = (String) getParameter("flag");
		if ("1".equals(flag)) { // 添加

			baseinfoPeople.setPeopleId(peopleId);
			baseinfoPeople.setFamilyId(familyId);
			baseinfoFamily.setFamilyId(familyId);
			bptPeople.setPeopleId(peopleId);
			bptPeopleWar.setPeopleId(peopleId);
			Intoprovi.setPeopleId(peopleId);

			service.insertBaseinfo(baseinfoPeople, baseinfoFamily);
			service.insertBptPeople(bptPeople);
		} else { // 修改
			service.updateBaseinfo(baseinfoPeople, baseinfoFamily);
			String peopleIdOld = baseinfoPeople.getPeopleId();
			ParameterSet pset = new ParameterSet();
			pset.setParameter("PEOPLE_ID", peopleIdOld);
			bptPeople.setPeopleId(peopleIdOld);
			DataSet ds = service.queryBptPeople(pset);
			if (ds.getCount() > 0) {
				BptPeople bptPeopleQuery = (BptPeople) ds.getRecord(0).toBean(
						BptPeople.class);
				bptPeople.setDisabilityTypeCode(bptPeopleQuery
						.getDisabilityTypeCode());
				bptPeople.setRedaTypeCode(bptPeopleQuery.getRedaTypeCode());
				bptPeople.setDependantTypeCode(bptPeopleQuery
						.getDependantTypeCode());
				bptPeople.setDemobilizedTyepCode(bptPeopleQuery
						.getDemobilizedTyepCode());
				bptPeople.setRetiredTypeCode(bptPeopleQuery.getRetiredTypeCode());
				bptPeople.setMartyrOffspringCode(bptPeopleQuery.getMartyrOffspringCode());

				service.update(bptPeople);
			} else {
				service.insertBptPeople(bptPeople);
			}

			bptPeopleWar.setPeopleId(peopleIdOld);
			Intoprovi.setPeopleId(peopleIdOld);
		}
		service.insert(bptPeopleWar);
		bptApplyIntoprovinceService.insert(Intoprovi);
		setReturn("peopleId", baseinfoPeople.getPeopleId());
		setReturn("familyId", baseinfoPeople.getFamilyId());
		setReturn("applyId", applyId);
	}

	/**
	 * 更新外省参战人员抚恤关系迁入我省人员信息
	 */

	/*
	 * @Trans public void updateWarIngoingProvince(){
	 *//**
		 * 获得参战人员服务接口
		 */
	/*
	 * IWarDomain iWarService =
	 * ScaComponentFactory.getService(IWarDomain.class,"bptWarDomain/bptWarDomain");
	 * 
	 * Record BaseinfoPeopleRecord = (Record)
	 * getParameter("BaseinfoPeopleRecord"); Record warEntity = (Record)
	 * getParameter("warEntity"); String applyId =
	 * (String)getParameter("applyId"); String peopleId =
	 * BaseinfoPeopleRecord.get("peopleId").toString(); ParameterSet pset = new
	 * ParameterSet(); pset.setParameter("PEOPLE_ID@=", peopleId);
	 * pset.setParameter("APPLY_ID@=", applyId);
	 * 
	 * 
	 * //获取人员优抚信息 BptPeople
	 * bptPeople=(BptPeople)warEntity.toBean(BptPeople.class);
	 * bptPeople.setDependantTypeCode("00"); bptPeople.setRedaTypeCode("00");
	 * bptPeople.setDemobilizedTyepCode("00");
	 * bptPeople.setDisabilityTypeCode("00"); bptPeople.setPeopleId(peopleId);
	 * 
	 * //获取参战信息 BptPeopleWar bptPeopleWar = (BptPeopleWar)
	 * warEntity.toBean(BptPeopleWar.class);
	 * bptPeopleWar.setModId(BspUtil.getEmpOrganId());
	 * bptPeopleWar.setModTime(DateUtil.getTime());
	 * bptPeopleWar.setPeopleId(peopleId);
	 * 
	 * //获得人员实体 BaseinfoPeople baseinfoPeople =
	 * (BaseinfoPeople)BaseinfoPeopleRecord.toBean(BaseinfoPeople.class);
	 * 
	 * //获得外省残疾人员抚恤关系迁入实体 BptApplyIntoprovince Intoprovi =
	 * (BptApplyIntoprovince)bptApplyIntoprovinceService.query(pset).getRecord(0).toBean(BptApplyIntoprovince.class);
	 * Intoprovi.setIngoingAddress(warEntity.get("ingoingAddress").toString());
	 * Intoprovi.setIngoingReason(warEntity.get("ingoingReason").toString());
	 * Intoprovi.setAllowanceMonth(warEntity.get("allowanceMonth").toString());
	 * Intoprovi.setIngoingCode(warEntity.get("ingoingCode").toString());
	 * 
	 * service.updateBaseinfoPeople(baseinfoPeople); service.update(bptPeople);
	 * iWarService.updateWar(bptPeopleWar);
	 * bptApplyIntoprovinceService.update(Intoprovi);
	 *  }
	 */

	@Trans
	public void updateWarIngoingProvinceNew() {
		ParameterSet pset = getParameterSet();
		Record record = (Record) getParameter("warEntity");
		String applyId = (String) getParameter("applyId");
		pset.clear();

		// 修改人员基本信息
		pset.setParameter("PEOPLE_ID", (String) record.get("peopleId"));
		DataSet baseDs = service.queryPeople(pset);
		if (baseDs.getCount() != 0) {
			BaseinfoPeople baseinfoPeople = (BaseinfoPeople) baseDs
					.getRecord(0).toBean(BaseinfoPeople.class);
			baseinfoPeople.setWarNo((String) record.get("warNo"));
			baseinfoPeople.setWarStateCode((String) record.get("warStateCode"));

			service.updateBaseinfoPeople(baseinfoPeople);
		}

		// 修改参战信息
		BptPeopleWar bptPeopleWar = (BptPeopleWar) record
				.toBean(BptPeopleWar.class);

		/** 参战人员服务接口 */
		IWarDomain bptPeopleWarService = ScaComponentFactory.getService(
				IWarDomain.class, "bptWarDomain/bptWarDomain");
		bptPeopleWarService.updateWar(bptPeopleWar);

		// 修改优抚人员信息
		DataSet bptDs = service.queryBptPeople(pset);
		if (bptDs.getCount() != 0) {
			BptPeople bptPeople = (BptPeople) bptDs.getRecord(0).toBean(
					BptPeople.class);
			bptPeople.setBank((String) record.get("bank"));
			bptPeople.setAccountName((String) record.get("accountName"));
			bptPeople.setAccountCode((String) record.get("accountCode"));
			bptPeople.setOldLonelyFlag((String) record.get("oldLonelyFlag"));
			bptPeople.setOrphanFlag((String) record.get("orphanFlag"));
			bptPeople
					.setWorkAbilityCode((String) record.get("workAbilityCode"));
			bptPeople.setWorkAbilityDescribe((String) record
					.get("workAbilityDescribe"));
			bptPeople.setViabilityCode((String) record.get("viabilityCode"));
			bptPeople.setSupportPattern((String) record.get("supportPattern"));
			bptPeople.setJobStatusDescribe((String) record
					.get("jobStatusDescribe"));
			bptPeople.setInsanityFlag((String) record.get("insanityFlag"));
			service.update(bptPeople);
		}

		// 修改外省三属人员迁入我省信息
		pset.clear();
		pset.setParameter("APPLY_ID", applyId);
		DataSet ingoDependantDs = bptApplyIntoprovinceService.query(pset);
		if (ingoDependantDs.getCount() != 0) {
			BptApplyIntoprovince bptApplyIntoprovince = (BptApplyIntoprovince) ingoDependantDs
					.getRecord(0).toBean(BptApplyIntoprovince.class);
			bptApplyIntoprovince.setAllowanceMonth((String) record
					.get("allowanceMonth"));
			bptApplyIntoprovince.setIngoingAddress((String) record
					.get("ingoingAddress"));
			bptApplyIntoprovince.setIngoingReason((String) record
					.get("ingoingReason"));
			bptApplyIntoprovince.setOldPaperNo((String) record
					.get("oldPaperNo"));
			bptApplyIntoprovince.setIngoingCode((String) record
					.get("ingoingCode"));
			bptApplyIntoprovinceService.update(bptApplyIntoprovince);
		}

	}

	/**
	 * 获得参战信息
	 */
	public BptPeopleWar getWarInfo() {
		Record bptCategoryRecord = (Record) getParameter("BptCategoryRecord");
		BptPeopleWar bean = (BptPeopleWar) bptCategoryRecord
				.toBean(BptPeopleWar.class);
		bean.setRegId(BspUtil.getEmpOrganId());
		bean.setRegTime(DateUtil.getTime());
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		return bean;
	}

	/**
	 * 取得外省优抚人员抚恤关系迁入审批表DataBean
	 * 
	 * @return BptApplyIntoprovince
	 */
	public BptApplyIntoprovince getIntoprovi() {
		Record bptCategoryRecord = (Record) getParameter("BptCategoryRecord");
		BptApplyIntoprovince dataBean = new BptApplyIntoprovince();
		dataBean.setApplyId(IdHelp.getUUID30());
		dataBean.setPeopleId(bptCategoryRecord.get("peopleId").toString());
		dataBean
				.setServiceType(bptCategoryRecord.get("serviceType").toString());
		dataBean.setIngoingAddress(bptCategoryRecord.get("ingoingAddress")
				.toString());
		dataBean.setIngoingCode(bptCategoryRecord.get("ingoingCode")
				.toString());
		dataBean.setIngoingReason(bptCategoryRecord.get("ingoingReason")
				.toString());
		dataBean.setAllowanceMonth(bptCategoryRecord.get("allowanceMonth")
				.toString());
		dataBean.setOldPaperNo(bptCategoryRecord
				.get("oldPaperNo").toString());
		dataBean.setCommitFlag(BptConstant.UN_COMMIT_FLAG);
		return dataBean;
	}

	/**
	 * 获得参战人员信息
	 * 
	 * @return BptPeople
	 */
	public BptPeople getWarBptPeople() {
		Record bptCategoryRecord = (Record) getParameter("BptCategoryRecord");
		BptPeople bptPeople = (BptPeople) bptCategoryRecord
				.toBean(BptPeople.class);
		bptPeople.setDependantTypeCode("00");
		bptPeople.setRedaTypeCode("00");
		bptPeople.setDemobilizedTyepCode("00");
		bptPeople.setDisabilityTypeCode("00");
		return bptPeople;
	}

	/**
	 * ********************************************【在乡抚恤关系迁入我省
	 * START】*****************************************************
	 */

	/**
	 * 获取人员信息 author: since:2011-05-16
	 */
	private BaseinfoPeople getDemoBaseinfoPeople() {
		Record baseinfopeopleRecord = (Record) getParameter("BaseinfoPeopleRecord");
		Record PeopleDemobilizedRecord = (Record) getParameter("PeopleDemobilizedRecord");
		BaseinfoPeople bean = (BaseinfoPeople) baseinfopeopleRecord
				.toBean(BaseinfoPeople.class);
		bean.setIdCardType("0");
		bean.setDisabilityFlag(baseinfopeopleRecord.get("disabilityFlag")
				.toString());
		bean.setRedaFlag(baseinfopeopleRecord.get("redaFlag").toString());
		bean.setDependantFlag(baseinfopeopleRecord.get("dependantFlag")
				.toString());
		bean.setDemobilizedFlag("1");
		bean.setWarFlag(baseinfopeopleRecord.get("warFlag").toString());
		bean.setDisabilityStateCode(baseinfopeopleRecord.get(
				"disabilityStateCode").toString());
		bean.setRedaStateCode(baseinfopeopleRecord.get("redaStateCode")
				.toString());
		bean.setDependantStateCode(baseinfopeopleRecord.get(
				"dependantStateCode").toString());
		bean.setWarStateCode(baseinfopeopleRecord.get("warStateCode")
				.toString());
		bean.setDemobilizedNo(PeopleDemobilizedRecord.get("oldPaperNo")
				.toString());
		bean.setDemobilizedStateCode(PeopleDemobilizedRecord.get(
				"demobilizedStateCode").toString());
		bean.setPersonalStatsTag("0");
		bean.setDisabilityStateCode("0");
		bean.setRegId(BspUtil.getEmpOrganId());
		bean.setRegTime(DateUtil.getTime());
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		return bean;
	}

	/**
	 * @description: 获得在乡复员军人信息
	 * @return : BptPeopleDependant
	 */
	private BptPeopleDemobilized getBptPeopleDemobilized() {
		Record peopleDemobilizedRecord = (Record) getParameter("PeopleDemobilizedRecord");
		BptPeopleDemobilized dataBean = (BptPeopleDemobilized) peopleDemobilizedRecord
				.toBean(BptPeopleDemobilized.class);
		dataBean
				.setPeopleId(peopleDemobilizedRecord.get("peopleId").toString());
		dataBean.setConscriptDate(peopleDemobilizedRecord.get("conscriptDate")
				.toString());
		dataBean.setDecruitmentDate(peopleDemobilizedRecord.get(
				"decruitmentDate").toString());
		dataBean
				.setForcesNo(peopleDemobilizedRecord.get("forcesNo").toString());
		dataBean
				.setPosition(peopleDemobilizedRecord.get("position").toString());
		dataBean.setAsdpNo(peopleDemobilizedRecord.get("asdpNo").toString());
		dataBean.setNote(peopleDemobilizedRecord.get("note").toString());
		dataBean.setCommitFlag("0");
		dataBean.setRegId(BspUtil.getEmpOrganId());
		dataBean.setRegTime(DateUtil.getTime());
		dataBean.setModId(BspUtil.getEmpOrganId());
		dataBean.setModTime(DateUtil.getTime());
		return dataBean;
	}

	/**
	 * 获取家庭信息
	 */
	private BaseinfoFamily getDemoBaseinfoFamily() {
		Record baseinfoPeopleRecord = (Record) getParameter("BaseinfoPeopleRecord");
		// BaseinfoFamily bean = (BaseinfoFamily)
		// baseinfofamilyRecord.toBean(BaseinfoFamily.class);
		BaseinfoFamily bean = new BaseinfoFamily();
		bean.setFamilyId(baseinfoPeopleRecord.get("familyId").toString());
		bean.setFamilyName(baseinfoPeopleRecord.get("name").toString());
		bean.setFamilyCardNo(baseinfoPeopleRecord.get("idCard").toString());
		bean.setDomicileCode(baseinfoPeopleRecord.get("domicileCode")
				.toString());
		bean.setApanageCode(baseinfoPeopleRecord.get("apanageCode").toString());
		bean.setFamilyCardType("0");
		bean.setFamilyStateFlag("0");
		bean.setRegId(BspUtil.getEmpOrganId());
		bean.setRegTime(DateUtil.getTime());
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		return bean;
	}

	/**
	 * 获得优抚人员信息
	 */
	private BptPeople getDemoBptPeople() {
		Record peopleDemobilizedRecord = (Record) getParameter("PeopleDemobilizedRecord");
		BptPeople bptPeople = (BptPeople) peopleDemobilizedRecord
				.toBean(BptPeople.class);
		bptPeople.setPeopleId(peopleDemobilizedRecord.get("peopleId")
				.toString());
		bptPeople.setDemobilizedTyepCode("41");
		bptPeople.setInsanityFlag(peopleDemobilizedRecord.get("insanityFlag")
				.toString());
		bptPeople.setOldLonelyFlag(peopleDemobilizedRecord.get("oldLonelyFlag")
				.toString());
		// bptPeople.setOrphanFlag(peopleDemobilizedRecord.get("orphanFlag").toString());
		bptPeople.setWorkAbilityCode(peopleDemobilizedRecord.get(
				"workAbilityCode").toString());
		bptPeople.setWorkAbilityDescribe(peopleDemobilizedRecord.get(
				"workAbilityDescribe").toString());
		bptPeople.setViabilityCode(peopleDemobilizedRecord.get("viabilityCode")
				.toString());
		bptPeople.setSupportPattern(peopleDemobilizedRecord.get(
				"supportPattern").toString());
		bptPeople.setJobStatusDescribe(peopleDemobilizedRecord.get(
				"jobStatusDescribe").toString());
		bptPeople.setBank(peopleDemobilizedRecord.get("bank").toString());
		bptPeople.setAccountCode(peopleDemobilizedRecord.get("accountCode")
				.toString());
		bptPeople.setAccountName(peopleDemobilizedRecord.get("accountName")
				.toString());

		// 将该对象修改为多个对象类别
		ParameterSet param = new ParameterSet();
		param.setParameter("PEOPLE_ID", peopleDemobilizedRecord.get("peopleId")
				.toString());
		DataSet ds = service.queryBptPeople(param);
		if (ds.getCount() != 0) {
			Record rd = ds.getRecord(0);

			bptPeople.setDisabilityTypeCode(rd.get("disabilityTypeCode")
					.toString());
			bptPeople.setDependantTypeCode(rd.get("dependantTypeCode")
					.toString());
			bptPeople.setRedaTypeCode(rd.get("redaTypeCode").toString());
			bptPeople.setWarTypeCode(rd.get("warTypeCode").toString());
			bptPeople.setRetiredTypeCode((String)rd.get("retiredTypeCode"));
			bptPeople.setMartyrOffspringCode((String)rd.get("martyrOffspringCode"));
		} else {
			bptPeople.setDisabilityTypeCode("00");
			bptPeople.setDependantTypeCode("00");
			bptPeople.setRedaTypeCode("00");
			bptPeople.setWarTypeCode("00");
			bptPeople.setRetiredTypeCode("00");
			bptPeople.setMartyrOffspringCode("00");
		}
		return bptPeople;
	}

	/**
	 * 取得外省优抚人员抚恤关系迁入审批表DataBean
	 * 
	 * @return BptApplyIntoprovince
	 */
	private BptApplyIntoprovince getDemobilizedProvinceFlow() {
		String applyId = IdHelp.getUUID30();
		Record peopleDemobilizedRecord = (Record) getParameter("PeopleDemobilizedRecord");
		BptApplyIntoprovince dataBean = new BptApplyIntoprovince();
		dataBean.setApplyId(IdHelp.getUUID30());
		dataBean
				.setPeopleId(peopleDemobilizedRecord.get("peopleId").toString());
		dataBean.setServiceType(peopleDemobilizedRecord.get("serviceType")
				.toString());
		dataBean.setIngoingAddress(peopleDemobilizedRecord
				.get("ingoingAddress").toString());
		dataBean.setIngoingCode(peopleDemobilizedRecord
				.get("ingoingCode").toString());
		dataBean.setIngoingReason(peopleDemobilizedRecord.get("ingoingReason")
				.toString());
		dataBean.setAllowanceMonth(peopleDemobilizedRecord
				.get("allowanceMonth").toString());
		dataBean.setOldPaperNo(peopleDemobilizedRecord.get("oldPaperNo")
				.toString());
		dataBean.setCommitFlag(BptConstant.UN_COMMIT_FLAG);
		return dataBean;

	}

	/**
	 * 保存外省在乡人员抚恤关系迁入我省人员信息
	 */
	@Trans
	public void insertDemoIngoingProvince(){
		//获得人员信息
		BaseinfoPeople baseinfoPeople = getDemoBaseinfoPeople();
		//获得家庭信息
		BaseinfoFamily baseinfoFamily = getDemoBaseinfoFamily();
		//获得bptpeopledemobilized
		BptPeopleDemobilized bptPeopleDemobilized = getBptPeopleDemobilized();
		//bptPeople
		BptPeople demoBptPeople = getDemoBptPeople();
		//获取外省人员抚恤关系迁入DataBean
		BptApplyIntoprovince getDemobilizedProvinceFlow = getDemobilizedProvinceFlow();
		
		String peoplePhotoTemp=baseinfoPeople.getPhotoTemp();
		String nowTime = DateUtil.getTime();
		String areaCode=baseinfoPeople.getRegOrgArea();
		String employeeName=baseinfoPeople.getRegPeople();
		dealPhotoC(baseinfoPeople, nowTime, areaCode, employeeName,peoplePhotoTemp);//处理照片
		
		String peopleId = IdHelp.getUUID30();
		String familyId = IdHelp.getUUID30();
		String applyId = IdHelp.getUUID30();
		
		getDemobilizedProvinceFlow.setApplyId(applyId);
		
		String flag = (String)getParameter("flag");
		if("1".equals(flag)) { // 添加
			
			baseinfoPeople.setPeopleId(peopleId);
			baseinfoPeople.setFamilyId(familyId);
			baseinfoFamily.setFamilyId(familyId);
			demoBptPeople.setPeopleId(peopleId);
			bptPeopleDemobilized.setPeopleId(peopleId);
			getDemobilizedProvinceFlow.setPeopleId(peopleId);
			
			service.insertBaseinfo(baseinfoPeople, baseinfoFamily);
			service.insertBptPeople(demoBptPeople);
		} else { // 修改
			service.updateBaseinfo(baseinfoPeople, baseinfoFamily);
			String peopleIdOld = baseinfoPeople.getPeopleId();
			ParameterSet pset = new ParameterSet();
			pset.setParameter("PEOPLE_ID", peopleIdOld);
			
			demoBptPeople.setPeopleId(peopleIdOld);
			
			DataSet ds = service.queryBptPeople(pset);
			if(ds.getCount() > 0 ) {
				service.update(demoBptPeople);
			} else {
				service.insertBptPeople(demoBptPeople);
			}
			
			bptPeopleDemobilized.setPeopleId(peopleIdOld);
			getDemobilizedProvinceFlow.setPeopleId(peopleIdOld);
		}
		service.insertPeopleDemobilized(bptPeopleDemobilized);
		bptApplyIntoprovinceService.insert(getDemobilizedProvinceFlow);
		setReturn("peopleId", baseinfoPeople.getPeopleId());
		setReturn("familyId", baseinfoPeople.getFamilyId());
		setReturn("applyId", applyId);
	}
	/**
	 * 修改在乡复员外省迁入我省类别信息
	 */
	@Trans
	public void updateDmeoIntoProvince() {
		Record peopleDemobilizedRecord = (Record) getParameter("PeopleDemobilizedRecord");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("PEOPLE_ID@=", peopleDemobilizedRecord
				.get("peopleId").toString());

		String w = peopleDemobilizedRecord.get("ingoingReason").toString();
		String q = peopleDemobilizedRecord.get("ingoingAddress").toString();
		BptApplyIntoprovince bptApplyIntoprovince = (BptApplyIntoprovince) bptApplyIntoprovinceService
				.query(pset).getRecord(0).toBean(BptApplyIntoprovince.class);
		bptApplyIntoprovince.setIngoingAddress(peopleDemobilizedRecord.get(
				"ingoingAddress").toString());
		bptApplyIntoprovince.setIngoingReason(peopleDemobilizedRecord.get(
				"ingoingReason").toString());
		bptApplyIntoprovince.setAllowanceMonth(peopleDemobilizedRecord.get(
				"allowanceMonth").toString());
		bptApplyIntoprovince.setOldPaperNo(peopleDemobilizedRecord.get(
				"oldPaperNo").toString());
		bptApplyIntoprovince.setIngoingCode(peopleDemobilizedRecord.get(
				"ingoingCode").toString());

		BptPeopleDemobilized dataBean = (BptPeopleDemobilized) peopleDemobilizedRecord
				.toBean(BptPeopleDemobilized.class);

		// 获取外省人员抚恤关系迁入DataBean
		BptApplyIntoprovince getDemobilizedProvinceFlow = getDemobilizedProvinceFlow();
		service.updateBptPeopleDemobilized(dataBean);

		bptApplyIntoprovinceService.update(bptApplyIntoprovince);

		DataSet baseDs = service.queryPeople(pset);
		if (baseDs.getCount() != 0) {
			BaseinfoPeople baseinfoPeople = (BaseinfoPeople) baseDs
					.getRecord(0).toBean(BaseinfoPeople.class);
			baseinfoPeople
					.setDemobilizedStateCode((String) peopleDemobilizedRecord
							.get("demobilizedStateCode"));
			baseinfoPeople.setDemobilizedNo((String) peopleDemobilizedRecord
					.get("oldPaperNo"));
			service.updateBaseinfoPeople(baseinfoPeople);
		}

		// 修改优抚人员信息
		DataSet bptDs = service.queryBptPeople(pset);
		if (bptDs.getCount() != 0) {
			BptPeople bptPeople = (BptPeople) bptDs.getRecord(0).toBean(
					BptPeople.class);
			bptPeople.setInsanityFlag((String) peopleDemobilizedRecord
					.get("insanityFlag"));
			bptPeople.setBank((String) peopleDemobilizedRecord.get("bank"));
			bptPeople.setAccountName((String) peopleDemobilizedRecord
					.get("accountName"));
			bptPeople.setAccountCode((String) peopleDemobilizedRecord
					.get("accountCode"));
			bptPeople.setOldLonelyFlag((String) peopleDemobilizedRecord
					.get("oldLonelyFlag"));
			bptPeople.setOrphanFlag((String) peopleDemobilizedRecord
					.get("orphanFlag"));
			bptPeople.setWorkAbilityCode((String) peopleDemobilizedRecord
					.get("workAbilityCode"));
			bptPeople.setWorkAbilityDescribe((String) peopleDemobilizedRecord
					.get("workAbilityDescribe"));
			bptPeople.setViabilityCode((String) peopleDemobilizedRecord
					.get("viabilityCode"));
			bptPeople.setSupportPattern((String) peopleDemobilizedRecord
					.get("supportPattern"));
			bptPeople.setJobStatusDescribe((String) peopleDemobilizedRecord
					.get("jobStatusDescribe"));
			service.update(bptPeople);
		}
	}

	/**
	 * ********************************************【在乡抚恤关系迁入我省
	 * END】*****************************************************
	 */

	/**
	 * 添加外省迁入我省参试抚恤信息
	 */
	@Trans
	public void insertTestedIntoProvince() {
		Record bptCategoryRecord = (Record) getParameter("BptCategoryRecord");
		// 封装人员信息
		BaseinfoPeople baseinfoPeople = getPeopleInfo();

		// 封装家庭信息
		BaseinfoFamily baseinfoFamily = getBaseinfoFamily();

		// 封装参试信息
		BptPeopleTested bptPeopleTested = (BptPeopleTested) bptCategoryRecord
				.toBean(BptPeopleTested.class);
		bptPeopleTested.setRegId(BspUtil.getEmpOrganId());
		bptPeopleTested.setRegTime(DateUtil.getTime());
		bptPeopleTested.setModId(BspUtil.getEmpOrganId());
		bptPeopleTested.setModTime(DateUtil.getTime());

		// 封装人员优抚信息
		BptPeople bptPeople = (BptPeople) bptCategoryRecord
				.toBean(BptPeople.class);
		bptPeople.setDisabilityTypeCode("00");
		bptPeople.setRedaTypeCode("00");
		bptPeople.setDemobilizedTyepCode("00");
		bptPeople.setDependantTypeCode("00");
		bptPeople.setWarTypeCode("61");
		bptPeople.setRetiredTypeCode("00");
		bptPeople.setMartyrOffspringCode("00");

		// 封装外省三属人员抚恤关系
		BptApplyIntoprovince disabilityIntoprovi = getDisabilityIntoprovi();

		String peoplePhotoTemp = baseinfoPeople.getPhotoTemp();
		String nowTime = DateUtil.getTime();
		String areaCode = baseinfoPeople.getRegOrgArea();
		String employeeName = baseinfoPeople.getRegPeople();
		dealPhotoC(baseinfoPeople, nowTime, areaCode, employeeName,
				peoplePhotoTemp);// 处理照片

		String peopleId = IdHelp.getUUID30();
		String familyId = IdHelp.getUUID30();
		String applyId = IdHelp.getUUID30();

		disabilityIntoprovi.setApplyId(applyId);

		String flag = (String) getParameter("flag");
		if ("1".equals(flag)) { // 添加

			baseinfoPeople.setPeopleId(peopleId);
			baseinfoPeople.setFamilyId(familyId);
			baseinfoFamily.setFamilyId(familyId);
			bptPeople.setPeopleId(peopleId);
			bptPeopleTested.setPeopleId(peopleId);
			disabilityIntoprovi.setPeopleId(peopleId);

			service.insertBaseinfo(baseinfoPeople, baseinfoFamily);
			service.insertBptPeople(bptPeople);
		} else { // 修改
			service.updateBaseinfo(baseinfoPeople, baseinfoFamily);
			String peopleIdOld = baseinfoPeople.getPeopleId();
			ParameterSet pset = new ParameterSet();
			pset.setParameter("PEOPLE_ID", peopleIdOld);
			
			bptPeople.setPeopleId(peopleIdOld);
			DataSet ds = service.queryBptPeople(pset);
			if (ds.getCount() > 0) {
				BptPeople bptPeopleQuery = (BptPeople) ds.getRecord(0).toBean(
						BptPeople.class);
				bptPeople.setDisabilityTypeCode(bptPeopleQuery
						.getDisabilityTypeCode());
				bptPeople.setRedaTypeCode(bptPeopleQuery.getRedaTypeCode());
				bptPeople.setDependantTypeCode(bptPeopleQuery
						.getDependantTypeCode());
				bptPeople.setDemobilizedTyepCode(bptPeopleQuery
						.getDemobilizedTyepCode());
				bptPeople.setRetiredTypeCode(bptPeopleQuery.getRetiredTypeCode());
				bptPeople.setMartyrOffspringCode(bptPeopleQuery.getMartyrOffspringCode());
				service.update(bptPeople);
			} else {
				service.insertBptPeople(bptPeople);
			}

			bptPeopleTested.setPeopleId(peopleIdOld);
			disabilityIntoprovi.setPeopleId(peopleIdOld);
		}
		service.insertTested(bptPeopleTested);
		bptApplyIntoprovinceService.insert(disabilityIntoprovi);
		setReturn("peopleId", baseinfoPeople.getPeopleId());
		setReturn("familyId", baseinfoPeople.getFamilyId());
		setReturn("applyId", applyId);
	}

	/**
	 * 修改外省参试人员抚恤迁入我省信息
	 */
	@Trans
	public void updateTestedInProvice() {
		ParameterSet pset = getParameterSet();
		Record record = (Record) getParameter("record");
		String applyId = (String) getParameter("applyId");
		pset.clear();

		// 修改人员基本信息
		pset.setParameter("PEOPLE_ID", (String) record.get("peopleId"));
		DataSet baseDs = service.queryPeople(pset);
		if (baseDs.getCount() != 0) {
			BaseinfoPeople baseinfoPeople = (BaseinfoPeople) baseDs
					.getRecord(0).toBean(BaseinfoPeople.class);
			baseinfoPeople.setWarStateCode((String) record.get("warStateCode"));
			baseinfoPeople.setWarNo((String) record.get("oldPaperNo"));
			service.updateBaseinfoPeople(baseinfoPeople);
		}

		// 修改参试人员信息
		BptPeopleTested bptPeopleTested = (BptPeopleTested) record
				.toBean(BptPeopleTested.class);
		bptPeopleTestedService.updatePeopleTeseted(bptPeopleTested);

		// 修改优抚人员信息
		DataSet bptDs = service.queryBptPeople(pset);
		if (bptDs.getCount() != 0) {
			BptPeople bptPeople = (BptPeople) bptDs.getRecord(0).toBean(
					BptPeople.class);
			bptPeople.setInsanityFlag((String) record.get("insanityFlag"));
			bptPeople.setBank((String) record.get("bank"));
			bptPeople.setAccountName((String) record.get("accountName"));
			bptPeople.setAccountCode((String) record.get("accountCode"));
			bptPeople.setOldLonelyFlag((String) record.get("oldLonelyFlag"));
			bptPeople.setOrphanFlag((String) record.get("orphanFlag"));
			bptPeople
					.setWorkAbilityCode((String) record.get("workAbilityCode"));
			bptPeople.setWorkAbilityDescribe((String) record
					.get("workAbilityDescribe"));
			bptPeople.setViabilityCode((String) record.get("viabilityCode"));
			bptPeople.setSupportPattern((String) record.get("supportPattern"));
			bptPeople.setJobStatusDescribe((String) record
					.get("jobStatusDescribe"));
			service.update(bptPeople);
		}

		// 修改外省参试人员迁入我省信息
		pset.clear();
		pset.setParameter("APPLY_ID", applyId);
		DataSet ingoDependantDs = bptApplyIntoprovinceService.query(pset);
		if (ingoDependantDs.getCount() != 0) {
			BptApplyIntoprovince bptApplyIntoprovince = (BptApplyIntoprovince) ingoDependantDs
					.getRecord(0).toBean(BptApplyIntoprovince.class);
			bptApplyIntoprovince.setAllowanceMonth((String) record
					.get("allowanceMonth"));
			bptApplyIntoprovince.setIngoingAddress((String) record
					.get("ingoingAddress"));
			bptApplyIntoprovince.setIngoingReason((String) record
					.get("ingoingReason"));
			bptApplyIntoprovince.setOldPaperNo((String) record
					.get("oldPaperNo"));
			bptApplyIntoprovince.setIngoingCode((String) record
					.get("ingoingCode"));

			bptApplyIntoprovinceService.update(bptApplyIntoprovince);
		}
	}

	/**
	 * ********************************************【带病回乡抚恤关系迁入我省
	 * START】*****************************************************
	 */
	/**
	 * 获取人员信息 author: since:2011-05-16
	 */
	private BaseinfoPeople getDemoIllBaseinfoPeople() {
		Record baseinfopeopleRecord = (Record) getParameter("BaseinfoPeopleRecord");
		Record PeopleDemobilizedRecord = (Record) getParameter("DemobilizedIllnessRecord");
		BaseinfoPeople bean = (BaseinfoPeople) baseinfopeopleRecord
				.toBean(BaseinfoPeople.class);
		bean.setIdCardType("0");
		bean.setDisabilityFlag(baseinfopeopleRecord.get("disabilityFlag")
				.toString());
		bean.setRedaFlag(baseinfopeopleRecord.get("redaFlag").toString());
		bean.setDependantFlag(baseinfopeopleRecord.get("dependantFlag")
				.toString());
		bean.setDemobilizedFlag("1");
		bean.setWarFlag(baseinfopeopleRecord.get("warFlag").toString());
		bean.setDisabilityStateCode(baseinfopeopleRecord.get(
				"disabilityStateCode").toString());
		bean.setRedaStateCode(baseinfopeopleRecord.get("redaStateCode")
				.toString());
		bean.setDependantStateCode(baseinfopeopleRecord.get(
				"dependantStateCode").toString());
		bean.setWarStateCode(baseinfopeopleRecord.get("warStateCode")
				.toString());
		bean.setDemobilizedStateCode(PeopleDemobilizedRecord.get(
				"demobilizedStateCode").toString());
		//bean.setDemobilizedNo(PeopleDemobilizedRecord.get("demobilizedNo")
			//	.toString());
		bean.setPersonalStatsTag("0");
		bean.setDisabilityStateCode("0");
		bean.setRegId(BspUtil.getEmpOrganId());
		bean.setRegTime(DateUtil.getTime());
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		return bean;
	}

	/**
	 * @description: 获得在乡复员军人信息
	 * @return : BptPeopleDependant
	 */
	private BptPeopleDemobilizedIllness getBptPeopleDemobilizedIllness() {
		Record peopleDemobilizedRecord = (Record) getParameter("DemobilizedIllnessRecord");
		BptPeopleDemobilizedIllness dataBean = (BptPeopleDemobilizedIllness) peopleDemobilizedRecord
				.toBean(BptPeopleDemobilizedIllness.class);
		dataBean
				.setPeopleId(peopleDemobilizedRecord.get("peopleId").toString());
		dataBean.setConscriptDate(peopleDemobilizedRecord.get("conscriptDate")
				.toString());
		dataBean.setDecruitmentDate(peopleDemobilizedRecord.get(
				"decruitmentDate").toString());
		dataBean
				.setForcesNo(peopleDemobilizedRecord.get("forcesNo").toString());
		dataBean
				.setPosition(peopleDemobilizedRecord.get("position").toString());
		dataBean.setAsdpNo(peopleDemobilizedRecord.get("asdpNo").toString());
		dataBean.setNote(peopleDemobilizedRecord.get("note").toString());
		dataBean.setCommitFlag("0");
		dataBean.setRegId(BspUtil.getEmpOrganId());
		dataBean.setRegTime(DateUtil.getTime());
		dataBean.setModId(BspUtil.getEmpOrganId());
		dataBean.setModTime(DateUtil.getTime());
		return dataBean;
	}

	/**
	 * 获得优抚人员信息
	 */
	private BptPeople getDemoIllBptPeople() {
		Record peopleDemobilizedRecord = (Record) getParameter("DemobilizedIllnessRecord");
		BptPeople bptPeople = (BptPeople) peopleDemobilizedRecord
				.toBean(BptPeople.class);
		bptPeople.setPeopleId(peopleDemobilizedRecord.get("peopleId")
				.toString());
		bptPeople.setDemobilizedTyepCode("42");
		bptPeople.setInsanityFlag(peopleDemobilizedRecord.get("insanityFlag")
				.toString());
		bptPeople.setOldLonelyFlag(peopleDemobilizedRecord.get("oldLonelyFlag")
				.toString());
		// bptPeople.setOrphanFlag(peopleDemobilizedRecord.get("orphanFlag").toString());
		bptPeople.setWorkAbilityCode(peopleDemobilizedRecord.get(
				"workAbilityCode").toString());
		bptPeople.setWorkAbilityDescribe(peopleDemobilizedRecord.get(
				"workAbilityDescribe").toString());
		bptPeople.setViabilityCode(peopleDemobilizedRecord.get("viabilityCode")
				.toString());
		bptPeople.setSupportPattern(peopleDemobilizedRecord.get(
				"supportPattern").toString());
		bptPeople.setJobStatusDescribe(peopleDemobilizedRecord.get(
				"jobStatusDescribe").toString());
		bptPeople.setBank(peopleDemobilizedRecord.get("bank").toString());
		bptPeople.setAccountCode(peopleDemobilizedRecord.get("accountCode")
				.toString());
		bptPeople.setAccountName(peopleDemobilizedRecord.get("accountName")
				.toString());

		// 将该对象修改为多个对象类别
		ParameterSet param = new ParameterSet();
		param.setParameter("PEOPLE_ID", peopleDemobilizedRecord.get("peopleId")
				.toString());
		DataSet ds = service.queryBptPeople(param);
		if (ds.getCount() != 0) {
			Record rd = ds.getRecord(0);

			bptPeople.setDisabilityTypeCode(rd.get("disabilityTypeCode")
					.toString());
			bptPeople.setDependantTypeCode(rd.get("dependantTypeCode")
					.toString());
			bptPeople.setRedaTypeCode(rd.get("redaTypeCode").toString());
			bptPeople.setWarTypeCode(rd.get("warTypeCode").toString());
			bptPeople.setRetiredTypeCode((String)rd.get("retiredTypeCode"));
			bptPeople.setMartyrOffspringCode((String)rd.get("martyrOffspringCode"));
		} else {
			bptPeople.setDisabilityTypeCode("00");
			bptPeople.setDependantTypeCode("00");
			bptPeople.setRedaTypeCode("00");
			bptPeople.setWarTypeCode("00");
			bptPeople.setRetiredTypeCode("00");
			bptPeople.setMartyrOffspringCode("00");
		}
		return bptPeople;
	}

	/**
	 * 取得外省优抚人员抚恤关系迁入审批表DataBean
	 * 
	 * @return BptApplyIntoprovince
	 */
	private BptApplyIntoprovince getDemobilizedIllProvinceFlow() {
		String applyId = IdHelp.getUUID30();
		Record peopleDemobilizedRecord = (Record) getParameter("DemobilizedIllnessRecord");
		BptApplyIntoprovince dataBean = new BptApplyIntoprovince();
		dataBean.setApplyId(IdHelp.getUUID30());
		dataBean
				.setPeopleId(peopleDemobilizedRecord.get("peopleId").toString());
		dataBean.setServiceType(peopleDemobilizedRecord.get("serviceType")
				.toString());
		dataBean.setIngoingAddress(peopleDemobilizedRecord
				.get("ingoingAddress").toString());
		dataBean.setIngoingCode(peopleDemobilizedRecord
				.get("ingoingCode").toString());
		dataBean.setIngoingReason(peopleDemobilizedRecord.get("ingoingReason")
				.toString());
		dataBean.setAllowanceMonth(peopleDemobilizedRecord
				.get("allowanceMonth").toString());
		dataBean.setOldPaperNo(peopleDemobilizedRecord
				.get("oldPaperNo").toString());
		dataBean.setCommitFlag(BptConstant.UN_COMMIT_FLAG);
		return dataBean;

	}

	/**
	 * 修改类别信息
	 */
	@Trans
	public void updateIntoDmeoIntoProvince() {
		Record peopleDemobilizedRecord = (Record) getParameter("DemobilizedIllnessRecord");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("PEOPLE_ID@=", peopleDemobilizedRecord
				.get("peopleId").toString());

		String w = peopleDemobilizedRecord.get("ingoingReason").toString();
		String q = peopleDemobilizedRecord.get("ingoingAddress").toString();
		BptApplyIntoprovince bptApplyIntoprovince = (BptApplyIntoprovince) bptApplyIntoprovinceService
				.query(pset).getRecord(0).toBean(BptApplyIntoprovince.class);
		bptApplyIntoprovince.setIngoingAddress(peopleDemobilizedRecord.get(
				"ingoingAddress").toString());
		bptApplyIntoprovince.setIngoingReason(peopleDemobilizedRecord.get(
				"ingoingReason").toString());
		bptApplyIntoprovince.setAllowanceMonth(peopleDemobilizedRecord.get(
				"allowanceMonth").toString());
		bptApplyIntoprovince.setIngoingCode(peopleDemobilizedRecord.get(
				"ingoingCode").toString());

		BptPeopleDemobilizedIllness dataBean = (BptPeopleDemobilizedIllness) peopleDemobilizedRecord
				.toBean(BptPeopleDemobilizedIllness.class);

		// 获取外省人员抚恤关系迁入DataBean
		BptApplyIntoprovince getDemobilizedProvinceFlow = getDemobilizedProvinceFlow();
		service.updateBptPeopleDemobilizedIllness(dataBean);

		bptApplyIntoprovinceService.update(bptApplyIntoprovince);
	}

	/**
	 * 保存外省带病回乡人员抚恤关系迁入我省人员信息
	 */
	@Trans
	public void insertIllIngoingProvince(){
		//获得人员信息
		BaseinfoPeople baseinfoPeople = getDemoIllBaseinfoPeople();
		//获得家庭信息
		BaseinfoFamily baseinfoFamily = getDemoBaseinfoFamily();
		//获得bptpeopledemobilized
		BptPeopleDemobilizedIllness bptPeopleDemobilizedIllness = getBptPeopleDemobilizedIllness();
		//bptPeople
		BptPeople demoBptPeople = getDemoIllBptPeople();
		//获取外省人员抚恤关系迁入DataBean
		BptApplyIntoprovince getDemobilizedProvinceFlow = getDemobilizedIllProvinceFlow();
		
		String peoplePhotoTemp=baseinfoPeople.getPhotoTemp();
		String nowTime = DateUtil.getTime();
		String areaCode=baseinfoPeople.getRegOrgArea();
		String employeeName=baseinfoPeople.getRegPeople();
		dealPhotoC(baseinfoPeople, nowTime, areaCode, employeeName,peoplePhotoTemp);//处理照片

		
		String peopleId = IdHelp.getUUID30();
		String familyId = IdHelp.getUUID30();
		String applyId = IdHelp.getUUID30();
		
		getDemobilizedProvinceFlow.setApplyId(applyId);
		
		String flag = (String)getParameter("flag");
		if("1".equals(flag)) { // 添加
			
			baseinfoPeople.setPeopleId(peopleId);
			baseinfoPeople.setFamilyId(familyId);
			baseinfoFamily.setFamilyId(familyId);
			demoBptPeople.setPeopleId(peopleId);
			bptPeopleDemobilizedIllness.setPeopleId(peopleId);
			getDemobilizedProvinceFlow.setPeopleId(peopleId);
			
			service.insertBaseinfo(baseinfoPeople, baseinfoFamily);
			service.insertBptPeople(demoBptPeople);
		} else { // 修改
			service.updateBaseinfo(baseinfoPeople, baseinfoFamily);
			String peopleIdOld = baseinfoPeople.getPeopleId();
			ParameterSet pset = new ParameterSet();
			pset.setParameter("PEOPLE_ID", peopleIdOld);
			demoBptPeople.setPeopleId(peopleIdOld);
			DataSet ds = service.queryBptPeople(pset);
			if(ds.getCount() > 0 ) {
				service.update(demoBptPeople);
			} else {
				service.insertBptPeople(demoBptPeople);
			}
			
			bptPeopleDemobilizedIllness.setPeopleId(peopleIdOld);
			getDemobilizedProvinceFlow.setPeopleId(peopleIdOld);
		}
		service.insertPeopleDemobilizedIllness(bptPeopleDemobilizedIllness);
		bptApplyIntoprovinceService.insert(getDemobilizedProvinceFlow);
		setReturn("peopleId", baseinfoPeople.getPeopleId());
		setReturn("familyId", baseinfoPeople.getFamilyId());
		setReturn("applyId", applyId);
	}

	/**
	 * 修改外省迁入带病回乡信息
	 */
	@Trans
	public void updateDemobilizedIllnessRecord() {
		ParameterSet pset = getParameterSet();
		Record record = (Record) getParameter("DemobilizedIllnessRecord");
		String applyId = (String) getParameter("applyId");
		pset.clear();

		// 修改人员基本信息
		pset.setParameter("PEOPLE_ID", (String) record.get("peopleId"));
		DataSet baseDs = service.queryPeople(pset);
		if (baseDs.getCount() != 0) {
			BaseinfoPeople baseinfoPeople = (BaseinfoPeople) baseDs
					.getRecord(0).toBean(BaseinfoPeople.class);
			baseinfoPeople.setWarStateCode((String) record
					.get("demobilizedStateCode"));
			baseinfoPeople.setWarNo((String) record.get("demobilizedNo"));
			service.updateBaseinfoPeople(baseinfoPeople);
		}

		// 修改带病回乡信息
		BptPeopleDemobilizedIllness bptPeopleDemobilizedIllness = (BptPeopleDemobilizedIllness) record
				.toBean(BptPeopleDemobilizedIllness.class);
		demobilizedIllnessService
				.updateBptPeopleDemobilizedIllness(bptPeopleDemobilizedIllness);

		// 修改优抚人员信息
		DataSet bptDs = service.queryBptPeople(pset);
		if (bptDs.getCount() != 0) {
			BptPeople bptPeople = (BptPeople) bptDs.getRecord(0).toBean(
					BptPeople.class);
			bptPeople.setBank((String) record.get("bank"));
			bptPeople.setAccountName((String) record.get("accountName"));
			bptPeople.setAccountCode((String) record.get("accountCode"));
			bptPeople.setOldLonelyFlag((String) record.get("oldLonelyFlag"));
			bptPeople.setOrphanFlag((String) record.get("orphanFlag"));
			bptPeople
					.setWorkAbilityCode((String) record.get("workAbilityCode"));
			bptPeople.setWorkAbilityDescribe((String) record
					.get("workAbilityDescribe"));
			bptPeople.setViabilityCode((String) record.get("viabilityCode"));
			bptPeople.setSupportPattern((String) record.get("supportPattern"));
			bptPeople.setJobStatusDescribe((String) record
					.get("jobStatusDescribe"));
			bptPeople.setInsanityFlag((String) record.get("insanityFlag"));
			service.update(bptPeople);
		}

		// 修改外省参试人员迁入我省信息
		pset.clear();
		pset.setParameter("APPLY_ID", applyId);
		DataSet ingoDependantDs = bptApplyIntoprovinceService.query(pset);
		if (ingoDependantDs.getCount() != 0) {
			BptApplyIntoprovince bptApplyIntoprovince = (BptApplyIntoprovince) ingoDependantDs
					.getRecord(0).toBean(BptApplyIntoprovince.class);
			bptApplyIntoprovince.setAllowanceMonth((String) record
					.get("allowanceMonth"));
			bptApplyIntoprovince.setIngoingAddress((String) record
					.get("ingoingAddress"));
			bptApplyIntoprovince.setIngoingReason((String) record
					.get("ingoingReason"));
			bptApplyIntoprovince.setOldPaperNo((String) record
					.get("oldPaperNo"));
			bptApplyIntoprovince.setIngoingCode((String) record
					.get("ingoingCode"));

			bptApplyIntoprovinceService.update(bptApplyIntoprovince);
		}
	}

	/**
	 * 添加审批记录
	 * 
	 * @param pset
	 */
	@Trans
	private void insertBptApplyHistory() {
		String currentField = (String) getParameter("currentField"); // 当前域
		String applyId = (String) getParameter("applyId");
		String actDefName = (String) getParameter("actName");
		Record record = (Record) getParameter("record");
		BptApplyIntoprovince dataBean = (BptApplyIntoprovince) record
				.toBean(BptApplyIntoprovince.class);
		// 插入审批记录历史表
		BptApplyHistory bptApplyHistory = new BptApplyHistory();
		bptApplyHistory.setHistoryId(IdHelp.getUUID30());
		bptApplyHistory.setActdefName(actDefName);
		bptApplyHistory.setCreateTime(DateUtil.getTime());
		bptApplyHistory.setApplyId(applyId);
		if ("TownVerify".equals(currentField)) { // 县级
			ParameterSet param = new ParameterSet();
			param.setParameter("APPLY_ID", applyId);
			DataSet ds = bptApplyIntoprovinceService.query(param);
			if (ds != null && ds.getCount() != 0) {
				dataBean = (BptApplyIntoprovince) (ds.getRecord(0)
						.toBean(BptApplyIntoprovince.class));
				bptApplyHistory.setApplyAdvice(dataBean.getTownAduitAdvice());
				bptApplyHistory.setApplyIncharge(dataBean
						.getTownAduitIncharge());
				bptApplyHistory
						.setApplyTime(dataBean.getTownAduitApproveDate());
			}
		} else if ("CityVerify".equals(currentField)) { // 市级
			bptApplyHistory.setApplyAdvice(dataBean.getCityAduitAdvice());
			bptApplyHistory.setApplyIncharge(dataBean.getCityAduitIncharge());
			bptApplyHistory.setApplyTime(dataBean.getCityAduitApproveDate());
		} else if ("ProvinceApprove".equals(currentField)) { // 省级审批
			bptApplyHistory.setApplyAdvice(dataBean.getProvinceAdvice());
			bptApplyHistory.setApplyIncharge(dataBean.getProvinceIncharge());
			bptApplyHistory.setApplyTime(dataBean.getProvinceApproveDate());
		}
		bptApplyHistoryService.insert(bptApplyHistory);
	}

	/**
	 * 发送流程
	 */
	@Trans
	public void send() {

		String contion = (String) getParameter("contion");
		update();

		insertBptApplyHistory();// 保存审批历史记录

		Map<String, String> context = new HashMap<String, String>();
		String town_OrganId = BspUtil.getParentStrId();
		context.put("City_OrganId", town_OrganId);
		context.put("Contion", contion);

		// 修改是否被退回标示为n（非退回）
		ParameterSet pset = new ParameterSet();
		pset.setParameter("applyId", (String) getParameter("applyId"));
		pset.setParameter("ifback", "n");
		wfProcessBusinessService.updateIfback(pset);
		
		//判段是否是县级提交 如果是修改流程发起时间为当前时间
		if("13".equals(BspUtil.getOrganType())){
			ParameterSet psettime = new ParameterSet();
			psettime.setParameter("applyId", (String) getParameter("applyId"));
			wfProcessBusinessService.updateProCreateTime(psettime);
		}
		
		// 调用工作流发送接口
		Map map = WfTaskRequestWrapper.getInstance().send(context);

		if (map.containsKey("isEnd")) { // 流程完成后修改三属信息
			String isEnd = (String) map.get("isEnd");
			if ("true".equals(isEnd)) {
				if ("pass".equals(contion)) {
					updateInfo(); // 审批结束后修改状态变更记录以及基本信息表
				} else if ("end".equals(contion)) {
					updateNotInto(); // 不予迁移并结束
				}
			}
		}
	}

	/**
	 * 回退流程
	 */
	@Trans
	public void back() {
		// 调用工作流回退接口
		update();

		insertBptApplyHistory(); // 保存审批历史记录

		WfTaskRequestWrapper.getInstance().back();

		// 修改是否被退回标示为y（退回）
		ParameterSet pset = new ParameterSet();
		pset.setParameter("applyId", (String) getParameter("applyId"));
		pset.setParameter("ifback", "y");
		wfProcessBusinessService.updateIfback(pset);
	}

	/**
	 * 流程完成后基本信息
	 */
	@Trans
	public void updateInfo() {
		ParameterSet pset = getParameterSet();
		String peopleId = (String) pset.getParameter("peopleId");
		String serviceType = (String) pset.getParameter("serviceType");
		String applyId = (String) pset.getParameter("applyId");
		BptStateChange bptStateChange = new BptStateChange();

		pset.clear();
		pset.setParameter("PEOPLE_ID", peopleId);
		BaseinfoPeople baseinfoPeople = (BaseinfoPeople) service.queryPeople(
				pset).getRecord(0).toBean(BaseinfoPeople.class);
		baseinfoPeople.setPersonalStatsTag("1");
		String statepre = stateChangeService.queryPreStateChange(peopleId);
		String domicileCode = baseinfoPeople.getDomicileCode();
		// 添加状态变更表数据
		bptStateChange.setStateChangeId(IdHelp.getUUID30());
		bptStateChange.setPeopleId(peopleId);
		String domiclile = baseinfoPeople.getDomicileCode();
		String inDomiclieCode = domiclile.substring(0, 6) + "000000";
		String inDomiclieCodeName = BptApplyEmigrationCommand
				.queryDomicileCodeName(inDomiclieCode);

		bptStateChange.setIdCard(baseinfoPeople.getIdCard());
		bptStateChange.setName(baseinfoPeople.getName());
		bptStateChange.setInDomicileCode(inDomiclieCode);
		bptStateChange.setInDomicileCodeName(inDomiclieCodeName);
		bptStateChange.setRegId(BspUtil.getEmpOrganId());
		bptStateChange.setRegTime(DateUtil.getTime());
		bptStateChange.setModId(BspUtil.getEmpOrganId());
		bptStateChange.setModTime(DateUtil.getTime());
		bptStateChange.setChangeStateDate(DateUtil.getDay());
		bptStateChange.setChangeStatePre("5");
		bptStateChange.setChangeStateSuf("2");
		bptStateChange.setObjectType(serviceType);
		// 后期完善生成编号
		if ((BptConstant.BPT_DISABILITY_INGOINGPROVINCE).equals(serviceType)) {// 伤残
			BptApplyDisabilityCommand com = new BptApplyDisabilityCommand();
			String disabilityNo = com.findCommNo(peopleId,domicileCode);
			/**
			 * 伤残人员信息服务接口
			 */
			IBptPeopleDisabilityDomain disabilityService = ScaComponentFactory.getService(IBptPeopleDisabilityDomain.class,
			"bptPeopleDisabilityDomain/bptPeopleDisabilityDomain");
			// bptStateChange.setObjectType("1");
			baseinfoPeople.setDisabilityStateCode("2");
			baseinfoPeople.setDisabilityNo(disabilityNo);
			BptPeopleDisability disability = (BptPeopleDisability) disabilityService.queryBptPeopleDisability(pset)
				.getRecord(0).toBean(BptPeopleDisability.class);
			disability.setApproveDate(DateUtil.getDay());
			disabilityService.updatePeopleDisability(disability);
			
		} else if ((BptConstant.BPT_DEPENDANT_INGOINGPROVINCE)
				.equals(serviceType)) {// 三属
			/**
			 * 三属服务接口
			 */
			IBptPeopleDependantDomain dependantService = ScaComponentFactory.getService(IBptPeopleDependantDomain.class,
			"bptPeopleDependantDomain/bptPeopleDependantDomain");
			// bptStateChange.setObjectType("2");
			baseinfoPeople.setDependantStateCode("2");
			baseinfoPeople.setDependantNo(NOService.getNO("LS",domicileCode));
			BptPeopleDependant dependant =  (BptPeopleDependant) dependantService.query(pset).getRecord(0)
				.toBean(BptPeopleDependant.class);
			dependant.setApprovalDate(DateUtil.getDay());
			dependantService.update(dependant);
		} else if ((BptConstant.BPT_DEMOBILIZED_INGOINGPROVINCE)
				.equals(serviceType)) {// 在乡
			/**  
			 * 在乡复员军人服务接口
			 */
			IBptPeopleDemobilizedDomain demobilizedService = ScaComponentFactory.getService(IBptPeopleDemobilizedDomain.class,
			"bptPeopleDemobilizedDomain/bptPeopleDemobilizedDomain");
			// bptStateChange.setObjectType("3");
			BptPeopleDemobilized demobilized = (BptPeopleDemobilized)demobilizedService.query(pset).getRecord(0).toBean(BptPeopleDemobilized.class);
			demobilized.setApprovalDate(DateUtil.getDay());
			baseinfoPeople.setDemobilizedStateCode("2");
			baseinfoPeople.setDemobilizedNo(NOService.getNO("ZX",domicileCode));
			demobilizedService.updateBptPeopleDemobilized(demobilized);
		} else if ((BptConstant.BPT_DEMOBILIZEDILLNESS_INGOINGPROVINCE)
				.equals(serviceType)) {// 带病回乡
			/**
			 * 带病回乡军人服务接口
			 */
			IBptPeopleDemobilizedIllnessDomain demobilizedIllnessDomainService = ScaComponentFactory
					.getService(IBptPeopleDemobilizedIllnessDomain.class,
							"demobilizedIllnessDomain/demobilizedIllnessDomain");
			// bptStateChange.setObjectType("4");
			BptPeopleDemobilizedIllness demobilizedIllness = (BptPeopleDemobilizedIllness) demobilizedIllnessDomainService.query(pset).getRecord(0).toBean(BptPeopleDemobilizedIllness.class);
			demobilizedIllness.setApprovalDate(DateUtil.getDay());
			baseinfoPeople.setDemobilizedStateCode("2");
			baseinfoPeople.setDemobilizedNo(NOService.getNO("DB",domicileCode));
			demobilizedIllnessDomainService.updateBptPeopleDemobilizedIllness(demobilizedIllness);

		} else if ((BptConstant.BPT_WAR_INGOINGPROVINCE).equals(serviceType)) {// 参战
			/**
			 * 参战人服务接口
			 */
			IWarDomain iWarService = ScaComponentFactory.getService(IWarDomain.class,"bptWarDomain/bptWarDomain");
			// bptStateChange.setObjectType("5");
			BptPeopleWar war = (BptPeopleWar) iWarService.query(pset).getRecord(0).toBean(BptPeopleWar.class);
			war.setApprovalDate(DateUtil.getDay());
			baseinfoPeople.setWarStateCode("2");
			baseinfoPeople.setWarNo(NOService.getNO("CZ",domicileCode));
			iWarService.updateWar(war);
		} else if ((BptConstant.BPT_TESTED_INGOINGPROVINCE).equals(serviceType)) {// 参试
			/**
			 * 获得参试人员服务接口
			 */
			IBptPeopleTestedDomain bptPeopleTestedService = ScaComponentFactory
					.getService(IBptPeopleTestedDomain.class,
							"bptPeopleTestedDomain/bptPeopleTestedDomain");
			// bptStateChange.setObjectType("6");
			pset.setParameter("domicileCode", baseinfoPeople.getDomicileCode());
			BptPeopleTested tested = (BptPeopleTested) bptPeopleTestedService.queryTested(pset).getRecord(0).toBean(BptPeopleTested.class);
			pset.remove("baseinfoPeople");
			tested.setApprovalDate(DateUtil.getDay());
			baseinfoPeople.setWarStateCode("2");
			baseinfoPeople.setWarNo(NOService.getNO("CS",domicileCode));
			bptPeopleTestedService.updatePeopleTeseted(tested);
		}

		pset.clear();
		pset.setParameter("APPLY_ID", applyId);
		BptApplyIntoprovince bptApplyIntoprovince = (BptApplyIntoprovince) bptApplyIntoprovinceService
				.query(pset).getRecord(0).toBean(BptApplyIntoprovince.class);

		bptStateChange.setAllowanceMonth(bptApplyIntoprovince
				.getAllowanceMonth().substring(0,7));
		bptStateChange.setOutDomicileCodeName(bptApplyIntoprovince
				.getIngoingAddress());
		bptStateChange
				.setOutDomicileCode(bptApplyIntoprovince.getIngoingCode());// 后期添加省外选择民政局完善此语句

		stateChangeService.insert(bptStateChange);
		service.updateBaseinfoPeople(baseinfoPeople); // 修改人员基本信息状态为正常
	}

	/**
	 * 家庭成员 照片处理(申请人证件照片、申请人现场照片)
	 * 
	 * @param icmApplyInfo
	 */
	@Trans
	public void dealPhotoC(BaseinfoPeople bean, String nowTime,
			String areaCode, String employeeName, String peoplePhotoTemp) {
		// 采集证件照片
		String applybase64Code = "";
		String applycardbase64Code = "";
		String applyId = "";
		applybase64Code = bean.getPhotoTemp();
		applycardbase64Code=bean.getCardPhotoTemp();
		if (null != applybase64Code && !"".equals(applybase64Code)) {
			// 保存图片到表 COM_PHOTO 中，并返回该图片的主键
			applyId = PhotoUtil.savePhoto(bean.getPhotoTemp(),bean.getCardPhotoTemp());
		}

		if (applyId != null && !"".equals(applyId)) {
			bean.setPhotoId(applyId);
		}

	}

	/**
	 * 不予迁移并结束
	 */
	@Trans
	private void updateNotInto() {
		ParameterSet pset = getParameterSet();
		String peopleId = (String) getParameter("peopleId");
		String serviceType = (String) getParameter("serviceType");
		pset.clear();
		pset.setParameter("PEOPLE_ID", peopleId);
		BaseinfoPeople baseinfoPeople = (BaseinfoPeople) service.queryPeople(
				pset).getRecord(0).toBean(BaseinfoPeople.class);
		baseinfoPeople.setPersonalStatsTag("1");
		//获取以前状态
		String statepre = stateChangeService.queryPreStateChange(peopleId);
		// 不予迁移时改为状态为不予认定
		if ((BptConstant.BPT_DISABILITY_INGOINGPROVINCE).equals(serviceType)) {// 伤残
			baseinfoPeople.setDisabilityStateCode("6");
		} else if ((BptConstant.BPT_DEPENDANT_INGOINGPROVINCE)
				.equals(serviceType)) {// 三属
			baseinfoPeople.setDependantStateCode("6");
		} else if ((BptConstant.BPT_DEMOBILIZED_INGOINGPROVINCE)
				.equals(serviceType)) {// 在乡
			baseinfoPeople.setDemobilizedStateCode("6");
		} else if ((BptConstant.BPT_DEMOBILIZEDILLNESS_IDENTIFIED)
				.equals(serviceType)) {// 带病回乡
			baseinfoPeople.setDemobilizedStateCode("6");
		} else if ((BptConstant.BPT_WAR_INGOINGPROVINCE).equals(serviceType)) {// 参战
			baseinfoPeople.setWarStateCode("6");
		} else if ((BptConstant.BPT_TESTED_INGOINGPROVINCE).equals(serviceType)) {// 参试
			baseinfoPeople.setWarStateCode("6");
		}
		insertStateChange( baseinfoPeople , "5", "6", serviceType);
		service.updateBaseinfoPeople(baseinfoPeople);
	}
	/**
	 * 添加状态变更表数据
	 * @param baseinfoPeople
	 * @param prestate
	 * @param endstate
	 * @param serviceType
	 */
	public void insertStateChange(BaseinfoPeople baseinfoPeople ,String prestate,String endstate,String serviceType){
		BptStateChange bptStateChange = new BptStateChange();
		bptStateChange.setStateChangeId(IdHelp.getUUID30());
		bptStateChange.setPeopleId(baseinfoPeople.getPeopleId());
		String domiclile = baseinfoPeople.getDomicileCode();
		String outDomiclieCode = domiclile.substring(0, 6) + "000000";
		String outDomiclieCodeName = BptApplyEmigrationCommand
				.queryDomicileCodeName(outDomiclieCode);

		bptStateChange.setIdCard(baseinfoPeople.getIdCard());
		bptStateChange.setName(baseinfoPeople.getName());
		bptStateChange.setOutDomicileCode(outDomiclieCode);
		bptStateChange.setOutDomicileCodeName(outDomiclieCodeName);
		bptStateChange.setRegId(BspUtil.getEmpOrganId());
		bptStateChange.setRegTime(DateUtil.getTime());
		bptStateChange.setModId(BspUtil.getEmpOrganId());
		bptStateChange.setModTime(DateUtil.getTime());
		bptStateChange.setChangeStateDate(DateUtil.getDay());
		bptStateChange.setChangeStatePre(prestate);
		bptStateChange.setChangeStateSuf(endstate);
		bptStateChange.setObjectType(serviceType);
		stateChangeService.insert(bptStateChange);
	}
}
