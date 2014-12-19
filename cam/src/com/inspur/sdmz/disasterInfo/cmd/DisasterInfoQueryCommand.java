package com.inspur.sdmz.disasterInfo.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.sdmz.disasterInfo.dao.*;

/**
 * @title:DisasterInfoQueryCommand
 * @description:
 * @author:
 * @since:2011-09-13
 * @version:1.0
*/
public class DisasterInfoQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<DisasterInfo> dao = (EntityDao<DisasterInfo>) DaoFactory.getDao("com.inspur.sdmz.disasterInfo.dao.DisasterInfoDao");
		return dao.query(pset);
	}
}
