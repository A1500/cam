package com.inspur.cams.drel.application.five.domain;

import java.util.Map;

import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.drel.sam.data.SamApplyInfo;

/**
 * 农村五保新申请业务Domain接口
 */
public interface ISamFiveApplyDomain {
	/**
	 * 保存五保新申请业务信息
	 */
	@Trans
	public SamApplyInfo insertInfo(SamApplyInfo applyInfo);
	/**
	 * 保存低保新申请业务信息(审核新增的)
	 */
	@Trans
	public SamApplyInfo insertInfoFromCheck(SamApplyInfo applyInfo);
	/**
	 * 更新低保新申请业务信息(审核新增的)
	 */
	@Trans
	public SamApplyInfo updateInfoFromCheck(SamApplyInfo applyInfo);
	/**
	 * 保存五保家庭成员信息
	 * @param applyId 
	 */
	@Trans
	public BaseinfoFamily insertPeopleInfo(BaseinfoPeople baseinfoPeople, String applyId);
	/**
	 * 删除五保家庭成员信息
	 */
	@Trans
	public BaseinfoFamily deletePeopleInfo(String delId,String familyId);
	/**
	 * 保存照片
	 * @param photoText
	 * @return
	 */
	@Trans
	public String savePhoto(String photoText);
	/**
	 * 更新照片
	 * @param photoText
	 * @return
	 */
	@Trans
	public String updatePhoto(String photoId, String photoText);
	/**
	 * 受理时提交流程
	 */
	@Trans
	public void submitApply(SamApplyInfo applyInfo);
	/**
	 * 更新流程意见
	 */
	@Trans
	public void updateApply(SamApplyInfo courseInfo);
	/**
	 * 发送流程
	 */
	@Trans
	public void sendApply(SamApplyInfo courseInfo);
	/**
	 * 校验身份证
	 * @param idCard 身份证号码
	 * @return familyId或者此人享有其他待遇的提示
	 */
	public Map<String, String> checkIDCard(String idCard);
	/**
	 * 批量审批
	 * @param batchApply
	 */
	@Trans
	public void batchApp(SamApplyInfo batchApply);
}
