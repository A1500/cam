package com.inspur.cams.fis.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.fis.base.dao.IFisCemeExpendInfoDao;
import com.inspur.cams.fis.base.data.FisCemeExpendInfo;
import com.inspur.cams.fis.base.domain.IFisCemeExpendInfoDomain;

/**
 * domain
 * @author 
 * @date 2013-09-29
 */
public class FisCemeExpendInfoDomain implements IFisCemeExpendInfoDomain {

	@Reference
	private IFisCemeExpendInfoDao fisCemeExpendInfoDao;

	/**
	 * 查询
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return fisCemeExpendInfoDao.query(pset);
	}

	/**
	 * 获取
	 * @param pset
	 * @return
	 */
	public FisCemeExpendInfo get(String recordId) {
		return fisCemeExpendInfoDao.get(recordId);
	}

	/**
	 * 增加
	 * @param fisCemeExpendInfo
	 */
	public void insert(FisCemeExpendInfo fisCemeExpendInfo) {
		fisCemeExpendInfoDao.insert(fisCemeExpendInfo);
	}
	
	/**
	 * 修改
	 * @param fisCemeExpendInfo
	 */
	public void update(FisCemeExpendInfo fisCemeExpendInfo) {
		fisCemeExpendInfoDao.update(fisCemeExpendInfo);
	}
	
	/**
	 * 删除
	 * @param recordId
	 */
	public void delete(String recordId) {
		fisCemeExpendInfoDao.delete(recordId);
	}

}