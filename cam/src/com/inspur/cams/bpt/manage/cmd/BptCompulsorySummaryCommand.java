package com.inspur.cams.bpt.manage.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.capital.dao.jdbc.BptCompulsorySummaryDao;
import com.inspur.cams.bpt.capital.data.BptCompulsorySummary;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;

/**
 * @title:BptCompulsorySummaryCommand
 * @description:
 * @author:
 * @since:2011-06-07
 * @version:1.0
*/
public class BptCompulsorySummaryCommand extends BaseAjaxCommand{
	private BptCompulsorySummaryDao dao = (BptCompulsorySummaryDao) DaoFactory
			.getDao("com.inspur.cams.bpt.capital.dao.jdbc.BptCompulsorySummaryDao");
	private IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class,"bptGroupDomain/bptGroupDomain");
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		BptCompulsorySummary dataBean=(BptCompulsorySummary)record.toBean(BptCompulsorySummary.class);
		dao.insert(dataBean);
	}
	
	/**
	 * 确认发放
	 */
	@Trans
	public void grantSumConfirm(){
		Record record = (Record) getParameter("record");
		BptCompulsorySummary dataBean=(BptCompulsorySummary)record.toBean(BptCompulsorySummary.class);
		dataBean.setGrantFlag("3");
		dao.update(dataBean);
	}
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		BptCompulsorySummary dataBean=(BptCompulsorySummary)record.toBean(BptCompulsorySummary.class);
		dao.update(dataBean);
	}
	@Trans
	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		for(int i =0;i < delIds.length ; i++){
			ParameterSet param  = new ParameterSet();
			param.setParameter("delId", delIds[i]);
			service.deleteRegisterId(param);
		}
		service.deleteCompulsorySummary(delIds);
	}
	@Trans
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<BptCompulsorySummary> list = new ArrayList<BptCompulsorySummary>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			BptCompulsorySummary dataBean = (BptCompulsorySummary) records[i].toBean(BptCompulsorySummary.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
