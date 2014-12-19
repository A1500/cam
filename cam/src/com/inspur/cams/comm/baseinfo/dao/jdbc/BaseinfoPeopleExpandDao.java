package com.inspur.cams.comm.baseinfo.dao.jdbc;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.comm.baseinfo.dao.IBaseinfoPeopleExpandDao;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeopleExpand;

public class BaseinfoPeopleExpandDao extends EntityDao<BaseinfoPeopleExpand> implements IBaseinfoPeopleExpandDao{

	@Override
	protected Class getEntityClass() {
		// TODO Auto-generated method stub
		return BaseinfoPeopleExpand.class;
	}
	

}
