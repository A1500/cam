package com.inspur.comm.cqm.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.comm.cqm.base.data.CqmCol;
import com.inspur.comm.cqm.base.domain.ICqmColDomain;

/**
 * 自定义统计报表属性表cmd
 * @author shgtch
 * @date 2012-03-16
 */
public class CqmColCmd extends BaseAjaxCommand {

	private ICqmColDomain cqmColDomain = ScaComponentFactory
			.getService(ICqmColDomain.class, "cqmColDomain/cqmColDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CqmCol cqmCol = (CqmCol) record.toBean(CqmCol.class);
		cqmColDomain.insert(cqmCol);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CqmCol cqmCol = (CqmCol) record.toBean(CqmCol.class);
		cqmColDomain.update(cqmCol);
	}
	
	// 删除
	public void delete() {
		String colId = (String) getParameter("colId");
		cqmColDomain.delete(colId);
	}
	
}