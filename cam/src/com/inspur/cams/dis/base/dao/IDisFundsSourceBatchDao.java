package com.inspur.cams.dis.base.dao;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.dis.base.data.DisFundsSource;
import com.inspur.cams.dis.base.data.DisFundsSourceBatch;

/**
 * 资金拨付批次表dao
 * @author 
 * @date 2013-01-04
 */
public interface IDisFundsSourceBatchDao extends BaseCURD<DisFundsSourceBatch> {

	/**
	 * @Description: 重新计算批次信息
	 * @author xuexzh
	 */
	void reCompute(DisFundsSourceBatch disFundsSourceBatch);
	/**
	 * @Description: 确认拨付
	 * @author xuexzh
	 */
	void confirmAllocation(DisFundsSourceBatch disFundsSourceBatch);
	/**
	 * @Description: 删除批次
	 * @author xuexzh
	 */
	void deleteAllocation(DisFundsSourceBatch disFundsSourceBatch);
	
	/**
	 * @Description: 验证数据
	 * @author xuexzh
	 */
	void validateData(DisFundsSourceBatch disFundsSourceBatch);

}