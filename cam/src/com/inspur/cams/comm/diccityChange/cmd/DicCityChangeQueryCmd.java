package com.inspur.cams.comm.diccityChange.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.diccityChange.domain.IDicCityChangeDomain;

/**
 * 行政区划变更查询cmd
 * @author 
 * @date 2013-12-23
 */
public class DicCityChangeQueryCmd extends BaseQueryCommand {

	private IDicCityChangeDomain dicCityChangeDomain = ScaComponentFactory
			.getService(IDicCityChangeDomain.class, "dicCityChangeDomain/dicCityChangeDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return dicCityChangeDomain.query(pset);
	}
	
}