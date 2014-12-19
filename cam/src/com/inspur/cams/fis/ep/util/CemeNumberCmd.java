package com.inspur.cams.fis.ep.util;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import com.inspur.cams.fis.ep.base.dao.jdbc.FisCemeDao;
import com.inspur.cams.fis.ep.base.data.FisCeme;

public class CemeNumberCmd extends BaseAjaxCommand {
	public void execute() {
		ParameterSet pset = getParameterSet();
		FisCemeDao dao = (FisCemeDao) DaoFactory
				.getDao("com.inspur.cams.fis.ep.base.dao.jdbc.FisCemeDao");
		DataSet ds = dao.queryCemeMaxNum(pset);
		String max = (String)ds.getRecord(0).get("MAX_NUM");
		if("01".equals(max)) {
			setReturn("cemeNumber", "01");
		}else {
			max = (Integer.parseInt(max)+1)+"";
			max = max.length()>=2 ? max : "0"+max;
			setReturn("cemeNumber", max);
		}
	}
}
