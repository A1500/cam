package com.inspur.cams.jcm.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.jcm.data.JcmCompanyProfile;

/**
 * 单位信息domain
 * @author 
 * @date 2014-05-16
 */
public interface IJcmCompanyProfileDomain {

	/**
	 * 查询 单位信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 单位信息
	 * @param pset
	 * @return
	 */
	public JcmCompanyProfile get(String companyId);

	/**
	 * 增加 单位信息
	 * @param jcmCompanyProfile
	 */
	@Trans
	public void insert(JcmCompanyProfile jcmCompanyProfile);
	
	/**
	 * 修改 单位信息
	 * @param jcmCompanyProfile
	 */
	@Trans
	public void update(JcmCompanyProfile jcmCompanyProfile);
	
	/**
	 * 删除 单位信息
	 * @param companyId
	 */
	@Trans
	public void delete(String companyId);

	public DataSet queryUserinfo(ParameterSet pset);
	/**
	 * 生成用户
	 * @param jcmCompanyProfile
	 */
	public void insertUser(JcmCompanyProfile jcmCompanyProfile);
	
	public DataSet queryCompany(ParameterSet pset);
	
	
	/**
	 * 查询 单位信息
	 * @param jcmCompanyProfile
	 */
	@Trans
	public DataSet queryCompanyInfo(ParameterSet pset);
	
	@Trans
	public void save(JcmCompanyProfile jcmCompanyProfile, List moneyList, List equipMentList);
	@Trans
	public void deleteAll(ParameterSet pset);
}