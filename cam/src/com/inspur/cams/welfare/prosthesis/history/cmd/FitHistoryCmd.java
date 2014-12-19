
package com.inspur.cams.welfare.prosthesis.history.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.welfare.prosthesis.history.domain.IFitHistoryDomain;


/**
 * 假矫历史数据采集
 * @author sunlei
 * @date 2011-8-23
 */
public class FitHistoryCmd extends BaseAjaxCommand {
	
	private IFitHistoryDomain fitHistoryDomain = ScaComponentFactory
	.getService(IFitHistoryDomain.class, "fitHistoryDomain/fitHistoryDomain");
	
	//假矫历史数据采集__保存
	public void saveFitHistory() {
		Record infoRecord=(Record) getParameter("recordInfo");
		Record[] recordWorker=(Record[]) getParameter("recordWorker");
		Record[] recordDevice=(Record[]) getParameter("recordDevice");
		Record[] recordProduct=(Record[]) getParameter("recordProduct");
		fitHistoryDomain.saveHistory(infoRecord,recordWorker,recordDevice,recordProduct);
	}
	//假矫历史数据采集__删除
	public void deleteFitHistory(){
		String taskCode = (String) getParameter("taskCode");
		String fitId = (String) getParameter("fitId");
		fitHistoryDomain.deleteFitHistory(taskCode,fitId);
	}
}
