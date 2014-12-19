package com.inspur.cams.fis.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.fis.base.dao.IFisResourceExtendDao;
import com.inspur.cams.fis.base.data.FisResourceExtend;
import com.inspur.cams.fis.base.domain.IFisResourceExtendDomain;

/**
 * 墓位特征扩展表domain
 * @author 
 * @date Mon Apr 16 15:35:06 GMT+08:00 2012
 */
public class FisResourceExtendDomain implements IFisResourceExtendDomain {

	@Reference
	private IFisResourceExtendDao fisResourceExtendDao;

	/**
	 * 查询 墓位特征扩展表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return fisResourceExtendDao.query(pset);
	}

	/**
	 * 获取 墓位特征扩展表
	 * @param pset
	 * @return
	 */
	public FisResourceExtend get(String recordId) {
		return fisResourceExtendDao.get(recordId);
	}

	/**
	 * 增加 墓位特征扩展表
	 * @param fisResourceExtend
	 */
	public void insert(FisResourceExtend fisResourceExtend) {
		fisResourceExtendDao.insert(fisResourceExtend);
	}
	
	/**
	 * 修改 墓位特征扩展表
	 * @param fisResourceExtend
	 */
	public void update(FisResourceExtend fisResourceExtend) {
		fisResourceExtendDao.update(fisResourceExtend);
	}
	
	/**
	 * 删除 墓位特征扩展表
	 * @param recordId
	 */
	public void delete(String recordId) {
		fisResourceExtendDao.delete(recordId);
	}

}