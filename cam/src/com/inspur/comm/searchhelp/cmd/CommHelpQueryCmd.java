package com.inspur.comm.searchhelp.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.comm.searchhelp.domain.ICommHelpDomain;

/**
 * 通用帮助数据查询Cmd
 * @author shgtch
 * @date 2011-5-31
 */
public class CommHelpQueryCmd extends BaseQueryCommand {
	
	// 通用帮助Domain
	private ICommHelpDomain commHelpDomain = (ICommHelpDomain) ScaComponentFactory.getService(ICommHelpDomain.class, "commHelpDomain/commHelpDomain");
	
	/**
	 * 通用帮助窗口查询字典集合
	 * @return
	 */
	public DataSet forhelp() {
		String helpId = (String) getParameter("helpId");
		return commHelpDomain.getHelpDataset(getParameterSet(), helpId);
	}
	
	/**
	 * 下拉列表查询字典表集合
	 * @return
	 */
	public DataSet forselect() {
		String helpId = (String) getParameter("helpId");
		return commHelpDomain.getSelectDataset(helpId);
	}
	
}
