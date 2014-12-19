package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IFisCremationRateDomain;

/**
 * 火化率计算表查询cmd
 * @author 
 * @date Thu Apr 19 18:46:28 GMT+08:00 2012
 */
public class FisCremationRateQueryCmd extends BaseQueryCommand {

	private IFisCremationRateDomain fisCremationRateDomain = ScaComponentFactory
			.getService(IFisCremationRateDomain.class, "fisCremationRateDomain/fisCremationRateDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return fisCremationRateDomain.query(pset);
	}
	
	public DataSet queryCremationSum() {
		ParameterSet pset = getParameterSet();
		return fisCremationRateDomain.queryCremationSum(pset);
	}
	
	public DataSet queryCremationRateList() {
		ParameterSet pset = getParameterSet();
		return fisCremationRateDomain.queryCremationRateList(pset);
	}
	
}