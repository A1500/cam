package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcFundInfo;
import com.inspur.cams.cdc.base.domain.ICdcFundInfoDomain;

/**
 * 社区建设经费情况信息表cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcFundInfoCmd extends BaseAjaxCommand {

	private ICdcFundInfoDomain cdcFundInfoDomain = ScaComponentFactory
			.getService(ICdcFundInfoDomain.class, "cdcFundInfoDomain/cdcFundInfoDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CdcFundInfo cdcFundInfo = (CdcFundInfo) record.toBean(CdcFundInfo.class);
	
		cdcFundInfoDomain.insert(cdcFundInfo);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CdcFundInfo cdcFundInfo = (CdcFundInfo) record.toBean(CdcFundInfo.class);
		cdcFundInfoDomain.update(cdcFundInfo);
	}
	
	// 删除
	public void delete() {
		String id = (String) getParameter("id");
		cdcFundInfoDomain.delete(id);
	}
	
	// 汇总
	public void sum() {
		Record record = (Record) getParameter("record");
		CdcFundInfo cdcFundInfo = (CdcFundInfo) record.toBean(CdcFundInfo.class);
		cdcFundInfoDomain.sum(cdcFundInfo);
	}
	
}