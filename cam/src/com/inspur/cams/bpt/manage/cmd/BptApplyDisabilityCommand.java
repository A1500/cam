package com.inspur.cams.bpt.manage.cmd;

import java.util.HashMap;
import java.util.Map;

import org.loushang.bsp.id.util.MaxValueUtil;
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

import com.inspur.cams.bpt.base.dao.jdbc.BptPhysicalExaminationDao;
import com.inspur.cams.bpt.base.data.BptApplyDisability;
import com.inspur.cams.bpt.base.data.BptApplyHistory;
import com.inspur.cams.bpt.base.data.BptPeople;
import com.inspur.cams.bpt.base.data.BptPeopleDisability;
import com.inspur.cams.bpt.base.data.BptPhysicalExamination;
import com.inspur.cams.bpt.base.data.BptStateChange;
import com.inspur.cams.bpt.base.data.WfProcessBusiness;
import com.inspur.cams.bpt.base.domain.IBptApplyDisabilityDomain;
import com.inspur.cams.bpt.base.domain.IBptApplyHistoryDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDisabilityDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDomain;
import com.inspur.cams.bpt.base.domain.IBptStateChangeDomain;
import com.inspur.cams.bpt.base.domain.IWfProcessBusinessDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.bpt.util.BptConstant;
import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao;
import com.inspur.cams.comm.diccity.data.DicCity;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.PhotoUtil;

/**
 * @title:BptApplyDisabilityCommand
 * @description:伤残审批
 * @author:
 * @since:2011-06-10
 * @version:1.0
 */
public class BptApplyDisabilityCommand extends BaseAjaxCommand {

	IBptGroupDomain service = ScaComponentFactory.getService(
			IBptGroupDomain.class, "bptGroupDomain/bptGroupDomain");

	/**
	 * 伤残审批服务接口
	 */
	IBptApplyDisabilityDomain applyDisabilityService = ScaComponentFactory
			.getService(IBptApplyDisabilityDomain.class,
					"bptApplyDisabilityDomain/bptApplyDisabilityDomain");

	/**
	 * 伤残人员信息服务接口
	 */
	IBptPeopleDisabilityDomain disabilityService = ScaComponentFactory
			.getService(IBptPeopleDisabilityDomain.class,
					"bptPeopleDisabilityDomain/bptPeopleDisabilityDomain");

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
	 * 审批记录历史服务接口
	 */
	IBptApplyHistoryDomain bptApplyHistoryService = ScaComponentFactory
			.getService(IBptApplyHistoryDomain.class,
					"BptApplyHistoryDomain/BptApplyHistoryDomain");

	/**
	 * 添加调残信息
	 */
	@Trans
	public void insert() {
		String applyId = IdHelp.getUUID30();
		Record record = (Record) getParameter("record");
		BptApplyDisability dateBean = (BptApplyDisability) record
				.toBean(BptApplyDisability.class);
		dateBean.setApplyId(applyId);
		dateBean.setServiceType(BptConstant.BPT_DISABILITY_ADJUST);
		dateBean.setCommitFlag(BptConstant.UN_COMMIT_FLAG);
		// 伤残人员调残 添加原残疾等级性质
		dateBean.setOldDisabilityLevel((String) record
				.get("disabilityLevelCode"));
		dateBean.setOldDisabilityNature((String) record
				.get("disabilityCaseCode"));
		applyDisabilityService.insert(dateBean);
		setReturn("applyId", applyId);
		// 添加矽肺病鉴定体检表
		String peopleId = dateBean.getPeopleId();
		BptPhysicalExamination physicalExamination = new BptPhysicalExamination();
		physicalExamination.setApplyId(applyId);
		physicalExamination.setPeopleId(peopleId);
		BptPhysicalExaminationDao physicalExaminationDao = (BptPhysicalExaminationDao) DaoFactory
				.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPhysicalExaminationDao");
		physicalExaminationDao.insert(physicalExamination);
	}

	/**
	 * 判断审批表是否有信息
	 * 
	 * @return
	 */
	public void queryCount() {
		ParameterSet pset = getParameterSet();
		DataSet applyDisabilityDataSet = applyDisabilityService.query(pset);
		int count = applyDisabilityDataSet.getCount();
		if (count < 1) {
			setReturn("count", 0);
		} else {
			setReturn("count", 1);
		}
	}

	/**
	 * 获取伤残审批信息判定是否提交
	 * 
	 * @return
	 */
	public void queryApplyInfo() {
		ParameterSet pset = getParameterSet();
		DataSet ds = applyDisabilityService.query(pset);
		if (ds.getCount() > 0) {
			Record record = ds.getRecord(0);
			String townAduitIncharge = (String) record.get("townAduitIncharge");
			String townFlag = (String) record.get("townFlag");
			String townReport = (String) record.get("townReport");
			this.setReturn("townAduitIncharge", townAduitIncharge);
			this.setReturn("townFlag", townFlag);
			this.setReturn("townReport", townReport);
		}
	}

	/**
	 * 添加补证换证信息
	 */
	@Trans
	public void addExchaCertiDisa() {
		String applyId = IdHelp.getUUID30();
		Record record = (Record) getParameter("record");
		BptApplyDisability dateBean = (BptApplyDisability) record
				.toBean(BptApplyDisability.class);
		dateBean.setApplyId(applyId);
		dateBean.setCommitFlag(BptConstant.UN_COMMIT_FLAG);
		dateBean.setServiceType(BptConstant.BPT_DISABILITY_EXCHANGECERTIFICATE);
		applyDisabilityService.insert(dateBean);
		setReturn("applyId", applyId);
	}

