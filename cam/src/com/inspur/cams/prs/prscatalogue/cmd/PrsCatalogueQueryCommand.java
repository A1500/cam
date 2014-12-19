package com.inspur.cams.prs.prscatalogue.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.prs.prscatalogue.dao.PrsCatalogue;


/**
 * @title:PrsCatalogueQueryCommand
 * @description:
 * @author:
 * @since:2011-12-06
 * @version:1.0
*/
public class PrsCatalogueQueryCommand extends BaseQueryCommand{

	@SuppressWarnings("unchecked")
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<PrsCatalogue> dao = (EntityDao<PrsCatalogue>) DaoFactory
				.getDao("com.inspur.cams.prs.prscatalogue.dao.PrsCatalogueDao");
		return dao.query(pset);
	}
}
