package com.inspur.cams.dis.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.dis.base.data.DisCurrentMoneyDetail;
import com.inspur.cams.dis.base.domain.IDisCurrentMoneyDetailDomain;

/**
 * 单位当前物资情况表cmd
 * @author 
 * @date 2012-11-05
 */
public class DisCurrentMoneyDetailCmd extends BaseAjaxCommand {

	private IDisCurrentMoneyDetailDomain disCurrentMoneyDetailDomain = ScaComponentFactory
			.getService(IDisCurrentMoneyDetailDomain.class, "disCurrentMoneyDetailDomain/disCurrentMoneyDetailDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		DisCurrentMoneyDetail disCurrentMoneyDetail = (DisCurrentMoneyDetail) record.toBean(DisCurrentMoneyDetail.class);
		disCurrentMoneyDetailDomain.insert(disCurrentMoneyDetail);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		DisCurrentMoneyDetail disCurrentMoneyDetail = (DisCurrentMoneyDetail) record.toBean(DisCurrentMoneyDetail.class);
		disCurrentMoneyDetailDomain.update(disCurrentMoneyDetail);
	}
	
	// 删除
	public void delete() {
		String meterialRecordId = (String) getParameter("meterialRecordId");
		disCurrentMoneyDetailDomain.delete(meterialRecordId);
	}
	
}