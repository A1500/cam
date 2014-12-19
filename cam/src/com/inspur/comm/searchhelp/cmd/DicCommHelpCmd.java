package com.inspur.comm.searchhelp.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.comm.searchhelp.data.CommHelp;
import com.inspur.comm.searchhelp.domain.ICommHelpDomain;


/**
 * 通用帮助配置维护cmd
 * @author shgtch
 * @date 2011-6-13
 */
public class DicCommHelpCmd extends BaseAjaxCommand {
	
	// 通用帮助Domain
	private ICommHelpDomain commHelpDomain = (ICommHelpDomain) ScaComponentFactory.getService(ICommHelpDomain.class, "commHelpDomain/commHelpDomain");
	
	/**
	 * 增加通用帮助配置
	 */
	public void insert() {
		Record record = (Record) getParameter("commHelp");
		CommHelp commHelp = (CommHelp) record.toBean(CommHelp.class);
		commHelpDomain.insertCommHelp(commHelp);
	}
	
	/**
	 * 更新通用帮助配置
	 */
	public void update() {
		Record record = (Record) getParameter("commHelp");
		CommHelp commHelp = (CommHelp) record.toBean(CommHelp.class);
		commHelpDomain.updateCommHelp(commHelp);
	}
	
	/**
	 * 删除通用帮助配置
	 */
	public void delete() {
		String helpId = (String) getParameter("helpId");
		commHelpDomain.deleteCommHelp(helpId);
	}
	
}
