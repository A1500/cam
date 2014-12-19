package com.inspur.cams.welfare.welfarecorp.history.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.welfare.welfarecorp.history.domain.IUnitHistoryDomain;

/**
 * 社会福利企业历史数据采集
 * 
 * @author liuxin
 * @date 2013-06-19
 */
public class UnitHistoryCmd extends BaseAjaxCommand {

	private IUnitHistoryDomain unitHistoryDomain = ScaComponentFactory
			.getService(IUnitHistoryDomain.class,
					"unitHistoryDomain/unitHistoryDomain");

	// 福利企业历史数据采集__保存
	public void saveUnitHistory() {
		Record infoRecord = (Record) getParameter("recordInfo");
		Record[] recordWorker = (Record[]) getParameter("recordWorker");
		Record[] recordProduct=(Record[]) getParameter("recordProduct");
		unitHistoryDomain.saveHistory(infoRecord, recordWorker,recordProduct);
	}

	// 福利企业历史数据采集__删除
	public void deleteUnitHistory() {
		String taskCode = (String) getParameter("taskCode");
		String unitId = (String) getParameter("unitId");
		unitHistoryDomain.deleteUnitHistory(taskCode, unitId);
	}
}
