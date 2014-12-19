package com.inspur.cams.cdc.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.sca.transaction.Trans;
import com.inspur.cams.cdc.base.data.CdcDecisionInfo;

/**
 * 基层民主民主决策信息表dao接口
 * @author shgtch
 * @date 2011-12-20
 */
public interface ICdcDecisionInfoDao extends BaseCURD<CdcDecisionInfo> {

	/**
	 * 删除某单位某次填报的内容
	 * @param recordId
	 * @param organCode
	 */
	@Trans
	void delete(String recordId, String organCode);

}