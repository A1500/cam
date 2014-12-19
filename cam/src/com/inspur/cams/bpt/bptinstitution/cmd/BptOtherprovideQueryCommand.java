package com.inspur.cams.bpt.bptinstitution.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.bpt.bptinstitution.data.BptOtherprovide;

/**
 * @title:BptOtherprovideQueryCommand
 * @description:
 * @author:
 * @since:2011-12-05
 * @version:1.0
*/
public class BptOtherprovideQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<BptOtherprovide> dao = (EntityDao<BptOtherprovide>) DaoFactory
				.getDao("com.inspur.cams.bpt.bptinstitution.dao.jdbc.BptOtherprovideDao");
		return dao.query(pset);
	}
}
