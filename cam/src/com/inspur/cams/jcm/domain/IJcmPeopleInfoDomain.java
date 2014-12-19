package com.inspur.cams.jcm.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.jcm.data.JcmPeopleInfo;

/**
 * 人员基本信息domain
 * @author 
 * @date 2014-05-16
 */
public interface IJcmPeopleInfoDomain {

	/**
	 * 查询 人员基本信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 人员基本信息
	 * @param pset
	 * @return
	 */
	public JcmPeopleInfo get(String peopleId);

	/**
	 * 增加 人员基本信息
	 * @param jcmPeopleInfo
	 */
	@Trans
	public void insert(JcmPeopleInfo jcmPeopleInfo);
	
	/**
	 * 修改 人员基本信息
	 * @param jcmPeopleInfo
	 */
	@Trans
	public void update(JcmPeopleInfo jcmPeopleInfo);
	
	/**
	 * 删除 人员基本信息
	 * @param peopleId
	 */
	@Trans
	public void delete(String peopleId);
	
	
	/**
	 * 保存人员相关信息
	 * @param jcmPeopleInfo
	 */
	@Trans
	public void save(JcmPeopleInfo jcmPeopleInfo,List resumeList,List companyList,List examList);
	
	
	/**
	 * 删除人员相关信息
	 * @param peopleId
	 */
	@Trans
	public void deleteAll(String peopleId);

}