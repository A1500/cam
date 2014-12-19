package com.inspur.cams.sorg.jxcheck.somjxextrarebuild.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.jxcheck.somjxextrarebuild.dao.*;

/**
 * @title:SomJxExtraRebuildQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxExtraRebuildQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxExtraRebuild> dao = (EntityDao<SomJxExtraRebuild>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxextrarebuild.dao.SomJxExtraRebuildDao");
		return dao.query(pset);
	}
}
