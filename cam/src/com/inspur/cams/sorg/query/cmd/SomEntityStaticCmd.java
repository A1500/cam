package com.inspur.cams.sorg.query.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.query.domain.ISomEntityStaticDomain;

public class SomEntityStaticCmd extends BaseQueryCommand {
	private ISomEntityStaticDomain service = ScaComponentFactory.getService(ISomEntityStaticDomain.class,"somEntityStaticDomain/somEntityStaticDomain");

	/**
	 * 社团举办实体统计
	 * 
	 * @return
	 */
	public DataSet groupEntityStatic() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.groupEntityStatic(pset);
		return ds;
	}
}
