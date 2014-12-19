package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcOrganInfo;
import com.inspur.cams.cdc.base.domain.ICdcOrganInfoDomain;

/**
 * 基础信息社区单位组织信息表cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcOrganInfoCmd extends BaseAjaxCommand {

	private ICdcOrganInfoDomain cdcOrganInfoDomain = ScaComponentFactory
			.getService(ICdcOrganInfoDomain.class, "cdcOrganInfoDomain/cdcOrganInfoDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CdcOrganInfo cdcOrganInfo = (CdcOrganInfo) record.toBean(CdcOrganInfo.class);
		cdcOrganInfoDomain.insert(cdcOrganInfo);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CdcOrganInfo cdcOrganInfo = (CdcOrganInfo) record.toBean(CdcOrganInfo.class);
		cdcOrganInfoDomain.update(cdcOrganInfo);
	}

	// 删除
	public void delete() {
		String id = (String) getParameter("id");
		cdcOrganInfoDomain.delete(id);
	}
	
}