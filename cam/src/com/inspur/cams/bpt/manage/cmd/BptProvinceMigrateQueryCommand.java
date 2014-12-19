package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.dao.jdbc.BptCountRetiredSoldierDao;
import com.inspur.cams.bpt.base.domain.IBptPeopleMartyrOffspringDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleTestedDomain;
import com.inspur.cams.bpt.base.domain.IBptProvinceMigrateDomain;
import com.inspur.cams.bpt.base.domain.IWfProcessBusinessDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.comm.diccity.data.DicCity;

/**
 * @title:BptDisabilityProvinceMigratQueryCommand
 * @description:优抚人员省内迁移
 * @author:
 * @since:2011-08-04
 * @version:1.0
 */
public class BptProvinceMigrateQueryCommand extends BaseQueryCommand {
	IBptGroupDomain service = ScaComponentFactory.getService(
			IBptGroupDomain.class, "bptGroupDomain/bptGroupDomain");

	/**
	 * 工作流信息的服务接口
	 */
	IWfProcessBusinessDomain processBusinessService = ScaComponentFactory
			.getService(IWfProcessBusinessDomain.class,
					"wfProcessBusinessDomain/wfProcessBusinessDomain");

	/**
	 * 优抚人员省内迁移服务接口
	 */
	IBptProvinceMigrateDomain bptProvinceMigratService = ScaComponentFactory
			.getService(IBptProvinceMigrateDomain.class,
					"BptProvinceMigrateDomain/BptProvinceMigrateDomain");

	/**
	 * 获得参试人员服务接口
	 */
	IBptPeopleTestedDomain bptPeopleTestedService = ScaComponentFactory
			.getService(IBptPeopleTestedDomain.class,
					"bptPeopleTestedDomain/bptPeopleTestedDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return bptProvinceMigratService.query(pset);
	}
	public DataSet query() {
		
		ParameterSet pset = getParameterSet();
		DataSet ds2 = bptProvinceMigratService.query(pset);
		ds2.addField("ingoingName");
		Record rd = ds2.getRecord(0);
		String ingoingCode = rd.get("ingoingCode").toString();
		EntityDao<DicCity> dao = (EntityDao<DicCity>) DaoFactory
				.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
		pset.clear();
		pset.setParameter("ID", ingoingCode);
		String ingoingName = dao.query(pset).getRecord(0).get("name")
				.toString();
		rd.set("ingoingName", ingoingName);
		return new DataSet(rd);
	}
	/**
	 * 根据前台传过来的process_Id或者assignmentId,查询优抚人员省内迁移审批表信息
	 */
	@SuppressWarnings("unchecked")
	@Trans
	public DataSet queryById() {
		ParameterSet pset = getParameterSet();
		DataSet ds = new DataSet();
		if(pset.containsKey("APPLY_ID")) {
			// 取得【迁入地行政区划】名称
			DataSet ds2 = bptProvinceMigratService.query(pset);
			ds2.addField("ingoingName");
			Record rd = ds2.getRecord(0);
			String ingoingCode = rd.get("ingoingCode").toString();
			EntityDao<DicCity> dao = (EntityDao<DicCity>) DaoFactory
					.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
			pset.clear();
			pset.setParameter("ID", ingoingCode);
			String ingoingName = dao.query(pset).getRecord(0).get("name")
					.toString();
			rd.set("ingoingName", ingoingName);
			ds = new DataSet(rd);
		} else {
			if (pset.containsKey("PROCESS_ID")) {
				DataSet ds1 = processBusinessService.query(pset);
				String applyId = (String) ds1.getRecord(0).get("businessId");
				pset.clear();
				pset.setParameter("APPLY_ID", applyId);
				// 取得【迁入地行政区划】名称
				DataSet ds2 = bptProvinceMigratService.query(pset);
				ds2.addField("ingoingName");
				Record rd = ds2.getRecord(0);
				String ingoingCode = rd.get("ingoingCode").toString();
				EntityDao<DicCity> dao = (EntityDao<DicCity>) DaoFactory
						.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
				pset.clear();
				pset.setParameter("ID", ingoingCode);
				String ingoingName = dao.query(pset).getRecord(0).get("name")
						.toString();
				rd.set("ingoingName", ingoingName);
				ds = new DataSet(rd);
			} else {
				String assignmentId = (String) pset.getParameter("assignmentId");
				String processId = processBusinessService
						.getProcessId(assignmentId);
				pset.clear();
				pset.setParameter("PROCESS_ID", processId);
				DataSet ds1 = processBusinessService.query(pset);
				String applyId = (String) ds1.getRecord(0).get("businessId");
				pset.remove("PROCESS_ID");
				pset.setParameter("APPLY_ID", applyId);
				// 取得【迁入地行政区划】名称
				DataSet ds2 = bptProvinceMigratService.query(pset);
				ds2.addField("ingoingName");
				Record rd = ds2.getRecord(0);
				String ingoingCode = rd.get("ingoingCode").toString();
				EntityDao<DicCity> dao = (EntityDao<DicCity>) DaoFactory
						.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
				pset.clear();
				pset.setParameter("ID", ingoingCode);
				String ingoingName = dao.query(pset).getRecord(0).get("name")
						.toString();
				rd.set("ingoingName", ingoingName);
				ds = new DataSet(rd);
			}
		}
		return ds;
	}

