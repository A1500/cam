package com.inspur.cams.sorg.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.sorg.base.dao.ISomPrepareDao;
import com.inspur.cams.sorg.base.data.SomPrepare;
import com.inspur.cams.sorg.base.domain.ISomPrepareDomain;

/**
 * 社会组织筹备domain实现类
 * @author shgtch
 * @date 2011-8-12
 */
public class SomPrepareDomain implements ISomPrepareDomain {
	
	@Reference
	private ISomPrepareDao somPrepareDao;

	/**
	 * 查询社会组织筹备
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return somPrepareDao.query(pset);
	}

	/**
	 * 增加社会组织筹备
	 * @param somMeeting
	 */
	@Trans
	public void insert(SomPrepare somPrepare) {
		somPrepareDao.insert(somPrepare);
	}
	
	/**
	 * 更新社会组织筹备
	 * @param somMeeting
	 */
	@Trans
	public void update(SomPrepare somPrepare) {
		somPrepareDao.update(somPrepare);
	}
	
}