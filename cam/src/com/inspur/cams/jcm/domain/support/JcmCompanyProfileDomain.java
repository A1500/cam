package com.inspur.cams.jcm.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.jcm.dao.IJcmCompanyMoneyDao;
import com.inspur.cams.jcm.dao.IJcmCompanyProfileDao;
import com.inspur.cams.jcm.dao.IJcmOfficeEquipmentDao;
import com.inspur.cams.jcm.dao.IJcmUserInfoDao;
import com.inspur.cams.jcm.data.JcmCompanyProfile;
import com.inspur.cams.jcm.data.JcmUserInfo;
import com.inspur.cams.jcm.domain.IJcmCompanyProfileDomain;
import com.inspur.comm.util.IdHelp;

/**
 * 单位信息domain
 * @author
 * @date 2014-05-16
 */
public class JcmCompanyProfileDomain implements IJcmCompanyProfileDomain {

	@Reference
	private IJcmCompanyProfileDao jcmCompanyProfileDao;

	@Reference
	private IJcmUserInfoDao jcmUserInfoDao;

	@Reference
	private IJcmCompanyMoneyDao jcmCompanyMoneyDao;

	@Reference
	private IJcmOfficeEquipmentDao jcmOfficeEquipmentDao;

	/**
	 * 查询 单位信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return jcmCompanyProfileDao.query(pset);
	}

	/**
	 * 获取 单位信息
	 * @param pset
	 * @return
	 */
	public JcmCompanyProfile get(String companyId) {
		return jcmCompanyProfileDao.get(companyId);
	}

	/**
	 * 增加 单位信息
	 * @param jcmCompanyProfile
	 */
	public void insert(JcmCompanyProfile jcmCompanyProfile) {
		jcmCompanyProfileDao.insert(jcmCompanyProfile);
	}

	/**
	 * 修改 单位信息
	 * @param jcmCompanyProfile
	 */
	public void update(JcmCompanyProfile jcmCompanyProfile) {
		jcmCompanyProfileDao.update(jcmCompanyProfile);
	}

	/**
	 * 删除 单位信息
	 * @param companyId
	 */
	public void delete(String companyId) {
		jcmCompanyProfileDao.delete(companyId);
	}

	public DataSet queryUserinfo(ParameterSet pset) {
		return jcmCompanyProfileDao.queryUserinfo(pset);
	}
	/**
	 * 生成用户
	 */
	public void insertUser(JcmCompanyProfile jcmCompanyProfile) {
		if("".equals(jcmCompanyProfile.getCompanyId()) || jcmCompanyProfile.getCompanyId() == null ){
			jcmCompanyProfile.setCompanyId(IdHelp.getUUID32());
			jcmCompanyProfileDao.insert(jcmCompanyProfile);
		}

		JcmUserInfo userinfo = new JcmUserInfo();
		userinfo.setCompanyId(jcmCompanyProfile.getCompanyId());
		userinfo.setUserId(jcmCompanyProfile.getUserId());
		userinfo.setUserInfoId(IdHelp.getUUID32());
		jcmUserInfoDao.insert(userinfo);
	}
	public DataSet queryCompany(ParameterSet pset){
		return jcmCompanyProfileDao.queryCompany(pset);
	}

	public void save(JcmCompanyProfile jcmCompanyProfile, List moneyList, List equipMentList) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("COMPANY_ID", jcmCompanyProfile.getCompanyId());
		DataSet infoDs = jcmCompanyProfileDao.query(pset);
		if(infoDs.getCount()>=1){
			jcmCompanyProfileDao.update(jcmCompanyProfile);
		}else{
			jcmCompanyProfileDao.insert(jcmCompanyProfile);
		}
		//保存工作经费信息
		jcmCompanyMoneyDao.save(moneyList);
		//保存办公设备信息
		jcmOfficeEquipmentDao.save(equipMentList);

	}
	public void deleteAll(ParameterSet pset) {
		String companyId = (String)pset.getParameter("companyId");
		jcmCompanyProfileDao.delete(companyId);
		jcmCompanyProfileDao.deleteAll(pset);
	}


	/**
	 * 查询 单位信息
	 * @param jcmCompanyProfile
	 */
	@Trans
	public DataSet queryCompanyInfo(ParameterSet pset){
		return jcmCompanyProfileDao.queryCompanyInfo(pset);
	}
}