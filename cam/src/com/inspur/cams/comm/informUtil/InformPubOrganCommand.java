package com.inspur.cams.comm.informUtil;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;

/**
 * @title:PubOrganCommand
 * @description:
 * @author:
 * @since:2010-12-04
 * @version:1.0
*/
public class InformPubOrganCommand extends BaseAjaxCommand{
	private InformPubOrganDao dao = (InformPubOrganDao) DaoFactory
			.getDao("com.inspur.cams.comm.informUtil.InformPubOrganDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		InformPubOrgan dataBean=(InformPubOrgan)record.toBean(InformPubOrgan.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		InformPubOrgan dataBean=(InformPubOrgan)record.toBean(InformPubOrgan.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<InformPubOrgan> list = new ArrayList<InformPubOrgan>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			InformPubOrgan dataBean = (InformPubOrgan) records[i].toBean(InformPubOrgan.class);
			list.add(dataBean);
		}
		// do save
		InformPubOrganDao dao = (InformPubOrganDao) DaoFactory
				.getDao("com.inspur.cams.comm.informUtil.InformPubOrganDao");
		dao.save(list);
	}
}
