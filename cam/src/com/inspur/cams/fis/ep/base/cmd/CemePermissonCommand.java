package com.inspur.cams.fis.ep.base.cmd;

import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.fis.util.BspUtil;


/**
 * 客户修改Command,接收界面传过来的所有的被修改的record
 */
public class CemePermissonCommand extends BaseAjaxCommand {
	public void execute() {
//		System.out.println(BspUtil.getDeptOrganId());
		setReturn("orgID", BspUtil.getDeptOrganId()) ;
	}
}
