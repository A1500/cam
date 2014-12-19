package com.inspur.cams.fis.change.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.change.domain.IFisChangeDomain;

/**
 * 经营性公墓变更
 * 
 * @author liuxin
 * @date 2013-08-13
 */
public class FisChangeCmd extends BaseAjaxCommand {
	private IFisChangeDomain fisChangeDomain = (IFisChangeDomain) ScaComponentFactory
			.getService(IFisChangeDomain.class,
					"fisChangeDomain/fisChangeDomain");

	// 经营性公墓变更保存
	public void saveFisCemeChange() {
		Record changeRecord = (Record) getParameter("changeRecord");
		Record[] changeRecordDetail = (Record[]) getParameter("changeRecordDetail");
		fisChangeDomain.saveChange(changeRecord, changeRecordDetail);
	}

	// 经营性公墓变更提交
	public void submitFisCemeChange() {
		Record changeRecord = (Record) getParameter("changeRecord");
		fisChangeDomain.submitChange(changeRecord);
	}

	public void createAndSendQualification() {
		fisChangeDomain.createAndSendQualification(getParameterSet());
	}
	// 经营性公墓变更备案保存
	public void saveFisCemeChangeRecord() {
		Record changeRecord = (Record) getParameter("changeRecord");
		Record[] changeRecordDetail = (Record[]) getParameter("changeRecordDetail");
		Record applyInfoRecord = (Record) getParameter("applyInfoRecord");
		fisChangeDomain.saveChangeRecord(changeRecord, changeRecordDetail,applyInfoRecord);
	}
	// 经营性公墓变更备案提交
	public void submitFisCemeChangeRecord() {
		Record changeRecord = (Record) getParameter("changeRecord");
		fisChangeDomain.submitChangeRecord(changeRecord);
	}
}
