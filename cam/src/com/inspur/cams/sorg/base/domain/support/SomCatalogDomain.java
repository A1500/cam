package com.inspur.cams.sorg.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.sorg.base.dao.ISomCatalogDao;
import com.inspur.cams.sorg.base.data.SomCatalog;
import com.inspur.cams.sorg.base.domain.ISomCatalogDomain;

/**
 * 社会组织档案目录树domain实现类
 * @author Muqi
 * @date 2011-7-21
 */
public class SomCatalogDomain implements ISomCatalogDomain {

	@Reference
	private ISomCatalogDao somCatalogDao;

	/**
	 * 查询社会组织档案目录
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset){
		return somCatalogDao.query(pset);
	}
	
	/**
	 * 增加社会组织档案目录
	 * @param somCatalog
	 */
	public void insert(SomCatalog somCatalog) {
		somCatalogDao.insert(somCatalog);
	}

	/**
	 * 修改社会组织档案目录
	 * @param somCatalog
	 */
	public void update(SomCatalog somCatalog) {
		somCatalogDao.update(somCatalog);
	}

	/**
	 * 保存社会组织档案目录
	 * @param list
	 */
	public void save(List<SomCatalog> list) {
		somCatalogDao.save(list);
	}

	/**
	 * 批量删除社会组织档案目录
	 * @param delIds
	 */
	public void batchDelete(String[] delIds) {
		somCatalogDao.batchDelete(delIds);
	}
	
	/**
	 * 删除社会组织档案目录
	 * @param delId
	 */
	public void delete(String delId) {
		somCatalogDao.delete(delId);
	}

	/**
	 * 删除所有社会组织档案目录
	 */
	public void deleteStruAll() {
		somCatalogDao.deleteStruAll();
	}
	
}
