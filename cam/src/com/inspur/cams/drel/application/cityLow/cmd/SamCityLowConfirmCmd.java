package com.inspur.cams.drel.application.cityLow.cmd;

import java.math.BigDecimal;
import java.util.Map;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.data.StatefulDatabean;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.baseinfo.domain.IBaseinfoDomain;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.RecordToBeanUtil;
import com.inspur.cams.drel.application.cityLow.data.CityLowFamilyInfo;
import com.inspur.cams.drel.application.cityLow.data.CityLowPeopleInfo;
import com.inspur.cams.drel.application.cityLow.data.SamLowApplyInfo;
import com.inspur.cams.drel.application.cityLow.data.SamLowPeopleIncome;
import com.inspur.cams.drel.application.cityLow.data.SamLowPeopleProperty;
import com.inspur.cams.drel.application.cityLow.data.SamLowSupportPeople;
import com.inspur.cams.drel.application.cityLow.domain.ISamLowApplyInfoDomain;
import com.inspur.cams.drel.application.cityLow.domain.ISamLowPeopleIncomeDomain;
import com.inspur.cams.drel.application.cityLow.domain.ISamLowPeoplePropertyDomain;
import com.inspur.cams.drel.application.cityLow.domain.ISamLowSupportPeopleDomain;
import com.inspur.cams.sorg.check.manage.trans;
import com.sun.corba.se.spi.orbutil.fsm.State;

/**城市低收入申请审核审批**/
public class SamCityLowConfirmCmd extends BaseAjaxCommand{
	
	// 获取SCA组件
	
	private IBaseinfoDomain service = ScaComponentFactory.getService(IBaseinfoDomain.class, "baseinfoDomain/baseinfoDomain");
	private ISamLowApplyInfoDomain applyInfservice = ScaComponentFactory.getService(ISamLowApplyInfoDomain.class, "samLowApplyInfoDomain/samLowApplyInfoDomain");
	private ISamLowPeopleIncomeDomain incomeService = ScaComponentFactory.getService(ISamLowPeopleIncomeDomain.class, "samLowPeopleIncomeDomain/samLowPeopleIncomeDomain");
	private ISamLowPeoplePropertyDomain propertyService = ScaComponentFactory.getService(ISamLowPeoplePropertyDomain.class, "samLowPeoplePropertyDomain/samLowPeoplePropertyDomain");
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		BaseinfoFamily dataBean=(BaseinfoFamily)record.toBean(BaseinfoFamily.class);
		String familyId = dataBean.getFamilyId();
		if(familyId==null||familyId.length()<=0||familyId.equals("null")){
			familyId=IdHelp.getUUID32();
			dataBean.setFamilyId(familyId);			
		}
		String apanageCode = dataBean.getApanageCode();
		String province = apanageCode.substring(0, 2)+"0000000000";
		String city= apanageCode.substring(0, 4)+"00000000";
		String county= apanageCode.substring(0, 6)+"000000";
		String town= apanageCode.substring(0, 9)+"000";
		String village = apanageCode;
		
		dataBean.setProvince(province);
		dataBean.setCity(city);
		dataBean.setCounty(county);
		dataBean.setTown(town);
		dataBean.setVillage(village);
		
