package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.bpt.base.data.BptApplyCountryside;

/**
 * @title:BptApplyCountrysideQueryCommand
 * @description:
 * @author:
 * @since:2011-06-16
 * @version:1.0
*/
public class BptApplyCountrysideQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<BptApplyCountryside> dao = (EntityDao<BptApplyCountryside>) DaoFactory
				.getDao("org.bptapplycountryside.dao.BptApplyCountrysideDao");
		return dao.query(pset);
	}
}
