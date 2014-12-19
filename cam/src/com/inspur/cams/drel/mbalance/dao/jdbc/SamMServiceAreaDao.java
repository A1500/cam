package com.inspur.cams.drel.mbalance.dao.jdbc;


import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.mbalance.dao.ISamMServiceAreaDao;
import com.inspur.cams.drel.mbalance.data.SamMServiceArea;



public class SamMServiceAreaDao extends EntityDao<SamMServiceArea> implements ISamMServiceAreaDao{

	@Override
	protected Class getEntityClass() {
		// TODO Auto-generated method stub
		return SamMServiceArea.class;
	}

}