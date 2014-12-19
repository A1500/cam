package com.inspur.cams.marry.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.marry.base.dao.IMrmCatalogDao;
import com.inspur.cams.marry.base.data.MrmCatalog;
import com.inspur.cams.marry.base.domain.IMrmCatalogDomain;

/**
 * 婚姻档案目录树domain实现类
 */
public class MrmCatalogDomain implements IMrmCatalogDomain {

	@Reference
	private IMrmCatalogDao mrmCatalogDao;

	/**
	 * 查询
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset){
		return mrmCatalogDao.query(pset);
	}
	
	/**
	 * 增加
	 * @param mrmCatalog
	 */
	public void insert(MrmCatalog mrmCatalog) {
		mrmCatalogDao.insert(mrmCatalog);
	}

	/**
	 * 修改
	 * @param mrmCatalog
	 */
	public void update(MrmCatalog mrmCatalog) {
		mrmCatalogDao.update(mrmCatalog);
	}

	/**
	 * 保存
	 * @param list
	 */
	public void save(List<MrmCatalog> list) {
		mrmCatalogDao.save(list);
	}

	/**
	 * 批量删除
	 * @param delIds
	 */
	public void batchDelete(String[] delIds) {
		mrmCatalogDao.batchDelete(delIds);
	}
	
	/**
	 * 删除
	 * @param delId
	 */
	public void delete(String delId) {
		mrmCatalogDao.delete(delId);
	}

	/**
	 * 删除所有
	 */
	public void deleteStruAll() {
		mrmCatalogDao.deleteStruAll();
	}
	
}
