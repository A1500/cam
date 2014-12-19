package com.inspur.cams.sorg.jxcheck.somjxcheckauditopinion.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.jxcheck.somjxcheckauditopinion.dao.*;

/**
 * @title:SomJxCheckAuditOpinionCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckAuditOpinionCommand extends BaseAjaxCommand{
	private SomJxCheckAuditOpinionDao dao = (SomJxCheckAuditOpinionDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckauditopinion.dao.SomJxCheckAuditOpinionDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxCheckAuditOpinion dataBean=(SomJxCheckAuditOpinion)record.toBean(SomJxCheckAuditOpinion.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxCheckAuditOpinion dataBean=(SomJxCheckAuditOpinion)record.toBean(SomJxCheckAuditOpinion.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxCheckAuditOpinion> list = new ArrayList<SomJxCheckAuditOpinion>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxCheckAuditOpinion dataBean = (SomJxCheckAuditOpinion) records[i].toBean(SomJxCheckAuditOpinion.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
