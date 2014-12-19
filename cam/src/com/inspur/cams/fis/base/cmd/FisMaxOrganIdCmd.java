package com.inspur.cams.fis.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.fis.base.dao.IFisQueryMaxOrganIdDao;

/**
 * @title:FisMaxOrganIdQueryCmd
 * @description:获取最大organId Command
 * @author:liuxin
 * @since:2012-07-26
 * @version:1.0
 */
public class FisMaxOrganIdCmd extends BaseAjaxCommand {
	private IFisQueryMaxOrganIdDao dao = (IFisQueryMaxOrganIdDao) DaoFactory
			.getDao("com.inspur.cams.fis.base.dao.jdbc.FisQueryMaxOrganIdDao");

	public void query() {
		String organId = (String) getParameter("organId");
		setReturn("organId", dao.queryMaxOrganId(organId));
	}
}
