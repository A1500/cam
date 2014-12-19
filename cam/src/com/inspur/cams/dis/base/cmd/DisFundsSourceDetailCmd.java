package com.inspur.cams.dis.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.dis.base.data.DisFundsSourceDetail;
import com.inspur.cams.dis.base.domain.IDisFundsSourceDetailDomain;

/**
 * 资金拨付明细表cmd
 * @author 
 * @date 2013-01-04
 */
public class DisFundsSourceDetailCmd extends BaseAjaxCommand {

	private IDisFundsSourceDetailDomain disFundsSourceDetailDomain = ScaComponentFactory
			.getService(IDisFundsSourceDetailDomain.class, "disFundsSourceDetailDomain/disFundsSourceDetailDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		DisFundsSourceDetail disFundsSourceDetail = (DisFundsSourceDetail) record.toBean(DisFundsSourceDetail.class);
		disFundsSourceDetailDomain.insert(disFundsSourceDetail);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		DisFundsSourceDetail disFundsSourceDetail = (DisFundsSourceDetail) record.toBean(DisFundsSourceDetail.class);
		disFundsSourceDetailDomain.update(disFundsSourceDetail);
	}
	
	// 删除
	public void delete() {
		String allocationDetailId = (String) getParameter("allocationDetailId");
		disFundsSourceDetailDomain.delete(allocationDetailId);
	}
	
}