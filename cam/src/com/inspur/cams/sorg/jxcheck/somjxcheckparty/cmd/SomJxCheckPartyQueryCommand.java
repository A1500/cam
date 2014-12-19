package com.inspur.cams.sorg.jxcheck.somjxcheckparty.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.jxcheck.somjxcheckparty.dao.*;

/**
 * @title:SomJxCheckPartyQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckPartyQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxCheckParty> dao = (EntityDao<SomJxCheckParty>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckparty.dao.SomJxCheckPartyDao");
		return dao.query(pset);
	}
}