	/**
	 * ****************************************************【伤残
	 * START】*******************************************************
	 */
	/**
	 * 查询未提交的伤残人员省内迁移列表
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryUnCommiDisaProvinceEmigrate() {
		ParameterSet pset = getParameterSet();
		return bptProvinceMigratService.queryUnCommiDisaProvinceEmigrate(pset);
	}

	/**
	 * 查询伤残省内迁移审批修改时的记录
	 */
	@Trans
	@SuppressWarnings("unchecked")
	public DataSet queryDisaUpdateRecord() {
		String applyId = getParameter("APPLY_ID").toString();
		String peopleId = getParameter("PEOPLE_ID").toString();
		ParameterSet pset = new ParameterSet();
		pset.setParameter("APPLY_ID", applyId);
		DataSet provinceEmigrateDs = bptProvinceMigratService.query(pset);
		provinceEmigrateDs.addField("ingoingName");
		provinceEmigrateDs.addField("idCard");
		provinceEmigrateDs.addField("name");
		provinceEmigrateDs.addField("sex");
		provinceEmigrateDs.addField("disabilityCaseCode");
		provinceEmigrateDs.addField("disabilityLevelCode");
		provinceEmigrateDs.addField("disabilityNo");
		provinceEmigrateDs.addField("disabilityTypeCode");
		Record provinceEmigrateRd = provinceEmigrateDs.getRecord(0);

		String ingoingCode = provinceEmigrateRd.get("ingoingCode").toString();

		pset.clear();
		pset.setParameter("PEOPLE_ID", peopleId);
		Record peopleRd = service.queryPeople(pset).getRecord(0);
		String name = peopleRd.get("name").toString();
		String idCard = peopleRd.get("idCard").toString();
		String sex = peopleRd.get("sex").toString();
		String disabilityCaseCode = peopleRd.get("disabilityCaseCode")==null?"":peopleRd.get("disabilityCaseCode").toString();
		String disabilityLevelCode = peopleRd.get("disabilityLevelCode")==null?"":peopleRd.get("disabilityLevelCode").toString().toString();
		String disabilityNo = new String();
		if (peopleRd.get("disabilityNo") != null) {
			disabilityNo = peopleRd.get("disabilityNo").toString();
		}
		Record bptRd = service.queryBptPeople(pset).getRecord(0);
		String disabilityTypeCode = bptRd.get("disabilityTypeCode")==null?"":bptRd.get("disabilityTypeCode").toString();

		provinceEmigrateRd.set("ingoingName", BptApplyEmigrationCommand
				.queryDomicileCodeName(ingoingCode));
		provinceEmigrateRd.set("domicileName",
				queryFullDomiName((String) provinceEmigrateRd
						.get("inDomicileCode")));
		provinceEmigrateRd.set("apanageName",
				queryFullDomiName((String) provinceEmigrateRd
						.get("inApanageCode")));

		provinceEmigrateRd.set("idCard", idCard);
		provinceEmigrateRd.set("name", name);
		provinceEmigrateRd.set("sex", sex);
		provinceEmigrateRd.set("disabilityCaseCode", disabilityCaseCode);
		provinceEmigrateRd.set("disabilityLevelCode", disabilityLevelCode);
		provinceEmigrateRd.set("disabilityNo", disabilityNo);
		provinceEmigrateRd.set("disabilityTypeCode", disabilityTypeCode);
		DataSet resultDs = new DataSet(provinceEmigrateRd);
		return resultDs;
	}

