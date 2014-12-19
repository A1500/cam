package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IFisPageInfoDomain;

/**
 * 页面信息表查询cmd
 * @author 
 * @date 2012-07-16
 */
public class FisPageInfoQueryCmd extends BaseQueryCommand {

	private IFisPageInfoDomain fisPageInfoDomain = ScaComponentFactory
			.getService(IFisPageInfoDomain.class, "fisPageInfoDomain/fisPageInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return fisPageInfoDomain.query(pset);
	}
	
}