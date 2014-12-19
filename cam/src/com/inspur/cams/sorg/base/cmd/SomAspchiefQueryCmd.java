package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.domain.ISomAspchiefDomain;

/**
 * 社会组织拟任负责人查询cmd
 * @author shgtch
 * @date 2011-8-9
 */
public class SomAspchiefQueryCmd extends BaseQueryCommand {

	ISomAspchiefDomain somAspchiefDomain = ScaComponentFactory.getService(ISomAspchiefDomain.class, "somAspchiefDomain/somAspchiefDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return somAspchiefDomain.query(pset);
	}

}