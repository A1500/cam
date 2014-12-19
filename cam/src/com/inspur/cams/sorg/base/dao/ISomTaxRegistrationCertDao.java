package com.inspur.cams.sorg.base.dao;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.base.data.SomTaxRegistrationCert;

/**
 * 税务登记证备案dao接口
 * 
 * @author zhangjian
 * @date 2011-12-12
 */
public interface ISomTaxRegistrationCertDao extends
		BaseCURD<SomTaxRegistrationCert> {
	
	public void del(String taskCode);

}
