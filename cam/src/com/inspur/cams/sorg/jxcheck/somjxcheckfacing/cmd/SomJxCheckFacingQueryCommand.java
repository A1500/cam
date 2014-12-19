package com.inspur.cams.sorg.jxcheck.somjxcheckfacing.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.jxcheck.somjxcheckfacing.dao.*;

/**
 * @title:SomJxCheckFacingQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckFacingQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxCheckFacing> dao = (EntityDao<SomJxCheckFacing>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckfacing.dao.SomJxCheckFacingDao");
		return dao.query(pset);
	}
}
