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

import com.inspur.cams.bpt.base.data.BptApplyHistory;
import com.inspur.cams.bpt.base.data.BptProvinceMigrate;
import com.inspur.cams.bpt.base.data.BptStateChange;
import com.inspur.cams.bpt.base.data.WfProcessBusiness;
import com.inspur.cams.bpt.base.domain.IBptApplyHistoryDomain;
import com.inspur.cams.bpt.base.domain.IBptComfortNoDomain;
import com.inspur.cams.bpt.base.domain.IBptProvinceMigrateDomain;
import com.inspur.cams.bpt.base.domain.IBptStateChangeDomain;
import com.inspur.cams.bpt.base.domain.IWfProcessBusinessDomain;
import com.inspur.cams.bpt.base.domain.support.BptComfortNoDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.bpt.util.BptConstant;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.diccity.data.DicCity;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * @title:BptDisabilityProvinceMigratCommand
 * @description:优抚人员省内迁移
 * @author:
 * @since:2011-08-04
 * @version:1.0
 */
public class BptProvinceMigrateCommand extends BaseAjaxCommand {
	/**
	 * 审批记录历史服务接口
	 */
	IBptApplyHistoryDomain bptApplyHistoryService = ScaComponentFactory
			.getService(IBptApplyHistoryDomain.class,
					"BptApplyHistoryDomain/BptApplyHistoryDomain");
	// 状态变更接口
	private IBptStateChangeDomain stateChangeService = ScaComponentFactory
			.getService(IBptStateChangeDomain.class,
					"bptStateChangeDomain/bptStateChangeDomain");

	IBptProvinceMigrateDomain bptProvinceMigratService = ScaComponentFactory
			.getService(IBptProvinceMigrateDomain.class,
					"BptProvinceMigrateDomain/BptProvinceMigrateDomain");

	IBptGroupDomain service = ScaComponentFactory.getService(
			IBptGroupDomain.class, "bptGroupDomain/bptGroupDomain");

	/**
	 * 工作流信息服务接口
	 */
	IWfProcessBusinessDomain wfProcessBusinessService = ScaComponentFactory
			.getService(IWfProcessBusinessDomain.class,
					"wfProcessBusinessDomain/wfProcessBusinessDomain");
	
	IBptComfortNoDomain NOService = ScaComponentFactory.getService(BptComfortNoDomain.class,"bptComfortNoDomain/bptComfortNoDomain");
	/**
	 * 获取伤残审批信息判定是否提交
	 * 
	 * @return
	 */
	public void queryApplyInfo() {
		ParameterSet pset = getParameterSet();
		DataSet ds = bptProvinceMigratService.query(pset);
		if (ds.getCount() > 0) {
			String outTownAduitIncharge = (String) ds.getRecord(0).get(
					"outTownAduitIncharge");
			this.setReturn("outTownAduitIncharge", outTownAduitIncharge);
		}
	}

