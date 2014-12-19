package com.inspur.cams.sorg.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.base.data.SomCatalog;

/**
 * 社会组织档案目录树dao接口
 * @author Muqi
 * @date 2011-7-21
 */
public interface ISomCatalogDao extends BaseCURD<SomCatalog> {
	
	/**
	 * 保存社会组织档案目录
	 * @param list
	 */
	public void save(List<SomCatalog> list);

	/**
	 * 删除所有社会组织档案目录
	 */
	public void deleteStruAll();
	
}
