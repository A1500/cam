package com.inspur.cams.drel.esurey.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.esurey.domain.ISamEsureyOrganConfigDomain;

/**
 * @title:SamEsureyOrganConfigQueryCommand
 * @description:
 * @author:
 * @since:2011-07-05
 * @version:1.0
*/
public class SamEsureyOrganConfigQueryCmd extends BaseQueryCommand{

	private ISamEsureyOrganConfigDomain samEsureyOrganConfigDomain = 
		ScaComponentFactory.getService(ISamEsureyOrganConfigDomain.class,
				"SamEsureyOrganConfigDomain/SamEsureyOrganConfigDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samEsureyOrganConfigDomain.query(pset);
	}
}
