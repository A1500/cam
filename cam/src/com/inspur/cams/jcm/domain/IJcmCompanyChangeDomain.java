package com.inspur.cams.jcm.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.jcm.data.JcmCompanyChange;

/**
 * 单位信息调整（多条记录过程）domain
 * @author 
 * @date 2014-05-16
 */
public interface IJcmCompanyChangeDomain {

	/**
	 * 查询 单位信息调整（多条记录过程）
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 单位信息调整（多条记录过程）
	 * @param pset
	 * @return
	 */
	public JcmCompanyChange get(String companyChangeId);

	/**
	 * 增加 单位信息调整（多条记录过程）
	 * @param jcmCompanyChange
	 */
	@Trans
	public void insert(JcmCompanyChange jcmCompanyChange);
	
	/**
	 * 修改 单位信息调整（多条记录过程）
	 * @param jcmCompanyChange
	 */
	@Trans
	public void update(JcmCompanyChange jcmCompanyChange);
	
	/**
	 * 删除 单位信息调整（多条记录过程）
	 * @param companyChangeId
	 */
	@Trans
	public void delete(String companyChangeId);

}