package com.inspur.cams.marry.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.marry.base.data.MrmCatalog;

/**
 * 婚姻档案目录树domain接口
 */
public interface IMrmCatalogDomain {
	
	/**
	 * 查询
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加
	 * @param mrmCatalog
	 */
	@Trans
	public void insert(MrmCatalog mrmCatalog);

	/**
	 * 修改
	 * @param mrmCatalog
	 */
	@Trans
	public void update(MrmCatalog mrmCatalog);

	/**
	 * 保存
	 * @param list
	 */
	@Trans
	public void save(List<MrmCatalog> list);

	/**
	 * 批量删除
	 * @param delIds
	 */
	@Trans
	public void batchDelete(String[] delIds);

	/**
	 * 删除
	 * @param delId
	 */
	@Trans
	public void delete(String delId);

	/**
	 * 删除所有
	 */
	@Trans
	public void deleteStruAll();
}
