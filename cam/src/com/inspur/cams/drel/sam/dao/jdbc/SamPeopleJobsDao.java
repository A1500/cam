package com.inspur.cams.drel.sam.dao.jdbc;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.sam.dao.ISamPeopleJobsDao;
import com.inspur.cams.drel.sam.data.SamPeopleJobs;

/**
 * @title:就业信息dao
 * @description:
 * @author:
 * @since:2012-05-03
 * @version:1.0
 */
public class SamPeopleJobsDao extends EntityDao<SamPeopleJobs> implements
		ISamPeopleJobsDao {
	private static String DELETE_BY_PEOPLE_ID = "DELETE FROM SAM_PEOPLE_JOBS WHERE PEOPLE_ID = ?";
	@SuppressWarnings("unchecked")
	@Override
	public Class getEntityClass() {
		return SamPeopleJobs.class;
	}
	/**
	 * 根据人员id删除就业信息
	 * @param samPeopleJobs
	 */
	public void deleteByPeopleId(String peopleId) {
		executeUpdate(DELETE_BY_PEOPLE_ID, new int[] { Types.VARCHAR },
				new Object[] { peopleId });

	}
}
