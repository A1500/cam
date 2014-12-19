package com.inspur.cams.welfare.welfarecorp.change.domain;

import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

/**
 * 社会福利企业变更
 * 
 * @author liuxin
 * @date 2013-06-26
 */
public interface IUnitChangeDomain {
	/**
	 * 福利企业变更数据保存
	 */
	@Trans
	public void saveChange(Record changeRecord, Record[] changeRecordDetail,
			Record statusRecord);
	@Trans
	public void submitChange(Record changeRecord);
}
