package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.domain.ISomFeeDomain;

/**
 * 会费备案查询cmd
 * @author shgtch
 * @date 2011-10-8
 */
public class SomFeeQueryCmd extends BaseQueryCommand {
	
	private ISomFeeDomain somFeeDomain = ScaComponentFactory.getService(ISomFeeDomain.class, "somFeeDomain/somFeeDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return somFeeDomain.query(pset);
	}
	
	public DataSet queryFee() {
		ParameterSet pset = getParameterSet();
		return somFeeDomain.queryFee(pset);
	}
	
}
