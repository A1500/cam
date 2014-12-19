package com.inspur.cams.sorg.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.sorg.base.dao.ISomPrepareDao;
import com.inspur.cams.sorg.base.data.SomPrepare;

/**
 * 社会组织筹备表
 * @author shgtch
 * @date 2011-8-18
 */
public class SomPrepareDao extends EntityDao<SomPrepare> implements
		ISomPrepareDao {

	@Override
	public Class<SomPrepare> getEntityClass() {
		return SomPrepare.class;
	}

}
