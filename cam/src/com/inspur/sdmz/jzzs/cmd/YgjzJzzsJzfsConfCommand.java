package com.inspur.sdmz.jzzs.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.sdmz.jzzs.dao.jdbc.YgjzJzzsJzfsConfDao;
import com.inspur.sdmz.jzzs.data.YgjzJzzsJzfsConf;

/**
 * @title:YgjzJzzsJzfsConfCommand
 * @description:
 * @author:
 * @since:2011-05-14
 * @version:1.0
*/
public class YgjzJzzsJzfsConfCommand extends BaseAjaxCommand{
	private YgjzJzzsJzfsConfDao dao = (YgjzJzzsJzfsConfDao) DaoFactory
			.getDao("demo.example.dao.YgjzJzzsJzfsConfDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		YgjzJzzsJzfsConf dataBean=(YgjzJzzsJzfsConf)record.toBean(YgjzJzzsJzfsConf.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		YgjzJzzsJzfsConf dataBean=(YgjzJzzsJzfsConf)record.toBean(YgjzJzzsJzfsConf.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<YgjzJzzsJzfsConf> list = new ArrayList<YgjzJzzsJzfsConf>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			YgjzJzzsJzfsConf dataBean = (YgjzJzzsJzfsConf) records[i].toBean(YgjzJzzsJzfsConf.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
