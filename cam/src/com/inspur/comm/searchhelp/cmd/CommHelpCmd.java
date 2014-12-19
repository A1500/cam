package com.inspur.comm.searchhelp.cmd;

import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.comm.searchhelp.data.CommHelp;
import com.inspur.comm.searchhelp.domain.ICommHelpDomain;

/**
 * 通用帮助，获取字典表值Cmd
 * @author shgtch
 * @date 2011-5-23
 */
public class CommHelpCmd extends BaseAjaxCommand {
	
	// 通用帮助Domain
	private ICommHelpDomain commHelpDomain = (ICommHelpDomain) ScaComponentFactory.getService(ICommHelpDomain.class, "commHelpDomain/commHelpDomain");
	
	/**
	 * 获取通用帮助配置，在前台生成通用帮助窗口
	 */
	public void getCommHelp() {
		String helpId = (String) getParameter("helpId");
		CommHelp commHelp = commHelpDomain.getCommHelp(helpId);
		setReturn("commHelp", commHelp);
	}
	
	/**
	 * 获取字典表key对应的value
	 */
	public void getDicValue() {
		String helpId = (String) getParameter("helpId");
		String key = (String) getParameter("key");
		String value = commHelpDomain.getDicValue(helpId, key);
		setReturn("value", value);
	}
	
}