	/**
	 * ****************************************************【伤残
	 * END】*******************************************************
	 */
	/** *****************************************************参战查询*********************************************************** */

	/**
	 * 查询未提交的参战人员省内迁移列表
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryUnComWarProvinceEmigrate() {
		ParameterSet pset = super.getParameterSet();
		return bptProvinceMigratService.queryUnComWarProvinceEmigrate(pset);
	}

	public DataSet queryWarDetail() {
		ParameterSet pset = super.getParameterSet();
		return bptProvinceMigratService.queryWarDetail(pset);
	}

	/**
	 * 查询参战省内迁移审批修改时的记录
	 */
	@Trans
	@SuppressWarnings("unchecked")
	public DataSet queryWarUpdateRecord() {
		String applyId = getParameter("APPLY_ID").toString();
		String peopleId = getParameter("PEOPLE_ID").toString();
		ParameterSet pset = new ParameterSet();
		pset.setParameter("APPLY_ID", applyId);
		DataSet provinceEmigrateDs = bptProvinceMigratService.query(pset);
		provinceEmigrateDs.addField("ingoingName");
		provinceEmigrateDs.addField("idCard");
		provinceEmigrateDs.addField("name");
		provinceEmigrateDs.addField("sex");
		provinceEmigrateDs.addField("warTypeCode");
		provinceEmigrateDs.addField("forcesNo");
		provinceEmigrateDs.addField("position");
		provinceEmigrateDs.addField("asdpNo");
		Record provinceEmigrateRd = provinceEmigrateDs.getRecord(0);

		String ingoingCode = provinceEmigrateRd.get("ingoingCode").toString();

		pset.clear();
		pset.setParameter("peopleId", peopleId);
		Record peopleRd = bptProvinceMigratService.queryWarDetailByPeopleId(
				pset).getRecord(0);
		String name = peopleRd.get("NAME").toString();
		String idCard = peopleRd.get("ID_CARD").toString();
		String sex = peopleRd.get("SEX").toString();
		if (peopleRd.get("WAR_TYPE_CODE") != null) {
			String warTypeCode = peopleRd.get("WAR_TYPE_CODE").toString();
			provinceEmigrateRd.set("warTypeCode", warTypeCode);
		}
		if (peopleRd.get("FORCES_NO") != null) {
			String forcesNo = peopleRd.get("FORCES_NO").toString();
			provinceEmigrateRd.set("forcesNo", forcesNo);
		}
		if (peopleRd.get("POSITION") != null) {
			String position = peopleRd.get("POSITION").toString();
			provinceEmigrateRd.set("position", position);
		}
		if (peopleRd.get("ASDP_NO") != null) {
			String asdpNo = peopleRd.get("ASDP_NO").toString();
			provinceEmigrateRd.set("asdpNo", asdpNo);
		}
		provinceEmigrateRd.set("idCard", idCard);
		provinceEmigrateRd.set("name", name);
		provinceEmigrateRd.set("sex", sex);

		provinceEmigrateRd.set("ingoingName", BptApplyEmigrationCommand
				.queryDomicileCodeName(ingoingCode));
		provinceEmigrateRd.set("domicileName",
				queryFullDomiName((String) provinceEmigrateRd
						.get("inDomicileCode")));
		provinceEmigrateRd.set("apanageName",
				queryFullDomiName((String) provinceEmigrateRd
						.get("inApanageCode")));
		DataSet resultDs = new DataSet(provinceEmigrateRd);
		return resultDs;
	}

