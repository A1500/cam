package com.inspur.cams.jcm.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.dao.jdbc.JcmCompanyProfileDao;
import com.inspur.cams.jcm.dao.jdbc.JcmPeopleInfoDao;
import com.inspur.cams.jcm.data.JcmCompanyMoney;
import com.inspur.cams.jcm.data.JcmCompanyProfile;
import com.inspur.cams.jcm.data.JcmOfficeEquipment;
import com.inspur.cams.jcm.domain.IJcmCompanyProfileDomain;

/**
 * 单位信息cmd
 * @author 
 * @date 2014-05-16
 */
public class JcmCompanyProfileCmd extends BaseAjaxCommand {

	private IJcmCompanyProfileDomain jcmCompanyProfileDomain = ScaComponentFactory
			.getService(IJcmCompanyProfileDomain.class, "jcmCompanyProfileDomain/jcmCompanyProfileDomain");
	
	JcmCompanyProfileDao dao = (JcmCompanyProfileDao) DaoFactory.getDao("com.inspur.cams.jcm.dao.jdbc.JcmCompanyProfileDao");
	
	JcmPeopleInfoDao peoDao = (JcmPeopleInfoDao) DaoFactory.getDao("com.inspur.cams.jcm.dao.jdbc.JcmPeopleInfoDao");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		JcmCompanyProfile jcmCompanyProfile = (JcmCompanyProfile) record.toBean(JcmCompanyProfile.class);
		jcmCompanyProfileDomain.insert(jcmCompanyProfile);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		JcmCompanyProfile jcmCompanyProfile = (JcmCompanyProfile) record.toBean(JcmCompanyProfile.class);
		jcmCompanyProfileDomain.update(jcmCompanyProfile);
	}
	
	// 删除
	public void delete() {
		String companyId = (String) getParameter("companyId");
		jcmCompanyProfileDomain.delete(companyId);
	}
		public void save() {
	//工作经费	
	List<JcmCompanyMoney> moneyList = new ArrayList<JcmCompanyMoney>();
	Record[] moneyRecords = (Record[]) getParameter("moneyRecords");
	//办公设备
	List<JcmOfficeEquipment> equipMentList = new ArrayList<JcmOfficeEquipment>();
	Record[] equipMentRecords = (Record[]) getParameter("equipMentRecords");
		
	Record record = (Record) getParameter("record");
	JcmCompanyProfile jcmCompanyProfile = (JcmCompanyProfile) record.toBean(JcmCompanyProfile.class);
	if(moneyRecords != null){
		for(int i=0;i<moneyRecords.length;i++){
			JcmCompanyMoney jcmMoney = (JcmCompanyMoney) moneyRecords[i].toBean(JcmCompanyMoney.class);
			moneyList.add(jcmMoney);
		}
	}
	if(equipMentRecords != null){
		for(int i=0;i<equipMentRecords.length;i++){
			JcmOfficeEquipment jcmOffice = (JcmOfficeEquipment) equipMentRecords[i].toBean(JcmOfficeEquipment.class);
			equipMentList.add(jcmOffice);
		}
	}
	
	jcmCompanyProfileDomain.save(jcmCompanyProfile,moneyList,equipMentList);
	}
	public void deleteAll() {
		ParameterSet pset = getParameterSet();
		jcmCompanyProfileDomain.deleteAll(pset);
	}
	public void insertUser(){
		Record record = (Record) getParameter("userInfo");
		JcmCompanyProfile jcmCompanyProfile = (JcmCompanyProfile) record.toBean(JcmCompanyProfile.class);
		jcmCompanyProfileDomain.insertUser(jcmCompanyProfile);
	}
	
	
	public void deleteCom(){
		String companyId = (String) getParameter("companyId");
		ParameterSet pset1 = new ParameterSet();
		ParameterSet pset2 = new ParameterSet();
		pset1.setParameter("ORDER_COMPANY_ID@=", companyId);
		pset2.setParameter("COMPANY_ID@=", companyId);
		DataSet ds = jcmCompanyProfileDomain.query(pset1);
		
		DataSet peopleDs = peoDao.query(pset2);
		
		
		if(ds.getCount()>0 || peopleDs.getCount()>0){
			this.setReturn("tips", "请先删除该机构下的信息.");
		}else{
				jcmCompanyProfileDomain.delete(companyId);
		}
		
	}
	
}