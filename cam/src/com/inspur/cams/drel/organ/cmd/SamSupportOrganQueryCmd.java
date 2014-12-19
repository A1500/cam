package com.inspur.cams.drel.organ.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.organ.domain.ISamSupportOrganDomain;

/**
 * @title:SamSupportOrganQueryCommand
 * @description:孤儿院、敬老院查询CMD
 * @author:douyn
 * @since:2012-05-21
 * @version:1.0
*/
public class SamSupportOrganQueryCmd extends BaseQueryCommand{
	
	private ISamSupportOrganDomain samSupportOrganDomain = 
		ScaComponentFactory.getService(ISamSupportOrganDomain.class,
				"samSupportOrganDomain/samSupportOrganDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samSupportOrganDomain.query(pset);
	}
}
