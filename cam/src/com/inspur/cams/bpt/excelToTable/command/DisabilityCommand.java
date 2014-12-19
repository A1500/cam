package com.inspur.cams.bpt.excelToTable.command;

import java.math.BigDecimal;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.data.BptHouseSubsidyInfo;
import com.inspur.cams.bpt.base.data.BptPeople;
import com.inspur.cams.bpt.base.data.BptPeopleDisability;
import com.inspur.cams.bpt.base.domain.IBptBaseinfoPeopleDomain;
import com.inspur.cams.bpt.base.domain.IBptHouseSubsidyInfoDomain;
import com.inspur.cams.bpt.excelToTable.Until;
import com.inspur.cams.bpt.excelToTable.dao.MessageDao;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

public class DisabilityCommand extends BaseAjaxCommand{
	IBptGroupDomain service = ScaComponentFactory.getService(
			IBptGroupDomain.class, "bptGroupDomain/bptGroupDomain");
	
	IBptHouseSubsidyInfoDomain houseService = ScaComponentFactory.getService(IBptHouseSubsidyInfoDomain.class,
	"bptHouseSubsidyInfoDomain/bptHouseSubsidyInfoDomain");
	
	IBptBaseinfoPeopleDomain bpservice = ScaComponentFactory.getService(IBptBaseinfoPeopleDomain.class,
	"bptBaseinfoPeopleDomain/bptBaseinfoPeopleDomain");
	public void idCardIsSame() {
		String idCard = (String) getParameter("idCard");
		MessageDao dao = new MessageDao();
		boolean isSame= dao.idCardIsSame(idCard);
		this.setReturn("isSame", isSame);
	}
	@Trans
	public void saveDisability() {
		String user = (String) getParameter("user");
		MessageDao dao = new MessageDao();
		DataSet ds = dao.queryMarkDatabyUser("bpt_imp_people_disability_make", user);
		
		for (int i=0;i<ds.getCount();i++) {
			saveDisability(ds.getRecord(i));
		}
	}
	@Trans
	public void saveDisability(Record r) {
		String flag = (String)r.get("COMMIT_FLAG");
		if(flag!=null&&"1".equals(flag)){//多重身份时只添加类别信息更新人员信息
			
			ParameterSet pset = new ParameterSet();
			pset.setParameter("ID_CARD", (String)r.get("ID_CARD"));
			DataSet d = bpservice.queryBaseinfoPeople(pset);
			pset.clear();
			if(d.getCount()>0){
				pset.setParameter("PEOPLE_ID", (String)d.getRecord(0).get("peopleId"));
				DataSet dp = service.queryBptPeople(pset);
				if(dp.getCount()>0){
					Record rdp = dp.getRecord(0);
					Record rd = d.getRecord(0);//baseinfo_poeple
					
					BaseinfoPeople baseinfoPeople = (BaseinfoPeople)rd.toBean(BaseinfoPeople.class);
					baseinfoPeople.setName((String)r.get("NAME"));
					baseinfoPeople.setIdCard((String)r.get("ID_CARD"));
					baseinfoPeople.setBirthday((String)r.get("BIRTHDAY"));
					baseinfoPeople.setNation((String)r.get("NATION"));
					baseinfoPeople.setSex((String)r.get("SEX"));
					baseinfoPeople.setRelationshipType((String)r.get("RELATIONSHIP_TYPE"));
					baseinfoPeople.setDomicileType((String)r.get("DOMICILE_TYPE"));
					baseinfoPeople.setDomicileCode((String)r.get("DOMICILE_CODE"));
					baseinfoPeople.setDomicileAddress((String)r.get("DOMICILE_ADDRESS"));
					baseinfoPeople.setApanageCode((String)r.get("APANAGE_CODE"));
					baseinfoPeople.setAddress((String)r.get("ADDRESS"));
					baseinfoPeople.setSafeguardType((String)r.get("SAFEGUARD_TYPE"));
					baseinfoPeople.setMedicalCode((String)r.get("MEDICAL_CODE"));
					baseinfoPeople.setPenSionCode((String)r.get("PEN_SION_CODE"));
					baseinfoPeople.setTelMobile((String)r.get("TEL_MOBILE"));
					baseinfoPeople.setTelOther((String)r.get("TEL_OTHER"));
					baseinfoPeople.setPostCode((String)r.get("POST_CODE"));
					baseinfoPeople.setMarriageCode((String)r.get("MARRIAGE_CODE"));
					baseinfoPeople.setEduCode((String)r.get("EDU_CODE"));;
					baseinfoPeople.setHealthCode((String)r.get("HEALTH_CODE"));
					baseinfoPeople.setPoliticalCode((String)r.get("POLITICAL_CODE"));
					baseinfoPeople.setEmploymentCode((String)r.get("EMPLOYMENT_CODE"));
					String iy =(String)r.get("INCOME_YEAR");
					if("".equals(iy)){
						baseinfoPeople.setIncomeYear(new BigDecimal(iy));
					}
					
					baseinfoPeople.setWorkUnitName((String)r.get("WORK_UNIT_NAME"));
					baseinfoPeople.setWorkUnitCharacter((String)r.get("WORK_UNIT_CHARACTER"));
					baseinfoPeople.setWorkUnitTel((String)r.get("WORK_UNIT_TEL"));
					baseinfoPeople.setWorkUnitAdd((String)r.get("WORK_UNIT_ADD"));
					
					baseinfoPeople.setIdCardType("0");
					baseinfoPeople.setDisabilityNo((String)r.get("DISABILITY_NO"));
					baseinfoPeople.setDisabilityFlag("1");
					baseinfoPeople.setPersonalStatsTag("0");
					baseinfoPeople.setDisabilityStateCode((String)r.get("DISABILITY_STATE_CODE"));
					baseinfoPeople.setPenSionCode((String)r.get("PENSION_CODE"));
					baseinfoPeople.setRegId(BspUtil.getEmpOrganId());
					baseinfoPeople.setRegTime(DateUtil.getTime());
					baseinfoPeople.setModId(BspUtil.getEmpOrganId());
					baseinfoPeople.setModTime(DateUtil.getTime());
					
					BaseinfoFamily baseinfoFamily = getBaseinfoFamily(r);
					baseinfoFamily.setFamilyId(baseinfoPeople.getFamilyId());
					
					BptPeople bptPeople = (BptPeople)rdp.toBean(BptPeople.class);
					bptPeople.setAccountCode((String)r.get("ACCOUNT_CODE"));
					bptPeople.setAccountName((String)r.get("ACCOUNT_NAME"));
					bptPeople.setBank((String)r.get("BANK"));
					bptPeople.setInsanityFlag((String)r.get("INSANITY_FLAG"));
					bptPeople.setOrphanFlag((String)r.get("ORPHAN_FLAG"));
					bptPeople.setOldLonelyFlag((String)r.get("OLD_LONELY_FLAG"));
					bptPeople.setWorkAbilityCode((String)r.get("WORK_ABILITY_CODE"));
					bptPeople.setViabilityCode((String)r.get("VIABILITY_CODE"));
					bptPeople.setSupportPattern((String)r.get("SUPPORT_PATTERN"));
					
					
					bptPeople.setDisabilityTypeCode((String)r.get("DISABILITY_TYPE_CODE"));
					
					
					
					service.update(bptPeople);
					service.updateBaseinfo(baseinfoPeople, baseinfoFamily);
				}
			}
			BptPeopleDisability bptpeopleDisability = getPeopleDisability(r);
			bptpeopleDisability.setPeopleId((String)d.getRecord(0).get("peopleId"));
			bptpeopleDisability.setState(1);
			service.insertBptPeopleDisability(bptpeopleDisability);
		}else{
			String peopleIdRe = IdHelp.getUUID30();
			String familyIdRe = IdHelp.getUUID30();
			BaseinfoPeople baseinfoPeople = getBaseinfoPeople(r);
			BaseinfoFamily baseinfoFamily = getBaseinfoFamily(r);
			BptPeople bptPeople = getBptPeople(r);
			BptPeopleDisability bptpeopleDisability = getPeopleDisability(r);
			BptHouseSubsidyInfo bptHouseSubsidyInfo = getHouseSubsidyInfo(r,baseinfoFamily.getFamilyId());
			baseinfoPeople.setPeopleId(peopleIdRe);
			baseinfoPeople.setFamilyId(familyIdRe);
			baseinfoFamily.setFamilyId(familyIdRe);
			bptPeople.setPeopleId(peopleIdRe);
			bptpeopleDisability.setPeopleId(peopleIdRe);
			service.insertBaseinfo(baseinfoPeople, baseinfoFamily);
			service.insertBptPeople(bptPeople);
			bptpeopleDisability.setState(1);
			service.insertBptPeopleDisability(bptpeopleDisability);
			houseService.insert(bptHouseSubsidyInfo);
		}
	}
	public BptHouseSubsidyInfo getHouseSubsidyInfo(Record r,String familyId){
		BptHouseSubsidyInfo dataBean = (BptHouseSubsidyInfo)Until.toBean(r,BptHouseSubsidyInfo.class);
		dataBean.setHouseSubsidyId(IdHelp.getUUID30());
		dataBean.setFamilyId(familyId);
		return dataBean;
		
	}
	/**
	 * **********************************【获取人员信息】
	 * 【信息采集】*****************************************
	 */
	private BaseinfoPeople getBaseinfoPeople(Record r) {
		BaseinfoPeople bean = (BaseinfoPeople)Until.toBean(r,BaseinfoPeople.class);
		bean.setIdCardType("0");
		bean.setDisabilityFlag("1");
		bean.setPenSionCode((String)r.get("PENSION_CODE"));
		bean.setRedaFlag((String)r.get("REDA_FLAG"));
		bean.setDependantFlag((String)r.get("DEPENDANT_FLAG")
				);
		bean.setDemobilizedFlag((String)r.get("DEMOBILIZED_FLAG")
				);
		bean.setWarFlag((String)r.get("WAR_FLAG"));
		bean.setDisabilityStateCode((String)r.get(
				"DISABILITY_STATE_CODE"));
		bean.setDisabilityLevelCode((String)r.get(
				"DISABILITY_LEVEL_CODE"));
		bean.setDisabilityCaseCode((String)r.get(
				"DISABILITY_CASE_CODE"));
		bean.setDisabilityNo((String)r.get("DISABILITY_NO")
				);
		bean.setRedaStateCode((String)r.get("REDA_STATE_CODE")
				);
		bean.setDependantStateCode((String)r.get(
				"DEPENDANT_STATE_CODE"));
		bean.setDemobilizedStateCode((String)r.get(
				"DEMOBILIZED_STATE_CODE"));
		bean.setWarStateCode((String)r.get("WAR_STATE_CODE")
				);
		bean.setPersonalStatsTag("0");
		bean.setRegId(BspUtil.getEmpOrganId());
		bean.setRegTime(DateUtil.getTime());
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		return bean;
	}
	/**
	 * **********************************【获取人原伤残信息】
	 * 【信息采集】*****************************************
	 */
	private BptPeopleDisability getPeopleDisability(Record r) {
		BptPeopleDisability bean =(BptPeopleDisability)Until.toBean(r, BptPeopleDisability.class);
		bean.setConscriptDate((String)r.get("CONSCRIPT_DATE")
				);
		bean.setVeteransDate((String)r.get("VETERANS_DATE")
				);
		bean.setDisabilityWarCode((String)r.get(
				"DISABILITY_WAR_CODE"));
		bean.setDisabilityLevelCode((String)r.get(
				"DISABILITY_LEVEL_CODE"));
		bean.setDisabilityCaseCode((String)r.get(
				"DISABILITY_CASE_CODE"));
		bean.setDisabilityGenusCode((String)r.get(
				"DISABILITY_GENUS_CODE"));
		bean.setDisabilityDate((String)r.get("DISABILITY_DATE")
				);
		bean.setDisabilityAdd((String)r.get("DISABILITY_ADD")
				);
		bean.setUinitOfDisability((String)r.get(
				"UINIT_OF_DISABILITY"));
		bean.setDisabilityBody((String)r.get("DISABILITY_BODY")
				);
		bean.setDisabilityReason((String)r.get(
				"DISABILITY_REASON"));
		bean.setNote((String)r.get("NOTE"));
		// bean.setCommitFlag("0");
		bean.setToWorkDate((String)r.get("TO_WORK_DATE")
				);
		bean.setRetiredDate((String)r.get("RETIRED_DATE")
				);
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
	private BptPeople getBptPeople(Record r) {
		BptPeople bptPeople = (BptPeople)Until.toBean(r, BptPeople.class);
		
		bptPeople.setInsanityFlag((String)r.get("INSANITY_FLAG")
				);
		bptPeople.setOldLonelyFlag((String)r.get(
				"OLD_LONELY_FLAG"));
		bptPeople.setWorkAbilityCode((String)r.get(
				"WORK_ABILITY_CODE"));
		bptPeople.setWorkAbilityDescribe((String)r.get(
				"WORK_ABILITY_DESCRIBE"));
		bptPeople.setViabilityCode((String)r.get(
				"VIABILITY_CODE"));
		bptPeople.setSupportPattern((String)r.get(
				"SUPPORT_PATTERN"));
		bptPeople.setJobStatusDescribe((String)r.get(
				"JOB_STATUS_DESCRIBE"));
		bptPeople.setBank((String)r.get("BANK"));
		bptPeople.setAccountCode((String)r.get("ACCOUNT_CODE")
				);
		bptPeople.setAccountName((String)r.get("ACCOUNT_NAME")
				);
		bptPeople.setDisabilityTypeCode((String)r.get(
		"DISABILITY_TYPE_CODE"));
		bptPeople.setDemobilizedTyepCode("00");
		bptPeople.setDependantTypeCode("00");
		bptPeople.setRedaTypeCode("00");
		bptPeople.setWarTypeCode("00");
		return bptPeople;
	}
	/**
	 * **********************************【获取家庭信息】
	 * 【信息采集】*****************************************
	 */
	private BaseinfoFamily getBaseinfoFamily(Record r) {
		BaseinfoFamily bean =  (BaseinfoFamily)Until.toBean(r, BaseinfoFamily.class);
		bean.setFamilyName((String)r.get("NAME"));
		bean.setFamilyCardNo((String)r.get("ID_CARD"));
		bean.setDomicileCode((String)r.get("DOMICILE_CODE")
				);
		bean.setApanageCode((String)r.get("APANAGE_CODE"));
		bean.setFamilyCardType("0");
		bean.setFamilyStateFlag("0");
		bean.setRegId(BspUtil.getEmpOrganId());
		bean.setRegTime(DateUtil.getTime());
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		return bean;
	}
	public static void main(String[] args) { 
		//execute();
	}
}
