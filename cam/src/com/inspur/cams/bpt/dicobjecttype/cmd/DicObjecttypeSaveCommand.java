package com.inspur.cams.bpt.dicobjecttype.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.dicobjecttype.dao.DicObjecttype;
import com.inspur.cams.bpt.dicobjecttype.dao.DicObjecttypeDao;
/**
 * @title:DicObjecttypeSaveCommand
 * @description:
 * @author:
 * @since:2011-08-16
 * @version:1.0
*/
public class DicObjecttypeSaveCommand extends BaseAjaxCommand {
	private DicObjecttypeDao dao = (DicObjecttypeDao) DaoFactory
			.getDao("com.inspur.cams.bpt.dicobjecttype.dao.DicObjecttypeDao");
	@Trans
	public void save() {
		Record DicObjecttyperec = (Record) getParameter("dicObjecttypeRecord");
		String parentId = (String)getParameter("parentId");
		String childId = (String)getParameter("childId"); 
		DicObjecttype  databean = (DicObjecttype) DicObjecttyperec.toBean(DicObjecttype.class);
		databean.setTypeParentId(parentId);
		databean.setTypeId(childId);
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
		Record DicObjecttyperec = (Record) getParameter("dicObjecttypeRecord");
		String parentId = (String)getParameter("parentId");
		String childId = (String)getParameter("childId"); 
		DicObjecttype  databean = (DicObjecttype) DicObjecttyperec.toBean(DicObjecttype.class);
		databean.setTypeParentId(parentId);
		databean.setTypeId(childId);
		dao.update(databean);
	}
}
