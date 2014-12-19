package com.inspur.cams.sorg.penalty.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.sorg.penalty.base.dao.ISomPenaltyDao;
import com.inspur.cams.sorg.penalty.base.data.SomPenalty;

/**
 * 行政执法基本信息dao
 * 
 * @author zhangjian
 * @date 2011-12-21
 */
public class SomPenaltyDao extends EntityDao<SomPenalty> implements
		ISomPenaltyDao {
	@Override
	public Class<SomPenalty> getEntityClass() {
		return SomPenalty.class;
	}
}