	/**
	 * 添加伤残人员证件变更信息
	 */
	@Trans
	public void addChangeCertiDisa() {
		String applyId = IdHelp.getUUID30();
		Record record = (Record) getParameter("record");
		BptApplyDisability dateBean = (BptApplyDisability) record
				.toBean(BptApplyDisability.class);
		dateBean.setApplyId(applyId);
		dateBean.setCommitFlag(BptConstant.UN_COMMIT_FLAG);
		dateBean.setServiceType(BptConstant.BPT_DISABILITY_CHANGECERTIFICATE);
		applyDisabilityService.insert(dateBean);
		setReturn("applyId", applyId);
	}

	/**
	 * 添加部队退役残疾军人抚恤关系迁移信息
	 */
	@Trans
	public void addVeteransShift() {

		BaseinfoPeople baseinfoPeople = getPeopleInfo();
		BptPeopleDisability bptpeopleDisability = getDisabilityInfo();
		BaseinfoFamily baseinfoFamily = getBaseinfoFamily();
		BptPeople bptPeople = getBptPeople();
		BptApplyDisability bptApplyDisability = getBptApplyDisability();

		String peoplePhotoTemp = baseinfoPeople.getPhotoTemp();
		String nowTime = DateUtil.getTime();
		String areaCode = baseinfoPeople.getRegOrgArea();
		String employeeName = baseinfoPeople.getRegPeople();
		dealPhotoC(baseinfoPeople, nowTime, areaCode, employeeName,
				peoplePhotoTemp);// 处理照片

		String peopleId = IdHelp.getUUID30();
		String familyId = IdHelp.getUUID30();
		String applyId = IdHelp.getUUID30();

		bptApplyDisability.setApplyId(applyId);

		String flag = (String) getParameter("flag");
		if ("1".equals(flag)) {
			bptpeopleDisability.setPeopleId(peopleId);
			baseinfoPeople.setPeopleId(peopleId);
			baseinfoPeople.setFamilyId(familyId);
			baseinfoFamily.setFamilyId(familyId);
			bptPeople.setPeopleId(peopleId);
			bptApplyDisability.setPeopleId(peopleId);

			service.insertDisabilityInfo(bptpeopleDisability);
			service.insertBaseinfo(baseinfoPeople, baseinfoFamily);
			service.insertBptPeople(bptPeople);
			applyDisabilityService.insert(bptApplyDisability);
		} else {
			String peopleOldId = baseinfoPeople.getPeopleId();

			service.insertDisabilityInfo(bptpeopleDisability);
			service.updateBaseinfo(baseinfoPeople, baseinfoFamily);

			// System.out.println(peopleId);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("PEOPLE_ID", peopleOldId);
			if (service.queryBptPeople(pset).getCount() == 0) {
				bptPeople.setPeopleId(peopleOldId);
				service.insertBptPeople(bptPeople);
			} else {
				service.update(bptPeople);
			}
			applyDisabilityService.insert(bptApplyDisability);
		}
		/*
		 * String applyId = IdHelp.getUUID30(); Record record = (Record)
		 * getParameter("record"); BptApplyDisability dateBean =
		 * (BptApplyDisability)record.toBean(BptApplyDisability.class);
		 * dateBean.setApplyId(applyId);
		 * dateBean.setCommitFlag(BptConstant.UN_COMMIT_FLAG);
		 * dateBean.setServiceType(BptConstant.BPT_DISABILITY_VETERANSSHIFT);
		 * applyDisabilityService.insert(dateBean);
		 */
		setReturn("peopleId", baseinfoPeople.getPeopleId());
		setReturn("familyId", baseinfoFamily.getFamilyId());
		setReturn("applyId", applyId);
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
	 * 获得评定伤残申请表实体Bean
	 */
	public BptApplyDisability getBptApplyDisability() {
		// String applyId = IdHelp.getUUID30();
		Record baseinfoPeopleRecord = (Record) getParameter("BptPeopleDisabilityRecord");
		BptApplyDisability bptApplyDisability = new BptApplyDisability();
		bptApplyDisability.setApplyId(baseinfoPeopleRecord.get("applyId")
				.toString());
		bptApplyDisability.setPeopleId(baseinfoPeopleRecord.get("peopleId")
				.toString());
		bptApplyDisability.setOldDisabilityNo(baseinfoPeopleRecord.get(
				"oldDisabilityNo").toString());
		bptApplyDisability.setAllowanceMonth(baseinfoPeopleRecord.get(
				"allowanceMonth").toString());
		bptApplyDisability.setIngoingAddress(baseinfoPeopleRecord.get(
				"ingoingAddress").toString());
		bptApplyDisability.setExchangeReason((String) baseinfoPeopleRecord
				.get("exchangeReason"));
		bptApplyDisability.setChangeReasonContent((String) baseinfoPeopleRecord
				.get("changeReasonContent"));
		bptApplyDisability
				.setServiceType(BptConstant.BPT_DISABILITY_VETERANSSHIFT);
		bptApplyDisability.setCommitFlag(BptConstant.UN_COMMIT_FLAG);
		return bptApplyDisability;
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
	 * 更新一条记录
	 */
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		BptApplyDisability dateBean = (BptApplyDisability) record.toBean(BptApplyDisability.class);
		String certType = (String)record.get("certType");
		String cancelTreateFlag =  (String)record.get("cancelTreateFlag");
		String serviceType = (String)record.get("serviceType");
		String peopleId = (String)record.get("peopleId");
		String newDisabilityNo = (String)record.get("newDisabilityNo");
		//如果是换证补证业务，生成新伤残优抚证书编号
		if("13".equals(certType)&&!"1".equals(cancelTreateFlag)){
			String oldDisabilityNo = (String)record.get("oldDisabilityNo");
			if("".equals(newDisabilityNo)||newDisabilityNo==null||oldDisabilityNo.equals(newDisabilityNo)){
				
				//更新人员信息表
				ParameterSet pt = new ParameterSet();
				pt.setParameter("people_id",peopleId);
				BaseinfoPeople baseinfoPeople = (BaseinfoPeople) service.queryPeople(pt).getRecord(0).toBean(BaseinfoPeople.class);
				baseinfoPeople.setDisabilityNo(newDisabilityNo);
				service.updateBaseinfoPeople(baseinfoPeople);
				
				newDisabilityNo = findCommNo(peopleId,baseinfoPeople.getDomicileCode());
				dateBean.setNewDisabilityNo(newDisabilityNo);
				this.setReturn("newDisabilityNo",newDisabilityNo);
			}
		}
		//退役残疾军人抚恤关系迁入业务更新
		if("14".equals(serviceType)){
			String proCheckFlag = (String)record.get("proCheckFlag");
			String provinceCheckDisNature = (String)record.get("provinceCheckDisNature");
			String provinceCheckDisLevel = (String)record.get("provinceCheckDisLevel");
			if(("0".equals(proCheckFlag))&&(provinceCheckDisLevel!=null)&&(!"".equals(provinceCheckDisNature))&&(provinceCheckDisLevel!=null)&&(!"".equals(provinceCheckDisLevel))){
				if("".equals(newDisabilityNo)||newDisabilityNo==null){
					
					//更新优抚证书编号，人员信息表
					ParameterSet pt = new ParameterSet();
					pt.setParameter("people_id",peopleId);
					BaseinfoPeople baseinfoPeople = (BaseinfoPeople) service.queryPeople(pt).getRecord(0).toBean(BaseinfoPeople.class);
					
					String disabilityNo = findCommNo(peopleId,baseinfoPeople.getDomicileCode());
					dateBean.setNewDisabilityNo(disabilityNo);
					this.setReturn("disabilityNo",disabilityNo);
					
					
					baseinfoPeople.setDisabilityNo(disabilityNo);
					baseinfoPeople.setDisabilityLevelCode(provinceCheckDisLevel);
					baseinfoPeople.setDisabilityCaseCode(provinceCheckDisNature);
					service.updateBaseinfoPeople(baseinfoPeople);
					dateBean.setProvinceVerifyDisabilityNat(provinceCheckDisNature);
					dateBean.setProvinceLevel(provinceCheckDisLevel);
					/*BptPeopleDisability disability = (BptPeopleDisability) disabilityService
					.queryBptPeopleDisability(pt).getRecord(0).toBean(
							BptPeopleDisability.class);
					disability.setDisabilityCaseCode(provinceCheckDisNature);
					disability.setDisabilityLevelCode(provinceCheckDisLevel);
					disabilityService.updatePeopleDisability(disability);*/
				}
			}
		}
		applyDisabilityService.update(dateBean);
		/*
		 * ParameterSet pset = new ParameterSet();
		 * pset.setParameter("PEOPLE_ID", record.get("peopleId")); DataSet ds =
		 * disabilityService.queryBptPeopleDisability(pset); if(ds.getCount() >
		 * 0) { BptPeopleDisability bptPeopleDisability =
		 * (BptPeopleDisability)ds.getRecord(0).toBean(
		 * BptPeopleDisability.class); String disabilityCaseCode =
		 * (String)getParameter("disabilityCaseCode"); String
		 * disabilityLevelCode = (String)getParameter("disabilityLevelCode");
		 * if(!"".equals(disabilityCaseCode) && disabilityCaseCode != null) {
		 * bptPeopleDisability.setDisabilityCaseCode(disabilityCaseCode); }
		 * if(!"".equals(disabilityLevelCode) && disabilityLevelCode != null) {
		 * bptPeopleDisability.setDisabilityLevelCode(disabilityLevelCode); }
		 * disabilityService.updatePeopleDisability(bptPeopleDisability); } ds =
		 * null;
		 */
	}

	/**
	 * 修改打印标示
	 * 
	 * @param pset
	 */
	@Trans
	public void editPrintFlag() {
		ParameterSet pset = getParameterSet();
		applyDisabilityService.editPrintFlag(pset);
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
		BptApplyDisability bptApplyDisabilityBean = (BptApplyDisability) record
				.toBean(BptApplyDisability.class);
		// 插入审批记录历史表
		BptApplyHistory bptApplyHistory = new BptApplyHistory();
		bptApplyHistory.setHistoryId(IdHelp.getUUID30());
		bptApplyHistory.setActdefName(actDefName);
		bptApplyHistory.setCreateTime(DateUtil.getTime());
		bptApplyHistory.setApplyId(applyId);
		if ("TownVerify".equals(currentField)) { // 县级
			ParameterSet param = new ParameterSet();
			param.setParameter("APPLY_ID", applyId);
			DataSet ds = applyDisabilityService.query(param);
			if (ds != null && ds.getCount() != 0) {
				bptApplyDisabilityBean = (BptApplyDisability) (ds.getRecord(0)
						.toBean(BptApplyDisability.class));
				bptApplyHistory.setApplyAdvice(bptApplyDisabilityBean
						.getTownAduitAdvice());
				bptApplyHistory.setApplyIncharge(bptApplyDisabilityBean
						.getTownAduitIncharge());
				bptApplyHistory.setApplyTime(bptApplyDisabilityBean
						.getTownAduitApproveDate());
				bptApplyHistory.setDisabilityCase(bptApplyDisabilityBean
						.getTownAduitDisabilityNature());
				bptApplyHistory.setDisabilityLevel(bptApplyDisabilityBean
						.getTownAduitDisabilityLevel());
				bptApplyHistory.setApplyFlag(bptApplyDisabilityBean
						.getTownFlag());
				bptApplyHistory.setReport(bptApplyDisabilityBean
						.getTownReport());
			}
		} else if ("CityVerify".equals(currentField)) { // 市级
			bptApplyHistory.setApplyAdvice(bptApplyDisabilityBean
					.getCityAduitAdvice());
			bptApplyHistory.setApplyIncharge(bptApplyDisabilityBean
					.getCityAduitIncharge());
			bptApplyHistory.setApplyTime(bptApplyDisabilityBean
					.getCityAduitApproveDate());
			bptApplyHistory.setDisabilityCase(bptApplyDisabilityBean
					.getCityAduitDisabilityNature());
			bptApplyHistory.setDisabilityLevel(bptApplyDisabilityBean
					.getCityAduitDisabilityLevel());
			bptApplyHistory.setApplyFlag(bptApplyDisabilityBean.getCityFlag());
			bptApplyHistory.setReport(bptApplyDisabilityBean.getCityReport());
		} else if ("ProvinceAccept".equals(currentField)) { // 省级初审
			bptApplyHistory.setApplyAdvice(bptApplyDisabilityBean
					.getProvinceCheckAdvice());
			bptApplyHistory.setApplyIncharge(bptApplyDisabilityBean
					.getProvinceCheckPeopleId());
			bptApplyHistory.setApplyTime(bptApplyDisabilityBean
					.getProvinceCheckDate());
			bptApplyHistory.setDisabilityCase(bptApplyDisabilityBean
					.getProvinceCheckDisNature());
			bptApplyHistory.setDisabilityLevel(bptApplyDisabilityBean
					.getProvinceCheckDisLevel());
			bptApplyHistory.setApplyFlag(bptApplyDisabilityBean
					.getProCheckFlag());
			bptApplyHistory.setReport(bptApplyDisabilityBean
					.getProCheckReport());
		} else if ("ProvinceVerify".equals(currentField)) { // 省级复审
			bptApplyHistory.setApplyAdvice(bptApplyDisabilityBean
					.getProvinceAduitAdvice());
			bptApplyHistory.setApplyIncharge(bptApplyDisabilityBean
					.getProvinceAduitIncharge());
			bptApplyHistory.setApplyTime(bptApplyDisabilityBean
					.getProvinceAduitApproveDate());
			bptApplyHistory.setDisabilityCase(bptApplyDisabilityBean
					.getProvinceAduitDisabilityNatu());
			bptApplyHistory.setDisabilityLevel(bptApplyDisabilityBean
					.getProvinceAduitDisabilityLeve());
			bptApplyHistory.setApplyFlag(bptApplyDisabilityBean
					.getProAduitFlag());
			bptApplyHistory.setReport(bptApplyDisabilityBean
					.getProAduitReport());
		} else if ("ProvinceApprove".equals(currentField)) {// 省级审批
			bptApplyHistory.setApplyAdvice(bptApplyDisabilityBean
					.getProvinceAdvice());
			bptApplyHistory.setApplyIncharge(bptApplyDisabilityBean
					.getProvinceIncharge());
			bptApplyHistory.setApplyTime(bptApplyDisabilityBean
					.getProvinceApproveDate());
			bptApplyHistory.setDisabilityCase(bptApplyDisabilityBean
					.getProvinceVerifyDisabilityNat());
			bptApplyHistory.setDisabilityLevel(bptApplyDisabilityBean
					.getProvinceLevel());
			bptApplyHistory.setApplyFlag(bptApplyDisabilityBean.getProFlag());
		}
		bptApplyHistoryService.insert(bptApplyHistory);
	}

	/**
	 * 流程通过后更新一条记录
	 */
	@Trans
	public void passUpdate() {
		Record record = (Record) getParameter("record");
		BptApplyDisability dateBean = (BptApplyDisability) record
				.toBean(BptApplyDisability.class);
		dateBean.setPassFlag("1");
		dateBean.setPrintFlag("0");
		applyDisabilityService.update(dateBean);
	}

	/**
	 * 换证补正及其证件变更发送流程
	 */
	@Trans
	public void changeCertSend() {
		String applyId = (String) getParameter("applyId");
		String condition = (String) getParameter("condition");
		Map<String, String> context = new HashMap<String, String>();
		String city_Code = BspUtil.getParentStrId();
		// if("pass".equals(condition)) {
		// update();
		// }

		context.put("City_Code", city_Code);
		context.put("Condition", condition);

		// 调用工作流发送接口
		Map map = WfTaskRequestWrapper.getInstance().send(context);

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
		
		insertBptApplyHistory(); // 添加审批记录

		if (map.containsKey("isEnd")
				&& "true".equals((String) map.get("isEnd"))) { // 流程完成后修改变更信息
			Record record = (Record) getParameter("record");
			String cancelTreateFlag = (String)record.get("cancelTreateFlag");//取消待遇标志  2012/04/16
			String newDisabilityNo = (String)getParameter("newDisabilityNo");
			String certType = (String) record.get("certType");
			if ("pass".equals(condition)) { // 流程正常结束
				ParameterSet pt = new ParameterSet();
				pt.setParameter("people_id", (String) getParameter("peopleId"));
				BaseinfoPeople baseinfoPeople = (BaseinfoPeople) service.queryPeople(pt).getRecord(0).toBean(BaseinfoPeople.class);
				BptPeople bptPeople = (BptPeople) bptPeopleService.query(pt).getRecord(0).toBean(BptPeople.class);
				baseinfoPeople.setIdCard((String) record.get("newIdCard"));
				baseinfoPeople.setName((String) record.get("newName"));
				//换证补正
				if("13".equals(certType)&&!"1".equals(cancelTreateFlag)){
					baseinfoPeople.setDisabilityNo(newDisabilityNo);
				}
				//假证，取消待遇   2012/04/16
				if(cancelTreateFlag!=null&&"1".equals(cancelTreateFlag)){ 
					//更新状态变更记录
					BptStateChange bptStateChange = new BptStateChange();
					bptStateChange.setStateChangeId(IdHelp.getUUID32());
					bptStateChange.setPeopleId(baseinfoPeople.getPeopleId());
					bptStateChange.setName(baseinfoPeople.getName());
					bptStateChange.setIdCard(baseinfoPeople.getIdCard());
					bptStateChange.setChangeStatePre(baseinfoPeople.getDisabilityStateCode());
					bptStateChange.setChangeStateSuf("8");
					bptStateChange.setNote("假证，取消待遇");
					bptStateChange.setChangeStateDate(DateUtil.getDay());
					bptStateChange.setObjectType(bptPeople.getDisabilityTypeCode());
					bptStateChange.setRegId(BspUtil.getEmpOrganId());
					bptStateChange.setRegTime(DateUtil.getTime());
					//状态变更接口
					IBptStateChangeDomain stateChangeService = ScaComponentFactory.getService(IBptStateChangeDomain.class,
							"bptStateChangeDomain/bptStateChangeDomain");
					stateChangeService.insert(bptStateChange);
					baseinfoPeople.setDisabilityStateCode("8");
				}
				service.updateBaseinfoPeople(baseinfoPeople);
			}
		} else {
			update();
		}
	}

	/**
	 * 发送流程
	 */
	@Trans
	public void send() {
		String applyId = (String) getParameter("applyId");
		String condition = (String) getParameter("condition");
		Map<String, String> context = new HashMap<String, String>();
		String city_Code = BspUtil.getParentStrId();
		
		update();

		context.put("City_Code", city_Code);
		context.put("Condition", condition);

		// 调用工作流发送接口
		Map map = WfTaskRequestWrapper.getInstance().send(context);

		// 修改是否被退回标示为n（非退回）
		ParameterSet pset = new ParameterSet();
		pset.setParameter("applyId", applyId);
		pset.setParameter("ifback", "n");
		wfProcessBusinessService.updateIfback(pset);
		
		//判段是否是县级提交 如果是修改流程发起时间为当前时间
		if("13".equals(BspUtil.getOrganType())){
			ParameterSet psettime = new ParameterSet();
			psettime.setParameter("applyId", applyId);
			wfProcessBusinessService.updateProCreateTime(psettime);
		}
		
		insertBptApplyHistory(); // 添加审批记录

		if (map.containsKey("isEnd")
				&& "true".equals((String) map.get("isEnd"))) { // 流程完成后修改伤残信息
			if ("pass".equals(condition)) { // 流程正常结束
				updateInfo("2"); // 设置状态为享受待遇
				//passUpdate();
			} else if ("end".equals(condition)) { // 流程不予评定结束
				String object_type = (String) getParameter("serviceType"); // 业务类型
				if ("11".equals(object_type)||"14".equals(object_type)) {
					updateInfo("6"); // 设置状态为不予认定
					
				}
			}
			passUpdate();
		}
	}

	/**
	 * 生成伤残评残编号
	 * 
	 * @param peopleId
	 * @return
	 */
	public String findCommNo(String peopleId,String domicileCode) {
		String codeNum = "";
		ParameterSet pset = new ParameterSet();
		pset.setParameter("PEOPLE_ID", peopleId);
		DataSet ds = service.queryBptPeople(pset);
		if (ds.getCount() > 0) {
			String code = "";
			String object_type = ((BptPeople) ds.getRecord(0).toBean(
					BptPeople.class)).getDisabilityTypeCode();
			if ("11".equals(object_type)) {
				codeNum = "鲁军";
				//生成新的证书编号
				Map map = new HashMap();
				map.put("3701","A");
				map.put("3702","B");
				map.put("3703","C");
				map.put("3704","D");
				map.put("3705","E");
				map.put("3706","F");
				map.put("3707","G");
				map.put("3708","H");
				map.put("3709","J");
				map.put("3710","K");
				map.put("3711","L");
				map.put("3712","S");
				map.put("3713","Q");
				map.put("3714","N");
				map.put("3715","P");
				map.put("3716","M");
				map.put("3717","R");
				
				String flag = (String)map.get(domicileCode.substring(0, 4));
				code = flag.toUpperCase()+MaxValueUtil.nextStringValue("BPT_DISBILITY_NO_"+flag.toUpperCase());
				
				
				BptPeopleDisability disability = (BptPeopleDisability) disabilityService
						.queryBptPeopleDisability(pset).getRecord(0).toBean(
								BptPeopleDisability.class);
				disability.setOldDisabilityNo("0");
				disability.setRenewalDate(DateUtil.getDay());
				disabilityService.updatePeopleDisability(disability);
				//code = MaxValueUtil.nextStringValue("BPT_DISBILITY_NO");
			} else if ("12".equals(object_type)) {
				codeNum = "鲁工";
				code = MaxValueUtil.nextStringValue("BPT_DISBILITY_NO_LG");
			} else if ("13".equals(object_type)) {
				codeNum = "鲁警";
				code = MaxValueUtil.nextStringValue("BPT_DISBILITY_NO_LJ");
			} else if ("14".equals(object_type) || "15".equals(object_type)) {
				codeNum = "鲁民";
				code = MaxValueUtil.nextStringValue("BPT_DISBILITY_NO_LM");
			}
			codeNum += code;
		}
		return codeNum;
	}

	/**
	 * 流程完成后更新人员基本信息以及评残调残信息
	 */
	@Trans
	public void updateInfo(String state) {
		String peopleId = (String) getParameter("peopleId");
		String object_type = (String) getParameter("serviceType"); // 业务类型
		Record record = (Record) getParameter("record");

		ParameterSet pset = new ParameterSet();
		pset.setParameter("PEOPLE_ID", peopleId);

		BaseinfoPeople baseinfoPeople = (BaseinfoPeople) service.queryPeople(
				pset).getRecord(0).toBean(BaseinfoPeople.class);
		BptPeopleDisability disability = (BptPeopleDisability) disabilityService
				.queryBptPeopleDisability(pset).getRecord(0).toBean(
						BptPeopleDisability.class);
		if ("2".equals(state)) {
			//findCommNo(peopleId);
			String caseCode = (String) record.get("provinceVerifyDisabilityNat");
			String levelCode = (String) record.get("provinceLevel");
			disability.setDisabilityCaseCode(caseCode);
			disability.setDisabilityLevelCode(levelCode);
			baseinfoPeople.setDisabilityLevelCode(levelCode);
			baseinfoPeople.setDisabilityCaseCode(caseCode);
		}
		if ("11".equals(object_type)) {// 评残
			baseinfoPeople.setDisabilityStateCode(state);// 设置状态
			if ("2".equals(state)) {
				String disabilityNo = findCommNo(peopleId,baseinfoPeople.getDomicileCode());
				if (!"".equals(disabilityNo)) {
					baseinfoPeople.setDisabilityNo(disabilityNo);
				}
				
			}
			disability.setApproveDate(DateUtil.getDay());
			insertStateChange(baseinfoPeople,"1",state,"11");
		} else if ("12".equals(object_type)) {// 调残
			// baseinfoPeople.setDisabilityStateCode(state);// 设置状态
			disability.setApproveDate(DateUtil.getDay());
			
		} else if ("14".equals(object_type)) {//退役军人伤残抚恤关系迁入
			baseinfoPeople.setDisabilityStateCode(state);// 设置状态
			if ("2".equals(state)) {
				disability.setApproveDate(DateUtil.getDay());
				/*String disabilityNo = findCommNo(peopleId);
				if (!"".equals(disabilityNo)) {
					baseinfoPeople.setDisabilityNo(disabilityNo);
				}*/
				
			}
			insertStateChange(baseinfoPeople,"1",state,"14");
		}
		service.updateBaseinfoPeople(baseinfoPeople); // 修改人员基本信息
		disabilityService.updatePeopleDisability(disability);
	}
	/**
	 * 添加状态变更表数据
	 * @param baseinfoPeople
	 * @param prestate
	 * @param endstate
	 * @param serviceType
	 */
	public void insertStateChange(BaseinfoPeople baseinfoPeople ,String prestate,String endstate,String serviceType){
		// 状态变更接口
		 IBptStateChangeDomain stateChangeService = ScaComponentFactory
				.getService(IBptStateChangeDomain.class,
						"bptStateChangeDomain/bptStateChangeDomain");
		BptStateChange bptStateChange = new BptStateChange();
		bptStateChange.setStateChangeId(IdHelp.getUUID30());
		bptStateChange.setPeopleId(baseinfoPeople.getPeopleId());
		/*String domiclile = baseinfoPeople.getDomicileCode();
		String outDomiclieCode = domiclile.substring(0, 6) + "000000";
		String outDomiclieCodeName = BptApplyEmigrationCommand
				.queryDomicileCodeName(outDomiclieCode);*/

		bptStateChange.setIdCard(baseinfoPeople.getIdCard());
		bptStateChange.setName(baseinfoPeople.getName());
		/*bptStateChange.setOutDomicileCode(outDomiclieCode);
		bptStateChange.setOutDomicileCodeName(outDomiclieCodeName);*/
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
	 * 创建并发起伤残业务流程
	 */
	@SuppressWarnings("unchecked")
	@Trans
	public void createAndSend() {
		String applyId;
		String serviceType = null;
		String peopleId;
		Record record = (Record) getParameter("record");
		ParameterSet pset = getParameterSet();
		String condition = (String) getParameter("condition");

		if (record != null && !"".equals(record)) {
			serviceType = (String) record.get("SERVICE_TYPE");
			peopleId = (String) record.get("PEOPLE_ID");
			applyId = (String) record.get("APPLY_ID");
		} else {
			serviceType = (String) getParameter("serviceType");
			applyId = (String) getParameter("applyId");
			peopleId = (String) getParameter("peopleId");

		}
		String serviceName = "";
		String bussinessType = "";
		if ("12".equals(serviceType)) { // 伤残人员调残
			serviceName = "的调残业务申请";
			bussinessType = BptConstant.BPT_DISABILITY_ADJUST;
		} else if ("13".equals(serviceType)) { // 伤残人员换证补证
			serviceName = "的伤残换证(补证)业务申请";
			bussinessType = BptConstant.BPT_DISABILITY_EXCHANGECERTIFICATE;
		} else if ("14".equals(serviceType)) { // 退役军人伤残抚恤关系迁入
			serviceName = "的退役残疾军人抚恤关系迁移申请";
			bussinessType = BptConstant.BPT_DISABILITY_VETERANSSHIFT;
		} else if ("18".equals(serviceType)) {// 伤残人员证件变更
			serviceName = "的伤残证件变更业务申请";
			bussinessType = BptConstant.BPT_DISABILITY_CHANGECERTIFICATE;
		}

		// 向表BPT_APPLY_DISABILITY表中更新记录【审批表】
		pset.clear();
		pset.setParameter("APPLY_ID", applyId);
		BptApplyDisability bptApplyDisabilityBean = (BptApplyDisability) applyDisabilityService
				.query(pset).getRecord(0).toBean(BptApplyDisability.class);
		bptApplyDisabilityBean.setCommitFlag(BptConstant.COMMIT_FLAG);
		bptApplyDisabilityBean.setApproveDate(DateUtil.getDay());
		bptApplyDisabilityBean.setApproveOrganId(BspUtil.getCorpOrgan()
				.getOrganName());
		bptApplyDisabilityBean.setTownCheckDate(DateUtil.getDay());
		bptApplyDisabilityBean.setTownCheckPeopleId(BspUtil.getEmpOrganId());
		/*
		 * if("12".equals(serviceType)) { // 伤残人员调残 添加原残疾等级性质
		 * bptApplyDisabilityBean.setOldDisabilityLevel((String)record.get("DISABILITY_LEVEL_CODE"));
		 * bptApplyDisabilityBean.setOldDisabilityNature((String)record.get("DISABILITY_CASE_CODE")); }
		 */
		applyDisabilityService.update(bptApplyDisabilityBean);

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
		
		String procDefUniqueId = null;
		// 调用创建并发送流程接口
		if ("13".equals(serviceType)) {//伤残人员换证补证
			procDefUniqueId = "8a898bd733632c560133632c56de0000";
		} else if ("14".equals(serviceType)) {//退役军人伤残抚恤关系迁入
			procDefUniqueId = "8a898bd7339fdfe601339fe06e3c0001";
		} else {//伤残人员调残										
			procDefUniqueId = "402881e435dc179d0135dc2275f90142";
		}
		// 通过流程唯一ID获得流程第一个环节ID
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
				.createAndSend(applyId, currentOrganName + serviceName, context);
		// Map map=WfTaskRequestWrapper.getInstance().createAndSendByProcDefId(
		// "E4D0F11846114A14108168B1587A3D6E","act1", "业务主键id1",
		// "new区县的配置伤残器械申请");
		String processId = map.get("processId");

		// 向表WF_PROCESS_BUSINESS【流程与业务关联表】表中添加一条记录

		WfProcessBusiness wfProcessBusiness = new WfProcessBusiness();
		wfProcessBusiness.setProcessId(processId);
		wfProcessBusiness.setBusinessId(applyId);
		wfProcessBusiness.setConnectId(peopleId);
		wfProcessBusiness.setBusinessType(bussinessType);
		wfProcessBusiness.setIfback("n");
		wfProcessBusinessService.insert(wfProcessBusiness);
	}

	/**
	 * 回退流程
	 */
	@Trans
	public void back() {
		update();

		insertBptApplyHistory(); // 添加审批记录

		// 调用工作流回退接口
		WfTaskRequestWrapper.getInstance().back();

		// 修改是否被退回标示为y（退回）
		ParameterSet pset = new ParameterSet();
		pset.setParameter("applyId", (String) getParameter("applyId"));
		pset.setParameter("ifback", "y");
		wfProcessBusinessService.updateIfback(pset);
	}

	/**
	 * 根据身份证号查询人员信息和伤残信息
	 */
	@SuppressWarnings("unchecked")
	public void queryDataSetByPeopleId() {
		ParameterSet pset = getParameterSet();
		DataSet peopleDataSet = service.queryPeople(pset);
		Record peopleRecord = peopleDataSet.getRecord(0);
		String peopleId = pset.getParameter("PEOPLE_ID").toString();
		String familyId = peopleRecord.get("familyId").toString();
		setReturn("familyId", familyId);
		String name = peopleRecord.get("name").toString();
		String sex = peopleRecord.get("sex").toString();
		String nation = peopleRecord.get("nation").toString();
		String birthday = peopleRecord.get("birthday").toString();
		String apanageCode = peopleRecord.get("apanageCode").toString();
		String domicileCode = peopleRecord.get("domicileCode").toString();

		setReturn("name", name);
		setReturn("sex", sex);
		setReturn("nation", nation);
		setReturn("birthday", birthday);
		if (peopleRecord.get("address") != null) {
			String address = peopleRecord.get("address").toString();
			setReturn("address", address);
		}
		if (peopleRecord.get("domicileAddress") != null) {
			String domicileAddress = peopleRecord.get("domicileAddress")
					.toString();
			setReturn("domicileAddress", domicileAddress);
		}
		if (peopleRecord.get("disabilityNo") != null) {
			String disabilityNo = peopleRecord.get("disabilityNo").toString();
			setReturn("disabilityNo", disabilityNo);
		}

		pset.clear();
		pset.setParameter("PEOPLE_ID", peopleId);
		DataSet bptPeopleDataSet = bptPeopleService.query(pset);
		String disabilityTypeCode = bptPeopleDataSet.getRecord(0).get(
				"disabilityTypeCode").toString();
		setReturn("disabilityTypeCode", disabilityTypeCode);

		// 通过apanageCode获取domicileName
		EntityDao<DicCity> dao = (EntityDao<DicCity>) DaoFactory
				.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
		pset.clear();
		pset.setParameter("ID", apanageCode);
		DataSet apanageCodeDataSet = dao.query(pset);
		Record apanageCodeRecord = apanageCodeDataSet.getRecord(0);
		String apanageName = apanageCodeRecord.get("name").toString();
		setReturn("apanageName", apanageName);
		// 通过domicileCode获取domicileName
		EntityDao<DicCity> dao1 = (EntityDao<DicCity>) DaoFactory
				.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
		pset.clear();
		pset.setParameter("ID", domicileCode);
		DataSet domicileCodeDataSet = dao1.query(pset);
		Record domicileCodeRecord = domicileCodeDataSet.getRecord(0);
		String domicileName = domicileCodeRecord.get("name").toString();
		setReturn("domicileName", domicileName);

		pset.clear();
		pset.setParameter("PEOPLE_ID", peopleId);
		DataSet disabilityDataSet = disabilityService
				.queryBptPeopleDisability(pset);
		Record disabilityRecord = disabilityDataSet.getRecord(0);

		if (disabilityRecord.get("conscriptDate") != null) {
			String conscriptDate = disabilityRecord.get("conscriptDate") == null ? ""
					: disabilityRecord.get("conscriptDate").toString();
			String veteransDate = disabilityRecord.get("veteransDate") == null ? ""
					: disabilityRecord.get("veteransDate").toString();
			String retiredDate = disabilityRecord.get("retiredDate") == null ? ""
					: disabilityRecord.get("retiredDate").toString();
			String disabilityGenusCode = disabilityRecord
					.get("disabilityGenusCode") == null ? "" : disabilityRecord
					.get("disabilityGenusCode").toString();
			String disabilityCaseCode = disabilityRecord
					.get("disabilityCaseCode") == null ? "" : disabilityRecord
					.get("disabilityCaseCode").toString();
			String disabilityLevelCode = disabilityRecord
					.get("disabilityLevelCode") == null ? "" : disabilityRecord
					.get("disabilityLevelCode").toString();
			String approveDate = disabilityRecord.get("approveDate") == null ? ""
					: disabilityRecord.get("approveDate").toString();
			String disabilityWarCode = disabilityRecord
					.get("disabilityWarCode") == null ? "" : disabilityRecord
					.get("disabilityWarCode").toString();
			String uinitOfDisability = disabilityRecord
					.get("uinitOfDisability") == null ? "" : disabilityRecord
					.get("uinitOfDisability").toString();
			String disabilityDate = disabilityRecord.get("disabilityDate") == null ? ""
					: disabilityRecord.get("disabilityDate").toString();
			String disabilityAdd = disabilityRecord.get("disabilityAdd") == null ? ""
					: disabilityRecord.get("disabilityAdd").toString();
			String disabilityBody = disabilityRecord.get("disabilityBody") == null ? ""
					: disabilityRecord.get("disabilityBody").toString();
			String disabilityReason = disabilityRecord.get("disabilityReason") == null ? ""
					: disabilityRecord.get("disabilityReason").toString();
			setReturn("conscriptDate", conscriptDate);
			setReturn("approveDate", approveDate);
			setReturn("veteransDate", veteransDate);
			setReturn("retiredDate", retiredDate);
			setReturn("disabilityGenusCode", disabilityGenusCode);
			setReturn("disabilityWarCode", disabilityWarCode);
			setReturn("disabilityCaseCode", disabilityCaseCode);
			setReturn("disabilityLevelCode", disabilityLevelCode);
			setReturn("uinitOfDisability", uinitOfDisability);
			setReturn("disabilityDate", disabilityDate);
			setReturn("disabilityAdd", disabilityAdd);
			setReturn("disabilityBody", disabilityBody);
			setReturn("disabilityReason", disabilityReason);

		}
	}

	/**
	 * 根据peopleId 获得伤残等级和伤残性质
	 */
	public void queryByPeopleId() {
		String peopleId = getParameter("peopleId").toString();
		ParameterSet pset = new ParameterSet();
		pset.setParameter("PEOPLE_ID", peopleId);
		Record peopleRecord = service.queryPeople(pset).getRecord(0);
		if (peopleRecord.get("disabilityCaseCode") != null) {
			String disabilityCaseCode = peopleRecord.get("disabilityCaseCode")
					.toString();
			setReturn("disabilityCaseCode", disabilityCaseCode);
		}
		if (peopleRecord.get("disabilityLevelCode") != null) {
			String disabilityLevelCode = peopleRecord
					.get("disabilityLevelCode").toString();
			setReturn("disabilityLevelCode", disabilityLevelCode);
		}
	}

	/**
	 * 删除伤残相关信息
	 * 
	 * @param pset
	 */
	@Trans
	public void deleteAboutDisability() {
		Record[] records = (Record[]) getParameter("records");
		String disType = (String) getParameter("disType");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("disType", disType);
		for (Record record : records) {
			String applyId = (String) record.get("APPLY_ID");
			String peopleId = (String) record.get("PEOPLE_ID");
			pset.setParameter("applyId", applyId);
			pset.setParameter("peopleId", peopleId);
			applyDisabilityService.deleteAboutDisability(pset);
		}
	}
	
	/**
	 * 通过peopleId获取Objecttype
	 */
	public void getObjecttypeByPeopleId(){
		String peopleId = (String)getParameter("peopleId");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("PEOPLE_ID",peopleId);
		String objectType = (String)bptPeopleService.query(pset).getRecord(0).get("disabilityTypeCode");
		this.setReturn("objectType",objectType);
	}
	
	/**
	 * 查询部队退役军人抚恤关系迁移省级审批是否保存
	 */
	public void chkSaveOfBudty(){
		String saveFlag = "";
		ParameterSet pset = getParameterSet();
		BptApplyDisability bean = applyDisabilityService.getBeanByKey(pset);
		String disLevel = bean.getProvinceCheckDisLevel();
		if(disLevel!=null&&!"".equals(disLevel)){
			saveFlag = "1";
			String newDisabilityNo = bean.getNewDisabilityNo();
			String peopleId = bean.getPeopleId();
			pset.clear();
			pset.setParameter("PEOPLE_ID", peopleId);
			BaseinfoPeople peopleBean = (BaseinfoPeople)service.queryPeople(pset).getRecord(0).toBean(BaseinfoPeople.class);
			String idCard = peopleBean.getIdCard();
			String domicileCode = peopleBean.getDomicileCode();
			DicCityDao dao = (DicCityDao)DaoFactory.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
			pset.clear();
			DicCity cCity = dao.get(domicileCode.substring(0, 4)+"00000000");
			DicCity cTown = dao.get(domicileCode.substring(0, 6)+"000000");
			String domicileName = "山东省"+cCity.getName()+cTown.getName();
			setReturn("newDisabilityNo",newDisabilityNo);
			setReturn("idCard",idCard);
			setReturn("domicileName",domicileName);
		}else{
			saveFlag = "0";
		}
		setReturn("saveFlag", saveFlag);
	}
}
