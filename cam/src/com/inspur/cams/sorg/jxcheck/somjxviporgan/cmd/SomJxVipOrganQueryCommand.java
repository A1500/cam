package com.inspur.cams.sorg.jxcheck.somjxviporgan.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.jxcheck.somjxviporgan.dao.*;

/**
 * @title:SomJxVipOrganQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxVipOrganQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxVipOrgan> dao = (EntityDao<SomJxVipOrgan>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxviporgan.dao.SomJxVipOrganDao");
		return dao.query(pset);
	}
}
