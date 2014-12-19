package com.inspur.cams.sorg.online.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.online.base.data.SomPartyMemberOnline;

/**
 * @title:SomPartyMemberOnlineQueryCommand
 * @description:
 * @author:
 * @since:2012-11-09
 * @version:1.0
*/
public class SomPartyMemberOnlineQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomPartyMemberOnline> dao = (EntityDao<SomPartyMemberOnline>) DaoFactory
				.getDao("com.inspur.cams.sorg.online.base.dao.support.SomPartyMemberOnlineDao");
		return dao.query(pset);
	}
}
