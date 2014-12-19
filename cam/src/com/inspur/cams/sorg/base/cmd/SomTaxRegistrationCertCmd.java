package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.data.SomTaxRegistrationCert;
import com.inspur.cams.sorg.base.domain.ISomTaxRegistrationCertDomain;

/**
 * 税务登记证备案保存和修改
 * 
 * @author zhangjian
 * @date 2011-12-12
 */
public class SomTaxRegistrationCertCmd extends BaseAjaxCommand {

	private ISomTaxRegistrationCertDomain somTaxRegistrationCertDomain = ScaComponentFactory
			.getService(ISomTaxRegistrationCertDomain.class,
					"somTaxRegistrationCertDomain/somTaxRegistrationCertDomain");

	// 插入
	public void insert() {
		Record record = (Record) getParameter("somTaxCertRecord");
		SomTaxRegistrationCert somTaxRegistrationCert = (SomTaxRegistrationCert) record
				.toBean(SomTaxRegistrationCert.class);
		somTaxRegistrationCertDomain.insert(somTaxRegistrationCert);
	}

	// 更新
	public void update() {
		Record record = (Record) getParameter("somTaxCertRecord");
		SomTaxRegistrationCert somTaxRegistrationCert = (SomTaxRegistrationCert) record
				.toBean(SomTaxRegistrationCert.class);
		somTaxRegistrationCertDomain.update(somTaxRegistrationCert);
	}
	
	public void del() {
		String taskCode = (String) getParameter("taskCode");
		somTaxRegistrationCertDomain.del(taskCode);
	}
}
