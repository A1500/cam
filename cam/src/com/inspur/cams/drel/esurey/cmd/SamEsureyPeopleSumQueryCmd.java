package com.inspur.cams.drel.esurey.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.esurey.domain.ISamEsureyPeopleSumDomain;

/**
 * @title:SamLowStandardsQueryCommand
 * @description:
 * @author:
 * @since:2011-07-06
 * @version:1.0
*/
public class SamEsureyPeopleSumQueryCmd extends BaseQueryCommand{
	private ISamEsureyPeopleSumDomain service = 
			ScaComponentFactory.getService(ISamEsureyPeopleSumDomain.class,"SamEsureyPeopleSumDomain/SamEsureyPeopleSumDomain");
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return service.query(pset);
	}
}
