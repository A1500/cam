package com.inspur.cams.fis.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.fis.base.dao.IFisCemeLogoffOpinionDao;
import com.inspur.cams.fis.base.data.FisCemeLogoffOpinion;

/**
 * 同级其它部门意见dao
 * @author 
 * @date 2013-08-15
 */
public class FisCemeLogoffOpinionDao extends EntityDao<FisCemeLogoffOpinion> implements IFisCemeLogoffOpinionDao {
	
	@Override
	public Class<FisCemeLogoffOpinion> getEntityClass() {
		return FisCemeLogoffOpinion.class;
	}

}