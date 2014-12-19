package com.inspur.cams.sorg.jxcheck.somjxextraplanconcrete.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.jxcheck.somjxextraplanconcrete.dao.*;

/**
 * @title:SomJxExtraPlanConcreteQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxExtraPlanConcreteQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxExtraPlanConcrete> dao = (EntityDao<SomJxExtraPlanConcrete>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxextraplanconcrete.dao.SomJxExtraPlanConcreteDao");
		return dao.query(pset);
	}
}
