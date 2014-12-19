package com.inspur.cams.sorg.check.balancesheet.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.balancesheet.data.SomCheckBalanceSheet;

/**
 * @title:SomCheckBalanceSheetQueryCommand
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
public class SomCheckBalanceSheetQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckBalanceSheet> dao = (EntityDao<SomCheckBalanceSheet>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.balancesheet.dao.SomCheckBalanceSheetDao");
		return dao.query(pset);
	}
}
