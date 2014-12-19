package com.inspur.cams.comm.print.dao.jdbc;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.print.dao.IPrintDao;
import com.inspur.cams.marry.base.data.MrmBasePerson;
import com.inspur.cams.marry.base.domain.IMrmRegisOrganInfoDomain;

public class MrmLevelApplyDao extends IPrintDao{

	@Override
	public DataSet queryData(ParameterSet pset) {
		String deptId = (String) pset.getParameter("deptId");
		IMrmRegisOrganInfoDomain domain = ScaComponentFactory.getService(
				IMrmRegisOrganInfoDomain.class, "MrmRegisOrganInfoDomain/MrmRegisOrganInfoDomain");
		return domain.getOrganInfo(pset);
	}

	@Override
	protected Class getEntityClass() {
		return MrmBasePerson.class;
	}

}
