package com.inspur.cams.sorg.jxcheck.somjxcheckpunnish.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.jxcheck.somjxcheckpunnish.dao.*;

/**
 * @title:SomJxCheckPunnishQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckPunnishQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxCheckPunnish> dao = (EntityDao<SomJxCheckPunnish>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckpunnish.dao.SomJxCheckPunnishDao");
		return dao.query(pset);
	}
}
