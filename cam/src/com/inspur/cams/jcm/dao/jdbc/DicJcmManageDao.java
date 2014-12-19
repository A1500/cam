package com.inspur.cams.jcm.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.jcm.dao.IDicJcmManageDao;
import com.inspur.cams.jcm.data.DicJcmManage;

/**
 * 字典维护dao
 * @author 
 * @date 2014-05-22
 */
public class DicJcmManageDao extends EntityDao<DicJcmManage> implements IDicJcmManageDao {
	
	@Override
	public Class<DicJcmManage> getEntityClass() {
		return DicJcmManage.class;
	}

}