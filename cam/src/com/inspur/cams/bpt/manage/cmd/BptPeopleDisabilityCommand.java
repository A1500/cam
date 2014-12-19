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
import com.inspur.cams.bpt.base.dao.jdbc.BptPhysicalExaminationDao;
import com.inspur.cams.bpt.base.data.BptApplyDisability;
import com.inspur.cams.bpt.base.data.BptApplyDisabilityNotice;
import com.inspur.cams.bpt.base.data.BptApplyHistory;
import com.inspur.cams.bpt.base.data.BptPeople;
import com.inspur.cams.bpt.base.data.BptPeopleDisability;
import com.inspur.cams.bpt.base.data.BptPhysicalExamination;
import com.inspur.cams.bpt.base.data.DisabilityIdentification;
import com.inspur.cams.bpt.base.data.WfProcessBusiness;
import com.inspur.cams.bpt.base.domain.IBptApplyDisabilityDomain;
import com.inspur.cams.bpt.base.domain.IBptApplyHistoryDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDisabilityDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDomain;
import com.inspur.cams.bpt.base.domain.IDisabilityIdentificationDomain;
import com.inspur.cams.bpt.base.domain.IDisabilityNoticeDomain;
import com.inspur.cams.bpt.base.domain.IWfProcessBusinessDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.bpt.util.BptConstant;
import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.PhotoUtil;

/**
 * @title:BptPeopleDisabilityCommand
 * @description:伤残业务
 * @author:
 * @since:2011-05-13
 * @version:1.0
 */
public class BptPeopleDisabilityCommand extends BaseAjaxCommand {

	IBptGroupDomain service = ScaComponentFactory.getService(
			IBptGroupDomain.class, "bptGroupDomain/bptGroupDomain");

	/**
	 * 获得伤残人员服务接口
	 */
	IBptPeopleDisabilityDomain bptPeopleDisabilityService = ScaComponentFactory
			.getService(IBptPeopleDisabilityDomain.class,
					"bptPeopleDisabilityDomain/bptPeopleDisabilityDomain");

	/**
	 * 获得伤残审批服务接口
	 */
	IBptApplyDisabilityDomain bptApplyDisabilityService = ScaComponentFactory
			.getService(IBptApplyDisabilityDomain.class,
					"bptApplyDisabilityDomain/bptApplyDisabilityDomain");

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

