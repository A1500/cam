package com.inspur.comm.cqm.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.comm.cqm.base.data.CqmIndex;
import com.inspur.comm.cqm.base.domain.ICqmIndexDomain;

/**
 * 自定义统计报表指标表cmd
 * @author shgtch
 * @date 2012-03-16
 */
public class CqmIndexCmd extends BaseAjaxCommand {

	private ICqmIndexDomain cqmIndexDomain = ScaComponentFactory
			.getService(ICqmIndexDomain.class, "cqmIndexDomain/cqmIndexDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CqmIndex cqmIndex = (CqmIndex) record.toBean(CqmIndex.class);
		cqmIndexDomain.insert(cqmIndex);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CqmIndex cqmIndex = (CqmIndex) record.toBean(CqmIndex.class);
		cqmIndexDomain.update(cqmIndex);
	}
	
	// 删除
	public void delete() {
		String indexId = (String) getParameter("indexId");
		cqmIndexDomain.delete(indexId);
	}
	
}