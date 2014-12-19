package com.inspur.cams.marry.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.marry.base.dao.jdbc.MrmRegisAreaDao;
import com.inspur.cams.marry.base.data.MrmRegisArea;

/**
 * @title:MrmRegisAreaCommand
 * @description:
 * @author:
 * @since:2011-11-28
 * @version:1.0
*/
public class MrmRegisAreaCommand extends BaseAjaxCommand{
	private MrmRegisAreaDao dao = (MrmRegisAreaDao) DaoFactory
			.getDao("com.inspur.cams.marry.base.dao.jdbc.MrmRegisAreaDao");
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		MrmRegisArea dataBean=(MrmRegisArea)record.toBean(MrmRegisArea.class);
		if("".equals(dataBean.getFunctionId()) || dataBean.getFunctionId()==null){
			dataBean.setFunctionId(IdHelp.getUUID32());
		}
		dao.insert(dataBean);
	}
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		MrmRegisArea dataBean=(MrmRegisArea)record.toBean(MrmRegisArea.class);
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
		List<MrmRegisArea> list = new ArrayList<MrmRegisArea>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			MrmRegisArea dataBean = (MrmRegisArea) records[i].toBean(MrmRegisArea.class);
			if("".equals(dataBean.getFunctionId()) || dataBean.getFunctionId()==null){
				dataBean.setFunctionId(IdHelp.getUUID32());
			}
			
			list.add(dataBean);
		}

		dao.save(list);
	}
}
