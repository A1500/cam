package com.inspur.cams.sorg.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.sorg.base.dao.ISomSignetDirectoryDao;
import com.inspur.cams.sorg.base.domain.ISomSignetDirectoryDomain;

/**
 * 印章名录domain实现类
 * 
 * @author zhangjian
 * @date 2011-12-12
 */
public class SomSignetDirectoryDomain implements ISomSignetDirectoryDomain {

	@Reference
	private ISomSignetDirectoryDao somSignetDirectoryDao;

	/**
	 * 查询社会组织印章名录
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return somSignetDirectoryDao.query(pset);
	}
}
