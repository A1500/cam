package com.inspur.cams.drel.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.base.dao.IDrelStandingbookDao;
import com.inspur.cams.drel.base.data.DrelStandingbook;
import com.inspur.cams.drel.base.domain.IDrelStandingbookDomain;

/**
 * 台账表domain
 * @author 
 * @date 2013-09-09
 */
public class DrelStandingbookDomain implements IDrelStandingbookDomain {

	@Reference
	private IDrelStandingbookDao drelStandingbookDao;

	/**
	 * 查询 台账表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return drelStandingbookDao.query(pset);
	}

	/**
	 * 获取 台账表
	 * @param pset
	 * @return
	 */
	public DrelStandingbook get(String domicileCode) {
		return drelStandingbookDao.get(domicileCode);
	}

	/**
	 * 增加 台账表
	 * @param drelStandingbook
	 */
	public void insert(DrelStandingbook drelStandingbook) {
		drelStandingbookDao.insert(drelStandingbook);
	}
	
	/**
	 * 修改 台账表
	 * @param drelStandingbook
	 */
	public void update(DrelStandingbook drelStandingbook) {
		drelStandingbookDao.update(drelStandingbook);
	}
	
	/**
	 * 删除 台账表
	 * @param domicileCode
	 */
	public void delete(String domicileCode) {
		drelStandingbookDao.delete(domicileCode);
	}
	
	/**
	 *  台账表导出查询
	 * @param domicileCode
	 */
	public DataSet queryInfo(ParameterSet pset) {
		return drelStandingbookDao.queryInfo(pset);
	}

}