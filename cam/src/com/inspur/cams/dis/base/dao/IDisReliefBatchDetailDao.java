package com.inspur.cams.dis.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.dis.base.data.DisReliefBatchDetail;
/**
 * @title:IDisReliefBatchDao
 * @description:
 * @author:
 * @since:2012-10-12
 * @version:1.0
*/
 public interface IDisReliefBatchDetailDao extends BaseCURD<DisReliefBatchDetail>{
	 	/**
		 * 根据批次id查询批次详细信息
		 */
		public DataSet queryBatchDetailByDetailId(ParameterSet pSet);
		/**
		 * 根据批次DetailId和所需填报单位区划requiredOrganCode删除批次详细信息
		 */
		public void deleteByDetailIdOrganCode(String DetailId,String requiredOrganCode);
		
		public DataSet queryBatchDetail(ParameterSet pset);
		/**
		 * 查询批次（冬春生活，因灾死亡，灾区民房）
		 * @param pset
		 * @return
		 */
		public DataSet queryAssistanceBatch(ParameterSet pset);
		public void selectBatch(String batchDetailId);
		/**
		 * 根据批次DetailId和所需填报单位区划requiredOrganCode删除批次详细信息
		 */
		public void deleteByBatchId(String BatchId);
		
		public DataSet queryDetail(ParameterSet pset);
}

