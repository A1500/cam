package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IFisCemeChangeDetailDomain;

/**
 * 公墓信息变更备案明细表查询cmd
 * @author 
 * @date 2013-08-01
 */
public class FisCemeChangeDetailQueryCmd extends BaseQueryCommand {

	private IFisCemeChangeDetailDomain fisCemeChangeDetailDomain = ScaComponentFactory
			.getService(IFisCemeChangeDetailDomain.class, "fisCemeChangeDetailDomain/fisCemeChangeDetailDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return fisCemeChangeDetailDomain.query(pset);
	}
	
}