package com.inspur.cams.drel.info.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.info.dao.ID204c21DieDao;
import com.inspur.cams.drel.info.data.D204c21Die;

/**
 * 户籍注销dao
 * @author
 * @date 2014-06-09
 */
public class D204c21DieDao extends EntityDao<D204c21Die> implements ID204c21DieDao {

	@Override
	public Class<D204c21Die> getEntityClass() {
		return D204c21Die.class;
	}

}