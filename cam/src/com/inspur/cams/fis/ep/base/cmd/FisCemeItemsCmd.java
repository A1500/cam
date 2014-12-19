package com.inspur.cams.fis.ep.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.fis.ep.base.data.FisCemeItems;

/**
 * @title: FisCemeItemsCmd
 * @description:公墓审批事项cmd
 * @author:lidongdong(xxz)
 * @since:2011-11-14
 * @version:1.0
 */
public class FisCemeItemsCmd extends BaseQueryCommand {
	@SuppressWarnings("unchecked")
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<FisCemeItems> dao = (EntityDao<FisCemeItems>) DaoFactory
				.getDao("com.inspur.cams.fis.ep.base.dao.jdbc.FisCemeItemsDao");
		return dao.query(pset);
	}
}
