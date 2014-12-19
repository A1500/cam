package com.inspur.cams.marry.base.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.marry.base.dao.jdbc.MrmPositionDao;
import com.inspur.cams.marry.base.data.MrmPosition;

/**
 * @title:MrmPositionCommand
 * @description:
 * @author:
 * @since:2011-12-06
 * @version:1.0
*/
public class MrmPositionCommand extends BaseAjaxCommand{
	private MrmPositionDao dao = (MrmPositionDao) DaoFactory
			.getDao("com.inspur.cams.marry.base.dao.jdbc.MrmPositionDao");

	public void update() {
		Record record = (Record) getParameter("record");
		MrmPosition dataBean=(MrmPosition)record.toBean(MrmPosition.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	/**
	 * 保存职务信息
	 */
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		String personId = (String) getParameter("personId");
		List<MrmPosition> list = new ArrayList<MrmPosition>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			MrmPosition dataBean = (MrmPosition) records[i].toBean(MrmPosition.class);
			dataBean.setPersonId(personId);
			String zwId = IdHelp.getUUID32();
			dataBean.setZwId(zwId);
			list.add(dataBean);
		}
		dao.save(list);
	}
}
