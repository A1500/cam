package com.inspur.cams.bpt.manage.cmd;

import java.util.HashMap;
import java.util.Map;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.next.web.cmd.CommandContext;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;
import org.loushang.workflow.api.WfQuery;
import org.loushang.workflow.api.WfTaskRequestWrapper;

import com.inspur.cams.bpt.base.dao.jdbc.BptPeopleValidateDao;
import com.inspur.cams.bpt.base.dao.jdbc.DemobilizedflowDao;
import com.inspur.cams.bpt.base.data.BptApplyHistory;
import com.inspur.cams.bpt.base.data.BptPeople;
import com.inspur.cams.bpt.base.data.BptPeopleDemobilized;
import com.inspur.cams.bpt.base.data.Demobilizedflow;
import com.inspur.cams.bpt.base.data.WfProcessBusiness;
import com.inspur.cams.bpt.base.domain.IBptApplyDemobilizedDomain;
import com.inspur.cams.bpt.base.domain.IBptApplyHistoryDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDemobilizedIllnessDomain;
import com.inspur.cams.bpt.base.domain.IWfProcessBusinessDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.PhotoUtil;

/**
 * @title:BptPeopleDemobilizedCommand
 * @description:在乡复员军人维护
 * @author:
 * @since:2011-05-20
 * @version:1.0
 */
public class BptPeopleDemobilizedCommand extends BaseAjaxCommand {
	IBptGroupDomain service = ScaComponentFactory.getService(
			IBptGroupDomain.class, "bptGroupDomain/bptGroupDomain");

	/**
	 * 获得在乡复员审批服务接口
	 */
	IBptApplyDemobilizedDomain bptApplyDemobilizedService = ScaComponentFactory
			.getService(IBptApplyDemobilizedDomain.class,
					"bptApplyDemobilizedDomain/bptApplyDemobilizedDomain");

	/**
	 * 带病回乡军人服务接口
	 */
	IBptPeopleDemobilizedIllnessDomain demobilizedIllnessDomainService = ScaComponentFactory
			.getService(IBptPeopleDemobilizedIllnessDomain.class,
					"demobilizedIllnessDomain/demobilizedIllnessDomain");
	/**
	 * 工作流信息服务接口
	 */
	IWfProcessBusinessDomain wfProcessBusinessService = ScaComponentFactory
			.getService(IWfProcessBusinessDomain.class,
					"wfProcessBusinessDomain/wfProcessBusinessDomain");
	/**
	 * 审批记录历史服务接口
	 */
	IBptApplyHistoryDomain bptApplyHistoryService = ScaComponentFactory
			.getService(IBptApplyHistoryDomain.class,
					"BptApplyHistoryDomain/BptApplyHistoryDomain");
	private DemobilizedflowDao dao = (DemobilizedflowDao) DaoFactory
			.getDao("com.inspur.cams.bpt.base.dao.jdbc.DemobilizedflowDao");

