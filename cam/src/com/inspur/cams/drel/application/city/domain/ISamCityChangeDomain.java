package com.inspur.cams.drel.application.city.domain;

import java.util.List;
import java.util.Map;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.drel.sam.data.SamApplyInfo;

/**
 * 城市低保复查变更业务Domain接口
 * @author yanliangliang
 * @date 2012年5月15日10:41:16
 */
public interface ISamCityChangeDomain {
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
	
	
	/**
	 * 城市低保复核业务录入
	 * */
	public SamApplyInfo insertInfoFromRecheck(SamApplyInfo applyInfo);
	
	public SamApplyInfo batchInsertInfoFromRecheck(
			List<SamApplyInfo> batchApplyInfoFromCheck);
	public void batchInsertChangeFromRecheck(List<SamApplyInfo> applys);
	public void sendApplyFromReCheck(SamApplyInfo applyInfo);
	
	public void insertChangeFromRecheck(SamApplyInfo samApplyInfo);
	public void ChangeStatus(ParameterSet pset);
	
	/**
	 * 忽略重复提示的疑似人员
	 */
	@Trans
	public void ignoreSuspectedPersonnel(ParameterSet pset);
	
}
