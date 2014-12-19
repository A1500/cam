package com.inspur.cams.welfare.prosthesis.change.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.welfare.prosthesis.change.domain.IFitChangeDomain;

/**
 * 假矫企业变更
 * 
 * @author liuxin
 * @date 2013-07-04
 */
public class FitChangeCmd extends BaseAjaxCommand {
	private IFitChangeDomain fitChangeDomain = (IFitChangeDomain) ScaComponentFactory
			.getService(IFitChangeDomain.class,
					"fitChangeDomain/fitChangeDomain");

	// 假矫企业变更保存
	public void saveFitChange() {
		Record changeRecord = (Record) getParameter("changeRecord");
		Record[] changeRecordDetail = (Record[]) getParameter("changeRecordDetail");
		Record statusRecord = (Record) getParameter("statusRecord");
		fitChangeDomain.saveChange(changeRecord, changeRecordDetail,
				statusRecord);
	}

	// 假矫企业变更提交
	public void submitFitChange() {
		Record changeRecord = (Record) getParameter("changeRecord");
		fitChangeDomain.submitChange(changeRecord);
	}
}
