package com.inspur.cams.drel.sam.dao.jdbc;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.sam.dao.ISamPeopleIncomeDao;
import com.inspur.cams.drel.sam.data.SamPeopleIncome;

/**
 * @title:人员收入信息dao
 * @description:
 * @author:
 * @since:2012-05-03
 * @version:1.0
 */
public class SamPeopleIncomeDao extends EntityDao<SamPeopleIncome> implements
		ISamPeopleIncomeDao {
	private static String DELETE_BY_PEOPLE_ID = "DELETE FROM SAM_PEOPLE_INCOME WHERE PEOPLE_ID = ?";
	@SuppressWarnings("unchecked")
	@Override
	public Class getEntityClass() {
		return SamPeopleIncome.class;
	}
	/**
	 * 根据人员id删除个人收入信息
	 * @param peopleId
	 */
	public void deleteByPeopleId(String peopleId) {
		executeUpdate(DELETE_BY_PEOPLE_ID, new int[] { Types.VARCHAR },
				new Object[] { peopleId });

	}
}
