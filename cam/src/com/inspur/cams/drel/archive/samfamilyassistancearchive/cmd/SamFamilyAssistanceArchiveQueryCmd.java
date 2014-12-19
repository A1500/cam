package com.inspur.cams.drel.archive.samfamilyassistancearchive.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.archive.samfamilyassistancearchive.domain.ISamFamilyAssistanceArchiveDomain;

/**
 * 社会救助_救助基本信息查询cmd
 * @author 
 * @date 2012-06-28
 */
public class SamFamilyAssistanceArchiveQueryCmd extends BaseQueryCommand {

	private ISamFamilyAssistanceArchiveDomain samFamilyAssistanceArchiveDomain = ScaComponentFactory
			.getService(ISamFamilyAssistanceArchiveDomain.class, "samFamilyAssistanceArchiveDomain/samFamilyAssistanceArchiveDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samFamilyAssistanceArchiveDomain.query(pset);
	}
	
}