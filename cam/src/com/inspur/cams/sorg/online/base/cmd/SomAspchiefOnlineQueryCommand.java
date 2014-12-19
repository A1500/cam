package com.inspur.cams.sorg.online.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.online.base.data.SomAspchiefOnline;

/**
 * @title:SomAspchiefOnlineQueryCommand
 * @description:
 * @author:
 * @since:2012-11-06
 * @version:1.0
*/
public class SomAspchiefOnlineQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomAspchiefOnline> dao = (EntityDao<SomAspchiefOnline>) DaoFactory
				.getDao("com.inspur.cams.sorg.online.base.dao.support.SomAspchiefOnlineDao");
		return dao.query(pset);
	}
}
