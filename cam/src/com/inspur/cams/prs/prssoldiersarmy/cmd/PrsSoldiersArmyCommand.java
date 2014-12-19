package com.inspur.cams.prs.prssoldiersarmy.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.prs.prssoldiersarmy.dao.*;

/**
 * @title:PrsSoldiersArmyCommand
 * @description:
 * @author:
 * @since:2011-08-18
 * @version:1.0
*/
public class PrsSoldiersArmyCommand extends BaseAjaxCommand{
	private PrsSoldiersArmyDao dao = (PrsSoldiersArmyDao) DaoFactory
			.getDao("com.inspur.cams.prs.prssoldiersarmy.dao.PrsSoldiersArmyDao");
@Trans
	public void insert() {
		Record record = (Record) getParameter("records");
		PrsSoldiersArmy dataBean=(PrsSoldiersArmy)record.toBean(PrsSoldiersArmy.class);
		dao.insert(dataBean);
	}
@Trans
	public void update() {
		Record record = (Record) getParameter("records");
		PrsSoldiersArmy dataBean=(PrsSoldiersArmy)record.toBean(PrsSoldiersArmy.class);
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
		List<PrsSoldiersArmy> list = new ArrayList<PrsSoldiersArmy>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			PrsSoldiersArmy dataBean = (PrsSoldiersArmy) records[i].toBean(PrsSoldiersArmy.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
