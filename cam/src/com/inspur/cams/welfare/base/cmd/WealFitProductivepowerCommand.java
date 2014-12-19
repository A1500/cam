package com.inspur.cams.welfare.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.welfare.base.dao.support.WealFitProductivepowerDao;
import com.inspur.cams.welfare.base.data.WealFitProductivepower;

/**
 * @title:WealFitProductivepowerCommand
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
public class WealFitProductivepowerCommand extends BaseAjaxCommand{
	private WealFitProductivepowerDao dao = (WealFitProductivepowerDao) DaoFactory
			.getDao("com.inspur.cams.welfare.base.dao.support.WealFitProductivepowerDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		WealFitProductivepower dataBean=(WealFitProductivepower)record.toBean(WealFitProductivepower.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		WealFitProductivepower dataBean=(WealFitProductivepower)record.toBean(WealFitProductivepower.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<WealFitProductivepower> list = new ArrayList<WealFitProductivepower>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			WealFitProductivepower dataBean = (WealFitProductivepower) records[i].toBean(WealFitProductivepower.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
	@Trans
	public void saveOrUpdate() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<WealFitProductivepower> list = new ArrayList<WealFitProductivepower>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			WealFitProductivepower dataBean = (WealFitProductivepower) records[i].toBean(WealFitProductivepower.class);
			if("".equals(dataBean.getProduceId())){
				list.add(dataBean);
			}else{
				dao.insert(dataBean);
			}
			
		}
		dao.save(list);
	}
}
