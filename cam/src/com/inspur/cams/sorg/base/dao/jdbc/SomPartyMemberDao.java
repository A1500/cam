package com.inspur.cams.sorg.base.dao.jdbc;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.sorg.base.dao.ISomPartyMemberDao;
import com.inspur.cams.sorg.base.data.SomPartyMember;

/**
 * 社会组织党建成员dao实现类
 * @author shgtch
 * @date 2011-8-18
 */
public class SomPartyMemberDao extends EntityDao<SomPartyMember> implements
		ISomPartyMemberDao {
	private static String deleteBySorgIdSql = "DELETE FROM SOM_PARTY_MEMBER WHERE SORG_ID = ?";
	@Override
	public Class<SomPartyMember> getEntityClass() {
		return SomPartyMember.class;
	}
	public void deleteBySorgId(String sorgId) {
		int[] types = new int[] { Types.VARCHAR };
		Object[] args = new Object[] { sorgId };
		executeUpdate(deleteBySorgIdSql, types, args);
	}

}
