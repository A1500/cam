package com.inspur.cams.dis.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.dis.base.data.DisFundsSource;
import com.inspur.cams.dis.base.data.DisFundsSourceBatch;
import com.inspur.cams.dis.base.data.DisFundsSourceDetail;

/**
 * 资金拨付明细表dao
 * @author 
 * @date 2013-01-04
 */
public interface IDisFundsSourceDetailDao extends BaseCURD<DisFundsSourceDetail> {
	/**
	 * @Description: 根据主表主键删除数据
	 * @author xuexzh
	 */
	void deleteByRef(String sourceId);

	/**
	 * @Description: 查询物资明细
	 * @author xuexzh
	 */
	DataSet queryFundsDetails(ParameterSet pset);
	
	/**
	 * @Description: 关系数据的物资返还给源编码-重置关系数据-根据源记录
	 * @author xuexzh
	 */
	void resetRefByOld(Record[] oldDisFundsSourceDetailDs, DisFundsSource disFundsSource);

	/**
	 * @Description: 删除关系数据-至临时表-根据源数据
	 * @author xuexzh
	 */
	void deleteRefByOld(Record[] oldDisFundsSourceDetailDs, DisFundsSource disFundsSource);
	
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

}