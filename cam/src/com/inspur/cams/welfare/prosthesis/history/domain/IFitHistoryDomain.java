package com.inspur.cams.welfare.prosthesis.history.domain;

import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

public interface IFitHistoryDomain {
	/**
	 * 假矫历史数据采集__保存
	 */
	@Trans
	public void saveHistory(Record infoRecord,Record[] recordWorker,Record[] recordDevice,Record[] recordProduct);
	/**
	 * 假矫历史数据采集__删除
	 */
	@Trans
	public void deleteFitHistory(String taskCode,String fitId);
}