		service.insertFamily(dataBean);
		insertConfirmInfo(familyId,dataBean);
		setReturn("familyId", familyId);
	}
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		BaseinfoFamily dataBean=(BaseinfoFamily)record.toBean(BaseinfoFamily.class);
		String apanageCode = dataBean.getApanageCode();
		String province = apanageCode.substring(0, 2)+"0000000000";
		String city= apanageCode.substring(0, 4)+"00000000";
		String county= apanageCode.substring(0, 6)+"000000";
		String town= apanageCode.substring(0, 9)+"000";
		String village = apanageCode;
		
		dataBean.setProvince(province);
		dataBean.setCity(city);
		dataBean.setCounty(county);
		dataBean.setTown(town);
		dataBean.setVillage(village);
		service.updateFamily(dataBean);
		//涉及到家主的信息变化
		Record jiazhuRecord = (Record) getParameter("jiazhuRecord");
		
		BaseinfoPeople jiazhu=(BaseinfoPeople)jiazhuRecord.toBean(BaseinfoPeople.class);
		
		jiazhu.setSex(dataBean.getSex());
		jiazhu.setNation(dataBean.getNation());
		service.updatePeople(jiazhu);
		
		upDateConfirmInfo();
	}
	@Trans
	public void insertConfirmInfo(String familyId,BaseinfoFamily family) {
		Record record = (Record) getParameter("lowApplyRecord");
		SamLowApplyInfo sai = (SamLowApplyInfo)record.toBean(SamLowApplyInfo.class);
		sai.setFamilyId(familyId);
		sai.setFamilyName(family.getFamilyName());
		sai.setFamilyCardType(family.getFamilyCardType());
		sai.setFamilyCardNo(family.getFamilyCardNo());
		sai.setLowApplyId(IdHelp.getUUID32());
		
		applyInfservice.insert(sai);
	}
	@Trans
	public void upDateConfirmInfo() {
		Record record = (Record) getParameter("lowApplyRecord");
		SamLowApplyInfo samLowApplyInfo = (SamLowApplyInfo)record.toBean(SamLowApplyInfo.class);
		applyInfservice.update(samLowApplyInfo);
	}
	
	@Trans
	public void delete() {
		String delId = (String)getParameter("delId");
		service.deleteFamily(delId);
	}
	@Trans
	public void batchDelete() {
		String[] delIds = (String[])getParameter("delIds");
		//service.batchDeleteFamily(delIds);
		incomeService.batchDeleteFamilyAll(delIds);
	}
	
	
	//家庭成员的增改
	@Trans
	public void insertPeople(){
		Record peopleRecord = (Record) getParameter("peopleRecord");
		BaseinfoPeople baseinfoPeople=(BaseinfoPeople)peopleRecord.toBean(BaseinfoPeople.class);
		String familyId =baseinfoPeople.getFamilyId();
		String peopleId = service.insertPeople(baseinfoPeople);

		SamLowPeopleIncome income = new SamLowPeopleIncome();
		SamLowPeopleProperty property = new SamLowPeopleProperty();
		
		income.setIncomeId(IdHelp.getUUID32());
		income.setPeopleId(peopleId);
		BigDecimal salaryIncome = new BigDecimal((String)peopleRecord.get("salaryIncome"));
		BigDecimal manageIncome = new BigDecimal((String)peopleRecord.get("manageIncome"));
		BigDecimal propertyIncome = new BigDecimal((String)peopleRecord.get("propertyIncome"));
		BigDecimal transferIncome = new BigDecimal((String)peopleRecord.get("transferIncome"));
		BigDecimal otherIncome = new BigDecimal((String)peopleRecord.get("otherIncome"));
		BigDecimal totalIncome=salaryIncome.add(manageIncome).add(propertyIncome).add(transferIncome).add(otherIncome);
		income.setSalaryIncome(salaryIncome);
		income.setManageIncome(manageIncome);
		income.setPropertyIncome(propertyIncome);
		income.setTransferIncome(transferIncome);
		income.setOtherIncome(otherIncome);
		income.setTotalIncome(totalIncome);
		incomeService.insert(income);
		
		property.setPeopleId(peopleId);
		property.setPropertyId(IdHelp.getUUID32());
		BigDecimal bankStockProperty = new BigDecimal((String)peopleRecord.get("bankStockProperty"));
		BigDecimal bondProperty = new BigDecimal((String)peopleRecord.get("bondProperty"));
		BigDecimal otherProperty = new BigDecimal((String)peopleRecord.get("otherProperty"));
		BigDecimal total = bankStockProperty.add(bondProperty).add(otherProperty);
		property.setBankStockProperty(bankStockProperty);
		property.setBondProperty(bondProperty);
		property.setOtherProperty(otherProperty);
		property.setTotalProperty(total);
		
		propertyService.insert(property);
		updateFamilyInfo(familyId,"");
	}
	
	@Trans
	public void updatePeople(){
		Record peopleRecord = (Record) getParameter("peopleRecord");
		BaseinfoPeople baseinfoPeople=(BaseinfoPeople)peopleRecord.toBean(BaseinfoPeople.class);
		String familyId =baseinfoPeople.getFamilyId();
		service.updatePeople(baseinfoPeople);

		SamLowPeopleIncome income = new SamLowPeopleIncome();
		SamLowPeopleProperty property = new SamLowPeopleProperty();
		
		income.setIncomeId((String)peopleRecord.get("incomeId"));
		income.setPeopleId((String)peopleRecord.get("peopleId"));
		BigDecimal salaryIncome = new BigDecimal((String)peopleRecord.get("salaryIncome"));
		BigDecimal manageIncome = new BigDecimal((String)peopleRecord.get("manageIncome"));
		BigDecimal propertyIncome = new BigDecimal((String)peopleRecord.get("propertyIncome"));
		BigDecimal transferIncome = new BigDecimal((String)peopleRecord.get("transferIncome"));
		BigDecimal otherIncome = new BigDecimal((String)peopleRecord.get("otherIncome"));
		BigDecimal totalIncome=salaryIncome.add(manageIncome).add(propertyIncome).add(transferIncome).add(otherIncome);
		income.setSalaryIncome(salaryIncome);
		income.setManageIncome(manageIncome);
		income.setPropertyIncome(propertyIncome);
		income.setTransferIncome(transferIncome);
		income.setOtherIncome(otherIncome);
		income.setTotalIncome(totalIncome);
		incomeService.update(income);
		
		property.setPeopleId((String)peopleRecord.get("peopleId"));
		property.setPropertyId((String)peopleRecord.get("propertyId"));
		BigDecimal bankStockProperty = new BigDecimal((String)peopleRecord.get("bankStockProperty"));
		BigDecimal bondProperty = new BigDecimal((String)peopleRecord.get("bondProperty"));
		BigDecimal otherProperty = new BigDecimal((String)peopleRecord.get("otherProperty"));
		BigDecimal total = bankStockProperty.add(bondProperty).add(otherProperty);
		property.setBankStockProperty(bankStockProperty);
		property.setBondProperty(bondProperty);
		property.setOtherProperty(otherProperty);
		property.setTotalProperty(total);
		
		propertyService.update(property);
		updateFamilyInfo(familyId,"");
	}
	@Trans
	public void delPeople(){
		String familyId = (String)getParameter("familyId");
		String delId = (String)getParameter("delId");
		
		service.deletePeople(delId);
		incomeService.delete(delId);
		propertyService.delete(delId);
		
		updateFamilyInfo(familyId,"");
		
	}
	
	public void updateFamilyInfo(String familyId,String peopleId){
		ParameterSet pset = new ParameterSet();
		pset.setParameter("FAMILY_ID", familyId);
		pset.setParameter("PEOPLE_ID", peopleId);
		DataSet familyDs = service.queryFamily(pset);
		BaseinfoFamily family = (BaseinfoFamily)familyDs.getRecord(0).toBean(BaseinfoFamily.class);
		
		BigDecimal buildArea = family.getBuildArea();
		
		BigDecimal peopleNum = BigDecimal.ZERO;
		BigDecimal yearIncomeAll = BigDecimal.ZERO;
		BigDecimal propertyAll = BigDecimal.ZERO;
		
		pset.clear();
		pset.setParameter("familyId", familyId);
		pset.setParameter("peopleId", peopleId);
		DataSet peopleDs = incomeService.queryAllPeopleById(pset);
		peopleNum = new BigDecimal(peopleDs.getCount());
		for(int i=0;i<peopleDs.getCount();i++){
			Record record = peopleDs.getRecord(i);
			BigDecimal yearIncome = (BigDecimal)record.get("TOTAL_INCOME");			
			yearIncomeAll = yearIncomeAll.add(yearIncome);		
			BigDecimal property = (BigDecimal)record.get("TOTAL_PROPERTY");	
			propertyAll = propertyAll.add(property);
		}
		BigDecimal yearAveIncome = yearIncomeAll.divide(peopleNum,BigDecimal.ROUND_CEILING);
		BigDecimal buildAverageArea = buildArea.divide(peopleNum,BigDecimal.ROUND_CEILING);
		//System.out.println(yearIncomeAll+"/"+peopleNum+"==="+yearAveIncome);
		family.setPeopleNum(peopleNum);
		family.setYearIncome(yearIncomeAll);
		//family.setMonthIncome(propertyAll);///月总收入字段存放家庭其他资产
		family.setYearAverageIncome(yearAveIncome);
		family.setBuildAverageArea(buildAverageArea);//人均居住面积
		service.updateFamily(family);
	}
	
	public void checkCardId() {
		//String cardNo = (String)getParameter("cardNo");
		ParameterSet pset = getParameterSet();
		Map map=incomeService.checkCardId(pset);
		setReturn("familyId",map.get("familyId"));
		setReturn("errorFlag",map.get("errorFlag"));
		setReturn("peopleId",map.get("peopleId"));
		setReturn("personalStatsTag",map.get("personalStatsTag"));
		setReturn("relationshipType",map.get("relationshipType"));
		
	}
	
	
	//封装城市低收入家庭信息
	public void getCityLowFamilyInfo(){
		CityLowFamilyInfo clfi=new CityLowFamilyInfo();
		//家庭信息
		Record record = (Record) getParameter("record");
		BaseinfoFamily baseinfoFamily=(BaseinfoFamily)record.toBean(BaseinfoFamily.class);
		String familyId = baseinfoFamily.getFamilyId();
		if(familyId==null||familyId.length()<=0||familyId.equals("null")){
			familyId=IdHelp.getUUID32();
			baseinfoFamily.setFamilyId(familyId);			
		}	
		clfi.setBaseinfoFamily(baseinfoFamily);
		
		//家庭成员信息,//前台封装全部家属成员信息//
		Record[] peopleRecord = (Record[]) getParameter("peopleRecord");
		//可支配收入信息
		//Record peopleIncomeRecord = (Record) getParameter("peopleIncomeRecord");
		//家庭成员财产信息
		//Record samLowPeopleRecord = (Record) getParameter("samLowPeopleRecord");
		
		CityLowPeopleInfo[] cityLowPeopleInfos=new CityLowPeopleInfo[peopleRecord.length];
		for(int i=0;i<peopleRecord.length;i++){
			BaseinfoPeople baseinfoPeople=new BaseinfoPeople();//
			//(BaseinfoPeople)peopleRecord[i].toBean(BaseinfoPeople.class);
			//baseinfoPeople.setAddress((String)peopleRecord[i].get(""));
			//设置主键
			String peopleId =(String)peopleRecord[i].get("peopleId");// baseinfoPeople.getPeopleId();
			if(peopleId==null||peopleId.length()<=0||peopleId.equals("null")){
				peopleId=IdHelp.getUUID32();
							
			}
			baseinfoPeople.setPeopleId(peopleId);
			baseinfoPeople.setFamilyId(familyId);
			// 设置信息
			baseinfoPeople.setName((String)peopleRecord[i].get("name"));//姓名
			baseinfoPeople.setIdCard((String)peopleRecord[i].get("idCard"));//身份证号
			baseinfoPeople.setRelationshipType((String)peopleRecord[i].get("relationshipType"));//与户主的关系
			baseinfoPeople.setBirthday((String)peopleRecord[i].get("birthday"));//生日
			baseinfoPeople.setHealthCode((String)peopleRecord[i].get("healthCode"));//健康状况
			baseinfoPeople.setDisabilityLevelCode((String)peopleRecord[i].get("disabilityLevelCode"));//残疾状况
			baseinfoPeople.setEmploymentCode((String)peopleRecord[i].get("employmentCode"));//职业状况EMPLOYMENT_CODE,employmentCode
			baseinfoPeople.setWorkUnitCharacter((String)peopleRecord[i].get("workUnitCharacter"));//工作单位性质
			//以下户主独有
			baseinfoPeople.setSex((String)peopleRecord[i].get("sex"));
			baseinfoPeople.setNation((String)peopleRecord[i].get("nation"));//民族
			
			//可支配收入信息
			SamLowPeopleIncome samLowPeopleIncome= new SamLowPeopleIncome();
			String incomeId=(String)peopleRecord[i].get("incomeId");
			if(incomeId==null||"".equalsIgnoreCase(incomeId)||"null".equals(incomeId)){
				incomeId=IdHelp.getUUID32();
			}
			samLowPeopleIncome.setIncomeId(incomeId);
			samLowPeopleIncome.setPeopleId(peopleId);
			BigDecimal salaryIncome=new BigDecimal((String)peopleRecord[i].get("salaryIncome"));
			BigDecimal manageIncome=new BigDecimal((String)peopleRecord[i].get("manageIncome"));
			BigDecimal propertyIncome=new BigDecimal((String)peopleRecord[i].get("propertyIncome"));
			BigDecimal transferIncome=new BigDecimal((String)peopleRecord[i].get("transferIncome"));
			BigDecimal otherIncome=new BigDecimal((String)peopleRecord[i].get("otherIncome"));
			BigDecimal totalIncome=salaryIncome.add(manageIncome).add(propertyIncome).add(transferIncome).add(otherIncome);
			samLowPeopleIncome.setSalaryIncome(salaryIncome);
			samLowPeopleIncome.setManageIncome(manageIncome);
			samLowPeopleIncome.setPropertyIncome(propertyIncome);
			samLowPeopleIncome.setTransferIncome(transferIncome);
			samLowPeopleIncome.setPropertyIncome(otherIncome);
			samLowPeopleIncome.setTotalIncome(totalIncome);
			//家庭成员财产信息
			SamLowPeopleProperty samLowPeopleProperty=new SamLowPeopleProperty();
			String propertyId=(String)peopleRecord[i].get("propertyId");
			if(propertyId==null||"".equalsIgnoreCase(propertyId)||"null".equals(propertyId)){
				propertyId=IdHelp.getUUID32();
			}
			samLowPeopleProperty.setPeopleId(peopleId);
			samLowPeopleProperty.setPropertyId(propertyId);
			samLowPeopleProperty.setBankStockProperty(new BigDecimal((String)peopleRecord[i].get("bankStockProperty")));
			samLowPeopleProperty.setBondProperty(new BigDecimal((String)peopleRecord[i].get("bondProperty")));
			samLowPeopleProperty.setOtherProperty(new BigDecimal((String)peopleRecord[i].get("otherProperty")));
			
			cityLowPeopleInfos[i].setBaseinfoPeople(baseinfoPeople);
			cityLowPeopleInfos[i].setSamLowPeopleIncome(samLowPeopleIncome);
			cityLowPeopleInfos[i].setSamLowPeopleProperty(samLowPeopleProperty);
			
			//SamLowPeopleIncome samLowPeopleIncome=(SamLowPeopleIncome)peopleIncomeRecord.toBean(SamLowPeopleIncome.class);
			//SamLowPeopleProperty samLowPeopleProperty=(SamLowPeopleProperty)samLowPeopleRecord.toBean(SamLowPeopleProperty.class);
			
			
		}
		clfi.setCityLowPeopleInfo(cityLowPeopleInfos);
		
	
		//低收入家庭赡养、扶养、义务人情况
		Record[] samLowSupportPeopleRecord = (Record[]) getParameter("samLowSupportPeopleRecord");
		SamLowSupportPeople[] samLowSupportPeoples=new SamLowSupportPeople[samLowSupportPeopleRecord.length];
		for(int i=0;i<peopleRecord.length;i++){
			SamLowSupportPeople samLowSupportPeople=(SamLowSupportPeople)samLowSupportPeopleRecord[i].toBean(SamLowSupportPeople.class);
			samLowSupportPeoples[i]=samLowSupportPeople;
		}
		clfi.setSamLowSupportPeople(samLowSupportPeoples);
		//低收入家庭认定业务表
		 Record SamLowApplyInfoRecord = (Record) getParameter("SamLowApplyInfosamLowPeopleRecord");
		 SamLowApplyInfo samLowApplyInfo=(SamLowApplyInfo)SamLowApplyInfoRecord.toBean(SamLowApplyInfo.class);
		 clfi.setSamLowApplyInfo(samLowApplyInfo);
		
	}
}
