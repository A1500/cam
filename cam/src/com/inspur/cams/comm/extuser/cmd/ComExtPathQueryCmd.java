package com.inspur.cams.comm.extuser.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.extuser.domain.IComExtPathDomain;

/**
 * 扩展页面路径配置cmd
 * @author shgtch
 * @date 2011-6-29
 */
public class ComExtPathQueryCmd extends BaseQueryCommand {
	
	// 扩展页面路径配置domain
	private IComExtPathDomain comExtPathDomain = (IComExtPathDomain) ScaComponentFactory.getService(IComExtPathDomain.class, "comExtPathDomain/comExtPathDomain");
	
	/**
	 * 查询扩展页面路径配置
	 * @return
	 */
	public DataSet execute() {
		return comExtPathDomain.queryExtPath(getParameterSet());
	}
	
}
