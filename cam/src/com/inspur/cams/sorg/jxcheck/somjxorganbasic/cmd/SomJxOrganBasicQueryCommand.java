package com.inspur.cams.sorg.jxcheck.somjxorganbasic.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.jxcheck.somjxorganbasic.dao.*;

/**
 * @title:SomJxOrganBasicQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxOrganBasicQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxOrganBasic> dao = (EntityDao<SomJxOrganBasic>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxorganbasic.dao.SomJxOrganBasicDao");
		return dao.query(pset);
	}
}
