package com.inspur.cams.prs.prssoldierstrain.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.prs.prssoldiersplacement.dao.PrsSoldiersPlacementDao;
import com.inspur.cams.prs.prssoldierstrain.dao.*;

/**
 * @title:PrsSoldiersTrainQueryCommand
 * @description:
 * @author:
 * @since:2011-08-19
 * @version:1.0
*/
public class PrsSoldiersTrainQueryCommand extends BaseQueryCommand{
	private PrsSoldiersTrainDao dao = (PrsSoldiersTrainDao) DaoFactory
	.getDao("com.inspur.cams.prs.prssoldierstrain.dao.PrsSoldiersTrainDao");
	@SuppressWarnings("unchecked")
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		String soldierId  = (String) pset.getParameter("SOLDIERS_ID");
		return dao.queryBySoldierId(soldierId);
	}
}
