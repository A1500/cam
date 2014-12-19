package com.inspur.comm.cqm.base.cmd;

import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.bsp.share.permit.bean.RoleView;
import org.loushang.bsp.share.permit.security.provider.SecurityProviderImp;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.comm.cqm.base.domain.ICqmModuleDomain;

/**
 * 自定义统计报表模型表查询cmd
 * @author shgtch
 * @date 2012-03-16
 */
public class CqmModuleQueryCmd extends BaseQueryCommand {

	private ICqmModuleDomain cqmModuleDomain = ScaComponentFactory
			.getService(ICqmModuleDomain.class, "cqmModuleDomain/cqmModuleDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cqmModuleDomain.query(pset);
	}
	
	public DataSet queryModule() {
		ParameterSet pset = getParameterSet();
		SecurityProviderImp securityProvider = new SecurityProviderImp();
		RoleView [] roles = securityProvider.getAssignedRole(GetBspInfo.getBspInfo().getUserId());
		pset.setParameter("roles", roles);
		return cqmModuleDomain.queryModule(pset);
	}
	
}