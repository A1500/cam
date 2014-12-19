package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.sorg.base.domain.ISomBorgDomain;

/**
 * 业务主管单位查询
 * @author yanliangliang
 * @date 2011-6-8
 */
public class SomBorgQueryCmd extends BaseQueryCommand {
	
	private ISomBorgDomain somBorgDomain = ScaComponentFactory.getService(ISomBorgDomain.class, "somBorgDomain/somBorgDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return somBorgDomain.query(pset);
	}
	
}
