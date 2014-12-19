package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.bpt.base.data.BptContentNumMaintain;

/**
 * @title:BptContentNumMaintainQueryCommand
 * @description:目录号维护
 * @author:
 * @since:2011-07-22
 * @version:1.0
*/
public class BptContentNumMaintainQueryCommand extends BaseQueryCommand{

	@SuppressWarnings("unchecked")
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<BptContentNumMaintain> dao = (EntityDao<BptContentNumMaintain>) DaoFactory.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptContentNumMaintainDao");
		return dao.query(pset);
	}
}
