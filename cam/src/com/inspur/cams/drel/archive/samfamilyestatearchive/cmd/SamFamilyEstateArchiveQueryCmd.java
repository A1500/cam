package com.inspur.cams.drel.archive.samfamilyestatearchive.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.archive.samfamilyestatearchive.domain.ISamFamilyEstateArchiveDomain;

/**
 * 家庭财产信息查询cmd
 * @author 
 * @date 2012-06-28
 */
public class SamFamilyEstateArchiveQueryCmd extends BaseQueryCommand {

	private ISamFamilyEstateArchiveDomain samFamilyEstateArchiveDomain = ScaComponentFactory
			.getService(ISamFamilyEstateArchiveDomain.class, "samFamilyEstateArchiveDomain/samFamilyEstateArchiveDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samFamilyEstateArchiveDomain.query(pset);
	}
	
}