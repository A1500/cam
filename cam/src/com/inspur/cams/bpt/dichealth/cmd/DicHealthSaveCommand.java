package com.inspur.cams.bpt.dichealth.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.dichealth.dao.DicHealth;
import com.inspur.cams.bpt.dichealth.dao.DicHealthDao;
/**
 * @title:DicHealthSaveCommand
 * @description:
 * @author:
 * @since:2011-12-26
 * @version:1.0
*/
public class DicHealthSaveCommand extends BaseAjaxCommand {
	private DicHealthDao dao = (DicHealthDao) DaoFactory
			.getDao("com.inspur.cams.bpt.dichealth.dao.DicHealthDao");
	@Trans
	public void save() {
		Record DicHealthrec = (Record) getParameter("dicHealthRecord");
		String parentId = (String)getParameter("parentId");
		String childId = (String)getParameter("childId"); 
		DicHealth  databean = (DicHealth) DicHealthrec.toBean(DicHealth.class);
		databean.setType(parentId);
		databean.setCode(childId);
		List list = new ArrayList();
		list.add(databean);
		dao.save(list);
	}
	@Trans
	public void delete(){
		String delId=(String)getParameter("delId");
		dao.delete(delId);
	}
	@Trans
	public void update() {
		Record DicHealthrec = (Record) getParameter("dicHealthRecord");
		String parentId = (String)getParameter("parentId");
		String childId = (String)getParameter("childId"); 
		DicHealth  databean = (DicHealth) DicHealthrec.toBean(DicHealth.class);
		databean.setType(parentId);
		databean.setCode(childId);
		dao.update(databean);
	}
}
