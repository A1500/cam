package com.inspur.cams.drel.archive.samfamilyhousearchive.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.archive.samfamilyhousearchive.domain.ISamFamilyHouseArchiveDomain;

/**
 * 基础信息_房屋信息查询cmd
 * @author 
 * @date 2012-06-28
 */
public class SamFamilyHouseArchiveQueryCmd extends BaseQueryCommand {

	private ISamFamilyHouseArchiveDomain samFamilyHouseArchiveDomain = ScaComponentFactory
			.getService(ISamFamilyHouseArchiveDomain.class, "samFamilyHouseArchiveDomain/samFamilyHouseArchiveDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samFamilyHouseArchiveDomain.query(pset);
	}
	
}