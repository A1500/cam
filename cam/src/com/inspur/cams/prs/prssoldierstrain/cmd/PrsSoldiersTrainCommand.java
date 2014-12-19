package com.inspur.cams.prs.prssoldierstrain.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.prs.prssoldierstrain.dao.PrsSoldiersTrain;
import com.inspur.cams.prs.prssoldierstrain.dao.PrsSoldiersTrainDao;

/**
 * @title:PrsSoldiersTrainCommand
 * @description:
 * @author:
 * @since:2011-08-19
 * @version:1.0
*/
public class PrsSoldiersTrainCommand extends BaseAjaxCommand{
	private PrsSoldiersTrainDao dao = (PrsSoldiersTrainDao) DaoFactory
			.getDao("com.inspur.cams.prs.prssoldierstrain.dao.PrsSoldiersTrainDao");
	@Trans
	public void insert() {
		Record record = (Record) getParameter("records");
		PrsSoldiersTrain dataBean=(PrsSoldiersTrain)record.toBean(PrsSoldiersTrain.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("records");
		PrsSoldiersTrain dataBean=(PrsSoldiersTrain)record.toBean(PrsSoldiersTrain.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
}
