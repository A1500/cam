package com.inspur.comm.cqm.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.comm.cqm.base.dao.ICqmViewRelDao;
import com.inspur.comm.cqm.base.data.CqmViewRel;

/**
 * 自定义统计报表模型视图关系dao
 * @author shgtch
 * @date 2012-03-16
 */
public class CqmViewRelDao extends EntityDao<CqmViewRel> implements ICqmViewRelDao {
	
	@Override
	public Class<CqmViewRel> getEntityClass() {
		return CqmViewRel.class;
	}

}