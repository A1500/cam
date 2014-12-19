package com.inspur.cams.sorg.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.base.data.SomPartyMemberStatusChange;

/**
 * @title:SomPartyMemberStatusChangeQueryCommand
 * @description:
 * @author:
 * @since:2012-08-21
 * @version:1.0
*/
public class SomPartyMemberStatusChangeQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomPartyMemberStatusChange> dao = (EntityDao<SomPartyMemberStatusChange>) DaoFactory
				.getDao("com.inspur.cams.sorg.base.dao.jdbc.SomPartyMemberStatusChangeDao");
		return dao.query(pset);
	}
}
