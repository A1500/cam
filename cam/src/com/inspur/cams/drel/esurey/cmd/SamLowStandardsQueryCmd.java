package com.inspur.cams.drel.esurey.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.esurey.domain.ISamLowStandardsDomain;

/**
 * @title:SamLowStandardsQueryCommand
 * @description:
 * @author:
 * @since:2011-07-06
 * @version:1.0
*/
public class SamLowStandardsQueryCmd extends BaseQueryCommand{
	private ISamLowStandardsDomain service = 
			ScaComponentFactory.getService(ISamLowStandardsDomain.class,"SamLowStandardsDomain/SamLowStandardsDomain");
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return service.query(pset);
	}
}
