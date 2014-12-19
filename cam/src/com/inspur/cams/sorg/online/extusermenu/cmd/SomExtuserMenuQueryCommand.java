package com.inspur.cams.sorg.online.extusermenu.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.online.extusermenu.data.SomExtuserMenu;

/**
 * @title:SomExtuserMenuQueryCommand
 * @description:
 * @author:
 * @since:2012-11-01
 * @version:1.0
*/
public class SomExtuserMenuQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomExtuserMenu> dao = (EntityDao<SomExtuserMenu>) DaoFactory
				.getDao("com.inspur.cams.sorg.online.extusermenu.dao.support.SomExtuserMenuDao");
		return dao.query(pset);
	}
}