	/**
	 * ***********************************【保存家庭信息、人员信息、人员伤残信息】
	 * 【信息采集】*******************************
	 */
	@Trans
	public void save() {
		String flag = (String) getParameter("flag");
		BaseinfoPeople baseinfoPeople = getBaseinfoPeople();
		BaseinfoFamily baseinfoFamily = getBaseinfoFamily();
		BptPeople bptPeople = getBptPeople();
		BptPeopleDisability bptpeopleDisability = getPeopleDisability();
		String peoplePhotoTemp = baseinfoPeople.getPhotoTemp();
		String nowTime = DateUtil.getTime();
		String areaCode = baseinfoPeople.getRegOrgArea();
		String employeeName = baseinfoPeople.getRegPeople();
		dealPhotoC(baseinfoPeople, nowTime, areaCode, employeeName,
				peoplePhotoTemp);// 处理照片
		if(("UPDATE".equals(idCardValidate(baseinfoPeople.getIdCard()))&&"1".equals(flag))
				||("INSERT".equals(idCardValidate(baseinfoPeople.getIdCard()))&&!"1".equals(flag))){
			throw new RuntimeException("插入标志不符:"+baseinfoPeople.getIdCard()+
					"-"+idCardValidate(baseinfoPeople.getIdCard())+"-"+flag);
			
		}
		
		if (flag.equals("1")) {// 新增人员信息
			try {
				String peopleIdRe = IdHelp.getUUID30();
				String familyIdRe = IdHelp.getUUID30();
				baseinfoPeople.setPeopleId(peopleIdRe);
				baseinfoPeople.setFamilyId(familyIdRe);
				baseinfoFamily.setFamilyId(familyIdRe);
				bptPeople.setPeopleId(peopleIdRe);
				bptpeopleDisability.setPeopleId(peopleIdRe);
				service.insertBaseinfo(baseinfoPeople, baseinfoFamily);
				service.insertBptPeople(bptPeople);
				service.insertDisabilityInfo(bptpeopleDisability);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {// 修改人员信息,将已存人员修改为多个优抚对象类别
			service.updateBaseinfo(baseinfoPeople, baseinfoFamily);
			String peopleId = baseinfoPeople.getPeopleId();
			ParameterSet pset = new ParameterSet();
			pset.setParameter("PEOPLE_ID", peopleId);
			if (service.queryBptPeople(pset).getCount() == 0) {
				service.insertBptPeople(bptPeople);
			} else {
				service.update(bptPeople);
			}
			service.insertDisabilityInfo(bptpeopleDisability);
		}
		setReturn("peopleId", baseinfoPeople.getPeopleId());
		setReturn("familyId", baseinfoPeople.getFamilyId());
	}

	/**
	 * ***********************************【更新人员伤残信息】【信息采集】*************************************************
	 */
	@Trans
	public void updateDisability() {
		/**
		 * 获得伤残人员服务接口
		 */
		IBptPeopleDisabilityDomain bptPeopleDisabilityService = ScaComponentFactory
				.getService(IBptPeopleDisabilityDomain.class,
						"bptPeopleDisabilityDomain/bptPeopleDisabilityDomain");

		/**
		 * 获得优抚人员服务接口
		 */
		IBptPeopleDomain bptPeopleService = ScaComponentFactory.getService(
				IBptPeopleDomain.class, "bptPeopleDomain/bptPeopleDomain");

		BptPeopleDisability bptpeopleDisability = getPeopleDisability();
		BptPeople bptPeople = getBptPeople();
		BaseinfoPeople baseinfoPeople = getUpdateBaseinfoPeople();

		bptPeopleDisabilityService.updatePeopleDisability(bptpeopleDisability);
		bptPeopleService.update(bptPeople);
		service.updateBaseinfoPeople(baseinfoPeople);
	}

	/**
	 * **********************************【获取人员信息】
	 * 【信息采集】*****************************************
	 */
	private BaseinfoPeople getBaseinfoPeople() {
		Record baseinfoPeopleRecord = (Record) getParameter("BaseinfoPeopleRecord");
		Record bptPeopleDisabilityRecord = (Record) getParameter("BptPeopleDisabilityRecord");
		BaseinfoPeople bean = (BaseinfoPeople) baseinfoPeopleRecord
				.toBean(BaseinfoPeople.class);
		bean.setIdCardType("0");
		bean.setDisabilityFlag("1");
		bean.setRedaFlag(baseinfoPeopleRecord.get("redaFlag").toString());
		bean.setDependantFlag(baseinfoPeopleRecord.get("dependantFlag")
				.toString());
		bean.setDemobilizedFlag(baseinfoPeopleRecord.get("demobilizedFlag")
				.toString());
		bean.setWarFlag(baseinfoPeopleRecord.get("warFlag").toString());
		bean.setDisabilityStateCode(bptPeopleDisabilityRecord.get(
				"disabilityStateCode").toString());
		bean.setDisabilityLevelCode(bptPeopleDisabilityRecord.get(
				"disabilityLevelCode").toString());
		bean.setDisabilityCaseCode(bptPeopleDisabilityRecord.get(
				"disabilityCaseCode").toString());
		bean.setDisabilityNo(bptPeopleDisabilityRecord.get("disabilityNo")
				.toString());
		bean.setRedaStateCode(baseinfoPeopleRecord.get("redaStateCode")
				.toString());
		bean.setDependantStateCode(baseinfoPeopleRecord.get(
				"dependantStateCode").toString());
		bean.setDemobilizedStateCode(baseinfoPeopleRecord.get(
				"demobilizedStateCode").toString());
		bean.setWarStateCode(baseinfoPeopleRecord.get("warStateCode")
				.toString());
		bean.setPersonalStatsTag("0");
		bean.setRegId(BspUtil.getEmpOrganId());
		bean.setRegTime(DateUtil.getTime());
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		return bean;
	}

	/**
	 * **********************************【获得更新时的人员信息】
	 * 【信息采集】*****************************************
	 */
	public BaseinfoPeople getUpdateBaseinfoPeople() {
		Record bptPeopleDisabilityrecord = (Record) getParameter("BptPeopleDisabilityRecord");
		String peopleId = (String) bptPeopleDisabilityrecord.get("peopleId");
		ParameterSet pset = getParameterSet();
		pset.clear();
		pset.setParameter("PEOPLE_ID@=", peopleId);
		DataSet ds = service.queryPeople(pset);
		Record rd = ds.getRecord(0);
		BaseinfoPeople bean = (BaseinfoPeople) rd.toBean(BaseinfoPeople.class);
		bean.setDisabilityLevelCode(bptPeopleDisabilityrecord.get(
				"disabilityLevelCode").toString());
		bean.setDisabilityCaseCode(bptPeopleDisabilityrecord.get(
				"disabilityCaseCode").toString());
		bean.setDisabilityNo(bptPeopleDisabilityrecord.get("disabilityNo")
				.toString());
		bean.setDisabilityStateCode(bptPeopleDisabilityrecord.get(
				"disabilityStateCode").toString());
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		return bean;
	}

	/**
	 * **********************************【获取人原伤残信息】
	 * 【信息采集】*****************************************
	 */
	private BptPeopleDisability getPeopleDisability() {
		Record bptPeopleDisabilityrecord = (Record) getParameter("BptPeopleDisabilityRecord");
		BptPeopleDisability bean = (BptPeopleDisability) bptPeopleDisabilityrecord
				.toBean(BptPeopleDisability.class);
		bean.setPeopleId(bptPeopleDisabilityrecord.get("peopleId").toString());
		bean.setConscriptDate(bptPeopleDisabilityrecord.get("conscriptDate")
				.toString());
		bean.setVeteransDate(bptPeopleDisabilityrecord.get("veteransDate")
				.toString());
		bean.setDisabilityWarCode(bptPeopleDisabilityrecord.get(
				"disabilityWarCode").toString());
		bean.setDisabilityLevelCode(bptPeopleDisabilityrecord.get(
				"disabilityLevelCode").toString());
		bean.setDisabilityCaseCode(bptPeopleDisabilityrecord.get(
				"disabilityCaseCode").toString());
		bean.setDisabilityGenusCode(bptPeopleDisabilityrecord.get(
				"disabilityGenusCode").toString());
		bean.setDisabilityDate(bptPeopleDisabilityrecord.get("disabilityDate")
				.toString());
		bean.setDisabilityAdd(bptPeopleDisabilityrecord.get("disabilityAdd")
				.toString());
		bean.setUinitOfDisability(bptPeopleDisabilityrecord.get(
				"uinitOfDisability").toString());
		bean.setDisabilityBody(bptPeopleDisabilityrecord.get("disabilityBody")
				.toString());
		bean.setDisabilityReason(bptPeopleDisabilityrecord.get(
				"disabilityReason").toString());
		bean.setNote(bptPeopleDisabilityrecord.get("note").toString());
		// bean.setCommitFlag("0");
		bean.setToWorkDate(bptPeopleDisabilityrecord.get("toWorkDate")
				.toString());
		bean.setRetiredDate(bptPeopleDisabilityrecord.get("retiredDate")
				.toString());
		bean.setRegId(BspUtil.getEmpOrganId());
		bean.setRegTime(DateUtil.getTime());
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		return bean;
	}

	/**
	 * **********************************【获得优抚人员信息】
	 * 【信息采集】*****************************************
	 */
	private BptPeople getBptPeople() {
		Record bptPeopleDisabilityRecord = (Record) getParameter("BptPeopleDisabilityRecord");
		BptPeople bptPeople = (BptPeople) bptPeopleDisabilityRecord
				.toBean(BptPeople.class);
		bptPeople.setPeopleId(bptPeopleDisabilityRecord.get("peopleId")
				.toString());
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

		// 将该对象修改为多个对象类别
		ParameterSet param = new ParameterSet();
		param.setParameter("PEOPLE_ID", bptPeopleDisabilityRecord.get(
				"peopleId").toString());
		DataSet ds = service.queryBptPeople(param);
		if (ds.getCount() != 0) {
			Record rd = ds.getRecord(0);
			bptPeople.setDemobilizedTyepCode(rd.get("demobilizedTyepCode")
					.toString());
			bptPeople.setDependantTypeCode(rd.get("dependantTypeCode")
					.toString());
			bptPeople.setRedaTypeCode(rd.get("redaTypeCode").toString());
			bptPeople.setWarTypeCode(rd.get("warTypeCode").toString());
			bptPeople.setRetiredTypeCode((String)rd.get("retiredTypeCode"));
			bptPeople.setMartyrOffspringCode((String)rd.get("martyrOffspringCode"));
		} else {
			bptPeople.setDemobilizedTyepCode("00");
			bptPeople.setDependantTypeCode("00");
			bptPeople.setRedaTypeCode("00");
			bptPeople.setWarTypeCode("00");
			bptPeople.setRetiredTypeCode("00");
			bptPeople.setMartyrOffspringCode("00");
		}
		return bptPeople;
	}

	/**
	 * **********************************【获取家庭信息】
	 * 【信息采集】*****************************************
	 */
	private BaseinfoFamily getBaseinfoFamily() {
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
	 * 创建并发起流程
	 */
	@SuppressWarnings("unchecked")
	@Trans
	public void createAndSend() {
		String applyId;
		String peopleId;
		Record record = (Record) getParameter("record");
		if (record!= null && !"".equals(record)) {

			applyId = (String) record.get("APPLY_ID");
			peopleId = (String) record.get("PEOPLE_ID");
		} else {

			applyId = (String) getParameter("applyId");
			peopleId = (String) getParameter("peopleId");
		}
		String condition = (String) getParameter("condition");

		// 获得伤残审批信息【在伤残审批表里面添加一条记录】
		ParameterSet pset = new ParameterSet();
		pset.setParameter("APPLY_ID", applyId);
		BptApplyDisability bptApplyDisabilityBean = (BptApplyDisability) bptApplyDisabilityService
				.query(pset).getRecord(0).toBean(BptApplyDisability.class);
		bptApplyDisabilityBean.setTownCheckDate(DateUtil.getDay());
		bptApplyDisabilityBean.setTownCheckPeopleId(BspUtil.getCorpOrgan()
				.getOrganName());
		bptApplyDisabilityBean.setApproveDate(DateUtil.getDay());
		bptApplyDisabilityBean.setApproveOrganId(BspUtil.getCorpOrgan()
				.getOrganName());
		bptApplyDisabilityBean.setCommitFlag(BptConstant.COMMIT_FLAG);
		bptApplyDisabilityService.update(bptApplyDisabilityBean);

		// 插入审批记录历史表
		BptApplyHistory bptApplyHistory = new BptApplyHistory();
		bptApplyHistory.setHistoryId(IdHelp.getUUID30());
		bptApplyHistory.setActdefName("县级审核");
		bptApplyHistory.setCreateTime(DateUtil.getTime());
		bptApplyHistory.setApplyAdvice(bptApplyDisabilityBean
				.getTownAduitAdvice());
		bptApplyHistory.setApplyIncharge(bptApplyDisabilityBean
				.getTownAduitIncharge());
		bptApplyHistory.setApplyTime(bptApplyDisabilityBean
				.getTownAduitApproveDate());
		bptApplyHistory.setApplyId(applyId);
		bptApplyHistory.setDisabilityCase(bptApplyDisabilityBean
				.getTownAduitDisabilityNature());
		bptApplyHistory.setDisabilityLevel(bptApplyDisabilityBean
				.getTownAduitDisabilityLevel());
		bptApplyHistory.setApplyFlag(bptApplyDisabilityBean.getTownFlag());
		bptApplyHistory.setReport(bptApplyDisabilityBean.getTownReport());
		bptApplyHistoryService.insert(bptApplyHistory);

		//通过流程唯一ID获得流程第一个环节ID
		String procDefUniqueId = "8a898bd732ed00f50132ed00f5700000";
		String startActDefUniqueId = (String)WfQuery.getActDefInfoByProcDefUniqueIdAndActDefId(procDefUniqueId,"act1").get("actDefUniqueId");
		
		// 调用创建并发送流程接口
		CommandContext.setContextParameter("procDefUniqueId",procDefUniqueId);
		CommandContext.setContextParameter("startActDefUniqueId",startActDefUniqueId);
		Map<String, String> context = new HashMap<String, String>();
		String city_Code = BspUtil.getParentStrId();
		String currentOrganName = BspUtil.getCorpOrgan().getOrganName();
		context.put("City_Code", city_Code);
		context.put("Condition", condition);
		Map<String, String> map = WfTaskRequestWrapper
				.getInstance()
				.createAndSend(
						applyId,
						currentOrganName + BptConstant.BPT_DISABILITY_ASSESS_NA,
						context);
		// Map map=WfTaskRequestWrapper.getInstance().createAndSendByProcDefId(
		// "E4D0F11846114A14108168B1587A3D6E","act1", "业务主键id1",
		// "new区县的配置伤残器械申请");
		String processId = (String) map.get("processId");

		// 添加工作流信息表
		WfProcessBusiness wfProcessBusiness = new WfProcessBusiness();
		wfProcessBusiness.setProcessId(processId);
		wfProcessBusiness.setBusinessId(applyId);
		wfProcessBusiness.setConnectId(peopleId);
		wfProcessBusiness.setBusinessType(BptConstant.BPT_DISABILITY_ASSESS);
		wfProcessBusiness.setIfback("n");
		wfProcessBusinessService.insert(wfProcessBusiness);

		if ("end".equals(condition)) { // 不予评定结束流程
			if (map.containsKey("isEnd")) { // 流程完成后修改伤残信息
				String isEnd = (String) map.get("isEnd");
				if ("true".equals(isEnd)) {
					pset.clear();
					pset.setParameter("PEOPLE_ID", peopleId);
					BaseinfoPeople baseinfoPeople = (BaseinfoPeople) service
							.queryPeople(pset).getRecord(0).toBean(
									BaseinfoPeople.class);
					BptPeopleDisability disability = (BptPeopleDisability) bptPeopleDisabilityService
							.queryBptPeopleDisability(pset).getRecord(0)
							.toBean(BptPeopleDisability.class);
					baseinfoPeople.setDisabilityStateCode("6");// 设置状态为不予评定
					disability.setApproveDate(DateUtil.getDay());
					service.updateBaseinfoPeople(baseinfoPeople); // 修改人员基本信息
					bptPeopleDisabilityService
							.updatePeopleDisability(disability);
				}
			}
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
	
	
	/**
	 * 添加[人员信息]和[人员伤残信息]和其他业务信息（受理通知书、鉴定介绍信和审批表信息）
	 */
	@Trans
	public void insert() {

		String applyId = IdHelp.getUUID30();
		String peopleId = IdHelp.getUUID30();
		String familyId = IdHelp.getUUID30();
		// 获得受理通知书服务接口
		IDisabilityNoticeDomain noticeService = ScaComponentFactory.getService(
				IDisabilityNoticeDomain.class,
				"disabilityNoticeDomain/disabilityNoticeDomain");

		// 获得伤残鉴定介绍信服务接口
		IDisabilityIdentificationDomain identiLetterService = ScaComponentFactory
				.getService(IDisabilityIdentificationDomain.class,
						"disabilityIdentificationDomain/disabilityIdentificationDomain");

		BaseinfoPeople baseinfoPeople = getBaseinfoPeople();
		BptPeopleDisability bptpeopleDisability = getDisabilityInfo();
		BaseinfoFamily baseinfoFamily = getBaseinfoFamily();
		BptPeople bptPeople = getBptPeople();
		BptApplyDisabilityNotice disabilityNotice = getNoticeInfo();
		DisabilityIdentification identiLetterBean = getIntroLetter();
		BptApplyDisability bptApplyDisability = getBptApplyDisability();

		bptApplyDisability.setApplyId(applyId);
		disabilityNotice.setApplyId(applyId);
		identiLetterBean.setApplyId(applyId);

		String peoplePhotoTemp = baseinfoPeople.getPhotoTemp();
		String nowTime = DateUtil.getTime();
		String areaCode = baseinfoPeople.getRegOrgArea();
		String employeeName = baseinfoPeople.getRegPeople();
		dealPhotoC(baseinfoPeople, nowTime, areaCode, employeeName,
				peoplePhotoTemp);// 处理照片

		String flag = (String) getParameter("flag");
		if(("UPDATE".equals(idCardValidate(baseinfoPeople.getIdCard()))&&"1".equals(flag))
				||("INSERT".equals(idCardValidate(baseinfoPeople.getIdCard()))&&!"1".equals(flag))){
			throw new RuntimeException("插入标志不符:"+baseinfoPeople.getIdCard()+
					"-"+idCardValidate(baseinfoPeople.getIdCard())+"-"+flag);
			
		}
		if ("1".equals(flag)) {
			baseinfoPeople.setPeopleId(peopleId);
			baseinfoPeople.setFamilyId(familyId);
			baseinfoFamily.setFamilyId(familyId);

			bptPeople.setPeopleId(peopleId);
			bptApplyDisability.setPeopleId(peopleId);

			disabilityNotice.setPeopleId(peopleId);

			identiLetterBean.setPeopleId(peopleId);
			bptpeopleDisability.setPeopleId(peopleId);

			service.insertDisabilityInfo(bptpeopleDisability);
			service.insertBaseinfo(baseinfoPeople, baseinfoFamily);
			service.insertBptPeople(bptPeople);
			noticeService.insert(disabilityNotice);
			identiLetterService.insert(identiLetterBean);
			bptApplyDisabilityService.insert(bptApplyDisability);
		} else {
			String peopleId_old = baseinfoPeople.getPeopleId();
			bptApplyDisability.setPeopleId(peopleId_old);
			bptpeopleDisability.setPeopleId(peopleId_old);
			disabilityNotice.setPeopleId(peopleId_old);
			identiLetterBean.setPeopleId(peopleId_old);
			bptPeople.setPeopleId(peopleId_old);

			service.insertDisabilityInfo(bptpeopleDisability);
			
			baseinfoPeople.setDisabilityStateCode("1");
			service.updateBaseinfo(baseinfoPeople, baseinfoFamily);

			// System.out.println(peopleId);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("PEOPLE_ID", peopleId_old);
			if (service.queryBptPeople(pset).getCount() == 0) {
				service.insertBptPeople(bptPeople);
			} else {
				service.update(bptPeople);
			}
			noticeService.insert(disabilityNotice);
			identiLetterService.insert(identiLetterBean);
			bptApplyDisabilityService.insert(bptApplyDisability);
		}
		setReturn("peopleId", baseinfoPeople.getPeopleId());
		setReturn("familyId", baseinfoFamily.getFamilyId());
		setReturn("applyId", applyId);
		// 添加矽肺病鉴定体检表
		BptPhysicalExamination physicalExamination = new BptPhysicalExamination();
		physicalExamination.setApplyId(applyId);
		physicalExamination.setPeopleId(baseinfoPeople.getPeopleId());
		BptPhysicalExaminationDao physicalExaminationDao = (BptPhysicalExaminationDao) DaoFactory
				.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPhysicalExaminationDao");
		physicalExaminationDao.insert(physicalExamination);
		//添加体检表
		physicalExamination.setApplyId(applyId+"@");
		physicalExaminationDao.insert(physicalExamination);
	}

	/**
	 * 更新类别信息【伤残】
	 */
	@Trans
	public void update() {
		/**
		 * 获得伤残人员服务接口
		 */
		IBptPeopleDisabilityDomain bptPeopleDisabilityService = ScaComponentFactory
				.getService(IBptPeopleDisabilityDomain.class,
						"bptPeopleDisabilityDomain/bptPeopleDisabilityDomain");

		/**
		 * 获得优抚人员服务接口
		 */
		IBptPeopleDomain bptPeopleService = ScaComponentFactory.getService(
				IBptPeopleDomain.class, "bptPeopleDomain/bptPeopleDomain");

		BptPeopleDisability bptpeopleDisability = getDisabilityInfo();
		BptPeople bptPeople = getBptPeople();

		bptPeopleDisabilityService.updatePeopleDisability(bptpeopleDisability);
		bptPeopleService.update(bptPeople);
	}

	/**
	 * 获取人员信息
	 */
	public BaseinfoPeople getPeopleInfo() {
		Record baseinfoPeopleRecord = (Record) getParameter("BaseinfoPeopleRecord");
		Record bptPeopleDisabilityRecord = (Record) getParameter("BptPeopleDisabilityRecord");
		BaseinfoPeople bean = (BaseinfoPeople) baseinfoPeopleRecord
				.toBean(BaseinfoPeople.class);
		bean.setIdCardType("0");
		bean.setDisabilityFlag("1");
		bean.setRedaFlag("0");
		bean.setDependantFlag("0");
		bean.setDemobilizedFlag("0");
		bean.setWarFlag("0");
		bean.setDisabilityStateCode("1");
		bean.setDisabilityLevelCode(bptPeopleDisabilityRecord.get(
				"disabilityLevelCode").toString());
		bean.setDisabilityCaseCode(bptPeopleDisabilityRecord.get(
				"disabilityCaseCode").toString());
		bean.setRedaStateCode("0");
		bean.setDependantStateCode("0");
		bean.setDemobilizedStateCode("0");
		bean.setWarStateCode("0");
		bean.setPersonalStatsTag("0");
		bean.setRegId(BspUtil.getEmpOrganId());
		bean.setRegTime(DateUtil.getTime());
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		return bean;
	}

	/**
	 * 获得伤残信息
	 */
	private BptPeopleDisability getDisabilityInfo() {
		Record bptPeopleDisabilityrecord = (Record) getParameter("BptPeopleDisabilityRecord");
		BptPeopleDisability bean = (BptPeopleDisability) bptPeopleDisabilityrecord
				.toBean(BptPeopleDisability.class);
		bean.setRegId(BspUtil.getEmpOrganId());
		bean.setRegTime(DateUtil.getTime());
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		return bean;
	}

	/**
	 * 获得介绍信实体Bean
	 */
	public DisabilityIdentification getIntroLetter() {
		DisabilityIdentification dataBean = new DisabilityIdentification();
		Record bptPeopleDisabilityrecord = (Record) getParameter("BptPeopleDisabilityRecord");
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
		dataBean.setDisabilityDate(bptPeopleDisabilityrecord.get(
				"disabilityDate").toString());
		dataBean.setDisabilityReason(bptPeopleDisabilityrecord.get(
				"disabilityReason").toString());
		dataBean.setDisabilityBody(bptPeopleDisabilityrecord.get(
				"disabilityBody").toString());
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
	 * 获得评定伤残申请表实体Bean
	 */
	public BptApplyDisability getBptApplyDisability() {
		String applyId = IdHelp.getUUID30();
		Record baseinfoPeopleRecord = (Record) getParameter("BaseinfoPeopleRecord");
		BptApplyDisability bptApplyDisability = new BptApplyDisability();
		bptApplyDisability.setApplyId(applyId);
		bptApplyDisability.setPeopleId(baseinfoPeopleRecord.get("peopleId")
				.toString());
		bptApplyDisability.setServiceType(BptConstant.BPT_DISABILITY_ASSESS);
		bptApplyDisability.setCommitFlag(BptConstant.UN_COMMIT_FLAG);
		return bptApplyDisability;
	}
	/**
	 * 换残疾军人证书中的 编号
	 * @param pset
	 */
	@Trans
	public void renewalCert(){
		String peopleId = (String) getParameter("peopleId");
		String domicileCode = (String) getParameter("domicileCode");
		String chipId = (String) getParameter("chipId");
		String no = bptPeopleDisabilityService.renewalCert(peopleId,domicileCode,chipId);
		this.setReturn("no", no);
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
	
	

}