package com.inspur.cams.jcm.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.jcm.dao.IJcmCompanyHisDao;
import com.inspur.cams.jcm.data.JcmCompanyHis;
import com.inspur.cams.jcm.domain.IJcmCompanyHisDomain;

/**
 * 单位历史信息domain
 * @author 
 * @date 2014-05-16
 */
public class JcmCompanyHisDomain implements IJcmCompanyHisDomain {

	@Reference
	private IJcmCompanyHisDao jcmCompanyHisDao;

	/**
	 * 查询 单位历史信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return jcmCompanyHisDao.query(pset);
	}

	/**
	 * 获取 单位历史信息
	 * @param pset
	 * @return
	 */
	public JcmCompanyHis get(String companyId) {
		return jcmCompanyHisDao.get(companyId);
	}

	/**
	 * 增加 单位历史信息
	 * @param jcmCompanyHis
	 */
	public void insert(JcmCompanyHis jcmCompanyHis) {
		jcmCompanyHisDao.insert(jcmCompanyHis);
	}
	
	/**
	 * 修改 单位历史信息
	 * @param jcmCompanyHis
	 */
	public void update(JcmCompanyHis jcmCompanyHis) {
		jcmCompanyHisDao.update(jcmCompanyHis);
	}
	
	/**
	 * 删除 单位历史信息
	 * @param companyId
	 */
	public void delete(String companyId) {
		jcmCompanyHisDao.delete(companyId);
	}

}