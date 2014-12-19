package com.inspur.cams.dis.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.dis.base.data.DisYearCostSheet;
import com.inspur.cams.dis.base.domain.IDisYearCostSheetDomain;

/**
 * @title:DisYearCostSheetCommand
 * @description:
 * @author:
 * @since:2012-10-09
 * @version:1.0
*/
public class DisYearCostSheetCommand extends BaseAjaxCommand{
	private IDisYearCostSheetDomain service = (IDisYearCostSheetDomain) ScaComponentFactory.getService(IDisYearCostSheetDomain.class,"disYearCostSheetDomain/disYearCostSheetDomain");

	public void insert() {
		Record record = (Record) getParameter("record");
		DisYearCostSheet dataBean=(DisYearCostSheet)record.toBean(DisYearCostSheet.class);
		service.save(dataBean);
	}
	
	
	
	public void update() {
		Record record = (Record) getParameter("record");
		DisYearCostSheet dataBean=(DisYearCostSheet)record.toBean(DisYearCostSheet.class);
		service.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		service.batchDelete(delIds);
	}
}
