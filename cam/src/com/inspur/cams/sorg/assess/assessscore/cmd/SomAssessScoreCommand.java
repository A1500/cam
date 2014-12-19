package com.inspur.cams.sorg.assess.assessscore.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.sorg.assess.assessscore.dao.SomAssessScoreDao;
import com.inspur.cams.sorg.assess.assessscore.data.SomAssessScore;

/**
 * @title:SomAssessScoreCommand
 * @description:
 * @author:
 * @since:2011-12-09
 * @version:1.0
*/
public class SomAssessScoreCommand extends BaseAjaxCommand{
	private SomAssessScoreDao dao = (SomAssessScoreDao) DaoFactory
			.getDao("com.inspur.cams.sorg.assess.assessscore.dao.SomAssessScoreDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomAssessScore dataBean=(SomAssessScore)record.toBean(SomAssessScore.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomAssessScore dataBean=(SomAssessScore)record.toBean(SomAssessScore.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomAssessScore> list = new ArrayList<SomAssessScore>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomAssessScore dataBean = (SomAssessScore) records[i].toBean(SomAssessScore.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
