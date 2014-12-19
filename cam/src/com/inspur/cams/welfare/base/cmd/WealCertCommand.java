package com.inspur.cams.welfare.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.welfare.base.dao.support.WealCertDao;
import com.inspur.cams.welfare.base.data.WealCert;

/**
 * WealCertCommand
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
public class WealCertCommand extends BaseAjaxCommand{
	private WealCertDao dao = (WealCertDao) DaoFactory
			.getDao("com.inspur.cams.welfare.base.dao.support.WealCertDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		WealCert dataBean=(WealCert)record.toBean(WealCert.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		WealCert dataBean=(WealCert)record.toBean(WealCert.class);
		dao.update(dataBean);
	}
	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
}
