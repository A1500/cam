package com.inspur.cams.jcm.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.jcm.data.JcmCompanyProfile;

/**
 * 单位信息dao
 * @author 
 * @date 2014-05-16
 */
public interface IJcmCompanyProfileDao extends BaseCURD<JcmCompanyProfile> {

	DataSet queryUserinfo(ParameterSet pset);
	public DataSet queryCompany(ParameterSet pset);
	public void deleteAll(ParameterSet pset);
	
	/**
	 * 查询 单位信息
	 * @param jcmCompanyProfile
	 */
	public DataSet queryCompanyInfo(ParameterSet pset);
	
	
	/**
	 * 查询下级行政区划
	 * @param ups
	 * @return
	 */
	public DataSet getOrgan(String ups); 
}