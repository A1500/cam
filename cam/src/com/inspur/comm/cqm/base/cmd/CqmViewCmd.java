package com.inspur.comm.cqm.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.comm.cqm.base.data.CqmCol;
import com.inspur.comm.cqm.base.data.CqmView;
import com.inspur.comm.cqm.base.domain.ICqmViewDomain;

/**
 * 自定义统计报表视图表cmd
 * @author shgtch
 * @date 2012-03-16
 */
public class CqmViewCmd extends BaseAjaxCommand {

	private ICqmViewDomain cqmViewDomain = ScaComponentFactory
			.getService(ICqmViewDomain.class, "cqmViewDomain/cqmViewDomain");
	
	// 增加
	public void insert() {
		cqmViewDomain.insert(getCqmView());
	}

	// 修改
	public void update() {
		cqmViewDomain.update(getCqmView());
	}
	
	// 删除
	public void delete() {
		String viewId = (String) getParameter("viewId");
		cqmViewDomain.delete(viewId);
	}
	
	private CqmView getCqmView() {
		Record record = (Record) getParameter("record");
		CqmView cqmView = (CqmView) record.toBean(CqmView.class);
		
		List<CqmCol> cqmColList = new ArrayList<CqmCol>();
		Record[] cqmColRecords = (Record[]) getParameter("cqmColRecords");
		if (cqmColRecords != null) {
			for (int i = 0; i < cqmColRecords.length; i++) {
				CqmCol cqmCol = (CqmCol) cqmColRecords[i].toBean(CqmCol.class);
				cqmColList.add(cqmCol);
			}
		}
		cqmView.setCqmColList(cqmColList);
		return cqmView;
	}
	
}