	@Trans
	public void insert() {
		String applyId = IdHelp.getUUID30();
		Record record = (Record) getParameter("record");
		BptProvinceMigrate dataBean = (BptProvinceMigrate) record
				.toBean(BptProvinceMigrate.class);
		dataBean.setApplyId(applyId);
		dataBean.setCommitFlag(BptConstant.UN_COMMIT_FLAG);
		bptProvinceMigratService.insert(dataBean);
		setReturn("applyId", applyId);
	}

	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		BptProvinceMigrate dataBean = (BptProvinceMigrate) record
				.toBean(BptProvinceMigrate.class);
		bptProvinceMigratService.update(dataBean);
	}

	/**
	 * 创建并发起流程
	 */
	@SuppressWarnings("unchecked")
	@Trans
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
		String serviceName = new String();
		ParameterSet pset = new ParameterSet();
		ParameterSet param = new ParameterSet();
		param.setParameter("PEOPLE_ID", peopleId);
		BaseinfoPeople baseinfoPeople = (BaseinfoPeople) service.queryPeople(
				param).getRecord(0).toBean(BaseinfoPeople.class);
		
		String state="";
		
		// 伤残
		if ((BptConstant.BPT_DISABILITY_PROVINCEMIGRATION).equals(serviceType)) {
			serviceName = BptConstant.BPT_DISABILITY_PROVINCEMIGRATION_NA;
			state = baseinfoPeople.getDisabilityStateCode();
			baseinfoPeople.setDisabilityStateCode("5"); // 将伤残状态改为迁移
			
		}
		// 三属
		if ((BptConstant.BPT_DEPENDANT_PROVINCEMIGRATION).equals(serviceType)) {
			serviceName = BptConstant.BPT_DEPENDANT_PROVINCEMIGRATION_NA;
			state = baseinfoPeople.getDependantStateCode();
			baseinfoPeople.setDependantStateCode("5"); // 将三属状态改为迁移
		}
		// 在乡
		if ((BptConstant.BPT_DEMOBILIZED_PROVINCEMIGRATION).equals(serviceType)) {
			serviceName = BptConstant.BPT_DEMOBILIZED_PROVINCEMIGRATION_NA;
			state = baseinfoPeople.getDemobilizedStateCode();
			baseinfoPeople.setDemobilizedStateCode("5"); // 将在乡状态改为迁移
		}
		// 带病回乡
		if ((BptConstant.BPT_DEMOBILIZEDILLNESS_PROVINCEMIGRATION)
				.equals(serviceType)) {
			serviceName = BptConstant.BPT_DEMOBILIZEDILLNESS_PROVINCEMIGRATION_NA;
			state = baseinfoPeople.getDemobilizedStateCode();
			baseinfoPeople.setDemobilizedStateCode("5"); // 将带病回乡状态改为迁移
		}
		// 参战
		if ((BptConstant.BPT_WAR_PROVINCEMIGRATION).equals(serviceType)) {
			serviceName = BptConstant.BPT_WAR_PROVINCEMIGRATION_NA;
			state = baseinfoPeople.getWarStateCode();
			baseinfoPeople.setWarStateCode("5");// 将参战状态改为迁移
		}
		// 参试
		if ((BptConstant.BPT_TESTED_PROVINCEMIGRATION).equals(serviceType)) {
			serviceName = BptConstant.BPT_TESTED_PROVINCEMIGRATION_NA;
			state = baseinfoPeople.getWarStateCode();
			baseinfoPeople.setWarStateCode("5");// 将参试状态改为迁移
		}
		// 60周岁退役士兵
		if ("83".equals(serviceType)) {
			serviceName = "年满60周岁农村籍退役士兵定补关系省内迁移";
			state = baseinfoPeople.getRetiredStateCode();
			baseinfoPeople.setRetiredStateCode("5");// 将参试状态改为迁移
		}
		// 部分烈士（错杀被平反人员）子女定补关系省内迁移
		if ("B3".equals(serviceType)) {
			serviceName = "部分烈士（错杀被平反人员）子女定补关系省内迁移";
			state = baseinfoPeople.getMartyrOffspringStateCode();
			baseinfoPeople.setMartyrOffspringStateCode("5");// 将参试状态改为迁移
		}
		
		insertStateChange( baseinfoPeople , state, "5", serviceType);
		
		// 更新【伤残人员省内迁移】信息
		pset.setParameter("APPLY_ID", applyId);
		BptProvinceMigrate dataBean = (BptProvinceMigrate) bptProvinceMigratService
				.query(pset).getRecord(0).toBean(BptProvinceMigrate.class);
		dataBean.setApplyDate(DateUtil.getDay());
		
		EntityDao<DicCity> dao = (EntityDao<DicCity>) DaoFactory
				.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
		ParameterSet pst = new ParameterSet ();
		pst.setParameter("ID", BspUtil.getOrganCode());
		String applyOrganization = (String)dao.query(pst).getRecord(0).get("fullName");
		
		dataBean.setApplyOrganization(applyOrganization);
		dataBean.setOutTownCheckPeople(GetBspInfo.getBspInfo().getUserName());
		dataBean.setOutTownCheckDate(DateUtil.getDay());
		dataBean.setCommitFlag(BptConstant.COMMIT_FLAG);
		bptProvinceMigratService.update(dataBean);

		// 插入审批记录历史表
		BptApplyHistory bptApplyHistory = new BptApplyHistory();
		bptApplyHistory.setHistoryId(IdHelp.getUUID30());
		bptApplyHistory.setActdefName("迁出地县级审核");
		bptApplyHistory.setCreateTime(DateUtil.getTime());
		bptApplyHistory.setApplyAdvice(dataBean.getOutTownAduitAdvice());
		bptApplyHistory.setApplyIncharge(dataBean.getOutTownAduitIncharge());
		bptApplyHistory.setApplyTime(dataBean.getOutTownCheckDate());
		bptApplyHistory.setApplyId(applyId);
		bptApplyHistoryService.insert(bptApplyHistory);

		// 调用BPM的接口发起流程
		//通过流程唯一ID获得流程第一个环节ID
		String procDefUniqueId = "8a898b4e3300a899013300df932f06ba";
		String startActDefUniqueId = (String)WfQuery.getActDefInfoByProcDefUniqueIdAndActDefId(procDefUniqueId,"act2").get("actDefUniqueId");
		CommandContext.setContextParameter("procDefUniqueId",procDefUniqueId);
		CommandContext.setContextParameter("startActDefUniqueId",startActDefUniqueId);
		
		Map<String, String> context = new HashMap<String, String>();
		String City_OrganId = BspUtil.getParentStrId();
		String currentOrganName = BspUtil.getCorpOrgan().getOrganName();
		String Condition = (String) getParameter("Condition");
		context.put("City_OrganId", City_OrganId);
		context.put("Condition", Condition);
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
		wfProcessBusinessService.insert(wfProcessBusiness);

		// 修改人员基本信息
		service.updateBaseinfoPeople(baseinfoPeople);
	}

	/**
	 * 发送流程
	 */
	@Trans
	public void send() {
		String ifInSameCity;
		update();
		ParameterSet pset1 = new ParameterSet();
		pset1.setParameter("PEOPLE_ID", getParameter("peopleId"));
		DataSet peopleDataSet = service.queryPeople(pset1);
		Record peopleRecord = peopleDataSet.getRecord(0);
		String outCode = peopleRecord.get("domicileCode").toString();
		pset1.remove("PEOPLE_ID");
		pset1.setParameter("APPLY_ID", getParameter("applyId"));
		String Condition = getParameter("Condition").toString();
		String inCode = queryOutIngoingCode(pset1);
		if (inCode.substring(0, 4).equals(outCode.substring(0, 4))) {
			ifInSameCity = "end";
		} else {
			if("end".equals(Condition)){//在迁入地判定是否不予评定
				ifInSameCity = "end";
			}else {
				ifInSameCity = "pass";
			}
			
		}

		Map<String, String> context = new HashMap<String, String>();
		String town_OrganId = BspUtil.getCorpStruId();
		String cityOrganId = BspUtil.getParentStrId();
		String City_Verify_OrganId = BspUtil.getCorpStruId();
		String In_Town_OrganId = getParameter("In_Town_OrganId").toString();
		

		In_Town_OrganId = "S0000000" + In_Town_OrganId.substring(0, 6)
				+ "000000";
		context.put("In_Town_OrganId", In_Town_OrganId);
		context.put("City_OrganId", cityOrganId);
		context.put("City_Verify_OrganId", cityOrganId);
		context.put("Town_OrganId", town_OrganId);
		// 获得当前域
		String currentField = (String) getParameter("currentField");
		// 如果是迁入地县级审核 判断该人是否是 同一市迁移
		if ("InTownAduit".equals(currentField)) {
			context.put("Condition", ifInSameCity);
		} else {
			context.put("Condition", Condition);
		}
		// 调用工作流发送接口
		Map map = WfTaskRequestWrapper.getInstance().send(context);
		// 修改是否被退回标示为n（非退回）
		ParameterSet pset = new ParameterSet();
		pset.setParameter("applyId", (String) getParameter("applyId"));
		pset.setParameter("ifback", "n");
		wfProcessBusinessService.updateIfback(pset);
		
		if(!map.containsKey("isEnd")&&"act2".equals((String)WfQuery.getCurActivityDefInfo().get("actDefId"))){
			ParameterSet psettime = new ParameterSet();
			psettime.setParameter("applyId", (String) getParameter("applyId"));
			wfProcessBusinessService.updateProCreateTime(psettime);
		}
		
		
		insertBptApplyHistory();
		if (map.containsKey("isEnd")) { // 流程完成后修改三属信息
			String isEnd = (String) map.get("isEnd");
			if ("true".equals(isEnd)) {
				if ("pass".equals(Condition)) {
					updateInfo(Condition);
				} else {
					updateNotInfo();
				}

			}
		}
	}

	/**
	 * 不予迁移并结束
	 * 
	 */
	@Trans
	public void updateNotInfo() {
		ParameterSet pset = getParameterSet();
		String peopleId = (String) pset.getParameter("peopleId");
		String serviceType = (String) pset.getParameter("serviceType");
		String applyId = (String) pset.getParameter("applyId");

		pset.clear();
		pset.setParameter("PEOPLE_ID", peopleId);
		BaseinfoPeople baseinfoPeople = (BaseinfoPeople) service.queryPeople(
				pset).getRecord(0).toBean(BaseinfoPeople.class);
		//baseinfoPeople.setPersonalStatsTag("2");
		String statepre = stateChangeService.queryPreStateChange(peopleId);
		//插入变更表信息
		insertStateChange( baseinfoPeople , "5", statepre, serviceType);
		if ((BptConstant.BPT_DISABILITY_PROVINCEMIGRATION).equals(serviceType)) {// 伤残
			// bptStateChange.setObjectType("1");
			baseinfoPeople.setDisabilityStateCode(statepre);

		} else if ((BptConstant.BPT_DEPENDANT_PROVINCEMIGRATION)
				.equals(serviceType)) {// 三属
			// bptStateChange.setObjectType("2");
			baseinfoPeople.setDependantStateCode(statepre);

		} else if ((BptConstant.BPT_DEMOBILIZED_PROVINCEMIGRATION)
				.equals(serviceType)) {// 在乡
			// bptStateChange.setObjectType("3");
			baseinfoPeople.setDemobilizedStateCode(statepre);

		} else if ((BptConstant.BPT_DEMOBILIZEDILLNESS_PROVINCEMIGRATION)
				.equals(serviceType)) {// 带病回乡
			// bptStateChange.setObjectType("4");
			baseinfoPeople.setDemobilizedStateCode(statepre);

		} else if ((BptConstant.BPT_WAR_PROVINCEMIGRATION).equals(serviceType)) {// 参战
			// bptStateChange.setObjectType("5");
			baseinfoPeople.setWarStateCode(statepre);

		} else if ((BptConstant.BPT_TESTED_PROVINCEMIGRATION)
				.equals(serviceType)) {// 参试
			// bptStateChange.setObjectType("6");
			baseinfoPeople.setWarStateCode(statepre);
		}else if ("83".equals(serviceType)) {// 60
			baseinfoPeople.setRetiredStateCode(statepre);
		}else if ("B3".equals(serviceType)) {// 老烈子女
			baseinfoPeople.setMartyrOffspringStateCode(statepre);
		}

		pset.clear();
		service.updateBaseinfoPeople(baseinfoPeople); // 修改人员基本信息状态为迁出

	}

	/**
	 * 流程完成后基本信息
	 */
	@Trans
	public void updateInfo(String Condition) {
		ParameterSet pset = getParameterSet();
		String peopleId = (String) pset.getParameter("peopleId");
		String serviceType = (String) pset.getParameter("serviceType");
		String applyId = (String) pset.getParameter("applyId");
		BptStateChange bptStateChange = new BptStateChange();

		pset.clear();
		pset.setParameter("PEOPLE_ID", peopleId);
		DataSet bptdataset=service.queryBptPeople(pset);
		String dependantTypeCode =(String)bptdataset.getRecord(0).get("dependantTypeCode");
		BaseinfoPeople baseinfoPeople = (BaseinfoPeople) service.queryPeople(
				pset).getRecord(0).toBean(BaseinfoPeople.class);
		//baseinfoPeople.setPersonalStatsTag("2");
		String domicileCode= baseinfoPeople.getDomicileCode();
		String statepre = stateChangeService.queryPreStateChange(peopleId);
		// 添加状态变更表数据
		bptStateChange.setStateChangeId(IdHelp.getUUID30());
		bptStateChange.setPeopleId(peopleId);
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
		bptStateChange.setChangeStatePre("5");
		bptStateChange.setChangeStateSuf(statepre);
		bptStateChange.setObjectType(serviceType);

		pset.clear();
		if (Condition.equals("pass")) {
			pset.setParameter("APPLY_ID", applyId);
			BptProvinceMigrate bptProvinceMigrate = (BptProvinceMigrate) bptProvinceMigratService
					.query(pset).getRecord(0).toBean(BptProvinceMigrate.class);
			//向迁移表插入迁出地址码
			bptProvinceMigrate.setOutDomicileCode(baseinfoPeople.getDomicileCode());
			bptStateChange.setAllowanceMonth(bptProvinceMigrate
					.getAllowanceMonth());

			String inDomicile = bptProvinceMigrate.getIngoingCode();
			bptStateChange.setInDomicileCodeName(BptApplyEmigrationCommand
					.queryDomicileCodeName(inDomicile));
			bptStateChange.setInDomicileCode(inDomicile.substring(0, 6)
					+ "000000");// 后期添加省外选择民政局完善此语句

			baseinfoPeople.setDomicileCode(bptProvinceMigrate
					.getInDomicileCode());
			baseinfoPeople
					.setApanageCode(bptProvinceMigrate.getInApanageCode());
			baseinfoPeople.setDomicileAddress(bptProvinceMigrate
					.getInDomicileAddress());
			baseinfoPeople.setAddress(bptProvinceMigrate.getInApanageAddress());
			if ((BptConstant.BPT_DISABILITY_PROVINCEMIGRATION).equals(serviceType)) {// 伤残
				// bptStateChange.setObjectType("1");
				baseinfoPeople.setDisabilityStateCode(statepre);
				/*BptApplyDisabilityCommand com = new BptApplyDisabilityCommand();
				String disabilityNo = com.findCommNo(peopleId);
				 baseinfoPeople.setDisabilityNo(disabilityNo);*/
			} else if ((BptConstant.BPT_DEPENDANT_PROVINCEMIGRATION)
					.equals(serviceType)) {// 三属
				// bptStateChange.setObjectType(statepre);
				baseinfoPeople.setDependantStateCode(statepre);
				if("21".equals(dependantTypeCode)){
					
					baseinfoPeople.setDependantNo( NOService.getNO("LS",bptProvinceMigrate
							.getInDomicileCode()));
						
				}else if("22".equals(dependantTypeCode)){
					baseinfoPeople.setDependantNo( NOService.getNO("YG",bptProvinceMigrate
							.getInDomicileCode()));
					
				}else if("23".equals(dependantTypeCode)){
					baseinfoPeople.setDependantNo( NOService.getNO("BG",bptProvinceMigrate
							.getInDomicileCode()));
					
				}
			} else if ((BptConstant.BPT_DEMOBILIZED_PROVINCEMIGRATION)
					.equals(serviceType)) {// 在乡
				// bptStateChange.setObjectType("3");
				baseinfoPeople.setDemobilizedStateCode(statepre);
				baseinfoPeople.setDemobilizedNo(NOService.getNO("ZX",bptProvinceMigrate
						.getInDomicileCode()));
			} else if ((BptConstant.BPT_DEMOBILIZEDILLNESS_PROVINCEMIGRATION)
					.equals(serviceType)) {// 带病回乡
				// bptStateChange.setObjectType("4");
				baseinfoPeople.setDemobilizedStateCode(statepre);
				baseinfoPeople.setDemobilizedNo(NOService.getNO("DB",bptProvinceMigrate
						.getInDomicileCode()));
			} else if ((BptConstant.BPT_WAR_PROVINCEMIGRATION).equals(serviceType)) {// 参战
				// bptStateChange.setObjectType("5");
				baseinfoPeople.setWarStateCode(statepre);
				baseinfoPeople.setWarNo( NOService.getNO("CZ",bptProvinceMigrate
						.getInDomicileCode()));
			} else if ((BptConstant.BPT_TESTED_PROVINCEMIGRATION)
					.equals(serviceType)) {// 参试
				// bptStateChange.setObjectType("6");
				baseinfoPeople.setWarStateCode(statepre);
				baseinfoPeople.setWarNo(  NOService.getNO("CS",bptProvinceMigrate
						.getInDomicileCode()));
			}else if ("83".equals(serviceType)) {// 60
				// bptStateChange.setObjectType("6");
				baseinfoPeople.setRetiredStateCode(statepre);
				//baseinfoPeople.setWarNo(  NOService.getNO("CS",bptProvinceMigrate
				//		.getInDomicileCode()));
			}else if ("B3".equals(serviceType)) {// 老烈子女
				// bptStateChange.setObjectType("6");
				baseinfoPeople.setMartyrOffspringStateCode(statepre);
				//baseinfoPeople.setWarNo(  NOService.getNO("CS",bptProvinceMigrate
				//		.getInDomicileCode()));
			}
			bptProvinceMigratService.update(bptProvinceMigrate);
			
		}
		stateChangeService.insert(bptStateChange);
		service.updateBaseinfoPeople(baseinfoPeople); // 修改人员基本信息状态为迁出

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
	/**
	 * 回退流程
	 */
	@Trans
	public void back() {
		update();
		// 调用工作流回退接口
		WfTaskRequestWrapper.getInstance().back();
		// 修改是否被退回标示为y（退回）
		ParameterSet pset = new ParameterSet();
		pset.setParameter("applyId", (String) getParameter("applyId"));
		pset.setParameter("ifback", "y");
		insertBptApplyHistory();
		wfProcessBusinessService.updateIfback(pset);
	}
	// **********************************参战****************************

	public void queryWarDetailByPeopleId() {
		ParameterSet pset = super.getParameterSet();
		DataSet dataset = bptProvinceMigratService
				.queryWarDetailByPeopleId(pset);
		Record record = dataset.getRecord(0);
		super.setReturn("peopleId", record.get("PEOPLE_ID").toString());
		super.setReturn("familyId", record.get("FAMILY_ID").toString());
		super.setReturn("idcard", record.get("ID_CARD").toString());
		super.setReturn("sex", record.get("SEX").toString());
		super.setReturn("name", record.get("NAME").toString());
		if (record.get("POSITION") != null) {
			super.setReturn("position", record.get("POSITION").toString());
		}
		// System.out.println(record.get("PEOPLE_ID").toString()+record.get("FAMILY_ID").toString());
		if (record.get("FORCES_NO") != null) {
			super.setReturn("forcesNo", record.get("FORCES_NO").toString());
		}
		if (record.get("WAR_TYPE_CODE") != null) {
			super.setReturn("warTypeCode", record.get("WAR_TYPE_CODE")
					.toString());
		}
		if (record.get("ASDP_NO") != null) {
			super.setReturn("asdpNo", record.get("ASDP_NO").toString());
		}

	}
	public void queryWarEProvinceByPeopleId() {
		ParameterSet pset = super.getParameterSet();
		DataSet dataset = bptProvinceMigratService
				.queryWarEProvinceByPeopleId(pset);
		Record record = dataset.getRecord(0);
		super.setReturn("peopleId", record.get("PEOPLE_ID").toString());
		super.setReturn("familyId", record.get("FAMILY_ID").toString());
		super.setReturn("idcard", record.get("ID_CARD").toString());
		super.setReturn("sex", record.get("SEX").toString());
		super.setReturn("name", record.get("NAME").toString());
		if (record.get("POSITION") != null) {
			super.setReturn("position", record.get("POSITION").toString());
		}
		// System.out.println(record.get("PEOPLE_ID").toString()+record.get("FAMILY_ID").toString());
		if (record.get("FORCES_NO") != null) {
			super.setReturn("forcesNo", record.get("FORCES_NO").toString());
		}
		if (record.get("WAR_TYPE_CODE") != null) {
			super.setReturn("warTypeCode", record.get("WAR_TYPE_CODE")
					.toString());
		}
		if (record.get("ASDP_NO") != null) {
			super.setReturn("asdpNo", record.get("ASDP_NO").toString());
		}

	}
	public void queryWarMigrateAddPeopleId() {
		ParameterSet pset = getParameterSet();
		DataSet dataset = bptProvinceMigratService
				.queryWarMigrateAddPeopleId(pset);
		Record record = dataset.getRecord(0);
		setReturn("peopleId", record.get("PEOPLE_ID").toString());
		setReturn("familyId", record.get("FAMILY_ID").toString());
		setReturn("idcard", record.get("ID_CARD").toString());
		setReturn("sex", record.get("SEX").toString());
		setReturn("name", record.get("NAME").toString());
		if (record.get("POSITION") != null) {
			setReturn("position", record.get("POSITION").toString());
		}
		// System.out.println(record.get("PEOPLE_ID").toString()+record.get("FAMILY_ID").toString());
		if (record.get("FORCES_NO") != null) {
			setReturn("forcesNo", record.get("FORCES_NO").toString());
		}
		if (record.get("WAR_TYPE_CODE") != null) {
			setReturn("warTypeCode", record.get("WAR_TYPE_CODE").toString());
		}
		if (record.get("ASDP_NO") != null) {
			setReturn("asdpNo", record.get("ASDP_NO").toString());
		}
	}

	public void queryWarDetailByIdCard() {
		ParameterSet pset = super.getParameterSet();
		DataSet dataset = bptProvinceMigratService.queryWarDetailByIdCard(pset);
		Record record = dataset.getRecord(0);
		super.setReturn("peopleId", record.get("PEOPLE_ID").toString());
		super.setReturn("familyId", record.get("FAMILY_ID").toString());
		super.setReturn("idcard", record.get("ID_CARD").toString());
		super.setReturn("sex", record.get("SEX").toString());
		super.setReturn("name", record.get("NAME").toString());
		if (record.get("POSITION") != null) {
			super.setReturn("position", record.get("POSITION").toString());
		}
		// System.out.println(record.get("PEOPLE_ID").toString()+record.get("FAMILY_ID").toString());
		if (record.get("FORCES_NO") != null) {
			super.setReturn("forcesNo", record.get("FORCES_NO").toString());
		}
		if (record.get("WAR_TYPE_CODE") != null) {
			super.setReturn("warTypeCode", record.get("WAR_TYPE_CODE")
					.toString());
		}
		if (record.get("ASDP_NO") != null) {
			super.setReturn("asdpNo", record.get("ASDP_NO").toString());
		}

	}

	// **********************************参战****************************

	// 获取省内迁移的ingongCode
	public String queryProvinceEmigrateIngoingCode() {
		ParameterSet pset = getParameterSet();
		DataSet ds = bptProvinceMigratService.query(pset);
		String code = (String) ds.getRecord(0).get("ingoingCode");
		setReturn("code", code);
		return code;

	}

	// 获取省内迁移 迁出县的ingongCode
	public String queryOutIngoingCode(ParameterSet pset) {
		DataSet ds = bptProvinceMigratService.query(pset);
		String code = (String) ds.getRecord(0).get("ingoingCode");
		setReturn("code", code);
		return code;

	}

	/**
	 * 删除抚恤关系省内迁移
	 * 
	 * @param pset
	 * @return
	 */
	@Trans
	public void deleteProvinceMigrate() {
		Record[] records = (Record[]) getParameter("records");
		ParameterSet pset = new ParameterSet();
		for (Record record : records) {
			String applyId = (String) record.get("APPLY_ID");
			pset.setParameter("applyId", applyId);
			bptProvinceMigratService.deleteProvinceMigrate(pset);
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
		String actDefName = (String) getParameter("actDefName");
		Record record = (Record) getParameter("record");
		BptProvinceMigrate dataBean = (BptProvinceMigrate) record
				.toBean(BptProvinceMigrate.class);
		// 插入审批记录历史表
		BptApplyHistory bptApplyHistory = new BptApplyHistory();
		bptApplyHistory.setHistoryId(IdHelp.getUUID30());
		bptApplyHistory.setActdefName(actDefName);
		bptApplyHistory.setCreateTime(DateUtil.getTime());
		bptApplyHistory.setApplyId(applyId);
		if ("OutTownAduit".equals(currentField)) { // 县级
			ParameterSet param = new ParameterSet();
			param.setParameter("APPLY_ID", applyId);
			DataSet ds = bptProvinceMigratService.query(param);
			if (ds != null && ds.getCount() != 0) {
				bptApplyHistory
						.setApplyAdvice(dataBean.getOutTownAduitAdvice());
				bptApplyHistory.setApplyIncharge(dataBean
						.getOutTownAduitIncharge());
				bptApplyHistory.setApplyTime(dataBean
						.getOutTownAduitApproveDate());
			}
		} else if ("OutCityAduit".equals(currentField)) { // 迁出地市级审核
			bptApplyHistory.setApplyAdvice(dataBean.getOutCityAduitAdvice());
			bptApplyHistory
					.setApplyIncharge(dataBean.getOutCityAduitIncharge());
			bptApplyHistory.setApplyTime(dataBean.getOutCityAduitApproveDate());
		} else if ("InTownAduit".equals(currentField)) { // 迁入地县级审核
			bptApplyHistory.setApplyAdvice(dataBean.getInTownAduitAdvice());
			bptApplyHistory.setApplyIncharge(dataBean.getInTownAduitIncharge());
			bptApplyHistory.setApplyTime(dataBean.getInTownAduitApproveDate());
		} else if ("InCityAduit".equals(currentField)) { // 迁入地市级审核
			bptApplyHistory.setApplyAdvice(dataBean.getInCityAduitAdvice());
			bptApplyHistory.setApplyIncharge(dataBean.getInCityAduitIncharge());
			bptApplyHistory.setApplyTime(dataBean.getInCityAduitApproveDate());
		}
		bptApplyHistoryService.insert(bptApplyHistory);
	}

}
