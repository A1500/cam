package com.inspur.cams.jcm.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.domain.IDicCompanyTypeDomain;

/**
 * 单位所属类别查询cmd
 * @author 
 * @date 2014-05-21
 */
public class DicCompanyTypeQueryCmd extends BaseQueryCommand {

	private IDicCompanyTypeDomain dicCompanyTypeDomain = ScaComponentFactory
			.getService(IDicCompanyTypeDomain.class, "dicCompanyTypeDomain/dicCompanyTypeDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return dicCompanyTypeDomain.query(pset);
	}
	
}