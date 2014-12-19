package com.inspur.cams.comm.dicm.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.comm.dicm.dao.IDicManageDao;
import com.inspur.cams.comm.dicm.data.DicManage;

/*******************************************************************************
 * 字典信息维护dao
 * 
 * @author luguosui
 * @date 2011-8-31
 */
public class DicManageDao extends EntityDao<DicManage> implements IDicManageDao {

	@Override
	protected Class<DicManage> getEntityClass() {
		return DicManage.class;
	}

}
