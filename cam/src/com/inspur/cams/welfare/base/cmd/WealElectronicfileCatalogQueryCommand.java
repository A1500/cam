package com.inspur.cams.welfare.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.welfare.base.data.WealElectronicfileCatalog;

/**
 * WealElectronicfileCatalogQueryCommand
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
public class WealElectronicfileCatalogQueryCommand extends BaseQueryCommand{
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<WealElectronicfileCatalog> dao = (EntityDao<WealElectronicfileCatalog>) DaoFactory
				.getDao("com.inspur.cams.welfare.base.dao.support.WealElectronicfileCatalogDao");
		return dao.query(pset);
	}
}
