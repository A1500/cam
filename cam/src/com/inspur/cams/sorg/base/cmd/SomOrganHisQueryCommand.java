package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.base.data.SomOrganHis;

/**
 * @title:SomOrganHisQueryCommand
 * @description:
 * @author:
 * @since:2012-05-28
 * @version:1.0
*/
public class SomOrganHisQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomOrganHis> dao = (EntityDao<SomOrganHis>) DaoFactory
				.getDao("com.inspur.cams.sorg.base.dao.SomOrganHisDao");
		return dao.query(pset);
	}
}
