package com.inspur.cams.welfare.welfarecorp.history.domain;

import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;
/**
 * 社会福利企业历史数据采集
 * 
 * @author liuxin
 * @date 2013-06-19
 */
public interface IUnitHistoryDomain {
	/**
	 * 福利企业历史数据采集__保存
	 */
	@Trans
	public void saveHistory(Record infoRecord,Record[] recordWorker,Record[] recordProduct);
	/**
	 * 福利企业历史数据采集__删除
	 */
	@Trans
	public void deleteUnitHistory(String taskCode,String unitId);
}
