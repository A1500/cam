package com.inspur.cams.sorg.jxcheck.somjxextraplanconcrete.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.jxcheck.somjxextraplanconcrete.dao.*;

/**
 * @title:SomJxExtraPlanConcreteCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxExtraPlanConcreteCommand extends BaseAjaxCommand{
	private SomJxExtraPlanConcreteDao dao = (SomJxExtraPlanConcreteDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxextraplanconcrete.dao.SomJxExtraPlanConcreteDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxExtraPlanConcrete dataBean=(SomJxExtraPlanConcrete)record.toBean(SomJxExtraPlanConcrete.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxExtraPlanConcrete dataBean=(SomJxExtraPlanConcrete)record.toBean(SomJxExtraPlanConcrete.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxExtraPlanConcrete> list = new ArrayList<SomJxExtraPlanConcrete>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxExtraPlanConcrete dataBean = (SomJxExtraPlanConcrete) records[i].toBean(SomJxExtraPlanConcrete.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
