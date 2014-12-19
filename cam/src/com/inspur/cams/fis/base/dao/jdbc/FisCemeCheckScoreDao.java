package com.inspur.cams.fis.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.fis.base.dao.IFisCemeCheckScoreDao;
import com.inspur.cams.fis.base.data.FisCemeCheckScore;

/**
 * 公墓年检打分dao
 * @author 
 * @date 2013-08-01
 */
public class FisCemeCheckScoreDao extends EntityDao<FisCemeCheckScore> implements IFisCemeCheckScoreDao {
	
	@Override
	public Class<FisCemeCheckScore> getEntityClass() {
		return FisCemeCheckScore.class;
	}

}