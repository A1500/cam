package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcManageInfo;
import com.inspur.cams.cdc.base.domain.ICdcManageInfoDomain;

/**
 * 基层民主民主管理信息表cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcManageInfoCmd extends BaseAjaxCommand {

	private ICdcManageInfoDomain cdcManageInfoDomain = ScaComponentFactory
			.getService(ICdcManageInfoDomain.class, "cdcManageInfoDomain/cdcManageInfoDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CdcManageInfo cdcManageInfo = (CdcManageInfo) record.toBean(CdcManageInfo.class);
		cdcManageInfoDomain.insert(cdcManageInfo);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CdcManageInfo cdcManageInfo = (CdcManageInfo) record.toBean(CdcManageInfo.class);
		cdcManageInfoDomain.update(cdcManageInfo);
	}
	
}