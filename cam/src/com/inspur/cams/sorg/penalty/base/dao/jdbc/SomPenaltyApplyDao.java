package com.inspur.cams.sorg.penalty.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.sorg.penalty.base.dao.ISomPenaltyApplyDao;
import com.inspur.cams.sorg.penalty.base.data.SomPenaltyApply;

/**
 * 行政执法审批dao
 * 
 * @author:zhangjian
 * @date 2011-12-21
 */
public class SomPenaltyApplyDao extends EntityDao<SomPenaltyApply> implements
		ISomPenaltyApplyDao {
	@Override
	public Class<SomPenaltyApply> getEntityClass() {
		return SomPenaltyApply.class;
	}
}
