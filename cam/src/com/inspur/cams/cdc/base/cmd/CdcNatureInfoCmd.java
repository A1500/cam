package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcNatureInfo;
import com.inspur.cams.cdc.base.domain.ICdcNatureInfoDomain;

/**
 * 基础信息自然状况信息表cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcNatureInfoCmd extends BaseAjaxCommand {

	private ICdcNatureInfoDomain cdcNatureInfoDomain = ScaComponentFactory
			.getService(ICdcNatureInfoDomain.class, "cdcNatureInfoDomain/cdcNatureInfoDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CdcNatureInfo cdcNatureInfo = (CdcNatureInfo) record.toBean(CdcNatureInfo.class);
		cdcNatureInfoDomain.insert(cdcNatureInfo);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CdcNatureInfo cdcNatureInfo = (CdcNatureInfo) record.toBean(CdcNatureInfo.class);
		cdcNatureInfoDomain.update(cdcNatureInfo);
	}
	
}