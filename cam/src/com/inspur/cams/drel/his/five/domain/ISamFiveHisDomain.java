package com.inspur.cams.drel.his.five.domain;

import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.sam.data.SamApplyInfo;

/**
 * 农村五保历史Domain接口
 * @author 
 * @date 
 */
public interface ISamFiveHisDomain {
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
}
