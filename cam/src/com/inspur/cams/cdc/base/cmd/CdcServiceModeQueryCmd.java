package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcServiceModeDomain;

/**
 * 基础信息社区服务方式信息表查询cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcServiceModeQueryCmd extends BaseQueryCommand {

	private ICdcServiceModeDomain cdcServiceModeDomain = ScaComponentFactory
			.getService(ICdcServiceModeDomain.class, "cdcServiceModeDomain/cdcServiceModeDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcServiceModeDomain.query(pset);
	}
	
	public DataSet queryList(){
		ParameterSet pset = getParameterSet();
		return cdcServiceModeDomain.queryList(pset);
	}
}