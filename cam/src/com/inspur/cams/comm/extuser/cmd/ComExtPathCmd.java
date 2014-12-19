package com.inspur.cams.comm.extuser.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.extuser.data.ComExtPath;
import com.inspur.cams.comm.extuser.domain.IComExtPathDomain;

/**
 * 扩展页面路径配置cmd
 * @author shgtch
 * @date 2011-6-29
 */
public class ComExtPathCmd extends BaseAjaxCommand {

	// 扩展页面路径配置domain
	private IComExtPathDomain comExtPathDomain = (IComExtPathDomain) ScaComponentFactory.getService(IComExtPathDomain.class, "comExtPathDomain/comExtPathDomain");
	
	/**
	 * 增加扩展页面路径配置
	 */
	public void insert() {
		Record record = (Record) getParameter("comExtPath");
		ComExtPath comExtPath = (ComExtPath) record.toBean(ComExtPath.class);
		comExtPathDomain.insertComExtPath(comExtPath);
	}
	
	/**
	 * 修改扩展页面路径配置
	 */
	public void update() {
		Record record = (Record) getParameter("comExtPath");
		ComExtPath comExtPath = (ComExtPath) record.toBean(ComExtPath.class);
		comExtPathDomain.updateComExtPath(comExtPath);
	}

	/**
	 * 删除扩展页面路径配置
	 */
	public void delete() {
		String extPath = (String) getParameter("extPath");
		comExtPathDomain.deleteComExtPath(extPath);
	}
	
}
