package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IFisCemeLogoffDomain;

/**
 * 公墓撤销备案表查询cmd
 * @author 
 * @date 2013-08-01
 */
public class FisCemeLogoffQueryCmd extends BaseQueryCommand {

	private IFisCemeLogoffDomain fisCemeLogoffDomain = ScaComponentFactory
			.getService(IFisCemeLogoffDomain.class, "fisCemeLogoffDomain/fisCemeLogoffDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return fisCemeLogoffDomain.query(pset);
	}
	
}