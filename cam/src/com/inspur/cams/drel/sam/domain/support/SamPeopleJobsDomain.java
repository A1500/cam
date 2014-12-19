package com.inspur.cams.drel.sam.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.drel.sam.dao.ISamPeopleJobsDao;
import com.inspur.cams.drel.sam.data.SamPeopleJobs;
import com.inspur.cams.drel.sam.domain.ISamPeopleJobsDomain;
/**
 * @title:就业信息Domain接口
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public class SamPeopleJobsDomain implements ISamPeopleJobsDomain {
	@Reference
	private ISamPeopleJobsDao samPeopleJobsDao;

	/**
	 * 增加就业信息
	 * @param samPeopleJobs
	 */
	public void insert(SamPeopleJobs samPeopleJobs) {
		samPeopleJobsDao.insert(samPeopleJobs);
	}
	/**
	 * 查询就业信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samPeopleJobsDao.query(pset);
	}
	/**
	 * 更新就业信息
	 * @param samPeopleJobs
	 */
	public void update(SamPeopleJobs samPeopleJobs) {
		samPeopleJobsDao.update(samPeopleJobs);
	}
	/**
	 * 根据人员id删除就业信息
	 * @param samPeopleJobs
	 */
	public void deleteByPeopleId(String peopleId){
		samPeopleJobsDao.deleteByPeopleId(peopleId);
	}

}
