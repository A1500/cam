package com.inspur.cams.welfare.prosthesis.change.domain;

import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

/**
 * 假矫企业变更
 * 
 * @author liuxin
 * @date 2013-07-04
 */
public interface IFitChangeDomain {
	/**
	 * 假矫企业变更数据保存
	 */
	@Trans
	public void saveChange(Record changeRecord, Record[] changeRecordDetail,
			Record statusRecord);

	@Trans
	public void submitChange(Record changeRecord);
}
