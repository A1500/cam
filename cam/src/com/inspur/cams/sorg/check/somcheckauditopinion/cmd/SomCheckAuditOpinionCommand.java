package com.inspur.cams.sorg.check.somcheckauditopinion.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;

import com.inspur.cams.sorg.check.somcheckauditopinion.dao.SomCheckAuditOpinion;
import com.inspur.cams.sorg.check.somcheckauditopinion.dao.SomCheckAuditOpinionDao;

/**
 * @title:SomCheckAuditOpinionCommand
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
public class SomCheckAuditOpinionCommand extends BaseAjaxCommand{
	private SomCheckAuditOpinionDao dao = (SomCheckAuditOpinionDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.somcheckauditopinion.dao.SomCheckAuditOpinionDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckAuditOpinion dataBean=(SomCheckAuditOpinion)record.toBean(SomCheckAuditOpinion.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckAuditOpinion dataBean=(SomCheckAuditOpinion)record.toBean(SomCheckAuditOpinion.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheckAuditOpinion> list = new ArrayList<SomCheckAuditOpinion>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheckAuditOpinion dataBean = (SomCheckAuditOpinion) records[i].toBean(SomCheckAuditOpinion.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
