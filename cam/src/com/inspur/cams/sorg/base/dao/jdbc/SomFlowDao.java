package com.inspur.cams.sorg.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.sorg.base.dao.ISomFlowDao;
import com.inspur.cams.sorg.base.data.SomFlow;

/**
 * 社会组织历史意见表
 * @author shgtch
 * @date 2011-8-18
 */
public class SomFlowDao extends EntityDao<SomFlow> implements ISomFlowDao {

	@Override
	public Class<SomFlow> getEntityClass() {
		return SomFlow.class;
	}

}
