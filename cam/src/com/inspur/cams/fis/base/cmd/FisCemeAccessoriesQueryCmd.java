package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IFisCemeAccessoriesDomain;

/**
 * 公墓审批附件表查询cmd
 * @author 
 * @date 2013-08-01
 */
public class FisCemeAccessoriesQueryCmd extends BaseQueryCommand {

	private IFisCemeAccessoriesDomain fisCemeAccessoriesDomain = ScaComponentFactory
			.getService(IFisCemeAccessoriesDomain.class, "fisCemeAccessoriesDomain/fisCemeAccessoriesDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return fisCemeAccessoriesDomain.query(pset);
	}
	
}