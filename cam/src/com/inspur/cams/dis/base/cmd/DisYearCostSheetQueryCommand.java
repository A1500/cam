package com.inspur.cams.dis.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.dis.base.data.DisYearCostSheet;

/**
 * @title:DisYearCostSheetQueryCommand
 * @description:
 * @author:
 * @since:2012-10-09
 * @version:1.0
*/
public class DisYearCostSheetQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<DisYearCostSheet> dao = (EntityDao<DisYearCostSheet>) DaoFactory
				.getDao("com.inspur.cams.dis.base.dao.support.DisYearCostSheetDao");
		return dao.query(pset);
	}
}
