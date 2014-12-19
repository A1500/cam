package com.inspur.cams.fis.change.domain;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

/**
 * 经营性公墓变更
 * 
 * @author liuxin
 * @date 2013-08-13
 */
public interface IFisChangeDomain {
	/**
	 * 福利企业变更数据保存
	 */
	@Trans
	public void saveChange(Record changeRecord, Record[] changeRecordDetail);

	@Trans
	public void submitChange(Record changeRecord);

	@Trans
	public void createAndSendQualification(ParameterSet pset);
	@Trans
	public void saveChangeRecord(Record changeRecord,
			Record[] changeRecordDetail, Record applyInfoRecord);
	@Trans
	public void submitChangeRecord(Record changeRecord);
}
