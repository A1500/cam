package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IFisCemeLogoffOpinionDomain;

/**
 * 同级其它部门意见查询cmd
 * @author 
 * @date 2013-08-15
 */
public class FisCemeLogoffOpinionQueryCmd extends BaseQueryCommand {

	private IFisCemeLogoffOpinionDomain fisCemeLogoffOpinionDomain = ScaComponentFactory
			.getService(IFisCemeLogoffOpinionDomain.class, "fisCemeLogoffOpinionDomain/fisCemeLogoffOpinionDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return fisCemeLogoffOpinionDomain.query(pset);
	}
	
}