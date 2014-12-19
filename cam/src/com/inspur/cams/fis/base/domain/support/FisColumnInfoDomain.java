package com.inspur.cams.fis.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.fis.base.dao.IFisColumnInfoDao;
import com.inspur.cams.fis.base.data.FisColumnInfo;
import com.inspur.cams.fis.base.domain.IFisColumnInfoDomain;

/**
 * 页面列描述domain
 * @author 
 * @date 2012-07-16
 */
public class FisColumnInfoDomain implements IFisColumnInfoDomain {

	@Reference
	private IFisColumnInfoDao fisColumnInfoDao;

	/**
	 * 查询 页面列描述
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return fisColumnInfoDao.query(pset);
	}

	/**
	 * 获取 页面列描述
	 * @param pset
	 * @return
	 */
	public FisColumnInfo get(String columnId) {
		return fisColumnInfoDao.get(columnId);
	}

	/**
	 * 增加 页面列描述
	 * @param fisColumnInfo
	 */
	public void insert(FisColumnInfo fisColumnInfo) {
		fisColumnInfoDao.insert(fisColumnInfo);
	}
	
	/**
	 * 修改 页面列描述
	 * @param fisColumnInfo
	 */
	public void update(FisColumnInfo fisColumnInfo) {
		fisColumnInfoDao.update(fisColumnInfo);
	}
	
	/**
	 * 删除 页面列描述
	 * @param columnId
	 */
	public void delete(String columnId) {
		fisColumnInfoDao.delete(columnId);
	}

}