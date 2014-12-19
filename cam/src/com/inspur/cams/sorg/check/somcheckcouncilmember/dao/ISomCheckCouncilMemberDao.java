package com.inspur.cams.sorg.check.somcheckcouncilmember.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomCheckCouncilMemberDao
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 public interface ISomCheckCouncilMemberDao extends BaseCURD<SomCheckCouncilMember>{
	public void save(List<SomCheckCouncilMember> list);
}

