package com.inspur.cams.jcm.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.jcm.data.JcmUserInfo;

/**
 * 用户表domain
 * @author 
 * @date 2014-05-16
 */
public interface IJcmUserInfoDomain {

	/**
	 * 查询 用户表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 用户表
	 * @param pset
	 * @return
	 */
	public JcmUserInfo get(String userInfoId);

	/**
	 * 增加 用户表
	 * @param jcmUserInfo
	 */
	@Trans
	public void insert(JcmUserInfo jcmUserInfo);
	
	/**
	 * 修改 用户表
	 * @param jcmUserInfo
	 */
	@Trans
	public void update(JcmUserInfo jcmUserInfo);
	
	/**
	 * 删除 用户表
	 * @param userInfoId
	 */
	@Trans
	public void delete(String userInfoId);

}