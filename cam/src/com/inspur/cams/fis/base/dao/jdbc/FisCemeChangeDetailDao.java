package com.inspur.cams.fis.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.fis.base.dao.IFisCemeChangeDetailDao;
import com.inspur.cams.fis.base.data.FisCemeChangeDetail;

/**
 * 公墓信息变更备案明细表dao
 * @author 
 * @date 2013-08-01
 */
public class FisCemeChangeDetailDao extends EntityDao<FisCemeChangeDetail> implements IFisCemeChangeDetailDao {
	
	@Override
	public Class<FisCemeChangeDetail> getEntityClass() {
		return FisCemeChangeDetail.class;
	}

	public void deleteByChangeId(String changeId) {
		StringBuffer sql = new StringBuffer();
		sql.append("DELETE FROM FIS_CEME_CHANGE_DETAIL WHERE CHANGE_ID = '"+changeId+"'");
		executeUpdate(sql.toString());
	}

}