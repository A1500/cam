package com.inspur.cams.sorg.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomTaxRegistrationCert;

/**
 * 税务登记证备案domain接口
 * 
 * @author zhangjian
 * @date 2011-12-12
 */
public interface ISomTaxRegistrationCertDomain {

	/**
	 * 查询社会组织税务登记证
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加社会组织税务登记证
	 * 
	 * @param somTaxRegistrationCert
	 */
	@Trans
	public void insert(SomTaxRegistrationCert somTaxRegistrationCert);

	/**
	 * 更新社会组织税务登记证
	 * 
	 * @param somTaxRegistrationCert
	 */
	@Trans
	public void update(SomTaxRegistrationCert somTaxRegistrationCert);
	
	@Trans
	public void del(String taskCode);
}
