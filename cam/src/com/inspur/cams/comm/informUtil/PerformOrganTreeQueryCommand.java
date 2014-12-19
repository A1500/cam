package com.inspur.cams.comm.informUtil;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

public class PerformOrganTreeQueryCommand extends BaseQueryCommand {


	public DataSet execute(){
		ParameterSet pset = getParameterSet();
		DataSet ds = new DataSet();

		String code	=(String)pset.getParameter("code");

		PerformOrganTreeDao dao = (PerformOrganTreeDao)DaoFactory.getDao("com.inspur.cams.comm.informUtil.PerformOrganTreeDao");
			ds = dao.query(code);

		return ds;
	}
}