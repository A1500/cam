package com.inspur.cams.bpt.manage.cmd;

import java.util.HashMap;
import java.util.Map;

import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.next.web.cmd.CommandContext;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;
import org.loushang.workflow.api.WfQuery;
import org.loushang.workflow.api.WfTaskRequestWrapper;

import com.inspur.cams.bpt.base.dao.jdbc.BptCountRetiredSoldierDao;
import com.inspur.cams.bpt.base.data.BptApplyEmigration;
import com.inspur.cams.bpt.base.data.BptApplyHistory;
import com.inspur.cams.bpt.base.data.BptCountRetiredSoldier;
import com.inspur.cams.bpt.base.data.BptPeopleDemobilized;
import com.inspur.cams.bpt.base.data.BptPeopleDemobilizedIllness;
import com.inspur.cams.bpt.base.data.BptPeopleDependant;
import com.inspur.cams.bpt.base.data.BptPeopleDisability;
import com.inspur.cams.bpt.base.data.BptPeopleMartyrOffspring;
import com.inspur.cams.bpt.base.data.BptPeopleTested;
import com.inspur.cams.bpt.base.data.BptPeopleWar;
import com.inspur.cams.bpt.base.data.BptStateChange;
import com.inspur.cams.bpt.base.data.WfProcessBusiness;
import com.inspur.cams.bpt.base.domain.IBptApplyEmigrationDomain;
import com.inspur.cams.bpt.base.domain.IBptApplyHistoryDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDemobilizedDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDemobilizedIllnessDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDependantDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDisabilityDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleMartyrOffspringDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleTestedDomain;
import com.inspur.cams.bpt.base.domain.IBptStateChangeDomain;
import com.inspur.cams.bpt.base.domain.IWarDomain;
import com.inspur.cams.bpt.base.domain.IWfProcessBusinessDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.bpt.util.BptConstant;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.diccity.data.DicCity;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * @description:优抚人员抚恤关系跨省迁出
 * @author:
 * @since:2011-07-29
 * @version:1.0
 */
public class BptApplyEmigrationCommand extends BaseAjaxCommand {
	IBptApplyEmigrationDomain bptApplyEmigrationService = ScaComponentFactory
			.getService(IBptApplyEmigrationDomain.class,
					"BptApplyEmigrationDomain/BptApplyEmigrationDomain");

	IBptGroupDomain service = ScaComponentFactory.getService(
			IBptGroupDomain.class, "bptGroupDomain/bptGroupDomain");

	// 状态变更接口
	private IBptStateChangeDomain stateChangeService = ScaComponentFactory
			.getService(IBptStateChangeDomain.class,
					"bptStateChangeDomain/bptStateChangeDomain");

	/**
	 * 工作流信息服务接口
	 */
	IWfProcessBusinessDomain wfProcessBusinessService = ScaComponentFactory
			.getService(IWfProcessBusinessDomain.class,
					"wfProcessBusinessDomain/wfProcessBusinessDomain");
	
	/**
	 * 审批记录历史服务接口
	 */
	IBptApplyHistoryDomain bptApplyHistoryService = ScaComponentFactory.getService(IBptApplyHistoryDomain.class,
	"BptApplyHistoryDomain/BptApplyHistoryDomain");

	/**
	 * 获得伤残人员服务接口
	 */
	IBptPeopleDisabilityDomain bptPeopleDisabilityService = ScaComponentFactory
			.getService(IBptPeopleDisabilityDomain.class,
					"bptPeopleDisabilityDomain/bptPeopleDisabilityDomain");
	IBptPeopleDependantDomain dependantService = ScaComponentFactory.getService(IBptPeopleDependantDomain.class,
			"bptPeopleDependantDomain/bptPeopleDependantDomain");

