package com.inspur.comm.cqm.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.comm.cqm.base.data.CqmUseView;
import com.inspur.comm.cqm.base.domain.ICqmUseViewDomain;

/**
 * 自定义报表使用视图cmd
 * @author shgtch
 * @date 2012-03-22
 */
public class CqmUseViewCmd extends BaseAjaxCommand {

	private ICqmUseViewDomain cqmUseViewDomain = ScaComponentFactory
			.getService(ICqmUseViewDomain.class, "cqmUseViewDomain/cqmUseViewDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CqmUseView cqmUseView = (CqmUseView) record.toBean(CqmUseView.class);
		cqmUseViewDomain.insert(cqmUseView);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CqmUseView cqmUseView = (CqmUseView) record.toBean(CqmUseView.class);
		cqmUseViewDomain.update(cqmUseView);
	}
	
	// 删除
	public void delete() {
		String useViewId = (String) getParameter("useViewId");
		cqmUseViewDomain.delete(useViewId);
	}
	
}