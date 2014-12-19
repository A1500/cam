package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcPopulateInfo;
import com.inspur.cams.cdc.base.domain.ICdcPopulateInfoDomain;

/**
 * 基础信息人口状况信息表cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcPopulateInfoCmd extends BaseAjaxCommand {

	private ICdcPopulateInfoDomain cdcPopulateInfoDomain = ScaComponentFactory
			.getService(ICdcPopulateInfoDomain.class, "cdcPopulateInfoDomain/cdcPopulateInfoDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CdcPopulateInfo cdcPopulateInfo = (CdcPopulateInfo) record.toBean(CdcPopulateInfo.class);
		cdcPopulateInfoDomain.insert(cdcPopulateInfo);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CdcPopulateInfo cdcPopulateInfo = (CdcPopulateInfo) record.toBean(CdcPopulateInfo.class);
		cdcPopulateInfoDomain.update(cdcPopulateInfo);
	}

	// 删除
	public void delete() {
		String id = (String) getParameter("id");
		cdcPopulateInfoDomain.delete(id);
	}
	
	// 汇总
	public void sum() {
		Record record = (Record) getParameter("record");
		CdcPopulateInfo cdcPopulateInfo = (CdcPopulateInfo) record.toBean(CdcPopulateInfo.class);
		cdcPopulateInfoDomain.sum(cdcPopulateInfo);
	}
	
}