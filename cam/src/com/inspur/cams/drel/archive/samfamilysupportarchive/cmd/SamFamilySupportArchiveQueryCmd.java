package com.inspur.cams.drel.archive.samfamilysupportarchive.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.archive.samfamilysupportarchive.domain.ISamFamilySupportArchiveDomain;

/**
 * 赡扶抚养人查询cmd
 * @author 
 * @date 2012-06-28
 */
public class SamFamilySupportArchiveQueryCmd extends BaseQueryCommand {

	private ISamFamilySupportArchiveDomain samFamilySupportArchiveDomain = ScaComponentFactory
			.getService(ISamFamilySupportArchiveDomain.class, "samFamilySupportArchiveDomain/samFamilySupportArchiveDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samFamilySupportArchiveDomain.query(pset);
	}
	
}