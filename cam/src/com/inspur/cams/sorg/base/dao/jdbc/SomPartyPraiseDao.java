package com.inspur.cams.sorg.base.dao.jdbc;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.sorg.base.dao.ISomPartyPraiseDao;
import com.inspur.cams.sorg.base.data.SomPartyPraise;

/**
 * 党建党内奖惩dao实现类
 */
public class SomPartyPraiseDao extends EntityDao<SomPartyPraise> implements
		ISomPartyPraiseDao {

	private static String deleteByMemberIdSql = "DELETE FROM SOM_PARTY_PRAISE WHERE MEMBER_ID = ?";

	@Override
	public Class<SomPartyPraise> getEntityClass() {
		return SomPartyPraise.class;
	}
	public void deleteByMemberId(String memberId) {
		int[] types = new int[] { Types.VARCHAR };
		Object[] args = new Object[] { memberId };
		executeUpdate(deleteByMemberIdSql, types, args);
	}
}
