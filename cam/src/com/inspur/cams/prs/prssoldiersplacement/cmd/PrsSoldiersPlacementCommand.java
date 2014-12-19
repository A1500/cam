package com.inspur.cams.prs.prssoldiersplacement.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.prs.prssoldiersplacement.dao.PrsSoldiersPlacement;
import com.inspur.cams.prs.prssoldiersplacement.dao.PrsSoldiersPlacementDao;

/**
 * @title:PrsSoldiersPlacementCommand
 * @description:
 * @author:
 * @since:2011-08-15
 * @version:1.0
 */
public class PrsSoldiersPlacementCommand extends BaseAjaxCommand {
	private PrsSoldiersPlacementDao dao = (PrsSoldiersPlacementDao) DaoFactory
			.getDao("com.inspur.cams.prs.prssoldiersplacement.dao.PrsSoldiersPlacementDao");
@Trans
	public void insert() {
		Record record = (Record) getParameter("records");
		PrsSoldiersPlacement dataBean = (PrsSoldiersPlacement) record
				.toBean(PrsSoldiersPlacement.class);
		dao.insert(dataBean);
	}
@Trans
	public void update() {
		Record record = (Record) getParameter("records");
		PrsSoldiersPlacement dataBean = (PrsSoldiersPlacement) record
				.toBean(PrsSoldiersPlacement.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds = (String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}

}