	/** *****************************************************参战查询*********************************************************** */

	/**
	 * 查询未提交的三属人员省内迁移列表
	 */
	public DataSet queryUnCommiDependProEmigrate() {
		ParameterSet pset = getParameterSet();
		return bptProvinceMigratService.queryUnCommiDependProEmigrate(pset);
	}

	/**
	 * 查询三属省内迁移信息
	 * 
	 * @return
	 */
	public DataSet queryDependentProEmigrate() {
		ParameterSet pset = getParameterSet();
		DataSet depentProEmigrate = bptProvinceMigratService.query(pset); // 三属人员省内迁移信息
		Record record = depentProEmigrate.getRecord(0);
		String peopleId = (String) record.get("peopleId");

		pset.clear();
		pset.setParameter("PEOPLE_ID", peopleId);
		DataSet basePeopleDs = service.queryPeople(pset); // 查询人员基本信息
		DataSet bptDenpendPeopleDs = service.queryDependantInfo(pset); // 查询三属人员基本信息
		DataSet bptPeopleDs = service.queryBptPeople(pset);// 查询优抚信息

		record.set("name", basePeopleDs.getRecord(0).get("name"));
		record.set("sex", basePeopleDs.getRecord(0).get("sex"));
		record.set("idCard", basePeopleDs.getRecord(0).get("idCard"));
		record.set("dependantNo", basePeopleDs.getRecord(0).get("dependantNo"));
		record.set("dependantTypeCode", bptPeopleDs.getRecord(0).get(
				"dependantTypeCode"));
		record.set("relationship", bptDenpendPeopleDs.getRecord(0).get(
				"relationship"));

		String ingoingCode = (String) record.get("ingoingCode");
		record.set("ingoingName", BptApplyEmigrationCommand
				.queryDomicileCodeName(ingoingCode));
		record.set("domicileName", queryFullDomiName((String) record
				.get("inDomicileCode")));
		record.set("apanageName", queryFullDomiName((String) record
				.get("inApanageCode")));
		return depentProEmigrate;
	}

