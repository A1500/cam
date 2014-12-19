package com.inspur.cams.prs.prsproblemhistory.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.prs.prsproblemhistory.dao.PrsProblemHistory;
import com.inspur.cams.prs.prsproblemhistory.domain.IPrsProblemHistoryDomain;

public class PrsProblemHistoryCmd extends BaseAjaxCommand{
	IPrsProblemHistoryDomain service=ScaComponentFactory.getService(IPrsProblemHistoryDomain.class,"PrsProblemHistoryDomain/PrsProblemHistoryDomain");
	
	/**
	 * 新增
	 */
	@Trans
	public void insert(){
		Record record=(Record)getParameter("record");
		PrsProblemHistory bean=(PrsProblemHistory)record.toBean(PrsProblemHistory.class);
		bean.setProblemHistoryId(IdHelp.getUUID32());
		service.insert(bean);
	}
	/**
	 * 更新
	 */
	@Trans
	public void update(){
		Record record=(Record)getParameter("record");
		PrsProblemHistory bean=(PrsProblemHistory)record.toBean(PrsProblemHistory.class);
		service.update(bean);
	}
}
