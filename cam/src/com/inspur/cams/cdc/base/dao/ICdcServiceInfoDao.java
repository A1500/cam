package com.inspur.cams.cdc.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcServiceInfo;

/**
 * 基础信息社区服务信息�?Dao??��??
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public interface ICdcServiceInfoDao extends BaseCURD<CdcServiceInfo> {

	/**
	 * 删除某次填报数据
	 * @param recordId
	 * @param organCode
	 */
	@Trans
	void delete(String recordId, String organCode);

}