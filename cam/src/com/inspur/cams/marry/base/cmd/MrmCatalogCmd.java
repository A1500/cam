package com.inspur.cams.marry.base.cmd;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.marry.base.data.MrmCatalog;
import com.inspur.cams.marry.base.domain.IMrmCatalogDomain;

/**
 * 婚姻档案目录树cmd
 */
public class MrmCatalogCmd extends BaseAjaxCommand {
	
	// 获取SCA组件
	private IMrmCatalogDomain mrmCatalogDomain = ScaComponentFactory.getService(IMrmCatalogDomain.class, "mrmCatalogDomain/mrmCatalogDomain");

	public void insert() {
		Record MrmCatalogrec = (Record) getParameter("mrmCatalogRecord");
		String childId = IdHelp.getUUID30();
		MrmCatalog  databean = (MrmCatalog) MrmCatalogrec.toBean(MrmCatalog.class);
		BigDecimal level = databean.getCatalogLevel();
		databean.setCatalogCode(childId);
		databean.setCatalogLevel(level.add(new BigDecimal(1)));
		mrmCatalogDomain.insert(databean);
		this.setReturn("childId", childId);
	}

	public void update() {
		Record MrmCatalogrec = (Record) getParameter("mrmCatalogRecord");
		String childId = (String)getParameter("childId"); 
		MrmCatalog  databean = (MrmCatalog) MrmCatalogrec.toBean(MrmCatalog.class);
		databean.setCatalogCode(childId);
		mrmCatalogDomain.update(databean);
	}
	
	public void save() {
		Record MrmCatalogrec = (Record) getParameter("mrmCatalogRecord");
		String childId = IdHelp.getUUID30();
		MrmCatalog  databean = (MrmCatalog) MrmCatalogrec.toBean(MrmCatalog.class);
		databean.setCatalogCode(childId);
		List<MrmCatalog> list = new ArrayList<MrmCatalog>();
		list.add(databean);
		mrmCatalogDomain.save(list);
	}
	
	public void delete(){
		String delId=(String)getParameter("delId");
		mrmCatalogDomain.delete(delId);
	}
	
	public void deleteAll(){
		mrmCatalogDomain.deleteStruAll();
	}
	
}
