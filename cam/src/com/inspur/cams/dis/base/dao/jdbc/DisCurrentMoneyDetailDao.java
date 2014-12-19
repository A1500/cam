package com.inspur.cams.dis.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.dis.base.dao.IDisCurrentMoneyDetailDao;
import com.inspur.cams.dis.base.data.DisCurrentMoneyDetail;

/**
 * 单位当前物资情况表dao
 * @author 
 * @date 2012-11-05
 */
public class DisCurrentMoneyDetailDao extends EntityDao<DisCurrentMoneyDetail> implements IDisCurrentMoneyDetailDao {
	
	@Override
	public Class<DisCurrentMoneyDetail> getEntityClass() {
		return DisCurrentMoneyDetail.class;
	}

}