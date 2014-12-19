package com.inspur.cams.jcm.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.jcm.data.JcmPoliciesRegulations;

/**
 * 政策法规表domain
 * @author 
 * @date 2014-05-16
 */
public interface IJcmPoliciesRegulationsDomain {

	/**
	 * 查询 政策法规表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 政策法规表
	 * @param pset
	 * @return
	 */
	public JcmPoliciesRegulations get(String prId);

	/**
	 * 增加 政策法规表
	 * @param jcmPoliciesRegulations
	 */
	@Trans
	public void insert(JcmPoliciesRegulations jcmPoliciesRegulations);
	
	/**
	 * 修改 政策法规表
	 * @param jcmPoliciesRegulations
	 */
	@Trans
	public void update(JcmPoliciesRegulations jcmPoliciesRegulations);
	
	/**
	 * 删除 政策法规表
	 * @param prId
	 */
	@Trans
	public void delete(String prId);

}