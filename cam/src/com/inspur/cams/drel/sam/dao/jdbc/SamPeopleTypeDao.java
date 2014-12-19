package com.inspur.cams.drel.sam.dao.jdbc;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.sam.dao.ISamPeopleTypeDao;
import com.inspur.cams.drel.sam.data.SamPeopleType;

/**
 * @title:人员类型dao
 * @description:
 * @author:zhangjian
 * @since:2012-05-28
 * @version:1.0
 */
public class SamPeopleTypeDao extends EntityDao<SamPeopleType> implements
		ISamPeopleTypeDao {
	private static String DELETE_BY_PEOPLE_ID = "DELETE FROM SAM_PEOPLE_TYPE WHERE PEOPLE_ID = ?";

	@SuppressWarnings("unchecked")
	@Override
	public Class getEntityClass() {
		return SamPeopleType.class;
	}

	/**
	 * 根据人员id删除
	 * 
	 * @param peopleId
	 */
	public void deleteByPeopleId(String peopleId) {
		executeUpdate(DELETE_BY_PEOPLE_ID, new int[] { Types.VARCHAR },
				new Object[] { peopleId });

	}
}
