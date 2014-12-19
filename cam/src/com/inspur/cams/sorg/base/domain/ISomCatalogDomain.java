package com.inspur.cams.sorg.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomCatalog;

/**
 * 社会组织档案目录树domain接口
 * @author Muqi
 * @date 2011-7-21
 */
public interface ISomCatalogDomain {
	
	/**
	 * 查询社会组织档案目录
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加社会组织档案目录
	 * @param somCatalog
	 */
	@Trans
	public void insert(SomCatalog somCatalog);

	/**
	 * 修改社会组织档案目录
	 * @param somCatalog
	 */
	@Trans
	public void update(SomCatalog somCatalog);

	/**
	 * 保存社会组织档案目录
	 * @param list
	 */
	@Trans
	public void save(List<SomCatalog> list);

	/**
	 * 批量删除社会组织档案目录
	 * @param delIds
	 */
	@Trans
	public void batchDelete(String[] delIds);

	/**
	 * 删除社会组织档案目录
	 * @param delId
	 */
	@Trans
	public void delete(String delId);

	/**
	 * 删除所有社会组织档案目录
	 */
	@Trans
	public void deleteStruAll();
}
