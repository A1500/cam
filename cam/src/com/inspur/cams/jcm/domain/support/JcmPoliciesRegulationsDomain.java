package com.inspur.cams.jcm.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.jcm.dao.IJcmPoliciesRegulationsDao;
import com.inspur.cams.jcm.data.JcmPoliciesRegulations;
import com.inspur.cams.jcm.domain.IJcmPoliciesRegulationsDomain;

/**
 * 政策法规表domain
 * @author 
 * @date 2014-05-16
 */
public class JcmPoliciesRegulationsDomain implements IJcmPoliciesRegulationsDomain {

	@Reference
	private IJcmPoliciesRegulationsDao jcmPoliciesRegulationsDao;

	/**
	 * 查询 政策法规表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return jcmPoliciesRegulationsDao.query(pset);
	}

	/**
	 * 获取 政策法规表
	 * @param pset
	 * @return
	 */
	public JcmPoliciesRegulations get(String prId) {
		return jcmPoliciesRegulationsDao.get(prId);
	}

	/**
	 * 增加 政策法规表
	 * @param jcmPoliciesRegulations
	 */
	public void insert(JcmPoliciesRegulations jcmPoliciesRegulations) {
		jcmPoliciesRegulationsDao.insert(jcmPoliciesRegulations);
	}
	
	/**
	 * 修改 政策法规表
	 * @param jcmPoliciesRegulations
	 */
	public void update(JcmPoliciesRegulations jcmPoliciesRegulations) {
		jcmPoliciesRegulationsDao.update(jcmPoliciesRegulations);
	}
	
	/**
	 * 删除 政策法规表
	 * @param prId
	 */
	public void delete(String prId) {
		jcmPoliciesRegulationsDao.delete(prId);
	}

}