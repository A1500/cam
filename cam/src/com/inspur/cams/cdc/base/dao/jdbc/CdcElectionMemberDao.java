package com.inspur.cams.cdc.base.dao.jdbc;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.cdc.base.dao.ICdcElectionMemberDao;
import com.inspur.cams.cdc.base.data.CdcElectionMember;

/**
 * 民主选举人员信息dao
 * @author 
 * @date 2012-12-14
 */
public class CdcElectionMemberDao extends EntityDao<CdcElectionMember> implements ICdcElectionMemberDao {
	
	@Override
	public Class<CdcElectionMember> getEntityClass() {
		return CdcElectionMember.class;
	}
	/**
	 * 删除某次选举候选人信息
	 * @param recordId
	 */
	public void deleteByRecord(String recordId,String type) {
		String sql = "DELETE FROM CDC_ELECTION_MEMBER T WHERE T.RECORD_ID = ? AND T.TYPE = ?";
		this.executeUpdate(sql,new int[]{Types.VARCHAR,Types.VARCHAR},new Object[]{recordId,type});
	}

}