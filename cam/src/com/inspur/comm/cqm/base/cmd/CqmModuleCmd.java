package com.inspur.comm.cqm.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.comm.cqm.base.data.CqmModule;
import com.inspur.comm.cqm.base.domain.ICqmModuleDomain;

/**
 * 自定义统计报表模型表cmd
 * @author shgtch
 * @date 2012-03-16
 */
public class CqmModuleCmd extends BaseAjaxCommand {

	private ICqmModuleDomain cqmModuleDomain = ScaComponentFactory
			.getService(ICqmModuleDomain.class, "cqmModuleDomain/cqmModuleDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CqmModule cqmModule = (CqmModule) record.toBean(CqmModule.class);
		cqmModuleDomain.insert(cqmModule);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CqmModule cqmModule = (CqmModule) record.toBean(CqmModule.class);
		cqmModuleDomain.update(cqmModule);
	}
	
	// 删除
	public void delete() {
		String moduleId = (String) getParameter("moduleId");
		cqmModuleDomain.delete(moduleId);
	}
	
}