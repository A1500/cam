package com.inspur.cams.fis.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.fis.base.dao.IFisCemeLogoffDao;
import com.inspur.cams.fis.base.data.FisCemeLogoff;
import com.inspur.cams.fis.base.domain.IFisCemeLogoffDomain;

/**
 * 公墓撤销备案表domain
 * @author 
 * @date 2013-08-01
 */
public class FisCemeLogoffDomain implements IFisCemeLogoffDomain {

	@Reference
	private IFisCemeLogoffDao fisCemeLogoffDao;

	/**
	 * 查询 公墓撤销备案表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return fisCemeLogoffDao.query(pset);
	}

	/**
	 * 获取 公墓撤销备案表
	 * @param pset
	 * @return
	 */
	public FisCemeLogoff get(String logoffId) {
		return fisCemeLogoffDao.get(logoffId);
	}

	/**
	 * 增加 公墓撤销备案表
	 * @param fisCemeLogoff
	 */
	public void insert(FisCemeLogoff fisCemeLogoff) {
		fisCemeLogoffDao.insert(fisCemeLogoff);
	}
	
	/**
	 * 修改 公墓撤销备案表
	 * @param fisCemeLogoff
	 */
	public void update(FisCemeLogoff fisCemeLogoff) {
		fisCemeLogoffDao.update(fisCemeLogoff);
	}
	
	/**
	 * 删除 公墓撤销备案表
	 * @param logoffId
	 */
	public void delete(String logoffId) {
		fisCemeLogoffDao.delete(logoffId);
	}

}