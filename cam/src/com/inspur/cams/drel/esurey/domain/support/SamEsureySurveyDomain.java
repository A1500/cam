package com.inspur.cams.drel.esurey.domain.support;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.esurey.dao.ISamEsureyFamilyDao;
import com.inspur.cams.drel.esurey.dao.ISamEsureyFeedbackDao;
import com.inspur.cams.drel.esurey.dao.ISamEsureyOrganConfigDao;
import com.inspur.cams.drel.esurey.dao.ISamEsureySurveyDao;
import com.inspur.cams.drel.esurey.data.SamEsureyFamily;
import com.inspur.cams.drel.esurey.data.SamEsureyFeedback;
import com.inspur.cams.drel.esurey.data.SamEsureyOrganConfig;
import com.inspur.cams.drel.esurey.data.SamEsureyPeople;
import com.inspur.cams.drel.esurey.data.SamEsureySurvey;
import com.inspur.cams.drel.esurey.domain.ISamEsureySurveyDomain;
/**
 * @title:ISamEsureySurveyDomain
 * @description:经济核对_核对流水domain实现
 * @author:luguosui
 * @since:2011-06-29
 * @version:1.0
*/
public class SamEsureySurveyDomain implements ISamEsureySurveyDomain{
	@Reference(name = "samEsureySurveyDao")
	private ISamEsureySurveyDao samEsureySurveyDao ;
	@Reference(name="samEsureyOrganConfigDao")
	private ISamEsureyOrganConfigDao samEsureyOrganConfigDao ;
	@Reference
	private ISamEsureyFamilyDao samEsureyFamilyDao;
	@Reference
	private ISamEsureyFeedbackDao samEsureyFeedbackDao;
	
	public DataSet query(ParameterSet pset) {
		// TODO Auto-generated method stub
		return samEsureySurveyDao.query(pset);
	}

