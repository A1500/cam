package com.inspur.cams.drel.sam.dao;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.sam.data.SamPeopleJobs;

/**
 * @title:就业信息dao接口
 * @description:
 * @author:
 * @since:2012-05-03
 * @version:1.0
 */
public interface ISamPeopleJobsDao extends BaseCURD<SamPeopleJobs> {
	/**
	 * 根据人员id删除就业信息
	 * @param samPeopleJobs
	 */
	public void deleteByPeopleId(String peopleId);
}