	/** *****************************************************在乡查询【start】*********************************************************** */
	/**
	 * 查询未提交的在乡人员省内迁移列表
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryUnCommiDemoProvinceEmigrate() {
		ParameterSet pset = getParameterSet();
		return bptProvinceMigratService.queryUnCommiDemoProvinceEmigrate(pset);
	}

	/**
	 * 查询在乡省内迁移审批修改时的记录
	 */
	@Trans
	@SuppressWarnings("unchecked")
	public DataSet queryDemoUpdateRecord() {
		String applyId = getParameter("APPLY_ID").toString();
		String peopleId = getParameter("PEOPLE_ID").toString();
		ParameterSet pset = new ParameterSet();
		pset.setParameter("APPLY_ID", applyId);
		DataSet provinceEmigrateDs = bptProvinceMigratService.query(pset);
		provinceEmigrateDs.addField("ingoingName");
		provinceEmigrateDs.addField("idCard");
		provinceEmigrateDs.addField("name");
		provinceEmigrateDs.addField("sex");
		provinceEmigrateDs.addField("warTypeCode");
		provinceEmigrateDs.addField("forcesNo");
		provinceEmigrateDs.addField("position");
		provinceEmigrateDs.addField("asdpNo");
		provinceEmigrateDs.addField("isKoreanwar");
		provinceEmigrateDs.addField("belongDate");
		provinceEmigrateDs.addField("conscriptDate");
		provinceEmigrateDs.addField("decruitmentDate");
		provinceEmigrateDs.addField("apanageName");
		provinceEmigrateDs.addField("nation");
		provinceEmigrateDs.addField("birthday");

		Record provinceEmigrateRd = provinceEmigrateDs.getRecord(0);

		String ingoingCode = provinceEmigrateRd.get("ingoingCode").toString();

		// 查询行政区划
		pset.clear();
		pset.setParameter("PEOPLE_ID", peopleId);
		DataSet peopleDataSet = service.queryPeople(pset);
		Record peopleRecord = peopleDataSet.getRecord(0);
		// 通过apanageCode获取domicileName
		EntityDao<DicCity> dao1 = (EntityDao<DicCity>) DaoFactory
				.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
		pset.clear();
		pset.setParameter("ID", peopleRecord.get("apanageCode").toString());
		DataSet apanageCodeDataSet = dao1.query(pset);
		Record apanageCodeRecord = apanageCodeDataSet.getRecord(0);
		String apanageName = apanageCodeRecord.get("name").toString();

		pset.clear();
		pset.setParameter("peopleId", peopleId);

		Record peopleRd = bptProvinceMigratService.queryDemoDetailByPeopleId(
				pset).getRecord(0);
		String name = peopleRd.get("NAME").toString();
		String idCard = peopleRd.get("ID_CARD").toString();
		String sex = peopleRd.get("SEX").toString();

		if (peopleRd.get("FORCES_NO") != null) {
			String forcesNo = peopleRd.get("FORCES_NO").toString();
			provinceEmigrateRd.set("forcesNo", forcesNo);
		}
		if (peopleRd.get("POSITION") != null) {
			String position = peopleRd.get("POSITION").toString();
			provinceEmigrateRd.set("position", position);
		}
		if (peopleRd.get("ASDP_NO") != null) {
			String asdpNo = peopleRd.get("ASDP_NO").toString();
			provinceEmigrateRd.set("asdpNo", asdpNo);
		}
		if (peopleRd.get("IS_KOREANWAR") != null) {
			String isKoreanwar = peopleRd.get("IS_KOREANWAR").toString();
			provinceEmigrateRd.set("isKoeanwar", isKoreanwar);
		}
		if (peopleRd.get("BELONGDATE") != null) {
			String belongDate = peopleRd.get("BELONGDATE").toString();
			provinceEmigrateRd.set("belongDate", belongDate);
		}
		if (peopleRd.get("CONSCRIPT_DATE") != null) {
			String conscriptDate = peopleRd.get("CONSCRIPT_DATE").toString();
			provinceEmigrateRd.set("conscriptDate", conscriptDate);
		}
		if (peopleRd.get("DECRUITMENT_DATE") != null) {
			String decruitmentDate = peopleRd.get("DECRUITMENT_DATE")
					.toString();
			provinceEmigrateRd.set("decruitmentDate", decruitmentDate);
		}
		if (peopleRd.get("NATION") != null) {
			String nation = peopleRd.get("NATION").toString();
			provinceEmigrateRd.set("nation", nation);
		}
		if (peopleRd.get("BIRTHDAY") != null) {
			String birthday = peopleRd.get("BIRTHDAY").toString();
			provinceEmigrateRd.set("birthday", birthday);
		}
		if (apanageCodeRecord.get("name").toString() != null) {
			provinceEmigrateRd.set("apanageName", apanageName);
		}

		provinceEmigrateRd.set("idCard", idCard);
		provinceEmigrateRd.set("name", name);
		provinceEmigrateRd.set("sex", sex);

		provinceEmigrateRd.set("ingoingName", BptApplyEmigrationCommand
				.queryDomicileCodeName(ingoingCode));
		provinceEmigrateRd.set("domicileName",
				queryFullDomiName((String) provinceEmigrateRd
						.get("inDomicileCode")));
		provinceEmigrateRd.set("apanageName",
				queryFullDomiName((String) provinceEmigrateRd
						.get("inApanageCode")));
		DataSet resultDs = new DataSet(provinceEmigrateRd);
		return resultDs;
	}

	/** *****************************************************在乡查询【end】*********************************************************** */

