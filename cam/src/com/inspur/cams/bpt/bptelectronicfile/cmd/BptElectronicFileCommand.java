package com.inspur.cams.bpt.bptelectronicfile.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.bptelectronicfile.dao.BptElectronicFile;
import com.inspur.cams.bpt.bptelectronicfile.dao.BptElectronicFileDao;


/**
 * @title:BptElectronicFileCommand
 * @description:
 * @author:
 * @since:2011-06-27
 * @version:1.0
*/
public class BptElectronicFileCommand extends BaseAjaxCommand{
	private BptElectronicFileDao dao = (BptElectronicFileDao) DaoFactory
			.getDao("com.inspur.cams.bpt.bptelectronicfile.dao.BptElectronicFileDao");
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		BptElectronicFile dataBean=(BptElectronicFile)record.toBean(BptElectronicFile.class);
		dao.insert(dataBean);
	}
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		BptElectronicFile dataBean=(BptElectronicFile)record.toBean(BptElectronicFile.class);
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
		List<BptElectronicFile> list = new ArrayList<BptElectronicFile>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			BptElectronicFile dataBean = (BptElectronicFile) records[i].toBean(BptElectronicFile.class);
			list.add(dataBean);
		}
		// do save
		BptElectronicFileDao dao = (BptElectronicFileDao) DaoFactory
				.getDao("com.inspur.cams.bpt.bptelectronicfile.dao.BptElectronicFileDao");
		dao.save(list);
	}
}
