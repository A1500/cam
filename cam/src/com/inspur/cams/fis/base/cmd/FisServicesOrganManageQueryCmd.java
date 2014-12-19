package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IFisServicesOrganManageDomain;

/**
 * 殡葬服务机构信息表查询cmd
 * @author 
 * @date Wed May 02 09:01:05 GMT+08:00 2012
 */
public class FisServicesOrganManageQueryCmd extends BaseQueryCommand {

	private IFisServicesOrganManageDomain fisServicesOrganManageDomain = ScaComponentFactory
			.getService(IFisServicesOrganManageDomain.class, "fisServicesOrganManageDomain/fisServicesOrganManageDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return fisServicesOrganManageDomain.query(pset);
	}
	
}