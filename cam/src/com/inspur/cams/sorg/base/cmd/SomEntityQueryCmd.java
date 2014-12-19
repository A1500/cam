package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.domain.ISomEntityDomain;

/**
 * 举办实体备案查询
 * @author shgtch
 * @date 2011-10-13
 */
public class SomEntityQueryCmd extends BaseQueryCommand {
	
	private ISomEntityDomain somEntityDomain = ScaComponentFactory.getService(
			ISomEntityDomain.class, "somEntityDomain/somEntityDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return somEntityDomain.query(pset);
	}
	
}
