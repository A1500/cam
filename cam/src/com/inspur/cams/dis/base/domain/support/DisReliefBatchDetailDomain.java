package com.inspur.cams.dis.base.domain.support;

import java.util.ArrayList;
import java.util.List;

import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.data.RecordSet;
import org.loushang.next.data.StatefulDatabean;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.dis.base.dao.IDisReliefInfoDao;
import com.inspur.cams.dis.base.dao.support.DisReliefBatchDetailDao;
import com.inspur.cams.dis.base.data.DisReliefBatchDetail;
import com.inspur.cams.dis.base.data.DisReliefInfo;
import com.inspur.cams.dis.base.domain.IDisReliefBatchDetailDomain;

/**
 * @title:DisReliefDetailDomain
 * @description:
 * @author:
 * @since:2011-12-03
 * @version:1.0
*/
 public class DisReliefBatchDetailDomain implements IDisReliefBatchDetailDomain {
	 @Reference
	 DisReliefBatchDetailDao disReliefBatchDetailDao;
	 
	 @Reference
	 IDisReliefInfoDao infoDao;
	 
	 public IDisReliefInfoDao getInfoDao() {
		return infoDao;
	 }
	 public void setInfoDao(IDisReliefInfoDao infoDao) {
		this.infoDao = infoDao;
	 }
		
	 public  void insert(DisReliefBatchDetail reliefBatchDetail){
		 disReliefBatchDetailDao.insert(reliefBatchDetail);
	 }
	 public DataSet query(ParameterSet pset){
		 return disReliefBatchDetailDao.query(pset);
	 }
	 /**
	 * 根据批次id查询批次详细信息
	 */
	public DataSet queryBatchDetailByDetailId(ParameterSet pSet){
		return disReliefBatchDetailDao.queryBatchDetailByDetailId(pSet);
	}
	/**
	 * 根据批次DetailId和所需填报单位区划requiredOrganCode删除批次详细信息
	 */
	public void deleteByDetailIdOrganCode(String DetailId,String requiredOrganCode){
		disReliefBatchDetailDao.deleteByDetailIdOrganCode(DetailId, requiredOrganCode);
	}
	
	 
	public DataSet queryBatchDetail(ParameterSet pset){
		return disReliefBatchDetailDao.queryBatchDetail(pset);
	}
	/**
	 * 查询批次（冬春生活，因灾死亡，灾区民房）
	 * @param pset
	 * @return
	 */
	public DataSet queryAssistanceBatch(ParameterSet pset){
		return disReliefBatchDetailDao.queryAssistanceBatch(pset);
	}
	public void  update (DisReliefBatchDetail reliefBatchDetail){
		disReliefBatchDetailDao.update(reliefBatchDetail);
	}
	@Trans
	public String batchSubmit(String subId) {
		DisReliefBatchDetail batchDetail = this.disReliefBatchDetailDao.get(subId);
		String msg = "";
		if(batchDetail != null) {
			ParameterSet pset = new ParameterSet();
			pset.setParameter("BATCH_DETAIL_ID", subId);
			DataSet ds = this.infoDao.query(pset);
			if(ds != null && ds.getCount() != 0) {
				List<DisReliefInfo> infoList = new ArrayList<DisReliefInfo>();
				RecordSet rs = ds.getRecordSet();
				for(Record record : rs) {
					DisReliefInfo info = (DisReliefInfo)record.toBean(DisReliefInfo.class);
					info.setWorkflowStatus(DisReliefInfo.STATUS_DSP);
					info.setState(StatefulDatabean.STATE_MODIFIED);
					infoList.add(info);
				}
				
				if(infoList.size() != 0) {
					this.infoDao.save(infoList);
				}
				
				batchDetail.setFillTime(DateUtil.getTime());
				batchDetail.setFillPeople(GetBspInfo.getBspInfo().getUserName());
				batchDetail.setFillState(DisReliefBatchDetail.FILL_STATE_WC);
				batchDetail.setState(StatefulDatabean.STATE_MODIFIED);
				this.disReliefBatchDetailDao.update(batchDetail);
				
				msg = "操作成功！";
			} else {
				msg = "该批次还没有添加救灾信息，请添加救灾信息！";
			}
			
		} else {
			msg = "该批次信息不存在，请刷新页面！";
		}
		
		return msg;
	}
	/**
	 * 根据批次DetailId和所需填报单位区划requiredOrganCode删除批次详细信息
	 */
	public void deleteByBatchId(String BatchId){
		disReliefBatchDetailDao.deleteByBatchId(BatchId);
	}
	
	/**
	 * 救灾批次明细查询
	 * @param pset
	 * @return
	 */
	public DataSet queryDetail(ParameterSet pset) {
		return this.disReliefBatchDetailDao.queryDetail(pset);
	}
}