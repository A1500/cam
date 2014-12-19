package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IFisCemeChangeDomain;

/**
 * 公墓信息变更备案表查询cmd
 * @author 
 * @date 2013-08-01
 */
public class FisCemeChangeQueryCmd extends BaseQueryCommand {

	private IFisCemeChangeDomain fisCemeChangeDomain = ScaComponentFactory
			.getService(IFisCemeChangeDomain.class, "fisCemeChangeDomain/fisCemeChangeDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return fisCemeChangeDomain.query(pset);
	}
	
}