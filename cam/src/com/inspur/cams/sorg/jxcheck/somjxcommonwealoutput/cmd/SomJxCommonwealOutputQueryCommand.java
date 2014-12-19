package com.inspur.cams.sorg.jxcheck.somjxcommonwealoutput.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.jxcheck.somjxcommonwealoutput.dao.*;

/**
 * @title:SomJxCommonwealOutputQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCommonwealOutputQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxCommonwealOutput> dao = (EntityDao<SomJxCommonwealOutput>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxcommonwealoutput.dao.SomJxCommonwealOutputDao");
		return dao.query(pset);
	}
}
