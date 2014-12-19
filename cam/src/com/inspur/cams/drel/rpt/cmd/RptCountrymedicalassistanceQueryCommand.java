package com.inspur.cams.drel.rpt.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.drel.rpt.dao.RptCountrymedicalassistanceDao;
import com.inspur.cams.drel.rpt.data.RptCountrymedicalassistance;

/**
 * @title:农村医疗救助工作情况查询Cmd
 * @description:
 * @author:yangliangliang
 * @since:2011-06-22
 * @version:1.0
*/
public class RptCountrymedicalassistanceQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		RptCountrymedicalassistanceDao dao = (RptCountrymedicalassistanceDao) DaoFactory
		.getDao("com.inspur.cams.drel.rpt.dao.RptCountrymedicalassistanceDao");
		return dao.query(pset);
	}
}