	IBptPeopleDemobilizedDomain demobilizedService = ScaComponentFactory.getService(IBptPeopleDemobilizedDomain.class,
			"bptPeopleDemobilizedDomain/bptPeopleDemobilizedDomain");
	IBptPeopleDemobilizedIllnessDomain demobilizedIllnessService = ScaComponentFactory.getService(IBptPeopleDemobilizedIllnessDomain.class,
			"demobilizedIllnessDomain/demobilizedIllnessDomain");
	 BptCountRetiredSoldierDao ptCountRetiredSoldierDao = (BptCountRetiredSoldierDao) DaoFactory
			.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptCountRetiredSoldierDao");
	 IBptPeopleMartyrOffspringDomain martyrOffspringDomain = (IBptPeopleMartyrOffspringDomain)ScaComponentFactory.getService(IBptPeopleMartyrOffspringDomain.class, "bptPeopleMartyrOffspringDomain/bptPeopleMartyrOffspringDomain");
	 IWarDomain iWarService = ScaComponentFactory.getService(IWarDomain.class,"bptWarDomain/bptWarDomain");
	 
	 /**
		 * 获得参战人员服务接口
		 */
		IBptPeopleTestedDomain iBptPeopleTestedService = ScaComponentFactory.getService(IBptPeopleTestedDomain.class,"bptPeopleTestedDomain/bptPeopleTestedDomain");
	
	/**
	 * 获取伤残审批信息判定是否提交
	 * @return
	 */
	public void queryApplyInfo() {
		ParameterSet pset = getParameterSet();
		DataSet ds =bptApplyEmigrationService.query(pset);
		if(ds.getCount()>0){
			String townAduitIncharge = (String)ds.getRecord(0).get("townAduitIncharge");
			this.setReturn("townAduitIncharge", townAduitIncharge);
		}
	}
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		BptApplyEmigration dataBean = (BptApplyEmigration) record
				.toBean(BptApplyEmigration.class);
		
