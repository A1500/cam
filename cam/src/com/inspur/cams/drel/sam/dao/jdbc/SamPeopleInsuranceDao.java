package com.inspur.cams.drel.sam.dao.jdbc;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.sam.dao.ISamPeopleInsuranceDao;
import com.inspur.cams.drel.sam.data.SamPeopleInsurance;

/**
 * @title:社会保险dao
 * @description:
 * @author:
 * @since:2012-05-03
 * @version:1.0
 */
public class SamPeopleInsuranceDao extends EntityDao<SamPeopleInsurance> implements
		ISamPeopleInsuranceDao {
	private static String DELETE_BY_PEOPLE_ID = "DELETE FROM SAM_PEOPLE_INSURANCE WHERE PEOPLE_ID = ?";
	@SuppressWarnings("unchecked")
	@Override
	public Class getEntityClass() {
		return SamPeopleInsurance.class;
	}
	/**
	 * 根据人员id删除社会保险
	 * @param peopleId
	 */
	public void deleteByPeopleId(String peopleId) {
		executeUpdate(DELETE_BY_PEOPLE_ID, new int[] { Types.VARCHAR },
				new Object[] { peopleId });

	}
}
