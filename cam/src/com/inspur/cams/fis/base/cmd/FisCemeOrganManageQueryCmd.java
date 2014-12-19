package com.inspur.cams.fis.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.dao.*;
import com.inspur.cams.fis.base.domain.IFisCemeOrganManageDomain;

/**
 * @title:FisCemeOrganManageQueryCommand
 * @description:
 * @author:
 * @since:2012-04-03
 * @version:1.0
 */
public class FisCemeOrganManageQueryCmd extends BaseQueryCommand {

	private IFisCemeOrganManageDomain service = ScaComponentFactory.getService(IFisCemeOrganManageDomain.class, "FisCemeOrganManageDomain/FisCemeOrganManageDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return service.query(pset);
	}
}
