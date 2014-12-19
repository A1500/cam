package com.inspur.cams.dis.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.dis.base.data.DisCurrentMoney;
import com.inspur.cams.dis.base.domain.IDisCurrentMoneyDomain;

/**
 * 单位当前资金情况表cmd
 * @author 
 * @date 2012-11-05
 */
public class DisCurrentMoneyCmd extends BaseAjaxCommand {

	private IDisCurrentMoneyDomain disCurrentMoneyDomain = ScaComponentFactory
			.getService(IDisCurrentMoneyDomain.class, "disCurrentMoneyDomain/disCurrentMoneyDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		DisCurrentMoney disCurrentMoney = (DisCurrentMoney) record.toBean(DisCurrentMoney.class);
		disCurrentMoneyDomain.insert(disCurrentMoney);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		DisCurrentMoney disCurrentMoney = (DisCurrentMoney) record.toBean(DisCurrentMoney.class);
		disCurrentMoneyDomain.update(disCurrentMoney);
	}
	
	// 删除
	public void delete() {
		String recordId = (String) getParameter("recordId");
		disCurrentMoneyDomain.delete(recordId);
	}
	
}