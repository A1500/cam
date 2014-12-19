package com.inspur.cams.sorg.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.base.data.SomPartyMemberStatusChange;

/**
 * @title:ISomPartyMemberStatusChangeDao
 * @description:
 * @author:
 * @since:2012-08-21
 * @version:1.0
*/
 public interface ISomPartyMemberStatusChangeDao extends BaseCURD<SomPartyMemberStatusChange>{
	public void save(List<SomPartyMemberStatusChange> list);
}

