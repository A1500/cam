package com.inspur.cams.cdc.base.dao.jdbc;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.cdc.base.dao.ICdcDecisionInfoDao;
import com.inspur.cams.cdc.base.data.CdcDecisionInfo;

/**
 * 基层民主民主决策信息表Dao实现类
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcDecisionInfoDao extends EntityDao<CdcDecisionInfo> implements ICdcDecisionInfoDao {
	
	@Override
	public Class<CdcDecisionInfo> getEntityClass() {
		return CdcDecisionInfo.class;
	}

	public void delete(String recordId, String organCode) {
		String sql = "DELETE  FROM CDC_DECISION_INFO T WHERE T.RECORD_ID = ? AND T.ORGAN_CODE = ?";
		this.executeUpdate(sql,new int[]{Types.VARCHAR,Types.VARCHAR},new Object[]{recordId,organCode});
		
	}

}