	/**
	 * 查询在乡省内迁移审批修改时的记录
	 */
	public DataSet queryIllDemoInfo() {
		ParameterSet pset = getParameterSet();
		DataSet depentProEmigrate = bptProvinceMigratService.query(pset); // 三属人员省内迁移信息
		Record record = depentProEmigrate.getRecord(0);
		String peopleId = (String) record.get("peopleId");

		pset.clear();
		pset.setParameter("PEOPLE_ID", peopleId);
		DataSet basePeopleDs = service.queryPeople(pset); // 查询人员基本信息

		record.set("name", basePeopleDs.getRecord(0).get("name"));
		record.set("sex", basePeopleDs.getRecord(0).get("sex"));
		record.set("idCard", basePeopleDs.getRecord(0).get("idCard"));
		record.set("nation", basePeopleDs.getRecord(0).get("nation"));
		record.set("demobilizedStateCode", basePeopleDs.getRecord(0).get(
				"demobilizedStateCode"));
		record.set("birthday", basePeopleDs.getRecord(0).get("birthday"));
		record.set("demobilizedNo", basePeopleDs.getRecord(0).get(
				"demobilizedNo"));

		String ingoingCode = (String) record.get("ingoingCode");
		record.set("ingoingName", BptApplyEmigrationCommand
				.queryDomicileCodeName(ingoingCode));
		record.set("domicileName", queryFullDomiName((String) record
				.get("inDomicileCode")));
		record.set("apanageName", queryFullDomiName((String) record
				.get("inApanageCode")));

		return depentProEmigrate;
	}

	/**
	 * 查询未提交的参试人员省内迁移列表
	 */
	public DataSet queryUncommitTestProvin() {
		ParameterSet pset = getParameterSet();
		return bptProvinceMigratService.queryUncommitTestProEmigrate(pset);
	}

	/**
	 * 查询参试人员省内迁移详细信息
	 */
	public DataSet queryTestedProEmigrate() {
		ParameterSet pset = getParameterSet();
		DataSet testedProEmigrate = bptProvinceMigratService.query(pset); //三属人员省内迁移信息
		Record record = testedProEmigrate.getRecord(0);
		String peopleId = (String)record.get("peopleId");
		
		pset.clear();
		pset.setParameter("PEOPLE_ID", peopleId);
		DataSet basePeopleDs = service.queryPeople(pset); //查询人员基本信息
		DataSet testedDs = bptPeopleTestedService.queryPeopleTested(pset); //查询参试人员基本信息
		
		if(basePeopleDs.getCount() != 0 && testedDs.getCount() != 0) {
			Record recordPeople = basePeopleDs.getRecord(0);
			Record recordTested = testedDs.getRecord(0);
			record.set("name", recordPeople.get("name"));
			record.set("sex", recordPeople.get("sex"));
			record.set("idCard", recordPeople.get("idCard"));
			record.set("testedType", recordTested.get("testedType"));
			record.set("position", recordTested.get("position"));

			String ingoingCode = (String)record.get("ingoingCode");
			record.set("ingoingName", BptApplyEmigrationCommand.queryDomicileCodeName(ingoingCode));
			record.set("domicileName", queryFullDomiName((String)record.get("inDomicileCode")));
			record.set("apanageName", queryFullDomiName((String)record.get("inApanageCode")));
		}
		return testedProEmigrate;
	}
	
