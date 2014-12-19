package com.inspur.cams.jcm.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.jcm.dao.IJcmCompanyChangeDao;
import com.inspur.cams.jcm.data.JcmCompanyChange;
import com.inspur.cams.jcm.domain.IJcmCompanyChangeDomain;

/**
 * 单位信息调整（多条记录过程）domain
 * @author 
 * @date 2014-05-16
 */
public class JcmCompanyChangeDomain implements IJcmCompanyChangeDomain {

	@Reference
	private IJcmCompanyChangeDao jcmCompanyChangeDao;

	/**
	 * 查询 单位信息调整（多条记录过程）
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return jcmCompanyChangeDao.query(pset);
	}

	/**
	 * 获取 单位信息调整（多条记录过程）
	 * @param pset
	 * @return
	 */
	public JcmCompanyChange get(String companyChangeId) {
		return jcmCompanyChangeDao.get(companyChangeId);
	}

	/**
	 * 增加 单位信息调整（多条记录过程）
	 * @param jcmCompanyChange
	 */
	public void insert(JcmCompanyChange jcmCompanyChange) {
		jcmCompanyChangeDao.insert(jcmCompanyChange);
	}
	
	/**
	 * 修改 单位信息调整（多条记录过程）
	 * @param jcmCompanyChange
	 */
	public void update(JcmCompanyChange jcmCompanyChange) {
		jcmCompanyChangeDao.update(jcmCompanyChange);
	}
	
	/**
	 * 删除 单位信息调整（多条记录过程）
	 * @param companyChangeId
	 */
	public void delete(String companyChangeId) {
		jcmCompanyChangeDao.delete(companyChangeId);
	}

}