	public void batchDelete(String[] delIds) {
		samEsureySurveyDao.batchDelete(delIds);
		
	}
	/**
	 * 核对分发
	 * @author jiangzhaobao
	 */
	@Trans
	public void insert(ParameterSet pset) {
		Record record = (Record)pset.getParameter("record");
		SamEsureySurvey dataBean=(SamEsureySurvey)record.toBean(SamEsureySurvey.class);
		String surveyId=IdHelp.getUUID30();
		dataBean.setSurveyId(surveyId);
		dataBean.setSurveyDate(DateUtil.getDay());
		dataBean.setRegTime(DateUtil.getDay());
		dataBean.setCheckFlg("0");
		samEsureySurveyDao.insert(dataBean);
		String rFamilyId=dataBean.getFamilyId();
		
		//经济核对_外部单位填报信息
		getExtFeedBack(pset,surveyId);
		
		ParameterSet nPset=new ParameterSet();
		nPset.setParameter("family_id", rFamilyId);
		DataSet familyDS=samEsureyFamilyDao.query(nPset);
		int fNum=familyDS.getCount();
		if(fNum==1){
			SamEsureyFamily familyBean=(SamEsureyFamily)familyDS.getRecord(0).toBean(SamEsureyFamily.class);
			familyBean.setCurActivity("03");
			familyBean.setCurState("1");
			samEsureyFamilyDao.update(familyBean);
		}
		
	}
	/**
	 * 经济核对_外部单位填报信息
	 * @author jiangzhaobao
	 */
	@Trans
	public void getExtFeedBack(ParameterSet pset,String surveyId){
		String organId=(String)pset.getParameter("organId");
		ParameterSet configpset=new ParameterSet();
		configpset.setParameter("organ_id", organId);
		DataSet configDS=samEsureyOrganConfigDao.query(configpset);
		int num=configDS.getCount();
		String extSocialId="";
		String extHouseId="";
		String extBusinessId="";
		String extCarId="";
		String extTaxGId="";
		String extTaxDId="";
		String extFundId="";
		String extBankId="";
		String extSecuritiesId="";
		String extInsuranceId="";
		for(int i=0;i<num;i++){
			SamEsureyOrganConfig configBean=(SamEsureyOrganConfig)configDS.getRecord(i).toBean(SamEsureyOrganConfig.class);
			String extOrganType=configBean.getExtOrganType();
			if("01".equals(extOrganType)){
				extSocialId=configBean.getExtOrganId();
			}else if("02".equals(extOrganType)){
			    extHouseId=configBean.getExtOrganId();
			}else if("03".equals(extOrganType)){
			    extBusinessId=configBean.getExtOrganId();
			}else if("04".equals(extOrganType)){
				extCarId=configBean.getExtOrganId();
			}else if("05".equals(extOrganType)){
				extTaxGId=configBean.getExtOrganId();
			}else if("06".equals(extOrganType)){
				extTaxDId=configBean.getExtOrganId();
			}else if("07".equals(extOrganType)){
				extFundId=configBean.getExtOrganId();
			}else if("08".equals(extOrganType)){
				extBankId=configBean.getExtOrganId();
			}else if("09".equals(extOrganType)){
				extSecuritiesId=configBean.getExtOrganId();
			}else if("10".equals(extOrganType)){
				extInsuranceId=configBean.getExtOrganId();
			}
		}
		String peoFlag=(String)pset.getParameter("peoFlag");
		if(!"peoNull".equals(peoFlag)){
		Record[] peoRecords=(Record[])pset.getParameter("peoRecords");
		SamEsureyPeople[] peoBeans=new SamEsureyPeople[peoRecords.length];
		List<SamEsureyFeedback> feedList=new ArrayList<SamEsureyFeedback>();
		for(int i=0;i<peoRecords.length;i++){
			peoBeans[i]=(SamEsureyPeople)peoRecords[i].toBean(SamEsureyPeople.class);
			String familyId=peoBeans[i].getFamilyId();
			String peopleId=peoBeans[i].getPeopleId();
			String name=peoBeans[i].getName();
			String idCard=peoBeans[i].getIdCard();
			if("1".equals(peoBeans[i].getExternalSocialOrg())&&extSocialId!=""){
				SamEsureyFeedback feedBackBean=new SamEsureyFeedback();
				feedBackBean.setFeedbackId(IdHelp.getUUID30());
				feedBackBean.setFamilyId(familyId);
				feedBackBean.setPeopleId(peopleId);
				feedBackBean.setName(name);
				feedBackBean.setIdCard(idCard);
				feedBackBean.setSurveyId(surveyId);
				feedBackBean.setCheckOrgId(extSocialId);
				feedBackBean.setCheckOrg("社保");
				feedBackBean.setCheckFlg("0");
				feedBackBean.setCheckTime(DateUtil.getDay());
				feedList.add(feedBackBean);
			}
			if("1".equals(peoBeans[i].getExternalHouseOrg())&&extHouseId!=""){
				SamEsureyFeedback feedBackBean=new SamEsureyFeedback();
				feedBackBean.setFeedbackId(IdHelp.getUUID30());
				feedBackBean.setFamilyId(familyId);
				feedBackBean.setPeopleId(peopleId);
				feedBackBean.setName(name);
				feedBackBean.setIdCard(idCard);
				feedBackBean.setSurveyId(surveyId);
				feedBackBean.setCheckOrgId(extHouseId);
				feedBackBean.setCheckOrg("房管");
				feedBackBean.setCheckFlg("0");
				feedBackBean.setCheckTime(DateUtil.getDay());
				feedList.add(feedBackBean);
			}
			if("1".equals(peoBeans[i].getExternalBusinessOrg())&&extBusinessId!=""){
				SamEsureyFeedback feedBackBean=new SamEsureyFeedback();
				feedBackBean.setFeedbackId(IdHelp.getUUID30());
				feedBackBean.setFamilyId(familyId);
				feedBackBean.setPeopleId(peopleId);
				feedBackBean.setName(name);
				feedBackBean.setIdCard(idCard);
				feedBackBean.setSurveyId(surveyId);
				feedBackBean.setCheckOrgId(extBusinessId);
				feedBackBean.setCheckOrg("工商");
				feedBackBean.setCheckFlg("0");
				feedBackBean.setCheckTime(DateUtil.getDay());
				feedList.add(feedBackBean);
			}
			if("1".equals(peoBeans[i].getExternalCarOrg())&&extCarId!=""){
				SamEsureyFeedback feedBackBean=new SamEsureyFeedback();
				feedBackBean.setFeedbackId(IdHelp.getUUID30());
				feedBackBean.setFamilyId(familyId);
				feedBackBean.setPeopleId(peopleId);
				feedBackBean.setName(name);
				feedBackBean.setIdCard(idCard);
				feedBackBean.setSurveyId(surveyId);
				feedBackBean.setCheckOrgId(extCarId);
				feedBackBean.setCheckOrg("车管（公安）");
				feedBackBean.setCheckFlg("0");
				feedBackBean.setCheckTime(DateUtil.getDay());
				feedList.add(feedBackBean);
			}
			if("1".equals(peoBeans[i].getExternalTaxGOrg())&&extTaxGId!=""){
				SamEsureyFeedback feedBackBean=new SamEsureyFeedback();
				feedBackBean.setFeedbackId(IdHelp.getUUID30());
				feedBackBean.setFamilyId(familyId);
				feedBackBean.setPeopleId(peopleId);
				feedBackBean.setName(name);
				feedBackBean.setIdCard(idCard);
				feedBackBean.setSurveyId(surveyId);
				feedBackBean.setCheckOrgId(extTaxGId);
				feedBackBean.setCheckOrg("国税");
				feedBackBean.setCheckFlg("0");
				feedBackBean.setCheckTime(DateUtil.getDay());
				feedList.add(feedBackBean);
			}
			if("1".equals(peoBeans[i].getExternalTaxDOrg())&&extTaxDId!=""){
				SamEsureyFeedback feedBackBean=new SamEsureyFeedback();
				feedBackBean.setFeedbackId(IdHelp.getUUID30());
				feedBackBean.setFamilyId(familyId);
				feedBackBean.setPeopleId(peopleId);
				feedBackBean.setName(name);
				feedBackBean.setIdCard(idCard);
				feedBackBean.setSurveyId(surveyId);
				feedBackBean.setCheckOrgId(extTaxDId);
				feedBackBean.setCheckOrg("地税");
				feedBackBean.setCheckFlg("0");
				feedBackBean.setCheckTime(DateUtil.getDay());
				feedList.add(feedBackBean);
			}
			if("1".equals(peoBeans[i].getExternalFundOrg())&&extFundId!=""){
				SamEsureyFeedback feedBackBean=new SamEsureyFeedback();
				feedBackBean.setFeedbackId(IdHelp.getUUID30());
				feedBackBean.setFamilyId(familyId);
				feedBackBean.setPeopleId(peopleId);
				feedBackBean.setName(name);
				feedBackBean.setIdCard(idCard);
				feedBackBean.setSurveyId(surveyId);
				feedBackBean.setCheckOrgId(extFundId);
				feedBackBean.setCheckOrg("公积金");
				feedBackBean.setCheckFlg("0");
				feedBackBean.setCheckTime(DateUtil.getDay());
				feedList.add(feedBackBean);
			}
			if("1".equals(peoBeans[i].getExternalBankOrg())&&extBankId!=""){
				SamEsureyFeedback feedBackBean=new SamEsureyFeedback();
				feedBackBean.setFeedbackId(IdHelp.getUUID30());
				feedBackBean.setFamilyId(familyId);
				feedBackBean.setPeopleId(peopleId);
				feedBackBean.setName(name);
				feedBackBean.setIdCard(idCard);
				feedBackBean.setSurveyId(surveyId);
				feedBackBean.setCheckOrgId(extBankId);
				feedBackBean.setCheckOrg("银行");
				feedBackBean.setCheckFlg("0");
				feedBackBean.setCheckTime(DateUtil.getDay());
				feedList.add(feedBackBean);
			}
			if("1".equals(peoBeans[i].getExternalSecuritiesOrg())&&extSecuritiesId!=""){
				SamEsureyFeedback feedBackBean=new SamEsureyFeedback();
				feedBackBean.setFeedbackId(IdHelp.getUUID30());
				feedBackBean.setFamilyId(familyId);
				feedBackBean.setPeopleId(peopleId);
				feedBackBean.setName(name);
				feedBackBean.setIdCard(idCard);
				feedBackBean.setSurveyId(surveyId);
				feedBackBean.setCheckOrgId(extSecuritiesId);
				feedBackBean.setCheckOrg("证监");
				feedBackBean.setCheckFlg("0");
				feedBackBean.setCheckTime(DateUtil.getDay());
				feedList.add(feedBackBean);
			}
			if("1".equals(peoBeans[i].getExternalInsuranceOrg())&&extInsuranceId!=""){
				SamEsureyFeedback feedBackBean=new SamEsureyFeedback();
				feedBackBean.setFeedbackId(IdHelp.getUUID30());
				feedBackBean.setFamilyId(familyId);
				feedBackBean.setPeopleId(peopleId);
				feedBackBean.setName(name);
				feedBackBean.setIdCard(idCard);
				feedBackBean.setSurveyId(surveyId);
				feedBackBean.setCheckOrgId(extInsuranceId);
				feedBackBean.setCheckOrg("保监");
				feedBackBean.setCheckFlg("0");
				feedBackBean.setCheckTime(DateUtil.getDay());
				feedList.add(feedBackBean);
			}
			}
			samEsureyFeedbackDao.batchInsert(feedList);
		}
		String relPeoFlag=(String)pset.getParameter("relPeoFlag");
		if(!"relPeoNull".equals(relPeoFlag)){
		Record[] relPeoRecords=(Record[])pset.getParameter("relPeoRecords");
		SamEsureyPeople[] relPeoBeans=new SamEsureyPeople[relPeoRecords.length];
		List<SamEsureyFeedback> relFeedList=new ArrayList<SamEsureyFeedback>();
		for(int i=0;i<relPeoRecords.length;i++){
			relPeoBeans[i]=(SamEsureyPeople)relPeoRecords[i].toBean(SamEsureyPeople.class);
			String familyId=relPeoBeans[i].getFamilyId();
			String peopleId=relPeoBeans[i].getPeopleId();
			String name=relPeoBeans[i].getName();
			String idCard=relPeoBeans[i].getIdCard();
			if("1".equals(relPeoBeans[i].getExternalSocialOrg())&&extSocialId!=""){
				SamEsureyFeedback feedBackBean=new SamEsureyFeedback();
				feedBackBean.setFeedbackId(IdHelp.getUUID30());
				feedBackBean.setFamilyId(familyId);
				feedBackBean.setPeopleId(peopleId);
				feedBackBean.setName(name);
				feedBackBean.setIdCard(idCard);
				feedBackBean.setSurveyId(surveyId);
				feedBackBean.setCheckOrgId(extSocialId);
				feedBackBean.setCheckOrg("社保");
				feedBackBean.setCheckFlg("0");
				feedBackBean.setCheckTime(DateUtil.getDay());
				relFeedList.add(feedBackBean);
			}
			if("1".equals(relPeoBeans[i].getExternalHouseOrg())&&extHouseId!=""){
				SamEsureyFeedback feedBackBean=new SamEsureyFeedback();
				feedBackBean.setFeedbackId(IdHelp.getUUID30());
				feedBackBean.setFamilyId(familyId);
				feedBackBean.setPeopleId(peopleId);
				feedBackBean.setName(name);
				feedBackBean.setIdCard(idCard);
				feedBackBean.setSurveyId(surveyId);
				feedBackBean.setCheckOrgId(extHouseId);
				feedBackBean.setCheckOrg("房管");
				feedBackBean.setCheckFlg("0");
				feedBackBean.setCheckTime(DateUtil.getDay());
				relFeedList.add(feedBackBean);
			}
			if("1".equals(relPeoBeans[i].getExternalBusinessOrg())&&extBusinessId!=""){
				SamEsureyFeedback feedBackBean=new SamEsureyFeedback();
				feedBackBean.setFeedbackId(IdHelp.getUUID30());
				feedBackBean.setFamilyId(familyId);
				feedBackBean.setPeopleId(peopleId);
				feedBackBean.setName(name);
				feedBackBean.setIdCard(idCard);
				feedBackBean.setSurveyId(surveyId);
				feedBackBean.setCheckOrgId(extBusinessId);
				feedBackBean.setCheckOrg("工商");
				feedBackBean.setCheckFlg("0");
				feedBackBean.setCheckTime(DateUtil.getDay());
				relFeedList.add(feedBackBean);
			}
			if("1".equals(relPeoBeans[i].getExternalCarOrg())&&extCarId!=""){
				SamEsureyFeedback feedBackBean=new SamEsureyFeedback();
				feedBackBean.setFeedbackId(IdHelp.getUUID30());
				feedBackBean.setFamilyId(familyId);
				feedBackBean.setPeopleId(peopleId);
				feedBackBean.setName(name);
				feedBackBean.setIdCard(idCard);
				feedBackBean.setSurveyId(surveyId);
				feedBackBean.setCheckOrgId(extCarId);
				feedBackBean.setCheckOrg("车管（公安）");
				feedBackBean.setCheckFlg("0");
				feedBackBean.setCheckTime(DateUtil.getDay());
				relFeedList.add(feedBackBean);
			}
			if("1".equals(relPeoBeans[i].getExternalTaxGOrg())&&extTaxGId!=""){
				SamEsureyFeedback feedBackBean=new SamEsureyFeedback();
				feedBackBean.setFeedbackId(IdHelp.getUUID30());
				feedBackBean.setFamilyId(familyId);
				feedBackBean.setPeopleId(peopleId);
				feedBackBean.setName(name);
				feedBackBean.setIdCard(idCard);
				feedBackBean.setSurveyId(surveyId);
				feedBackBean.setCheckOrgId(extTaxGId);
				feedBackBean.setCheckOrg("国税");
				feedBackBean.setCheckFlg("0");
				feedBackBean.setCheckTime(DateUtil.getDay());
				relFeedList.add(feedBackBean);
			}
			if("1".equals(relPeoBeans[i].getExternalTaxDOrg())&&extTaxDId!=""){
				SamEsureyFeedback feedBackBean=new SamEsureyFeedback();
				feedBackBean.setFeedbackId(IdHelp.getUUID30());
				feedBackBean.setFamilyId(familyId);
				feedBackBean.setPeopleId(peopleId);
				feedBackBean.setName(name);
				feedBackBean.setIdCard(idCard);
				feedBackBean.setSurveyId(surveyId);
				feedBackBean.setCheckOrgId(extTaxDId);
				feedBackBean.setCheckOrg("地税");
				feedBackBean.setCheckFlg("0");
				feedBackBean.setCheckTime(DateUtil.getDay());
				relFeedList.add(feedBackBean);
			}
			if("1".equals(relPeoBeans[i].getExternalFundOrg())&&extFundId!=""){
				SamEsureyFeedback feedBackBean=new SamEsureyFeedback();
				feedBackBean.setFeedbackId(IdHelp.getUUID30());
				feedBackBean.setFamilyId(familyId);
				feedBackBean.setPeopleId(peopleId);
				feedBackBean.setName(name);
				feedBackBean.setIdCard(idCard);
				feedBackBean.setSurveyId(surveyId);
				feedBackBean.setCheckOrgId(extFundId);
				feedBackBean.setCheckOrg("公积金");
				feedBackBean.setCheckFlg("0");
				feedBackBean.setCheckTime(DateUtil.getDay());
				relFeedList.add(feedBackBean);
			}
			if("1".equals(relPeoBeans[i].getExternalBankOrg())&&extBankId!=""){
				SamEsureyFeedback feedBackBean=new SamEsureyFeedback();
				feedBackBean.setFeedbackId(IdHelp.getUUID30());
				feedBackBean.setFamilyId(familyId);
				feedBackBean.setPeopleId(peopleId);
				feedBackBean.setName(name);
				feedBackBean.setIdCard(idCard);
				feedBackBean.setSurveyId(surveyId);
				feedBackBean.setCheckOrgId(extBankId);
				feedBackBean.setCheckOrg("银行");
				feedBackBean.setCheckFlg("0");
				feedBackBean.setCheckTime(DateUtil.getDay());
				relFeedList.add(feedBackBean);
			}
			if("1".equals(relPeoBeans[i].getExternalSecuritiesOrg())&&extSecuritiesId!=""){
				SamEsureyFeedback feedBackBean=new SamEsureyFeedback();
				feedBackBean.setFeedbackId(IdHelp.getUUID30());
				feedBackBean.setFamilyId(familyId);
				feedBackBean.setPeopleId(peopleId);
				feedBackBean.setName(name);
				feedBackBean.setIdCard(idCard);
				feedBackBean.setSurveyId(surveyId);
				feedBackBean.setCheckOrgId(extSecuritiesId);
				feedBackBean.setCheckOrg("证监");
				feedBackBean.setCheckFlg("0");
				feedBackBean.setCheckTime(DateUtil.getDay());
				relFeedList.add(feedBackBean);
			}
			if("1".equals(relPeoBeans[i].getExternalInsuranceOrg())&&extInsuranceId!=""){
				SamEsureyFeedback feedBackBean=new SamEsureyFeedback();
				feedBackBean.setFeedbackId(IdHelp.getUUID30());
				feedBackBean.setFamilyId(familyId);
				feedBackBean.setPeopleId(peopleId);
				feedBackBean.setName(name);
				feedBackBean.setIdCard(idCard);
				feedBackBean.setSurveyId(surveyId);
				feedBackBean.setCheckOrgId(extInsuranceId);
				feedBackBean.setCheckOrg("保监");
				feedBackBean.setCheckFlg("0");
				feedBackBean.setCheckTime(DateUtil.getDay());
				relFeedList.add(feedBackBean);
			}
		}
		samEsureyFeedbackDao.batchInsert(relFeedList);
		}
	}
	public void save(List<SamEsureySurvey> list) {
		samEsureySurveyDao.save(list);
		
	}

	public void update(SamEsureySurvey dataBean) {
		samEsureySurveyDao.update(dataBean);
		
	}
	public void delete(String peopleId){
		samEsureySurveyDao.delete(peopleId);
	}

	/**
	 * 查询家庭核对流水
	 * @return
	 */
	public DataSet queryForEsureyList(ParameterSet pset){
		return samEsureySurveyDao.queryForEsureyList(pset);
	}
}
