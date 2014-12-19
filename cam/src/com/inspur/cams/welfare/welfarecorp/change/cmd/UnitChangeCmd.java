package com.inspur.cams.welfare.welfarecorp.change.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.welfare.welfarecorp.change.domain.IUnitChangeDomain;

/**
 * 社会福利企业变更
 * 
 * @author liuxin
 * @date 2013-06-26
 */
public class UnitChangeCmd extends BaseAjaxCommand {
	private IUnitChangeDomain unitChangeDomain = (IUnitChangeDomain) ScaComponentFactory
			.getService(IUnitChangeDomain.class,
					"unitChangeDomain/unitChangeDomain");

	// 福利企业变更保存
	public void saveUnitChange() {
		Record changeRecord = (Record) getParameter("changeRecord");
		Record[] changeRecordDetail = (Record[]) getParameter("changeRecordDetail");
		Record statusRecord = (Record) getParameter("statusRecord");
		unitChangeDomain.saveChange(changeRecord, changeRecordDetail,statusRecord);
	}
	// 福利企业变更提交
	public void submitUnitChange() {
		Record changeRecord = (Record) getParameter("changeRecord");
		unitChangeDomain.submitChange(changeRecord);
	}
}
