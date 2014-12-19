package com.inspur.cams.comm.diccityChange.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.comm.diccityChange.dao.IDicCityChangeBatchDao;
import com.inspur.cams.comm.diccityChange.data.DicCityChangeBatch;

/**
 * 变更批次表dao
 * @author 
 * @date 2014-01-02
 */
public class DicCityChangeBatchDao extends EntityDao<DicCityChangeBatch> implements IDicCityChangeBatchDao {
	
	@Override
	public Class<DicCityChangeBatch> getEntityClass() {
		return DicCityChangeBatch.class;
	}

}