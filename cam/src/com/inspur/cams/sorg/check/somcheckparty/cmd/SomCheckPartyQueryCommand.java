package com.inspur.cams.sorg.check.somcheckparty.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.check.somcheckparty.dao.SomCheckParty;

/**
 * @title:SomCheckPartyQueryCommand
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
public class SomCheckPartyQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckParty> dao = (EntityDao<SomCheckParty>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.somcheckparty.dao.SomCheckPartyDao");
		return dao.query(pset);
	}
}
