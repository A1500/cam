package com.inspur.cams.drel.his.country.domain;

import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.sam.data.SamApplyInfo;

/**
 * 农村低保历史Domain接口
 * @author 
 * @date 
 */
public interface ISamCountryHisDomain {
	/**
	 * 保存
	 */
	@Trans
	public SamApplyInfo insertInfo(SamApplyInfo samApplyInfo);
	/**
	 * 调用存储过程把记录保存到备用表中
	 */
	@Trans
	public void toDuplicateRecord(SamApplyInfo samApplyInfo);
}
