package com.inspur.cams.bpt.manage.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.dao.jdbc.BptCompulsoryDao;
import com.inspur.cams.bpt.base.data.BptCompulsory;
import com.inspur.cams.comm.util.IdHelp;

/**
 * @title:BptCompulsoryCommand
 * @description:
 * @author:
 * @since:2011-06-05
 * @version:1.0
*/
public class BptCompulsoryCommand extends BaseAjaxCommand{
	private BptCompulsoryDao dao = (BptCompulsoryDao) DaoFactory
			.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptCompulsoryDao");
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		BptCompulsory dataBean=(BptCompulsory)record.toBean(BptCompulsory.class);
		dao.insert(dataBean);
	}
	@Trans
	public void updateCompulsory() {
		Record record = (Record) getParameter("record");
		BptCompulsory dataBean=(BptCompulsory)record.toBean(BptCompulsory.class);
		dao.update(dataBean);
	}
	@Trans
	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	@Trans
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<BptCompulsory> list = new ArrayList<BptCompulsory>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			BptCompulsory dataBean = (BptCompulsory) records[i].toBean(BptCompulsory.class);
			//判断是否新增的数据
			if(dataBean.isNew()){
				dataBean.setId(IdHelp.getUUID30());
			}
			list.add(dataBean);
		}

		dao.save(list);
	}
}
