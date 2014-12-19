package com.inspur.cams.jcm.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.jcm.data.JcmCompanyHis;

/**
 * 单位历史信息domain
 * @author 
 * @date 2014-05-16
 */
public interface IJcmCompanyHisDomain {

	/**
	 * 查询 单位历史信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 单位历史信息
	 * @param pset
	 * @return
	 */
	public JcmCompanyHis get(String companyId);

	/**
	 * 增加 单位历史信息
	 * @param jcmCompanyHis
	 */
	@Trans
	public void insert(JcmCompanyHis jcmCompanyHis);
	
	/**
	 * 修改 单位历史信息
	 * @param jcmCompanyHis
	 */
	@Trans
	public void update(JcmCompanyHis jcmCompanyHis);
	
	/**
	 * 删除 单位历史信息
	 * @param companyId
	 */
	@Trans
	public void delete(String companyId);

}