	/**
	 * 创建并结束流程
	 */
	@Trans
	public void createAndSendOver() {

		String peopleId;
		String apply;
		Record record = (Record) getParameter("record");
		if (record != null && !"".equals(record)) {
			apply = (String) record.get("APPLY_ID");
			peopleId = (String) record.get("PEOPLE_ID");
		} else {
			peopleId = (String) getParameter("peopleId");
			apply = (String) getParameter("applyId");
		}

		ParameterSet pset = getParameterSet();
		pset.clear();
		pset.setParameter("PEOPLE_ID@=", peopleId);
		DataSet ds = service.queryPeople(pset);
		BaseinfoPeople dataBean = (BaseinfoPeople) ds.getRecord(0).toBean(
				BaseinfoPeople.class);
		dataBean.setDemobilizedStateCode("6");
		service.updateBaseinfoPeople(dataBean);
		/*
		 * pset.setParameter("PEOPLE_ID@=", peopleId); DataSet ds =
		 * service.queryDemobilizedInfo(pset); BptPeopleDemobilized dataBean=
		 * (BptPeopleDemobilized)ds.getRecord(0).toBean(BptPeopleDemobilized.class);
		 * //修改在乡复员人员信息 service.updateBptPeopleDemobilized(dataBean);
		 */

		/*
		 * DataSet ds = service.queryDemobilizedInfo(pset); BptPeopleDemobilized
		 * dataBean=
		 * (BptPeopleDemobilized)ds.getRecord(0).toBean(BptPeopleDemobilized.class);
		 * //修改在乡复员人员信息 service.updateBptPeopleDemobilized(dataBean);
		 */

		// 获得在乡复员审批信息【在在乡复员审批表里面更新一条记录】
		Demobilizedflow BptPeopleDemobilizedBean = new Demobilizedflow();
		BptPeopleDemobilizedBean.setApplyId(apply);
		BptPeopleDemobilizedBean.setCommitFlag("1");
		bptApplyDemobilizedService.update(BptPeopleDemobilizedBean);
		// 调用创建并发送流程接口
		
		//通过流程唯一ID获得流程第一个环节ID
		String procDefUniqueId = "8ac88be4318e52d601318e52d6a60000";
		String startActDefUniqueId = (String)WfQuery.getActDefInfoByProcDefUniqueIdAndActDefId(procDefUniqueId,"act2").get("actDefUniqueId");
		CommandContext.setContextParameter("procDefUniqueId",procDefUniqueId);
		CommandContext.setContextParameter("startActDefUniqueId",startActDefUniqueId);
		
		Map context = new HashMap();
		String City_OrganId = BspUtil.getParentStrId();
		String currentOrganName = BspUtil.getCorpOrgan().getOrganName();
		context.put("City_OrganId", City_OrganId);
		context.put("Condition", "1");
		Map map = WfTaskRequestWrapper.getInstance().createAndSend(apply,
				currentOrganName + "的在乡复员申请", context);
		// Map map=WfTaskRequestWrapper.getInstance().createAndSendByProcDefId(
		// "E4D0F11846114A14108168B1587A3D6E","act1", "业务主键id1",
		// "new区县的配置伤残器械申请");
		String processId = (String) map.get("processId");
		// List list = (List)map.get("actList");
		// Map map1 = (Map)list.get(0);
		// List assignmentIdMap=(List)map1.get("assList");
		// Map assignmentId1 = (Map)assignmentIdMap.get(0);
		// String assignmentId = (String)assignmentId1.get("assignmentId");
		// 增加工作流信息表
		WfProcessBusiness wfProcessBusiness = new WfProcessBusiness();
		wfProcessBusiness.setProcessId(processId);
		wfProcessBusiness.setBusinessId(apply);
		wfProcessBusiness.setConnectId(peopleId);
		wfProcessBusiness.setBusinessType("41");
		wfProcessBusinessService.insert(wfProcessBusiness);
		insertBptApplyHistory(apply);
	}

