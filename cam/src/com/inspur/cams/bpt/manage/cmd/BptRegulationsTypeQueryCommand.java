package com.inspur.cams.bpt.manage.cmd;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.bpt.base.data.BptRegulationsType;

/**
 * @title:BptRegulationsTypeQueryCommand
 * @description:
 * @author:
 * @since:2011-12-13
 * @version:1.0
*/
public class BptRegulationsTypeQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<BptRegulationsType> dao = (EntityDao<BptRegulationsType>) DaoFactory
				.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptRegulationsTypeDao");
		return dao.query(pset);
	}
}
