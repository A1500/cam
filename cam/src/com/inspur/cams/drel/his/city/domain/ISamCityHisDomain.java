package com.inspur.cams.drel.his.city.domain;

import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.sam.data.SamApplyInfo;

/**
 * 城市低保历史Domain接口
 * @author 
 * @date 
 */
public interface ISamCityHisDomain {
	/**
	 * 保存
	 */
	@Trans
	public SamApplyInfo insertInfo(SamApplyInfo samApplyInfo);
	/**
	 * 调用存储过程
	 * @param samApplyInfo
	 */
	@Trans
	public void toDuplicateRecord(SamApplyInfo samApplyInfo);
	/**
	 * 调用存储过程删除历史采集的信息
	 */
	@Trans
	public void deleteHisInfoByApplyAndFamilyId(String applyId, String familyId);
	@Trans
	public void deleteHisPeople(String peopleId, String familyId);
	@Trans
	public SamApplyInfo saveModInfo(SamApplyInfo applyInfo);
}
