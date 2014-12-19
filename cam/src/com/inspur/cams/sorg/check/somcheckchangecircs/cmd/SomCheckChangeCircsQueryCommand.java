package com.inspur.cams.sorg.check.somcheckchangecircs.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.somcheckaccountingpeople.dao.SomCheckAccountingPeople;
import com.inspur.cams.sorg.check.somcheckchangecircs.dao.SomCheckChangeCircs;

/**
 * @title:SomCheckAccountingPeopleQueryCommand
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
public class SomCheckChangeCircsQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckChangeCircs> dao = (EntityDao<SomCheckChangeCircs>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.somcheckchangecircs.dao.SomCheckChangeCircsDao");
		return dao.query(pset);
	}
}
