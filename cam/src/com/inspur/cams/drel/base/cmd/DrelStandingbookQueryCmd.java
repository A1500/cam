package com.inspur.cams.drel.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.base.domain.IDrelStandingbookDomain;

/**
 * 台账表查询cmd
 * @author 
 * @date 2013-09-09
 */
public class DrelStandingbookQueryCmd extends BaseQueryCommand {

	private IDrelStandingbookDomain drelStandingbookDomain = ScaComponentFactory
			.getService(IDrelStandingbookDomain.class, "drelStandingbookDomain/drelStandingbookDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return drelStandingbookDomain.query(pset);
	}
	//台账导出查询
	public DataSet queryInfo(){
		ParameterSet pset = getParameterSet();
		return drelStandingbookDomain.queryInfo(pset);
	}
	
}