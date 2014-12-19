package com.inspur.cams.fis.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.fis.base.dao.IFisCemeInfoDao;
import com.inspur.cams.fis.base.data.FisCemeInfo;
import com.inspur.cams.fis.base.domain.IFisCemeInfoDomain;

/**
 * 殡葬业务公墓信息表domain
 * @author 
 * @date 2013-08-01
 */
public class FisCemeInfoDomain implements IFisCemeInfoDomain {

	@Reference
	private IFisCemeInfoDao fisCemeInfoDao;

	/**
	 * 查询 殡葬业务公墓信息表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return fisCemeInfoDao.query(pset);
	}

	/**
	 * 获取 殡葬业务公墓信息表
	 * @param pset
	 * @return
	 */
	public FisCemeInfo get(String recordId) {
		return fisCemeInfoDao.get(recordId);
	}

	/**
	 * 增加 殡葬业务公墓信息表
	 * @param fisCemeInfo
	 */
	public void insert(FisCemeInfo fisCemeInfo) {
		fisCemeInfoDao.insert(fisCemeInfo);
	}
	
	/**
	 * 修改 殡葬业务公墓信息表
	 * @param fisCemeInfo
	 */
	public void update(FisCemeInfo fisCemeInfo) {
		fisCemeInfoDao.update(fisCemeInfo);
	}
	
	/**
	 * 删除 殡葬业务公墓信息表
	 * @param recordId
	 */
	public void delete(String recordId) {
		fisCemeInfoDao.delete(recordId);
	}
	
	/**
	 * 修改公墓状态
	 * @param organState
	 * @param recordId
	 * */
	public void setOrganState(String organState, String recordId){
		fisCemeInfoDao.setOrganState(organState,recordId);
	}

}