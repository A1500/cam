package com.inspur.cams.sorg.jxcheck.somjxcheckbalancesheet.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.jxcheck.somjxcheckbalancesheet.dao.*;

/**
 * @title:SomJxCheckBalanceSheetQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckBalanceSheetQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxCheckBalanceSheet> dao = (EntityDao<SomJxCheckBalanceSheet>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckbalancesheet.dao.SomJxCheckBalanceSheetDao");
		return dao.query(pset);
	}
}
