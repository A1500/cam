package com.inspur.cams.jcm.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.jcm.dao.IJcmUserInfoDao;
import com.inspur.cams.jcm.data.JcmUserInfo;
import com.inspur.cams.jcm.domain.IJcmUserInfoDomain;

/**
 * 用户表domain
 * @author 
 * @date 2014-05-16
 */
public class JcmUserInfoDomain implements IJcmUserInfoDomain {

	@Reference
	private IJcmUserInfoDao jcmUserInfoDao;

	/**
	 * 查询 用户表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return jcmUserInfoDao.query(pset);
	}

	/**
	 * 获取 用户表
	 * @param pset
	 * @return
	 */
	public JcmUserInfo get(String userInfoId) {
		return jcmUserInfoDao.get(userInfoId);
	}

	/**
	 * 增加 用户表
	 * @param jcmUserInfo
	 */
	public void insert(JcmUserInfo jcmUserInfo) {
		jcmUserInfoDao.insert(jcmUserInfo);
	}
	
	/**
	 * 修改 用户表
	 * @param jcmUserInfo
	 */
	public void update(JcmUserInfo jcmUserInfo) {
		jcmUserInfoDao.update(jcmUserInfo);
	}
	
	/**
	 * 删除 用户表
	 * @param userInfoId
	 */
	public void delete(String userInfoId) {
		jcmUserInfoDao.delete(userInfoId);
	}

}