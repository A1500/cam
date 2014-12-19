package com.inspur.cams.sorg.online.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.online.base.dao.support.SomDutyOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomDutyOnline;

/**
 * @title:SomDutyOnlineQueryCommand
 * @description:
 * @author:
 * @since:2012-11-08
 * @version:1.0
*/
public class SomDutyOnlineQueryCommand extends BaseQueryCommand{
	private SomDutyOnlineDao onlineDao = (SomDutyOnlineDao) DaoFactory
	.getDao("com.inspur.cams.sorg.online.base.dao.support.SomDutyOnlineDao");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomDutyOnline> dao = (EntityDao<SomDutyOnline>) DaoFactory
				.getDao("com.inspur.cams.sorg.online.base.dao.support.SomDutyOnlineDao");
		return dao.query(pset);
	}
	
	/**
	 * 查询带有人员信息的任职信息
	 * @return
	 */
	public DataSet queryPeople() {
		ParameterSet pset = getParameterSet();
		return onlineDao.queryPeople(pset);
	}
}
