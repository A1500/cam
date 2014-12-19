package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.bpt.base.data.BptAssistiveDevicesMaintena;

/**
 * @title:BptAssistiveDevicesMaintenaQueryCommand
 * @description:伤残辅助器械维护
 * @author:
 * @since:2011-05-31
 * @version:1.0
*/
public class BptAssistiveDevicesMaintenaQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<BptAssistiveDevicesMaintena> dao = (EntityDao<BptAssistiveDevicesMaintena>) DaoFactory
				.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptAssistiveDevicesMaintenaDao");
		pset.setSortField("APPLY_APPARATUS_ID");
		return dao.query(pset);
	}
}
