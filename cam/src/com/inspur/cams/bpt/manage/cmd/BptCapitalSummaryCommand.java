package com.inspur.cams.bpt.manage.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.capital.dao.jdbc.BptCapitalDetailDao;
import com.inspur.cams.bpt.capital.dao.jdbc.BptCapitalSummaryDao;
import com.inspur.cams.bpt.capital.data.BptCapitalSummary;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;

/**
 * @title:BptCapitalSummaryCommand
 * @description:
 * @author:
 * @since:2011-05-28
 * @version:1.0
*/
public class BptCapitalSummaryCommand extends BaseAjaxCommand{
	private BptCapitalSummaryDao dao = (BptCapitalSummaryDao) DaoFactory.getDao("com.inspur.cams.bpt.capital.dao.jdbc.BptCapitalSummaryDao");
	private BptCapitalDetailDao detailDao = (BptCapitalDetailDao) DaoFactory.getDao("com.inspur.cams.bpt.capital.dao.jdbc.BptCapitalDetailDao");
	private IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class, "bptGroupDomain/bptGroupDomain");
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		BptCapitalSummary dataBean=(BptCapitalSummary)record.toBean(BptCapitalSummary.class);
		dao.insert(dataBean);
	}
	
	/**
	 * 确认发放名册
	 */
	@Trans
	public void grantSumConfirm(){
		Record record = (Record) getParameter("record");
		BptCapitalSummary dataBean=(BptCapitalSummary)record.toBean(BptCapitalSummary.class);
		dataBean.setGrantFlag("3");
		dao.update(dataBean);
	}
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		BptCapitalSummary dataBean=(BptCapitalSummary)record.toBean(BptCapitalSummary.class);
		dao.update(dataBean);
	}
    /**
     * 明细汇总表中批量删除，并删除名册明细表中的数据
     */
	@Trans
	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		service.deleteData(delIds);
		service.deleteCapitalSummary(delIds);
	}
	@Trans
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<BptCapitalSummary> list = new ArrayList<BptCapitalSummary>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			BptCapitalSummary dataBean = (BptCapitalSummary) records[i].toBean(BptCapitalSummary.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
