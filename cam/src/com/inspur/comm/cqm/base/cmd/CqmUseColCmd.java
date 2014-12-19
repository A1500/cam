package com.inspur.comm.cqm.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.comm.cqm.base.data.CqmUseCol;
import com.inspur.comm.cqm.base.domain.ICqmUseColDomain;

/**
 * 自定义报表使用列cmd
 * @author shgtch
 * @date 2012-03-22
 */
public class CqmUseColCmd extends BaseAjaxCommand {

	private ICqmUseColDomain cqmUseColDomain = ScaComponentFactory
			.getService(ICqmUseColDomain.class, "cqmUseColDomain/cqmUseColDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CqmUseCol cqmUseCol = (CqmUseCol) record.toBean(CqmUseCol.class);
		cqmUseColDomain.insert(cqmUseCol);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CqmUseCol cqmUseCol = (CqmUseCol) record.toBean(CqmUseCol.class);
		cqmUseColDomain.update(cqmUseCol);
	}
	
	// 删除
	public void delete() {
		String useColId = (String) getParameter("useColId");
		cqmUseColDomain.delete(useColId);
	}
	
}