		String applyId = IdHelp.getUUID30();
		dataBean.setApplyId(applyId);
		dataBean.setCommitFlag(BptConstant.UN_COMMIT_FLAG);
		bptApplyEmigrationService.insert(dataBean);
		setReturn("applyId", applyId);
	}
	/**
	 * 删除抚恤关系跨省迁出
	 * @param pset
	 * @return
	 */
	@Trans
	public void deleteEmigration(){
		Record[] records = (Record[])getParameter("records");
		ParameterSet pset = new ParameterSet();
		for (Record record : records) {
			String applyId = (String)record.get("APPLY_ID");
			pset.setParameter("applyId", applyId);
			bptApplyEmigrationService.deleteEmigration(pset);
		}
	}
	/**
	 * 
	 */
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		String applyId = getParameter("applyId").toString();
		ParameterSet pset = new ParameterSet();
		pset.setParameter("APPLY_ID", applyId);
		DataSet ds = bptApplyEmigrationService.query(pset);
		BptApplyEmigration dataBean = (BptApplyEmigration) ds.getRecord(0)
				.toBean(BptApplyEmigration.class);
		dataBean.setIngoingAddress(record.get("ingoingAddress").toString());
		dataBean.setIngoingCode(record.get("ingoingCode").toString());
		dataBean.setAllowanceMonth(record.get("allowanceMonth").toString());
		dataBean.setTownCheckPhone(record.get("townCheckPhone").toString());
		bptApplyEmigrationService.update(dataBean);
	}

	/**
	 * 审批时的修改
	 */
	@Trans
	public void updateApprove() {
		Record record = (Record) getParameter("record");
		BptApplyEmigration dataBean = (BptApplyEmigration) record
				.toBean(BptApplyEmigration.class);
		bptApplyEmigrationService.update(dataBean);
	}

	/**
	 * 创建并发起优抚人员抚恤关系跨省迁出流程
	 */
	@Trans
	@SuppressWarnings("unchecked")
	public void createAndSend() {
		String applyId;
		String peopleId;
		String serviceType;
		Record rd = (Record) getParameter("record");
		if (rd != null && !"".equals(rd)) {
			applyId = rd.get("APPLY_ID").toString();
			peopleId = rd.get("PEOPLE_ID").toString();
			serviceType = rd.get("SERVICE_TYPE").toString();
		} else {
			applyId = (String)getParameter("applyId");
			peopleId = (String)getParameter("peopleId");
			serviceType = (String)getParameter("serviceType");
		}
		String condition = (String)getParameter("Condition");
		ParameterSet pset = new ParameterSet();
		String serviceName = new String();
		ParameterSet param = new ParameterSet();
		param.setParameter("PEOPLE_ID", peopleId);
		BaseinfoPeople baseinfoPeople = (BaseinfoPeople) service.queryPeople(
				param).getRecord(0).toBean(BaseinfoPeople.class);

		// 伤残
		if ((BptConstant.BPT_DISABILITY_EMIGRATION).equals(serviceType)) {
			serviceName = BptConstant.BPT_DISABILITY_EMIGRATION_NA;
			baseinfoPeople.setDisabilityStateCode("5"); // 将伤残状态改为迁移
		}
		// 三属
		if ((BptConstant.BPT_DEPENDANT_EMIGRATION).equals(serviceType)) {
			serviceName = BptConstant.BPT_DEPENDANT_EMIGRATION_NA;
			baseinfoPeople.setDependantStateCode("5"); // 将三属状态改为迁移
		}
		// 在乡
		if ((BptConstant.BPT_DEMOBILIZED_EMIGRATION).equals(serviceType)) {
			serviceName = BptConstant.BPT_DEMOBILIZED_EMIGRATION_NA;
			baseinfoPeople.setDemobilizedStateCode("5"); // 将在乡状态改为迁移
		}
		// 带病回乡
		if ((BptConstant.BPT_DEMOBILIZEDILLNESS_EMIGRATION).equals(serviceType)) {
			serviceName = BptConstant.BPT_DEMOBILIZEDILLNESS_EMIGRATION_NA;
			baseinfoPeople.setDemobilizedStateCode("5"); // 将带病回乡状态改为迁移
		}
		// 参战
		if ((BptConstant.BPT_WAR_EMIGRATION).equals(serviceType)) {
			serviceName = BptConstant.BPT_WAR_EMIGRATION_NA;
			baseinfoPeople.setWarStateCode("5");// 将参战状态改为迁移
		}
		// 参试
		if ((BptConstant.BPT_TESTED_EMIGRATION).equals(serviceType)) {
			serviceName = BptConstant.BPT_TESTED_EMIGRATION_NA;
			baseinfoPeople.setWarStateCode("5");// 将参试状态改为迁移
		}
		// 60周岁退役士兵
		if ("84".equals(serviceType)) {
			serviceName = "年满60周岁农村籍退役士兵定补关系跨省迁出";
			baseinfoPeople.setRetiredStateCode("5");// 
		}
		// 部分烈士（错杀被平反人员）子女定
		if ("B4".equals(serviceType)) {
			serviceName = "部分烈士（错杀被平反人员）子女定补关系跨省迁出";
			baseinfoPeople.setMartyrOffspringStateCode("5");// 
		}

		// 更新【优抚人员抚恤关系跨省迁出审批表】信息
		pset.setParameter("APPLY_ID", applyId);
		BptApplyEmigration dataBean = (BptApplyEmigration) bptApplyEmigrationService
				.query(pset).getRecord(0).toBean(BptApplyEmigration.class);
		dataBean.setApplyDate(DateUtil.getDay());
		dataBean.setApplyOrganization(BspUtil.getOrganName());
		dataBean.setTownCheckPeople(GetBspInfo.getBspInfo().getUserName());
		dataBean.setTownCheckDate(DateUtil.getDay());
		dataBean.setCommitFlag(BptConstant.COMMIT_FLAG);
		bptApplyEmigrationService.update(dataBean);
		
		// 插入审批记录历史表
		BptApplyHistory bptApplyHistory = new BptApplyHistory();
		bptApplyHistory.setHistoryId(IdHelp.getUUID30());
		bptApplyHistory.setActdefName("县级审核");
		bptApplyHistory.setCreateTime(DateUtil.getTime());
		bptApplyHistory.setApplyAdvice(dataBean.getTownAduitAdvice());
		bptApplyHistory.setApplyIncharge(dataBean.getTownAduitIncharge());
		bptApplyHistory.setApplyTime(dataBean.getTownAduitApproveDate());
		bptApplyHistory.setApplyId(applyId);
		bptApplyHistoryService.insert(bptApplyHistory);

		// 调用BPM的接口发起流程
		//通过流程唯一ID获得流程第一个环节ID
		String procDefUniqueId = "8a898bd7318d35c401318d42c73e0002";
		String startActDefUniqueId = (String)WfQuery.getActDefInfoByProcDefUniqueIdAndActDefId(procDefUniqueId,"act2").get("actDefUniqueId");
		CommandContext.setContextParameter("procDefUniqueId",procDefUniqueId);
		CommandContext.setContextParameter("startActDefUniqueId",startActDefUniqueId);
		
		Map<String, String> context = new HashMap<String, String>();
		String City_Verify_OrganId = BspUtil.getParentStrId();
		String currentOrganName = BspUtil.getCorpOrgan().getOrganName();
		context.put("City_OrganId", City_Verify_OrganId);
		context.put("Condition", condition);
		Map<String, String> map = WfTaskRequestWrapper
				.getInstance()
				.createAndSend(applyId, currentOrganName + serviceName, context);
		String processId = map.get("processId");

		// 向表WF_PROCESS_BUSINESS【流程与业务关联表】表中添加一条记录
		WfProcessBusiness wfProcessBusiness = new WfProcessBusiness();
		wfProcessBusiness.setProcessId(processId);
		wfProcessBusiness.setBusinessId(applyId);
		wfProcessBusiness.setConnectId(peopleId);
		wfProcessBusiness.setBusinessType(serviceType);
		wfProcessBusiness.setIfback("n");
		wfProcessBusinessService.insert(wfProcessBusiness);

		// 修改人员基本信息
		service.updateBaseinfoPeople(baseinfoPeople);
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
		BptApplyEmigration dataBean=(BptApplyEmigration)record.toBean(BptApplyEmigration.class);
		// 插入审批记录历史表
		BptApplyHistory bptApplyHistory = new BptApplyHistory();
		bptApplyHistory.setHistoryId(IdHelp.getUUID30());
		bptApplyHistory.setActdefName(actDefName);
		bptApplyHistory.setCreateTime(DateUtil.getTime());
		bptApplyHistory.setApplyId(applyId);
		if ("TownVerify".equals(currentField)) { // 县级
			ParameterSet param = new ParameterSet();
			param.setParameter("APPLY_ID", applyId);
			DataSet ds = bptApplyEmigrationService.query(param);
			if (ds != null && ds.getCount() != 0) {
				dataBean = (BptApplyEmigration) (ds.getRecord(0)
						.toBean(BptApplyEmigration.class));
				bptApplyHistory.setApplyAdvice(dataBean
						.getTownAduitAdvice());
				bptApplyHistory.setApplyIncharge(dataBean
						.getTownAduitIncharge());
				bptApplyHistory.setApplyTime(dataBean
						.getTownAduitApproveDate());
			}
		} else if ("CityAduit".equals(currentField)) { // 市级
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
		updateApprove();
		Map<String, String> context = new HashMap<String, String>();
		 
		String condition = (String)getParameter("condition");
		context.put("Condition",condition);
		
		String City_Verify_OrganId = BspUtil.getParentStrId();
		context.put("City_OrganId", City_Verify_OrganId);
		
		insertBptApplyHistory();//添加审批历史记录

		// 调用工作流发送接口
		Map map = WfTaskRequestWrapper.getInstance().send(context);
		// 修改是否被退回标示为n（非退回）
		ParameterSet pset = new ParameterSet();
		pset.setParameter("applyId", (String)getParameter("applyId"));
		String apply= (String)getParameter("applyId");
		pset.setParameter("ifback", "n");
		wfProcessBusinessService.updateIfback(pset);
		
		//判段是否是县级提交 如果是修改流程发起时间为当前时间
		if("13".equals(BspUtil.getOrganType())){
			ParameterSet psettime = new ParameterSet();
			psettime.setParameter("applyId", (String) getParameter("applyId"));
			wfProcessBusinessService.updateProCreateTime(psettime);
		}
		
		if (map.containsKey("isEnd")) { // 流程完成后修改三属信息
			String isEnd = (String) map.get("isEnd");
			if ("true".equals(isEnd)) {
				if("pass".equals(condition)) {
					updateInfo(); // 审批结束后修改状态变更记录以及基本信息表
				} else if("end".equals(condition)) {
					updateNotInto(); //不予迁移并结束
				}
			}
		}
	}

	/**
	 * 回退流程
	 */
	@Trans
	public void back() {
		updateApprove();
		// 调用工作流回退接口
		WfTaskRequestWrapper.getInstance().back();
		
		insertBptApplyHistory();//添加审批历史记录
		
		// 修改是否被退回标示为y（退回）
		ParameterSet pset = new ParameterSet();
		pset.setParameter("applyId", (String)getParameter("applyId"));
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
		baseinfoPeople.setPersonalStatsTag("2");
		service.updateBaseinfoPeople(baseinfoPeople); // 修改人员基本信息状态为迁出

		// 添加状态变更表数据
		bptStateChange.setStateChangeId(IdHelp.getUUID30());
		bptStateChange.setPeopleId(peopleId);
		String domiclile = baseinfoPeople.getDomicileCode();
		String outDomiclieCode = domiclile.substring(0, 6) + "000000";
		String outDomiclieCodeName = queryDomicileCodeName(outDomiclieCode);

		bptStateChange.setIdCard(baseinfoPeople.getIdCard());
		bptStateChange.setName(baseinfoPeople.getName());
		bptStateChange.setOutDomicileCode(outDomiclieCode);
		bptStateChange.setOutDomicileCodeName(outDomiclieCodeName);
		bptStateChange.setRegId(BspUtil.getEmpOrganId());
		bptStateChange.setRegTime(DateUtil.getTime());
		bptStateChange.setModId(BspUtil.getEmpOrganId());
		bptStateChange.setModTime(DateUtil.getTime());
		bptStateChange.setChangeStateDate(DateUtil.getDay());
		bptStateChange.setChangeStatePre("2");
		bptStateChange.setChangeStateSuf("5");
		bptStateChange.setServiceType(serviceType);
		if ((BptConstant.BPT_DISABILITY_EMIGRATION).equals(serviceType)) {// 伤残
			DataSet ds =bptPeopleDisabilityService.queryBptPeopleDisability(pset);
			if(ds.getCount()>0){
				BptPeopleDisability b =(BptPeopleDisability)ds.getRecord(0).toBean(BptPeopleDisability.class);
				b.setCancellationDate(bptStateChange.getChangeStateDate());
				bptPeopleDisabilityService.updatePeopleDisability(b);
				
			}
		} else if ((BptConstant.BPT_DEPENDANT_EMIGRATION).equals(serviceType)) {// 三属
			DataSet ds =dependantService.query(pset);
			if(ds.getCount()>0){
				BptPeopleDependant b =(BptPeopleDependant)ds.getRecord(0).toBean(BptPeopleDependant.class);
				b.setCancellationDate(bptStateChange.getChangeStateDate());
				dependantService.update(b);
			}
		} else if ((BptConstant.BPT_DEMOBILIZED_EMIGRATION).equals(serviceType)) {// 在乡
			DataSet ds =demobilizedService.query(pset);
			if(ds.getCount()>0){
				BptPeopleDemobilized b =(BptPeopleDemobilized)ds.getRecord(0).toBean(BptPeopleDemobilized.class);
				b.setCancellationDate(bptStateChange.getChangeStateDate());
				demobilizedService.updateBptPeopleDemobilized(b);
				
			}
		} else if ((BptConstant.BPT_DEMOBILIZEDILLNESS_EMIGRATION)
				.equals(serviceType)) {// 带病回乡
			DataSet ds =demobilizedIllnessService.query(pset);
			if(ds.getCount()>0){
				BptPeopleDemobilizedIllness b =(BptPeopleDemobilizedIllness)ds.getRecord(0).toBean(BptPeopleDemobilizedIllness.class);
				b.setCancellationDate(bptStateChange.getChangeStateDate());
				demobilizedIllnessService.updateBptPeopleDemobilizedIllness(b);
			}
		} else if ((BptConstant.BPT_WAR_EMIGRATION).equals(serviceType)) {// 参战
			DataSet ds =iWarService.query(pset);
			if(ds.getCount()>0){
				BptPeopleWar b =(BptPeopleWar)ds.getRecord(0).toBean(BptPeopleWar.class);
				b.setCancellationDate(bptStateChange.getChangeStateDate());
				iWarService.updateWar(b);
			}
		} else if ((BptConstant.BPT_TESTED_EMIGRATION).equals(serviceType)) {// 参试
			DataSet ds =iBptPeopleTestedService.queryPeopleTested(pset);
			if(ds.getCount()>0){
				BptPeopleTested b =(BptPeopleTested)ds.getRecord(0).toBean(BptPeopleTested.class);
				b.setCancellationDate(bptStateChange.getChangeStateDate());
				iBptPeopleTestedService.updatePeopleTeseted(b);
			}
		}else if (("84").equals(serviceType)) {// 
			DataSet ds =ptCountRetiredSoldierDao.query(pset);
			if(ds.getCount()>0){
				BptCountRetiredSoldier b =(BptCountRetiredSoldier)ds.getRecord(0).toBean(BptCountRetiredSoldier.class);
				b.setCancellationDate(bptStateChange.getChangeStateDate());
				ptCountRetiredSoldierDao.update(b);
			}
		}else if (("B4").equals(serviceType)) {// 
			DataSet ds =martyrOffspringDomain.query(pset);
			if(ds.getCount()>0){
				BptPeopleMartyrOffspring b =(BptPeopleMartyrOffspring)ds.getRecord(0).toBean(BptPeopleMartyrOffspring.class);
				b.setCancellationDate(bptStateChange.getChangeStateDate());
				martyrOffspringDomain.update(b);
			}
		}

		pset.clear();
		pset.setParameter("APPLY_ID", applyId);
		BptApplyEmigration bptApplyEmigration = (BptApplyEmigration) bptApplyEmigrationService
				.query(pset).getRecord(0).toBean(BptApplyEmigration.class);
		
		bptStateChange.setAllowanceMonth(bptApplyEmigration.getAllowanceMonth());
		bptStateChange.setInDomicileCodeName(bptApplyEmigration.getIngoingAddress());
		bptStateChange.setInDomicileCode(bptApplyEmigration.getIngoingCode());// 后期添加省外选择民政局完善此语句
		
		stateChangeService.insert(bptStateChange);
		
	}

	/**
	 * 根据行政区划代码获得行政区划name
	 * 
	 * @param domicileCode
	 * @return
	 */
	public static String queryDomicileCodeName(String domicileCode) {
		EntityDao<DicCity> dao = (EntityDao<DicCity>) DaoFactory
				.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
		String name = "";
		String[] domicile = new String[3];
		domicile[0] = domicileCode.substring(0, 2) + "0000000000";
		domicile[1] = domicileCode.substring(0, 4) + "00000000";
		domicile[2] = domicileCode.substring(0, 6) + "000000";
		ParameterSet pset = new ParameterSet();
		DataSet ds = null;
		for (int i = 0; i < domicile.length; i++) {
			pset.setParameter("ID", domicile[i]);
			ds = dao.query(pset);
			if (ds != null && ds.getCount() != 0) {
				name += (String) ds.getRecord(0).get("name");
			}
			pset.clear();
		}
		return name;
	}
	
	/**
	 * 不予迁移并结束
	 */
	@Trans
	private void updateNotInto() {
		ParameterSet pset = getParameterSet();
		String peopleId = (String)getParameter("peopleId");
		String serviceType = (String)getParameter("serviceType");

		pset.clear();
		pset.setParameter("PEOPLE_ID", peopleId);
		BaseinfoPeople baseinfoPeople = (BaseinfoPeople) service.queryPeople(
				pset).getRecord(0).toBean(BaseinfoPeople.class);
		// 不予迁移时改为状态为享受待遇
		if ((BptConstant.BPT_DISABILITY_EMIGRATION).equals(serviceType)) {
			baseinfoPeople.setDisabilityStateCode("2");  
		} else if ((BptConstant.BPT_DEPENDANT_EMIGRATION).equals(serviceType)) {
			baseinfoPeople.setDependantStateCode("2");  
		} else if ((BptConstant.BPT_DEMOBILIZED_EMIGRATION).equals(serviceType)) {
			baseinfoPeople.setDemobilizedStateCode("2"); 
		} else if ((BptConstant.BPT_DEMOBILIZEDILLNESS_EMIGRATION).equals(serviceType)) {
			baseinfoPeople.setDemobilizedStateCode("2");  
		} else if ((BptConstant.BPT_WAR_EMIGRATION).equals(serviceType)) {
			baseinfoPeople.setWarStateCode("2"); 
		} else if ((BptConstant.BPT_TESTED_EMIGRATION).equals(serviceType)) {
			baseinfoPeople.setWarStateCode("2"); 
		}
		service.updateBaseinfoPeople(baseinfoPeople);  
	}

}