	@Trans
	public void createAndSendOver1() {

		String peopleId;
		String apply;
		Record record = (Record) getParameter("record");
		if (record != null && !"".equals(record)) {
			apply = (String) record.get("APPLY_ID");
			peopleId = (String) record.get("PEOPLE_ID");
		} else {
			peopleId = (String) getParameter("peopleId");
			apply = (String) getParameter("applyId");
		}

		ParameterSet pset = getParameterSet();
		pset.clear();
		pset.setParameter("PEOPLE_ID@=", peopleId);
		DataSet ds = service.queryPeople(pset);
		BaseinfoPeople dataBean = (BaseinfoPeople) ds.getRecord(0).toBean(
				BaseinfoPeople.class);
		dataBean.setDemobilizedStateCode("6");
		service.updateBaseinfoPeople(dataBean);
		// pset.clear();
		// pset.setParameter("PEOPLE_ID@=", peopleId);
		// DataSet ds = service.queryDemobilizedInfo(pset);
		// BptPeopleDemobilized dataBean=
		// (BptPeopleDemobilized)ds.getRecord(0).toBean(BptPeopleDemobilized.class);
		// //修改在乡复员人员信息
		// service.updateBptPeopleDemobilized(dataBean);
		//		
		// 获得在乡复员审批信息【在在乡复员审批表里面添加一条记录】
		Demobilizedflow BptPeopleDemobilizedBean = new Demobilizedflow();
		BptPeopleDemobilizedBean.setApplyId(apply);
		BptPeopleDemobilizedBean.setCommitFlag("1");
		bptApplyDemobilizedService.update(BptPeopleDemobilizedBean);
		// 调用创建并发送流程接口
		//通过流程唯一ID获得流程第一个环节ID
		String procDefUniqueId = "8ac88be4318e52d601318e52d6a60000";
		String startActDefUniqueId = (String)WfQuery.getActDefInfoByProcDefUniqueIdAndActDefId(procDefUniqueId,"act2").get("actDefUniqueId");
		CommandContext.setContextParameter("procDefUniqueId",procDefUniqueId);
		CommandContext.setContextParameter("startActDefUniqueId",startActDefUniqueId);
		
		Map context = new HashMap();
		String City_OrganId = BspUtil.getParentStrId();
		String currentOrganName = BspUtil.getCorpOrgan().getOrganName();
		context.put("City_OrganId", City_OrganId);
		context.put("Condition", "1");
		Map map = WfTaskRequestWrapper.getInstance().createAndSend(apply,
				currentOrganName + "的带病回乡申请", context);
		// Map map=WfTaskRequestWrapper.getInstance().createAndSendByProcDefId(
		// "E4D0F11846114A14108168B1587A3D6E","act1", "业务主键id1",
		// "new区县的配置伤残器械申请");
		String processId = (String) map.get("processId");
		// List list = (List)map.get("actList");
		// Map map1 = (Map)list.get(0);
		// List assignmentIdMap=(List)map1.get("assList");
		// Map assignmentId1 = (Map)assignmentIdMap.get(0);
		// String assignmentId = (String)assignmentId1.get("assignmentId");
		// 增加工作流信息表
		WfProcessBusiness wfProcessBusiness = new WfProcessBusiness();
		wfProcessBusiness.setProcessId(processId);
		wfProcessBusiness.setBusinessId(apply);
		wfProcessBusiness.setConnectId(peopleId);
		wfProcessBusiness.setBusinessType("45");
		wfProcessBusinessService.insert(wfProcessBusiness);
		insertBptApplyHistory(apply);
	}

