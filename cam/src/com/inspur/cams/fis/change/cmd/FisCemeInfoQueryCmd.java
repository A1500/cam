package com.inspur.cams.fis.change.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.change.domain.IFisCemeChangeQueryDomain;

public class FisCemeInfoQueryCmd extends BaseQueryCommand {
	private IFisCemeChangeQueryDomain fisCemeChangeQueryDomain = ScaComponentFactory
			.getService(IFisCemeChangeQueryDomain.class,
					"fisCemeChangeQueryDomain/fisCemeChangeQueryDomain");

	// 查询经营性公墓信息
	public DataSet queryFisCemeList() {
		ParameterSet pset = getParameterSet();
		return fisCemeChangeQueryDomain.queryFisCemeList(pset);
	}

}
