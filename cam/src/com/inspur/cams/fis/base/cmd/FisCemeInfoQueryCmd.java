package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IFisCemeInfoDomain;

/**
 * 殡葬业务公墓信息表查询cmd
 * @author 
 * @date 2013-08-01
 */
public class FisCemeInfoQueryCmd extends BaseQueryCommand {

	private IFisCemeInfoDomain fisCemeInfoDomain = ScaComponentFactory
			.getService(IFisCemeInfoDomain.class, "fisCemeInfoDomain/fisCemeInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return fisCemeInfoDomain.query(pset);
	}
	
}