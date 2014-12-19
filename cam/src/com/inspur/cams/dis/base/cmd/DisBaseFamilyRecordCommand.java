package com.inspur.cams.dis.base.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;

import com.inspur.cams.dis.base.dao.*;
import com.inspur.cams.dis.base.dao.support.*;
import com.inspur.cams.dis.base.dao.support.DisBaseFamilyRecordDao;

import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.dis.base.data.DisBaseFamilyRecord;
//import com.inspur.cams.dis.base.domain.IDisBaseFamilyRecordDomain;
/**
 * @title:DisBaseFamilyRecordCommand
 * @description:
 * @author:
 * @since:2012-10-23
 * @version:1.0
*/
public class DisBaseFamilyRecordCommand extends BaseAjaxCommand{
	private DisBaseFamilyRecordDao dao = (DisBaseFamilyRecordDao) DaoFactory
			.getDao("com.inspur.cams.dis.base.dao.support.DisBaseFamilyRecordDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		DisBaseFamilyRecord dataBean=(DisBaseFamilyRecord)record.toBean(DisBaseFamilyRecord.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		DisBaseFamilyRecord dataBean=(DisBaseFamilyRecord)record.toBean(DisBaseFamilyRecord.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<DisBaseFamilyRecord> list = new ArrayList<DisBaseFamilyRecord>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			DisBaseFamilyRecord dataBean = (DisBaseFamilyRecord) records[i].toBean(DisBaseFamilyRecord.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
