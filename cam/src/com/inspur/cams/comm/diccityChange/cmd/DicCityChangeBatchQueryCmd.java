package com.inspur.cams.comm.diccityChange.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.diccityChange.domain.IDicCityChangeBatchDomain;

/**
 * 变更批次表查询cmd
 * @author 
 * @date 2014-01-02
 */
public class DicCityChangeBatchQueryCmd extends BaseQueryCommand {

	private IDicCityChangeBatchDomain dicCityChangeBatchDomain = ScaComponentFactory
			.getService(IDicCityChangeBatchDomain.class, "dicCityChangeBatchDomain/dicCityChangeBatchDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return dicCityChangeBatchDomain.query(pset);
	}
	
}