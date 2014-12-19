package com.inspur.cams.fis.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.fis.base.dao.IFisCemeAccessoriesDao;
import com.inspur.cams.fis.base.data.FisCemeAccessories;
import com.inspur.cams.fis.base.domain.IFisCemeAccessoriesDomain;

/**
 * 公墓审批附件表domain
 * @author 
 * @date 2013-08-01
 */
public class FisCemeAccessoriesDomain implements IFisCemeAccessoriesDomain {

	@Reference
	private IFisCemeAccessoriesDao fisCemeAccessoriesDao;

	/**
	 * 查询 公墓审批附件表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return fisCemeAccessoriesDao.query(pset);
	}

	/**
	 * 获取 公墓审批附件表
	 * @param pset
	 * @return
	 */
	public FisCemeAccessories get(String accessoriesId) {
		return fisCemeAccessoriesDao.get(accessoriesId);
	}

	/**
	 * 增加 公墓审批附件表
	 * @param fisCemeAccessories
	 */
	public void insert(FisCemeAccessories fisCemeAccessories) {
		fisCemeAccessoriesDao.insert(fisCemeAccessories);
	}
	
	/**
	 * 修改 公墓审批附件表
	 * @param fisCemeAccessories
	 */
	public void update(FisCemeAccessories fisCemeAccessories) {
		fisCemeAccessoriesDao.update(fisCemeAccessories);
	}
	
	/**
	 * 删除 公墓审批附件表
	 * @param accessoriesId
	 */
	public void delete(String accessoriesId) {
		fisCemeAccessoriesDao.delete(accessoriesId);
	}
	
	public void deleteAll(ParameterSet pset){
		fisCemeAccessoriesDao.deleteAll(pset);
	}

}