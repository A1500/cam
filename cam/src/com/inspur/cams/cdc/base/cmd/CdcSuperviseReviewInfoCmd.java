package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcSuperviseReviewInfo;
import com.inspur.cams.cdc.base.domain.ICdcSuperviseReviewInfoDomain;

/**
 * 基层民主民主监督信息表cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcSuperviseReviewInfoCmd extends BaseAjaxCommand {

	private ICdcSuperviseReviewInfoDomain cdcSuperviseReviewInfoDomain = ScaComponentFactory
			.getService(ICdcSuperviseReviewInfoDomain.class, "cdcSuperviseReviewInfoDomain/cdcSuperviseReviewInfoDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CdcSuperviseReviewInfo cdcSuperviseReviewInfo = (CdcSuperviseReviewInfo) record.toBean(CdcSuperviseReviewInfo.class);
		cdcSuperviseReviewInfoDomain.insert(cdcSuperviseReviewInfo);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CdcSuperviseReviewInfo cdcSuperviseReviewInfo = (CdcSuperviseReviewInfo) record.toBean(CdcSuperviseReviewInfo.class);
		cdcSuperviseReviewInfoDomain.update(cdcSuperviseReviewInfo);
	}
	
}