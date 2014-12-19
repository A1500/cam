package com.inspur.cams.fis.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.fis.base.dao.IFisPageInfoDao;
import com.inspur.cams.fis.base.data.FisPageInfo;
import com.inspur.cams.fis.base.domain.IFisPageInfoDomain;

/**
 * 页面信息表domain
 * @author 
 * @date 2012-07-16
 */
public class FisPageInfoDomain implements IFisPageInfoDomain {

	@Reference
	private IFisPageInfoDao fisPageInfoDao;

	/**
	 * 查询 页面信息表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return fisPageInfoDao.query(pset);
	}

	/**
	 * 获取 页面信息表
	 * @param pset
	 * @return
	 */
	public FisPageInfo get(String pageId) {
		return fisPageInfoDao.get(pageId);
	}

	/**
	 * 增加 页面信息表
	 * @param fisPageInfo
	 */
	public void insert(FisPageInfo fisPageInfo) {
		fisPageInfoDao.insert(fisPageInfo);
	}
	
	/**
	 * 修改 页面信息表
	 * @param fisPageInfo
	 */
	public void update(FisPageInfo fisPageInfo) {
		fisPageInfoDao.update(fisPageInfo);
	}
	
	/**
	 * 删除 页面信息表
	 * @param pageId
	 */
	public void delete(String pageId) {
		fisPageInfoDao.delete(pageId);
	}

}