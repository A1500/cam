package com.inspur.cams.welfare.welfarecorp.query.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.welfare.base.dao.support.WealUnitStatusDao;

public class UnitStatusAndInfoQueryCmd extends BaseQueryCommand {
	private WealUnitStatusDao wealUnitStatusDao = (WealUnitStatusDao) DaoFactory
			.getDao("com.inspur.cams.welfare.base.dao.support.WealUnitStatusDao");

	// 查询信息采集列表
	public DataSet queryStatusAndInfoList() {
		ParameterSet pset = getParameterSet();
		return wealUnitStatusDao.queryStatusAndInfoList(pset);
	}
}
