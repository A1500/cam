package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcServiceFacilitiesDomain;

/**
 * @title:CdcServiceFacilitiesQueryCommand
 * @description:
 * @author:
 * @since:2012-02-29
 * @version:1.0
*/
public class CdcServiceFacilitiesQueryCmd extends BaseQueryCommand{
	private ICdcServiceFacilitiesDomain cdcServiceFacilitiesDomain = (ICdcServiceFacilitiesDomain) ScaComponentFactory
	.getService(ICdcServiceFacilitiesDomain.class, "cdcServiceFacilitiesDomain/cdcServiceFacilitiesDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcServiceFacilitiesDomain.query(pset);
	}
	
	public DataSet queryList(){
		ParameterSet pset = getParameterSet();
		return cdcServiceFacilitiesDomain.queryList(pset);
	}
}
