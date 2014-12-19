package com.inspur.cams.fis.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.fis.base.dao.IFisCemeChangeDao;
import com.inspur.cams.fis.base.data.FisCemeChange;
import com.inspur.cams.fis.base.domain.IFisCemeChangeDomain;

/**
 * 公墓信息变更备案表domain
 * @author 
 * @date 2013-08-01
 */
public class FisCemeChangeDomain implements IFisCemeChangeDomain {

	@Reference
	private IFisCemeChangeDao fisCemeChangeDao;

	/**
	 * 查询 公墓信息变更备案表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return fisCemeChangeDao.query(pset);
	}

	/**
	 * 获取 公墓信息变更备案表
	 * @param pset
	 * @return
	 */
	public FisCemeChange get(String changeId) {
		return fisCemeChangeDao.get(changeId);
	}

	/**
	 * 增加 公墓信息变更备案表
	 * @param fisCemeChange
	 */
	public void insert(FisCemeChange fisCemeChange) {
		fisCemeChangeDao.insert(fisCemeChange);
	}
	
	/**
	 * 修改 公墓信息变更备案表
	 * @param fisCemeChange
	 */
	public void update(FisCemeChange fisCemeChange) {
		fisCemeChangeDao.update(fisCemeChange);
	}
	
	/**
	 * 删除 公墓信息变更备案表
	 * @param changeId
	 */
	public void delete(String changeId) {
		fisCemeChangeDao.delete(changeId);
	}

}