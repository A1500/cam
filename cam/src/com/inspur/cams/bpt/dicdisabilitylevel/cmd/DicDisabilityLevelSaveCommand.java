package com.inspur.cams.bpt.dicdisabilitylevel.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.dicdisabilitylevel.dao.DicDisabilityLevel;
import com.inspur.cams.bpt.dicdisabilitylevel.dao.DicDisabilityLevelDao;
/**
 * @title:DicDisabilityLevelSaveCommand
 * @description:
 * @author:
 * @since:2011-11-03
 * @version:1.0
*/
public class DicDisabilityLevelSaveCommand extends BaseAjaxCommand {
	private DicDisabilityLevelDao dao = (DicDisabilityLevelDao) DaoFactory
			.getDao("com.inspur.cams.bpt.dicdisabilitylevel.dao.DicDisabilityLevelDao");
	@Trans
	public void save() {
		Record DicDisabilityLevelrec = (Record) getParameter("dicDisabilityLevelRecord");
		String parentId = (String)getParameter("parentId");
		String childId = (String)getParameter("childId"); 
		DicDisabilityLevel  databean = (DicDisabilityLevel) DicDisabilityLevelrec.toBean(DicDisabilityLevel.class);
		databean.setParentId(parentId);
		databean.setLevelId(childId);
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
		Record DicDisabilityLevelrec = (Record) getParameter("dicDisabilityLevelRecord");
		String parentId = (String)getParameter("parentId");
		String childId = (String)getParameter("childId"); 
		DicDisabilityLevel  databean = (DicDisabilityLevel) DicDisabilityLevelrec.toBean(DicDisabilityLevel.class);
		databean.setParentId(parentId);
		databean.setLevelId(childId);
		dao.update(databean);
	}
}
