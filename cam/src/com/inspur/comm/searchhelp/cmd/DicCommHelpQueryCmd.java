package com.inspur.comm.searchhelp.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.comm.searchhelp.domain.ICommHelpDomain;

/**
 * 查询通用帮助配置
 * @author shgtch
 * @date 2011-6-13
 */
public class DicCommHelpQueryCmd extends BaseQueryCommand {
	
	private ICommHelpDomain commHelpDomain = (ICommHelpDomain) ScaComponentFactory.getService(ICommHelpDomain.class, "commHelpDomain/commHelpDomain");
	
	/**
	 * 查询通用帮助配置
	 * @return
	 */
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return commHelpDomain.query(pset);
	}
	
}
