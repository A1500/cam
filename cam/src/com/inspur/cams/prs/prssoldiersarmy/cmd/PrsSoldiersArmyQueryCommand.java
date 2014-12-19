package com.inspur.cams.prs.prssoldiersarmy.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.prs.prssoldiersarmy.dao.PrsSoldiersArmyDao;

/**
 * @title:PrsSoldiersArmyQueryCommand
 * @description:
 * @author:
 * @since:2011-08-18
 * @version:1.0
*/
public class PrsSoldiersArmyQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		PrsSoldiersArmyDao dao = (PrsSoldiersArmyDao) DaoFactory
				.getDao("com.inspur.cams.prs.prssoldiersarmy.dao.PrsSoldiersArmyDao");
		return dao.queryBySoldierId(pset);
	}
}
