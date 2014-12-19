package com.inspur.cams.dis.base.domain.support;

import java.util.ArrayList;
import java.util.List;

import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.StatefulDatabean;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.PubUtils;
import com.inspur.cams.dis.base.dao.IDisBaseFamilyRecordDao;
import com.inspur.cams.dis.base.dao.IDisReliefBatchDetailDao;
import com.inspur.cams.dis.base.dao.IDisReliefInfoDao;
import com.inspur.cams.dis.base.data.DisReliefBatchDetail;
import com.inspur.cams.dis.base.data.DisReliefInfo;
import com.inspur.cams.dis.base.domain.IDisReliefInfoDomain;

/**
 * @title:SomAssessTypeDomain
 * @description:
 * @author:
 * @since:2011-12-03
 * @version:1.0
*/
 public class DisReliefInfoDomain implements IDisReliefInfoDomain {

	 IDisReliefInfoDao dao = (IDisReliefInfoDao) DaoFactory
		.getDao("com.inspur.cams.dis.base.dao.support.DisReliefInfoDao");
	 
	 @Reference
	 private IDisBaseFamilyRecordDao familyDao;
	 
	 @Reference
	 private IDisReliefBatchDetailDao detailDao;
	 

	public IDisReliefBatchDetailDao getDetailDao() {
		return detailDao;
	}

	public IDisBaseFamilyRecordDao getFamilyDao() {
		return familyDao;
	}

	@Trans
	 public void save(DisReliefInfo disReliefInfo){
		 disReliefInfo.setInfoId(IdHelp.getUUID32());
		 // 行政区划
		 String organCode = BspUtil.getOrganCode();
		// 填报单位名称
		 String organName = BspUtil.getDeptOrgan().getOrganName();
		
		 disReliefInfo.setOrganName(organName);
		 disReliefInfo.setOrganCode(organCode);
		 
		 dao.insert(disReliefInfo);
	 }
	 
	 @Trans
	 public void update(DisReliefInfo disReliefInfo){
		 dao.update(disReliefInfo);
	 }
	 
	 @Trans
	 public void delete(DisReliefInfo disReliefInfo){
		 dao.delete(disReliefInfo);
	 }
	 
	 @Trans
	 public void batchDelete(String[] delIds){
		 dao.batchDelete(delIds);
	 }

	 @Trans
	public void batchSubmit(String[] subIds) {
		List<DisReliefInfo> list = new ArrayList<DisReliefInfo>();
		for(String subId : subIds) {
			DisReliefInfo info = dao.get(subId);
			if(DisReliefInfo.STATUS_DSP.equals(info.getWorkflowStatus())) {
				continue;
			} else {
				info.setWorkflowStatus(DisReliefInfo.STATUS_DSP);
				info.setState(StatefulDatabean.STATE_MODIFIED);
				list.add(info);
			}
			
		}
		dao.save(list);
		
	}

	/**
	 * 保存救助信息
	 */
	 @Trans
	public void saveInfo(DisReliefInfo info) {
		List<DisReliefInfo> infoList = new ArrayList<DisReliefInfo>();
		String organCode = BspUtil.getOrganCode();
		String organName = BspUtil.getOrganName();
		if(PubUtils.isEmpty(info.getInfoId())){  //判断主键是否为空：为空则为添加记录
			String pid = IdHelp.getUUID32();
			info.setInfoId(pid);
			info.setFillTime(DateUtil.getTime());
			info.setOrganCode(organCode);    //填报单位代码
			info.setOrganName(organName);    //填报单位名称
			if("14".equals(BspUtil.getOrganType())) {
				info.setCheckOrganCode(organCode);
				info.setCheckOrganName(organName);
				info.setCheckDate(DateUtil.getTime());
				info.setCheckPeopleName(GetBspInfo.getBspInfo().getUserName());
			}
			info.setWorkflowStatus(DisReliefInfo.STATUS_DTJ);
			info.setState(StatefulDatabean.STATE_NEW);
			infoList.add(info);
			dao.save(infoList);
			
			DisReliefBatchDetail detail = this.detailDao.get(info.getBatchDetailId());
			if(DisReliefBatchDetail.FILL_STATE_XJ.equals(detail.getFillState())) {
				detail.setFillState(DisReliefBatchDetail.FILL_STATE_LR);
				detail.setState(StatefulDatabean.STATE_MODIFIED);
				this.detailDao.update(detail);
			}
			
		} else {	//不为空，则为修改记录
			info.setFillTime(DateUtil.getTime());
			info.setOrganCode(organCode);
			info.setOrganName(organName);
			info.setGrantOrganCode(organCode);
			info.setGrantOrganName(organName);
			info.setState(StatefulDatabean.STATE_MODIFIED);
			dao.update(info);
		}
		
	}
	 @Trans
	public boolean checkDelete(String infoId) {
		boolean bl = true;
		DisReliefInfo info = dao.get(infoId);
		if(DisReliefInfo.STATUS_DSP.equals(info.getWorkflowStatus())) {
			bl = false;
		}
		return bl;
	}

	public boolean checkUpdate(String infoId) {
		boolean bl = true;
		DisReliefInfo info = dao.get(infoId);
		String workflowStatus = info.getWorkflowStatus();
		if(DisReliefInfo.STATUS_DSP.equals(workflowStatus)) {
			bl = false;
		} else if(DisReliefInfo.STATUS_BQBZ.equals(workflowStatus)) {
			bl = false;
		}
		return bl;
	}

	@Trans
	public void batchDelete(String[] delIds, String batchDetailId) {
		this.dao.batchDelete(delIds);
		ParameterSet pset = new ParameterSet();
		pset.setParameter("BATCH_DETAIL_ID", batchDetailId);
		DataSet ds = this.dao.query(pset);
		if(ds == null || ds.getCount() == 0) {
			DisReliefBatchDetail detail = this.detailDao.get(batchDetailId);
			detail.setFillState(DisReliefBatchDetail.FILL_STATE_XJ);
			detail.setState(StatefulDatabean.STATE_MODIFIED);
			this.detailDao.update(detail);
		}
	}
	/**
	 * 查询任务列表救灾的信息
	 * @param pset
	 * @return
	 */
	public DataSet queryTaskInfo(ParameterSet pset){
		return dao.queryTaskInfo(pset);
	}
	public DataSet query(ParameterSet pset){
		return dao.query(pset);
	}
	/**
	 * 获取各批次的核准信息及平均值
	 * @param pset
	 * @return
	 */
	public DataSet queryBatchGatherDate(ParameterSet pset){
		return dao.queryBatchGatherDate(pset);
	}
}