	/**
	 * 创建并发起流程
	 */
	@Trans
	public void createAndSend() {
		String peopleId;
		String apply;
		Record record = (Record) getParameter("record");
		if (record != null && !"".equals(record)) {
			apply = (String) record.get("APPLY_ID");
			peopleId = (String) record.get("PEOPLE_ID");
		} else {
			peopleId = (String) getParameter("peopleId");
			apply = (String) getParameter("applyId");
		}

		ParameterSet pset = getParameterSet();
		pset.clear();
		/*
		 * pset.setParameter("PEOPLE_ID@=", peopleId);
		 * 
		 * DataSet ds = service.queryDemobilizedInfo(pset); BptPeopleDemobilized
		 * dataBean=
		 * (BptPeopleDemobilized)ds.getRecord(0).toBean(BptPeopleDemobilized.class);
		 * //修改在乡复员人员信息 service.updateBptPeopleDemobilized(dataBean);
		 */

		// 获得在乡复员/带病回乡审批信息【在在乡复员审批表/带病回乡里面更新一条记录】
		Demobilizedflow BptPeopleDemobilizedBean = new Demobilizedflow();
		BptPeopleDemobilizedBean.setApplyId(apply);
		BptPeopleDemobilizedBean.setCommitFlag("1");
		bptApplyDemobilizedService.update(BptPeopleDemobilizedBean);
		// 调用创建并发送流程接口
		//通过流程唯一ID获得流程第一个环节ID
		String procDefUniqueId = "8ac88be4318e52d601318e52d6a60000";
		String startActDefUniqueId = (String)WfQuery.getActDefInfoByProcDefUniqueIdAndActDefId(procDefUniqueId,"act2").get("actDefUniqueId");
		CommandContext.setContextParameter("procDefUniqueId",procDefUniqueId);
		CommandContext.setContextParameter("startActDefUniqueId",startActDefUniqueId);
		
		Map<String,String> context = new HashMap<String,String>();
		String City_OrganId = BspUtil.getParentStrId();
		String currentOrganName = BspUtil.getCorpOrgan().getOrganName();
		context.put("City_OrganId", City_OrganId);
		context.put("Condition", "0");
		Map map = WfTaskRequestWrapper.getInstance().createAndSend(apply,
				currentOrganName + "的在乡复员申请", context);
		// Map map=WfTaskRequestWrapper.getInstance().createAndSendByProcDefId(
		// "E4D0F11846114A14108168B1587A3D6E","act1", "业务主键id1",
		// "new区县的配置伤残器械申请");
		String processId = (String) map.get("processId");
		// List list = (List)map.get("actList");
		// Map map1 = (Map)list.get(0);
		// List assignmentIdMap=(List)map1.get("assList");
		// Map assignmentId1 = (Map)assignmentIdMap.get(0);
		// String assignmentId = (String)assignmentId1.get("assignmentId");
		// 增加工作流信息表
		WfProcessBusiness wfProcessBusiness = new WfProcessBusiness();
		wfProcessBusiness.setProcessId(processId);
		wfProcessBusiness.setBusinessId(apply);
		wfProcessBusiness.setConnectId(peopleId);
		wfProcessBusiness.setBusinessType("41");
		wfProcessBusinessService.insert(wfProcessBusiness);
		insertBptApplyHistory(apply);
	}

	/**
	 * 带病回乡创建并发起流程
	 */
	@Trans
	public void createAndSend1() {

		String peopleId;
		String apply;
		Record record = (Record) getParameter("record");
		if (record != null && !"".equals(record)) {
			apply = (String) record.get("APPLY_ID");
			peopleId = (String) record.get("PEOPLE_ID");
		} else {
			peopleId = (String) getParameter("peopleId");
			apply = (String) getParameter("applyId");
		}

		// 获得在乡复员审批信息【在在乡复员审批表里面添加一条记录】
		Demobilizedflow BptPeopleDemobilizedBean = new Demobilizedflow();
		BptPeopleDemobilizedBean.setApplyId(apply);
		BptPeopleDemobilizedBean.setCommitFlag("1");
		bptApplyDemobilizedService.update(BptPeopleDemobilizedBean);
		// 调用创建并发送流程接口
		//通过流程唯一ID获得流程第一个环节ID
		String procDefUniqueId = "8ac88be4318e52d601318e52d6a60000";
		String startActDefUniqueId = (String)WfQuery.getActDefInfoByProcDefUniqueIdAndActDefId(procDefUniqueId,"act2").get("actDefUniqueId");
		CommandContext.setContextParameter("procDefUniqueId",procDefUniqueId);
		CommandContext.setContextParameter("startActDefUniqueId",startActDefUniqueId);
		Map context = new HashMap();
		String City_OrganId = BspUtil.getParentStrId();
		String currentOrganName = BspUtil.getCorpOrgan().getOrganName();
		context.put("City_OrganId", City_OrganId);
		context.put("Condition", "0");
		Map map = WfTaskRequestWrapper.getInstance().createAndSend(apply,
				currentOrganName + "的带病回乡申请", context);
		// Map map=WfTaskRequestWrapper.getInstance().createAndSendByProcDefId(
		// "E4D0F11846114A14108168B1587A3D6E","act1", "业务主键id1",
		// "new区县的配置伤残器械申请");
		String processId = (String) map.get("processId");

		// 增加工作流信息表
		WfProcessBusiness wfProcessBusiness = new WfProcessBusiness();
		wfProcessBusiness.setProcessId(processId);
		wfProcessBusiness.setBusinessId(apply);
		wfProcessBusiness.setConnectId(peopleId);
		wfProcessBusiness.setBusinessType("45");
		wfProcessBusinessService.insert(wfProcessBusiness);
		insertBptApplyHistory(apply);

	}

