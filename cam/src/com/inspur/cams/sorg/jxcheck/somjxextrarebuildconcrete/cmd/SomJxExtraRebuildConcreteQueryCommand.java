package com.inspur.cams.sorg.jxcheck.somjxextrarebuildconcrete.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.jxcheck.somjxextrarebuildconcrete.dao.SomJxExtraRebuildConcrete;

/**
 * @title:SomJxExtraRebuildConcreteQueryCommand
 * @description:
 * @author:
 * @since:2012-01-16
 * @version:1.0
*/
public class SomJxExtraRebuildConcreteQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxExtraRebuildConcrete> dao = (EntityDao<SomJxExtraRebuildConcrete>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxextrarebuild.dao.SomJxExtraRebuildConcreteDao");
		return dao.query(pset);
	}
}
