package com.inspur.cams.jcm.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.jcm.dao.IJcmPeopleTransferManageDao;
import com.inspur.cams.jcm.data.JcmPeopleTransferManage;

/**
 * 人员调动表dao
 * @author 
 * @date 2014-12-15
 */
public class JcmPeopleTransferManageDao extends EntityDao<JcmPeopleTransferManage> implements IJcmPeopleTransferManageDao {
	
	@Override
	public Class<JcmPeopleTransferManage> getEntityClass() {
		return JcmPeopleTransferManage.class;
	}

}