package com.inspur.cams.fis.ep.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.fis.ep.base.data.FisCemeGovApproval;

/**
 * @title: FisCemeGovApprovalCmd
 * @description:公墓政府批准信息cmd
 * @author:lidongdong(xxz)
 * @since:2011-11-14
 * @version:1.0
 */
public class FisCemeGovApprovalCmd extends BaseQueryCommand {
	@SuppressWarnings("unchecked")
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<FisCemeGovApproval> dao = (EntityDao<FisCemeGovApproval>) DaoFactory
				.getDao("com.inspur.cams.fis.ep.base.dao.jdbc.FisCemeGovApprovalDao");
		return dao.query(pset);
	}
}