	/**
	 * 查询平反人员省内迁移详细信息
	 */
	public DataSet queryMartyProEmigrate() {
		ParameterSet pset = getParameterSet();
		DataSet mProEmigrate = bptProvinceMigratService.query(pset); 
		Record record = mProEmigrate.getRecord(0);
		String peopleId = (String)record.get("peopleId");
		
		pset.clear();
		pset.setParameter("PEOPLE_ID", peopleId);
		DataSet basePeopleDs = service.queryPeople(pset); //查询人员基本信息
		IBptPeopleMartyrOffspringDomain martyrOffspringDomain = (IBptPeopleMartyrOffspringDomain)ScaComponentFactory.getService(IBptPeopleMartyrOffspringDomain.class, "bptPeopleMartyrOffspringDomain/bptPeopleMartyrOffspringDomain");
		DataSet mDs = martyrOffspringDomain.query(pset); 
		
		if(basePeopleDs.getCount() != 0 && mDs.getCount() != 0) {
			Record recordPeople = basePeopleDs.getRecord(0);
			Record recordMarty = mDs.getRecord(0);
			record.set("name", recordPeople.get("name"));
			record.set("sex", recordPeople.get("sex"));
			record.set("idCard", recordPeople.get("idCard"));
			record.set("lezswApproveDate", recordMarty.get("lezswApproveDate"));
			record.set("statusType", recordMarty.get("statusType"));
			record.set("lezswName", recordMarty.get("lezswName"));

			String ingoingCode = (String)record.get("ingoingCode");
			record.set("ingoingName", BptApplyEmigrationCommand.queryDomicileCodeName(ingoingCode));
			record.set("domicileName", queryFullDomiName((String)record.get("inDomicileCode")));
			record.set("apanageName", queryFullDomiName((String)record.get("inApanageCode")));
		}
		return mProEmigrate;
	}
	/**
	 * 查询60退役士兵人员省内迁移详细信息
	 */
	public DataSet querySoldierProEmigrate() {
		ParameterSet pset = getParameterSet();
		DataSet mProEmigrate = bptProvinceMigratService.query(pset); 
		Record record = mProEmigrate.getRecord(0);
		String peopleId = (String)record.get("peopleId");
		
		pset.clear();
		pset.setParameter("PEOPLE_ID", peopleId);
		DataSet basePeopleDs = service.queryPeople(pset); //查询人员基本信息
		BptCountRetiredSoldierDao dao = (BptCountRetiredSoldierDao) DaoFactory.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptCountRetiredSoldierDao");
		DataSet mDs = dao.query(pset); 
		if(basePeopleDs.getCount() != 0 && mDs.getCount() != 0) {
			Record recordPeople = basePeopleDs.getRecord(0);
			Record recordMarty = mDs.getRecord(0);
			record.set("name", recordPeople.get("name"));
			record.set("sex", recordPeople.get("sex"));
			record.set("idCard", recordPeople.get("idCard"));
			
			record.set("conscriptDate", recordMarty.get("conscriptDate"));
			record.set("decruitmentDate", recordMarty.get("decruitmentDate"));
			record.set("retiredNo", recordMarty.get("retiredNo"));
			record.set("forcesName", recordMarty.get("forcesName"));
			record.set("forcesNo", recordMarty.get("forcesNo"));
			record.set("soldierStartDate", recordMarty.get("soldierStartDate"));
			record.set("soldierEndDate", recordMarty.get("soldierEndDate"));
			record.set("soldierYears", recordMarty.get("soldierYears"));
			
			String ingoingCode = (String)record.get("ingoingCode");
			record.set("ingoingName", BptApplyEmigrationCommand.queryDomicileCodeName(ingoingCode));
			record.set("domicileName", queryFullDomiName((String)record.get("inDomicileCode")));
			record.set("apanageName", queryFullDomiName((String)record.get("inApanageCode")));
		}
		return mProEmigrate;
	}
	/**
	 * 获得省内行政区划详细地址（name）
	 * 
	 * @param code
	 * @return
	 */
	public static String queryFullDomiName(String code) {
		EntityDao<DicCity> dao = (EntityDao<DicCity>) DaoFactory
				.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
		ParameterSet pset = new ParameterSet();
		String dominame = "";
		if (code != null && !("".equals(code))) {
			String city = code.substring(0, 4) + "00000000"; // 市区code
			if (!city.equals(code)) {
				pset.setParameter("ID", city);
				dominame += dao.query(pset).getRecord(0).get("name");
			}

			String town = code.substring(0, 6) + "000000";// 县区code
			if (!town.equals(code)) {
				pset.setParameter("ID", town);
				dominame += dao.query(pset).getRecord(0).get("name");
			}

			String road = code.substring(0, 9) + "000"; // 街道
			if (!road.equals(code)) {
				pset.setParameter("ID", road);
				dominame += dao.query(pset).getRecord(0).get("name");
			}

			pset.setParameter("ID", code); // 社区
			dominame += dao.query(pset).getRecord(0).get("name");
		}

		return dominame;
	}
	
	
	/**
	 * 查询其他抚恤关系省内迁移列表
	 * @return
	 */
	public DataSet queryProvinceEmigrate() {
		ParameterSet pset = getParameterSet();
		return bptProvinceMigratService.queryProvinceEmigrate(pset);
	}
}
