package com.inspur.cams.sorg.jxcheck.somjxcommonwealdetail.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.jxcheck.somjxcommonwealdetail.dao.*;

/**
 * @title:SomJxCommonwealDetailQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCommonwealDetailQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxCommonwealDetail> dao = (EntityDao<SomJxCommonwealDetail>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxcommonwealdetail.dao.SomJxCommonwealDetailDao");
		return dao.query(pset);
	}
}