	/**
	 * 添加审批记录
	 * 
	 * @param pset
	 */
	@Trans
	private void insertBptApplyHistory(String applyId) {
		// String applyId = (String)getParameter("APPLY_ID");
		// String actDefName = (String)getParameter("actDefName");
		// 插入审批记录历史表
		BptApplyHistory bptApplyHistory = new BptApplyHistory();
		bptApplyHistory.setHistoryId(IdHelp.getUUID30());
		bptApplyHistory.setActdefName("县优抚科审核");
		bptApplyHistory.setCreateTime(DateUtil.getTime());
		bptApplyHistory.setApplyId(applyId);
		ParameterSet param = new ParameterSet();
		param.setParameter("APPLY_ID", applyId);
		DataSet ds = dao.query(param);
		if (ds != null && ds.getCount() != 0) {
			Demobilizedflow dataBean = (Demobilizedflow) (ds.getRecord(0)
					.toBean(Demobilizedflow.class));
			bptApplyHistory.setApplyAdvice(dataBean.getCountiesViews());
			bptApplyHistory.setApplyIncharge(dataBean.getReviewView());
			bptApplyHistory.setApplyTime(dataBean.getTrialDate());
			bptApplyHistory.setApplyFlag(dataBean.getTownFlag());
			bptApplyHistory.setReport(dataBean.getTownReport());

			// 乡审批意见
			bptApplyHistory.setApplyTownAdvice(dataBean.getTownViews());
			bptApplyHistory.setApplyTownIncharge(dataBean.getTrialName());
			bptApplyHistory.setApplyTownTime(dataBean.getTrialDate());
		}
		bptApplyHistoryService.insert(bptApplyHistory);
	}

	/**
	 * 添加人员信息、家庭信息和在乡复员军人信息
	 */
	@Trans
	public void insert() {
		String ifApplyAdd = (String) getParameter("ifApplyAdd"); // 是否为在乡业务受理添加
		String flag = (String) getParameter("flag");
		BaseinfoPeople baseinfopeople = getBaseinfoPeople();
		BaseinfoFamily baseinfofamily = getBaseinfoFamily();
		BptPeopleDemobilized bptPeopleDemobilized = getBptPeopleDemobilized();

		BptPeople bptPeople = getBptPeople();

		String peoplePhotoTemp = baseinfopeople.getPhotoTemp();
		String nowTime = DateUtil.getTime();
		String areaCode = baseinfopeople.getRegOrgArea();
		String employeeName = baseinfopeople.getRegPeople();
		dealPhotoC(baseinfopeople, nowTime, areaCode, employeeName,
				peoplePhotoTemp);// 处理照片

		if(("UPDATE".equals(idCardValidate(baseinfopeople.getIdCard()))&&"1".equals(flag))
				||("INSERT".equals(idCardValidate(baseinfopeople.getIdCard()))&&!"1".equals(flag))){
			throw new RuntimeException("插入标志不符:"+baseinfopeople.getIdCard()+
					"-"+idCardValidate(baseinfopeople.getIdCard())+"-"+flag);
			
		}
		if (flag.equals("1")) {
			String peopleIdRe = IdHelp.getUUID30();
			String familyIdRe = IdHelp.getUUID30();
			baseinfopeople.setPeopleId(peopleIdRe);
			baseinfopeople.setFamilyId(familyIdRe);
			baseinfofamily.setFamilyId(familyIdRe);
			bptPeople.setPeopleId(peopleIdRe);
			bptPeopleDemobilized.setPeopleId(peopleIdRe);
			service.insertBaseinfo(baseinfopeople, baseinfofamily);
			service.insertPeopleDemobilized(bptPeopleDemobilized);
			service.insertBptPeople(bptPeople);

		} else {
			service.updateBaseinfo(baseinfopeople, baseinfofamily);
			String peopleId = baseinfopeople.getPeopleId();
			ParameterSet pset = new ParameterSet();
			pset.setParameter("PEOPLE_ID", peopleId);
			if (service.queryBptPeople(pset).getCount() == 0) {
				service.insertBptPeople(bptPeople);
			} else {
				service.update(bptPeople);
			}
			service.insertPeopleDemobilized(bptPeopleDemobilized);
		}
		setReturn("peopleId", baseinfopeople.getPeopleId());
		setReturn("familyId", baseinfopeople.getFamilyId());
		if ("applyAdd".equals(ifApplyAdd)) { // 三属业务受理添加
			Demobilizedflow demobilizedflow = new Demobilizedflow();
			demobilizedflow.setPeopleId(baseinfopeople.getPeopleId());
			demobilizedflow.setApplyId(IdHelp.getUUID30());
			demobilizedflow.setCommitFlag("0");
			demobilizedflow.setObjectType("4");// 优抚对象类别设置为“在乡”
			demobilizedflow.setServiceYype("41");
			bptApplyDemobilizedService.insert(demobilizedflow);
			setReturn("applyId", demobilizedflow.getApplyId());
		}

	}

