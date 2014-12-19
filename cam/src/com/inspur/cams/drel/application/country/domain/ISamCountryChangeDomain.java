package com.inspur.cams.drel.application.country.domain;

import java.util.Map;

import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.drel.sam.data.SamApplyInfo;

/**
 * 农村低保复查变更业务Domain接口
 * @author yanliangliang
 * @date 2012年5月29日14:03:24
 */
public interface ISamCountryChangeDomain {
	/**
	 * 保存低保复查变更业务信息
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
	 * 更新低保家庭成员状态信息
	 */
	@Trans
	public BaseinfoFamily updatePeopleStats(String peopleId,String familyId,String personalStatsTag,String assistanceModeValue,String applyId);
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
	 * 复查变更受理时提交流程
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
	 * 保存区县内变更
	 */
	@Trans
	public void saveInChange(SamApplyInfo courseInfo);
	/**
	 * 校验身份证
	 * @param idCard 身份证号码
	 * @return familyId或者此人享有其他待遇的提示
	 */
	public Map<String, String> checkIDCard(String idCard);
	/**
	 * 更改申请人时保存人员申请人关系
	 */
	@Trans
	public void updatePeopleRelationshipType(Record[] peoples);
	/**
	 * 批量审批
	 * @param batchApply
	 */
	@Trans
	public void batchApp(SamApplyInfo batchApply);
}
