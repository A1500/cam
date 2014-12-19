package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcMailListDomain;

/**
 *基层民主与社区建设通讯录cmd
 * @author shgtch
 * @date 2012-3-1
 */
public class CdcMailListQueryCmd extends BaseQueryCommand {

	private ICdcMailListDomain cdcMailListDomain = ScaComponentFactory
			.getService(ICdcMailListDomain.class, "cdcMailListDomain/cdcMailListDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcMailListDomain.query(pset);
	}
	public DataSet queryList() {
		ParameterSet pset = getParameterSet();
		return cdcMailListDomain.queryList(pset);
	}
	
}