	/**
	 * 更新人员信息、优抚信息
	 */
	@Trans
	public void update() {
		Record demobilizedRecord = (Record) getParameter("PeopleDemobilizedRecord");
		String peopleId = demobilizedRecord.get("peopleId").toString();
		ParameterSet pset = new ParameterSet();
		pset.setParameter("PEOPLE_ID", peopleId);
		BaseinfoPeople baseinfopeople = (BaseinfoPeople) service.queryPeople(
				pset).getRecord(0).toBean(BaseinfoPeople.class);
		if (demobilizedRecord.get("demobilizedStateCode") != null
				&& !demobilizedRecord.get("demobilizedStateCode").equals("")) {
			baseinfopeople.setDemobilizedStateCode(demobilizedRecord.get(
					"demobilizedStateCode").toString());
		}
		if (demobilizedRecord.get("demobilizedNo") != null
				&& !demobilizedRecord.get("demobilizedNo").equals("")) {
			baseinfopeople.setDemobilizedNo(demobilizedRecord.get(
					"demobilizedNo").toString());
		}
		service.updateBaseinfoPeople(baseinfopeople);

		BptPeopleDemobilized bptPeopleDemobilized = getBptPeopleDemobilized();
		BptPeople bptPeople = getBptPeople();
		service.updateBptPeopleDemobilized(bptPeopleDemobilized);
		service.update(bptPeople);
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
	 * 获得优抚人员信息
	 */
	private BptPeople getBptPeople() {
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
	 * 获取人员信息 author: since:2011-05-16
	 */
	private BaseinfoPeople getBaseinfoPeople() {
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
		bean.setDemobilizedNo((String) PeopleDemobilizedRecord
				.get("demobilizedNo"));
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
	 * 获取家庭信息
	 */
	private BaseinfoFamily getBaseinfoFamily() {
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
	 * 获取对应申请表单数据
	 */
	private Demobilizedflow getDemobilizedFlow() {
		String applyId = IdHelp.getUUID30();
		Record peopleDemobilizedRecord = (Record) getParameter("PeopleDemobilizedRecord");
		Demobilizedflow bean = new Demobilizedflow();
		bean.setPeopleId(peopleDemobilizedRecord.get("peopleId").toString());
		bean.setCommitFlag("0");
		bean.setServiceYype("41");
		bean.setApplyId(applyId);

		return bean;

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
	public String idCardValidate(String idCard){
		BptPeopleValidateDao dao = (BptPeopleValidateDao) DaoFactory
				.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPeopleValidateDao");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("idCard", idCard);
		DataSet ds = dao.validateBptPeople(pset);
		if(ds.getCount()>0){
			return "UPDATE";
		}else{
			return "INSERT";
		}
	}
}
