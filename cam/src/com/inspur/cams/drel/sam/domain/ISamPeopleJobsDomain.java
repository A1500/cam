package com.inspur.cams.drel.sam.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import com.inspur.cams.drel.sam.data.SamPeopleJobs;

/**
 * @title:就业信息Domain接口
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public interface ISamPeopleJobsDomain {
	/**
	 * 查询就业信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加就业信息
	 * @param samPeopleJobs
	 */
	@Trans
	public void insert(SamPeopleJobs samPeopleJobs);
	
	/**
	 * 更新就业信息
	 * @param samPeopleJobs
	 */
	@Trans
	public void update(SamPeopleJobs samPeopleJobs);
	
	/**
	 * 根据人员id删除就业信息
	 * @param samPeopleJobs
	 */
	@Trans
	public void deleteByPeopleId(String peopleId);
}
