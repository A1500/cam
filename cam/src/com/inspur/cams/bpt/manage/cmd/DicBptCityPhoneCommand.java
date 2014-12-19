package com.inspur.cams.bpt.manage.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.dao.jdbc.DicBptCityPhoneDao;
import com.inspur.cams.bpt.base.data.DicBptCityPhone;
import com.inspur.cams.comm.util.IdHelp;

/**
 * @title:DicBptCityPhoneCommand
 * @description:
 * @author:
 * @since:2011-09-20
 * @version:1.0
*/
public class DicBptCityPhoneCommand extends BaseAjaxCommand{
	private DicBptCityPhoneDao dao = (DicBptCityPhoneDao) DaoFactory
			.getDao("com.inspur.cams.bpt.base.dao.jdbc.DicBptCityPhoneDao");
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		DicBptCityPhone dataBean=(DicBptCityPhone)record.toBean(DicBptCityPhone.class);
		dao.insert(dataBean);
	}
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		DicBptCityPhone dataBean=(DicBptCityPhone)record.toBean(DicBptCityPhone.class);
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
		
		List<DicBptCityPhone> list = new ArrayList<DicBptCityPhone>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			String id = IdHelp.getUUID30();
			String ss =  records[i].get("id").toString();
			if("".equals(records[i].get("id").toString())){
			records[i].set("id",id );
			}
			DicBptCityPhone dataBean = (DicBptCityPhone) records[i].toBean(DicBptCityPhone.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
