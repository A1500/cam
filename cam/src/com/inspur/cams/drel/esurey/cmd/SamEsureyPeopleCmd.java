package com.inspur.cams.drel.esurey.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.drel.esurey.data.SamEsureyPeople;
import com.inspur.cams.drel.esurey.domain.ISamEsureyFamilyDomain;
import com.inspur.cams.drel.esurey.domain.ISamEsureyPeopleDomain;
import com.inspur.cams.drel.esurey.domain.ISamEsureyRelationDomain;


public class SamEsureyPeopleCmd extends BaseAjaxCommand{
	private ISamEsureyPeopleDomain service = ScaComponentFactory.getService(ISamEsureyPeopleDomain.class, "SamEsureyPeopleDomain/SamEsureyPeopleDomain");
	private ISamEsureyFamilyDomain familyDomain = ScaComponentFactory.getService(ISamEsureyFamilyDomain.class, "SamEsureyFamilyDomain/SamEsureyFamilyDomain");
	private ISamEsureyRelationDomain relation = ScaComponentFactory.getService(ISamEsureyRelationDomain.class, "SamEsureyRelationDomain/SamEsureyRelationDomain");
	@Trans
	public void save(){
		String signType = (String) getParameter("signType");
		String sFlag=(String)getParameter("sFlag");
		SamEsureyPeople  bean=getSamEsureyPeople(signType);
		String peopleId=bean.getPeopleId();
		String familyId=bean.getFamilyId();
		if("insert".equalsIgnoreCase(signType)){
			service.insert(bean);
			familyDomain.updateFamilyInfo(familyId);
		}else if("update".equalsIgnoreCase(signType)){
			service.update(bean);
			familyDomain.updateFamilyInfo(familyId);
			if(bean.getRelationshipType().equals("01")){
				String name=bean.getName();
				String idCard=bean.getIdCard();
				String domicileType=bean.getDomicileType();
				ParameterSet pset=new ParameterSet();
				pset.setParameter("FAMILY_ID", familyId);
				pset.setParameter("NAME", name);
				pset.setParameter("ID_CARD", idCard);
				pset.setParameter("DOMICILE_TYPE", domicileType);
				familyDomain.updateNameOrIdCard(pset);
			}
		}
		if("notSupport".equalsIgnoreCase(sFlag)){
			relation.deleteByPeopleId(peopleId);
		}
		//社保信息
		Record[] SamSocials = (Record[]) getParameter("SocialBeans");
		if(SamSocials!=null&&SamSocials.length!=0){			
			service.getSamEsureySocial(SamSocials,peopleId);
			//社保财产信息
			service.getEstateSocial(peopleId,familyId);
		}
		
		//财产信息
		Record[] estateRecords = (Record[]) getParameter("estateRecords");
		if(estateRecords!=null&&estateRecords.length!=0){
			service.getSamEsureyEstate(estateRecords, peopleId,familyId);
		}
		//房屋信息
		Record[] houseRecords = (Record[]) getParameter("houseRecords");
		if(houseRecords!=null&&houseRecords.length!=0){
			service.getSamEsureyHouse(houseRecords, peopleId);
			//房屋财产信息
			service.getEsureyHouse(peopleId,familyId);
		}	
		//工商信息
		Record[] businessRecords = (Record[]) getParameter("businessRecords");
		if(businessRecords!=null&&businessRecords.length!=0){
			service.getSamEsureyBusiness(businessRecords, peopleId);
		}
		//车辆信息
		Record[] carRecords = (Record[]) getParameter("carRecords");
		if(carRecords!=null&&carRecords.length!=0){
			service.getSamEsureyCar(carRecords, peopleId);
			//车辆财产信息
			service.getEsureyCar(peopleId,familyId);
		}
		//国税
		Record[] taxRecords = (Record[]) getParameter("taxRecords");
		if(taxRecords!=null&&taxRecords.length!=0){
			service.getEsureyTaxG(taxRecords, peopleId);
		}
		//地税信息
		Record[] taxRecords2 = (Record[]) getParameter("taxRecords2");
		if(taxRecords2!=null&&taxRecords2.length!=0){
			service.getEsureyTaxD(taxRecords2, peopleId);
		}
		// 公积金信息
		Record[] fundRecords = (Record[]) getParameter("fundRecords");
		if(fundRecords!=null&&fundRecords.length!=0){
			service.getEsureyFund(fundRecords, peopleId);
		}
		// 人行信息
		Record[] bankRecords = (Record[]) getParameter("bankRecords");
		if(bankRecords!=null&&bankRecords.length!=0){
			service.getEsureyBank(bankRecords, peopleId);
			//人行财产信息
			service.getBankEstate(peopleId,familyId);
		}
		// 证监信息
		Record[] securitiesRecords = (Record[]) getParameter("securitiesRecords");
		if(securitiesRecords!=null&&securitiesRecords.length!=0){
			service.getEsureySecurities(securitiesRecords, peopleId);
			//有价证券
			service.getSecuritiesEstate(peopleId,familyId);
		}
		// 保监信息
		Record[] insuranceRecords = (Record[]) getParameter("insuranceRecords");
		if(insuranceRecords!=null&&insuranceRecords.length!=0){
			service.getEsureyInsurance(insuranceRecords, peopleId);
		}	
				
	}
	
	public void update(){
		SamEsureyPeople bean= (SamEsureyPeople) getParameter("SamEsureyPeople");
		service.update(bean);
	}
	
	public void delete(){
		String delId=(String)getParameter("peopleId");
		String familyId=(String)getParameter("familyId");
		String Flag=(String)getParameter("Flag");
		service.deletePeople(familyId, delId, Flag);		
	}
	/**
	 * 家庭成员信息获取
	 * 
	 * @return
	 */
	private SamEsureyPeople getSamEsureyPeople(String signType) {
		Record SamEsureyPeopleRecord = (Record) getParameter("SamEsureyPeople");
		SamEsureyPeople bean = (SamEsureyPeople) SamEsureyPeopleRecord.toBean(SamEsureyPeople.class);	  
		if ("insert".equals(signType)) {
			//登录人Id
			bean.setRegId(BspUtil.getEmpOrganId());
			//登录人姓名
			bean.setRegPeople(BspUtil.getEmpOrgan().getOrganName());
			//录入时间
			bean.setRegTime(DateUtil.getTime());
		}else{
			//修改人Id
			bean.setModId(BspUtil.getEmpOrganId());
			//修改人姓名
			bean.setModPeople(BspUtil.getEmpOrgan().getOrganName());
			//修改时间
			bean.setModTime(DateUtil.getTime());
		} 
		return bean;
	}
	/**
	 * 检查家庭成员身份证号的唯一性
	 */
	public void checkUnqiue(){
		String familyId=(String)getParameter("familyId");
		String idCard=(String)getParameter("idCard");
		ParameterSet pset=new ParameterSet();
		pset.setParameter("familyId", familyId);
		pset.setParameter("idCard", idCard);
		setReturn("peopleId",service.queryUnqiue(pset));
	}
}
