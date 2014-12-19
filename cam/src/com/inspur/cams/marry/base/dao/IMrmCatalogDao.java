package com.inspur.cams.marry.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.marry.base.data.MrmCatalog;

/**
 * 婚姻档案目录树dao接口
 */
public interface IMrmCatalogDao extends BaseCURD<MrmCatalog> {
	
	/**
	 * 保存
	 * @param list
	 */
	public void save(List<MrmCatalog> list);

	/**
	 * 删除
	 */
	public void deleteStruAll();
	
}
