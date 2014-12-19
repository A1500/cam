package com.inspur.cams.sorg.base.cmd;

import java.math.BigDecimal;
import java.util.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.base.data.SomCatalog;
import com.inspur.cams.sorg.base.domain.ISomCatalogDomain;

/**
 * 社会组织档案目录树cmd
 * @author Muqi
 * @date 2011-7-21
 */
public class SomCatalogCmd extends BaseAjaxCommand {
	
	// 获取SCA组件
	private ISomCatalogDomain somCatalogDomain = ScaComponentFactory.getService(ISomCatalogDomain.class, "somCatalogDomain/somCatalogDomain");

	public void insert() {
		Record SomCatalogrec = (Record) getParameter("somCatalogRecord");
		String childId = IdHelp.getUUID30();
		SomCatalog  databean = (SomCatalog) SomCatalogrec.toBean(SomCatalog.class);
		BigDecimal level = databean.getCatalogLevel();
		databean.setCatalogCode(childId);
		databean.setCatalogLevel(level.add(new BigDecimal(1)));
		somCatalogDomain.insert(databean);
		this.setReturn("childId", childId);
	}

	public void update() {
		Record SomCatalogrec = (Record) getParameter("somCatalogRecord");
		String childId = (String)getParameter("childId"); 
		SomCatalog  databean = (SomCatalog) SomCatalogrec.toBean(SomCatalog.class);
		databean.setCatalogCode(childId);
		somCatalogDomain.update(databean);
	}
	
	public void save() {
		Record SomCatalogrec = (Record) getParameter("somCatalogRecord");
		String childId = IdHelp.getUUID30();
		SomCatalog  databean = (SomCatalog) SomCatalogrec.toBean(SomCatalog.class);
		databean.setCatalogCode(childId);
		List<SomCatalog> list = new ArrayList<SomCatalog>();
		list.add(databean);
		somCatalogDomain.save(list);
	}
	
	public void delete(){
		String delId=(String)getParameter("delId");
		somCatalogDomain.delete(delId);
	}
	
	public void deleteAll(){
		somCatalogDomain.deleteStruAll();
	}
	
}
