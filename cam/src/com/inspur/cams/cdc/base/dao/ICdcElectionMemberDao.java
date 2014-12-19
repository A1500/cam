package com.inspur.cams.cdc.base.dao;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.cdc.base.data.CdcElectionMember;

/**
 * 民主选举人员信息dao
 * @author 
 * @date 2012-12-14
 */
public interface ICdcElectionMemberDao extends BaseCURD<CdcElectionMember> {

	void deleteByRecord(String recordId,String Type);

}