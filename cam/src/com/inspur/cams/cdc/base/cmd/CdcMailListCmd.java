package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcMailList;
import com.inspur.cams.cdc.base.domain.ICdcMailListDomain;

/**
 * 基层民主与社区建设通讯录cmd
 * @author shgtch
 * @date 2012-3-1
 */
public class CdcMailListCmd extends BaseAjaxCommand {

	private ICdcMailListDomain cdcMailListDomain = ScaComponentFactory
			.getService(ICdcMailListDomain.class, "cdcMailListDomain/cdcMailListDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CdcMailList cdcMailList = (CdcMailList) record.toBean(CdcMailList.class);
		cdcMailListDomain.insert(cdcMailList);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CdcMailList cdcMailList = (CdcMailList) record.toBean(CdcMailList.class);
		cdcMailListDomain.update(cdcMailList);
	}

	// 删除
	public void delete() {
		String listId = (String) getParameter("listId");
		cdcMailListDomain.delete(listId);
	}
	
}