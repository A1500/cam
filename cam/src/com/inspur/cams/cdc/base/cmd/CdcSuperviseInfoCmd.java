package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcSuperviseInfo;
import com.inspur.cams.cdc.base.domain.ICdcSuperviseInfoDomain;

/**
 * 基层民主民主监督信息表cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcSuperviseInfoCmd extends BaseAjaxCommand {

	private ICdcSuperviseInfoDomain cdcSuperviseInfoDomain = ScaComponentFactory
			.getService(ICdcSuperviseInfoDomain.class, "cdcSuperviseInfoDomain/cdcSuperviseInfoDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CdcSuperviseInfo cdcSuperviseInfo = (CdcSuperviseInfo) record.toBean(CdcSuperviseInfo.class);
		cdcSuperviseInfoDomain.insert(cdcSuperviseInfo);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CdcSuperviseInfo cdcSuperviseInfo = (CdcSuperviseInfo) record.toBean(CdcSuperviseInfo.class);
		cdcSuperviseInfoDomain.update(cdcSuperviseInfo);
	}
	
}