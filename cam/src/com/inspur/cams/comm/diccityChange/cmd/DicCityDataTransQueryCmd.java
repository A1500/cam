package com.inspur.cams.comm.diccityChange.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.diccityChange.domain.IDicCityDataTransDomain;

/**
 * 数据迁移查询cmd
 * @author 
 * @date 2013-12-23
 */
public class DicCityDataTransQueryCmd extends BaseQueryCommand {

	private IDicCityDataTransDomain dicCityDataTransDomain = ScaComponentFactory
			.getService(IDicCityDataTransDomain.class, "dicCityDataTransDomain/dicCityDataTransDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return dicCityDataTransDomain.query(pset);
	}
	public DataSet getUnder() {
		ParameterSet pset = getParameterSet();
		return dicCityDataTransDomain.getUnder(pset);
	}
}