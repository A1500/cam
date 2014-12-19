package com.inspur.cams.marry.application.domain;

import com.inspur.cams.marry.base.data.MrmOrganStandardApply;

/**
 * 婚姻登记机关等级评定申报domain接口
 */
public interface IMrmLevelApplyDomain {
	/**
	 * 新增业务信息
	 */
	public String insert(MrmOrganStandardApply mrmOrganStandardApply);
	/**
	 * 新增并提交
	 */
	public void insertAndSend(MrmOrganStandardApply mrmOrganStandardApply);
	/**
	 * 修改业务信息
	 */
	public void update(MrmOrganStandardApply mrmOrganStandardApply);
	/**
	 * 修改并提交
	 */
	public void updateAndSend(MrmOrganStandardApply mrmOrganStandardApply);
	/**
	 * 删除业务信息
	 */
	public void delete(String applyId);
	public void deleteElec(String applyId);
	public String insertu(MrmOrganStandardApply apply);
	public void insertuAndSend(MrmOrganStandardApply apply);
}
