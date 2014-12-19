package com.inspur.cams.dis.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.dis.base.dao.support.DisPhotoDao;
import com.inspur.cams.dis.base.data.DisPhoto;

/**
 * @title:DisPhotoCommand
 * @description:
 * @author:
 * @since:2012-11-09
 * @version:1.0
*/
public class DisPhotoCommand extends BaseAjaxCommand{
	private DisPhotoDao dao = (DisPhotoDao) DaoFactory
			.getDao("com.inspur.cams.dis.base.data.dao.DisPhotoDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		DisPhoto dataBean=(DisPhoto)record.toBean(DisPhoto.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		DisPhoto dataBean=(DisPhoto)record.toBean(DisPhoto.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<DisPhoto> list = new ArrayList<DisPhoto>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			DisPhoto dataBean = (DisPhoto) records[i].toBean(DisPhoto.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
