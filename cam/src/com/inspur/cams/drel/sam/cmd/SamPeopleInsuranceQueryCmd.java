package com.inspur.cams.drel.sam.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.drel.sam.dao.jdbc.SamPeopleInsuranceDao;

/**
 * @title:社会保险queryCmd
 * @description:
 * @author:
 * @since:2012-05-03
 * @version:1.0
*/
public class SamPeopleInsuranceQueryCmd extends BaseQueryCommand {
	public DataSet execute() {
		SamPeopleInsuranceDao dao = (SamPeopleInsuranceDao) DaoFactory.getDao(SamPeopleInsuranceDao.class);
		return dao.query(getParameterSet());
	}
}