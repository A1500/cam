package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IFisResourceExtendDomain;

/**
 * 墓位特征扩展表查询cmd
 * @author 
 * @date Fri Apr 13 09:45:56 GMT+08:00 2012
 */
public class FisResourceExtendQueryCmd extends BaseQueryCommand {

	private IFisResourceExtendDomain fisResourceExtendDomain = ScaComponentFactory
			.getService(IFisResourceExtendDomain.class, "FisResourceExtendDomain/FisResourceExtendDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return fisResourceExtendDomain.query(pset);
	}
	
}