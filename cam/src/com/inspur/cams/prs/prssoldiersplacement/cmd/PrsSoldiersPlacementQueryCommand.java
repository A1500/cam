package com.inspur.cams.prs.prssoldiersplacement.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.prs.prssoldiersplacement.dao.PrsSoldiersPlacementDao;

/**
 * @title:PrsSoldiersPlacementQueryCommand
 * @description:
 * @author:
 * @since:2011-08-15
 * @version:1.0
*/
public class PrsSoldiersPlacementQueryCommand extends BaseQueryCommand{
	
	private PrsSoldiersPlacementDao dao = (PrsSoldiersPlacementDao) DaoFactory
	.getDao("com.inspur.cams.prs.prssoldiersplacement.dao.PrsSoldiersPlacementDao");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		String soldierId  = (String) pset.getParameter("SOLDIERS_ID");
		return dao.queryBySoldierId(soldierId);
	}
}
