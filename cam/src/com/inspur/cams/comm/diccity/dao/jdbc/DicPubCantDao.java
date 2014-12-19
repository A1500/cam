package com.inspur.cams.comm.diccity.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.comm.diccity.dao.IDicPubCantDao;
import com.inspur.cams.comm.diccity.data.DicCity;
import com.inspur.cams.comm.diccity.data.DicPubCant;

public class DicPubCantDao extends EntityDao<DicPubCant> implements IDicPubCantDao{

	@Override
	protected Class getEntityClass() {
		// TODO Auto-generated method stub
		return DicPubCant.class;
	}

}
