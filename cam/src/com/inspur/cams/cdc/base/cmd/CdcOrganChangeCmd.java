package com.inspur.cams.cdc.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcOrganChange;
import com.inspur.cams.cdc.base.domain.ICdcOrganChangeDomain;
import com.inspur.cams.comm.extuser.data.ComExtUser;

/**
 * 社区变更表cmd
 * @author 
 * @date 2012-04-13
 */
public class CdcOrganChangeCmd extends BaseAjaxCommand {

	private ICdcOrganChangeDomain cdcOrganChangeDomain = ScaComponentFactory
			.getService(ICdcOrganChangeDomain.class, "cdcOrganChangeDomain/cdcOrganChangeDomain");

	// 增加社区
	public void add() {
		Record record = (Record) getParameter("record");
		ComExtUser comExtUser = (ComExtUser) record.toBean(ComExtUser.class);
		cdcOrganChangeDomain.add(comExtUser);
	}
	
	// 变更社区
	public void change() {
		Record record = (Record) getParameter("record");
		ComExtUser comExtUser = (ComExtUser) record.toBean(ComExtUser.class);
		cdcOrganChangeDomain.change(comExtUser);
	}
	
	// 撤销社区
	public void cancel() {
		String userId = (String) getParameter("userId");
		cdcOrganChangeDomain.cancel(userId);
	}
	

	// 合并社区
	public void merge() {
		Record record = (Record) getParameter("record");
		ComExtUser comExtUser = (ComExtUser) record.toBean(ComExtUser.class);
		Record[] cdcOrganChangeRecords = (Record[]) getParameter("cdcOrganChangeRecords");
		List<CdcOrganChange> cdcOrganChangeList = new ArrayList<CdcOrganChange>();
		for (int i = 0; i < cdcOrganChangeRecords.length; i++) {
			CdcOrganChange cdcOrganChange = (CdcOrganChange) cdcOrganChangeRecords[i].toBean(CdcOrganChange.class);
			cdcOrganChangeList.add(cdcOrganChange);
		}
		cdcOrganChangeDomain.merge(comExtUser, cdcOrganChangeList);
	}
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CdcOrganChange cdcOrganChange = (CdcOrganChange) record.toBean(CdcOrganChange.class);
		cdcOrganChangeDomain.insert(cdcOrganChange);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CdcOrganChange cdcOrganChange = (CdcOrganChange) record.toBean(CdcOrganChange.class);
		cdcOrganChangeDomain.update(cdcOrganChange);
	}
	
	// 删除
	public void delete() {
		String changeId = (String) getParameter("changeId");
		cdcOrganChangeDomain.delete(changeId);
	}
	
}