package com.inspur.cams.dis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import cmd.GetBspInfo;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.dis.base.data.DisReliefBatchDetail;
import com.inspur.cams.dis.base.data.DisReliefInfo;
import com.inspur.cams.dis.base.domain.IDisReliefBatchDetailDomain;
import com.inspur.cams.dis.base.domain.IDisReliefInfoDomain;
/**
 * @title:DisReliefInfoCommand
 * @description:
 * @author:
 * @since:2012-10-12
 * @version:1.0
*/
public class DisReliefTaskCommand extends BaseAjaxCommand{
	
	private IDisReliefBatchDetailDomain detailservice = ScaComponentFactory.getService(IDisReliefBatchDetailDomain.class,
		"disReliefBatchDetailDomain/disReliefBatchDetailDomain");
	private IDisReliefInfoDomain infoservice = ScaComponentFactory.getService(IDisReliefInfoDomain.class,"disReliefInfoDomain/disReliefInfoDomain");
	
	/**
	 * 提交
	 * 
	 */
	@Trans
	public void send(){
		Record[] records = (Record[]) getParameter("records");
		String state = (String) getParameter("changeState");
		String auditPeopleName = (String) getParameter("auditPeopleName");
		String auditDate = (String) getParameter("auditDate");
		String batchDetailId = (String) getParameter("batchDetailId");
		ParameterSet pset = new ParameterSet();
		if(DisReliefInfo.STATUS_FFJS.equals(state)||DisReliefInfo.STATUS_SPBTY.equals(state)
				||DisReliefInfo.STATUS_BQBZ.equals(state)||DisReliefInfo.STATUS_DSP.equals(state)){
			for (int i = 0; i < records.length; i++) {
				Record record = records[i];
				pset.clear();
				pset.setParameter("INFO_ID",record.get("INFO_ID"));
				DataSet ds = infoservice.query(pset);
				if(ds.getCount()>0){
					DisReliefInfo dataBean=(DisReliefInfo)ds.getRecord(0).toBean(DisReliefInfo.class);
					dataBean.setAuditPeopleName(auditPeopleName);
					dataBean.setAuditOrganName(BspUtil.getOrganName());
					dataBean.setAuditDate(auditDate);
					dataBean.setAuditOrganCode(BspUtil.getOrganCode());
					dataBean.setWorkflowStatus(state);
					infoservice.update(dataBean);
				}
			}
		}else if("31".equals(state)||"41".equals(state)){//全部同意和全部同意
			if("31".equals(state)){
				state=DisReliefInfo.STATUS_FFJS;
			}else{
				state=DisReliefInfo.STATUS_SPBTY;
			}
			pset.clear();
			pset.setParameter("BATCH_DETAIL_ID",batchDetailId);
			pset.setParameter("WORKFLOW_STATUS",DisReliefInfo.STATUS_DSP);
			DataSet ds = infoservice.query(pset);
			for (int i=0;i<ds.getCount();i++) {
				DisReliefInfo dataBean=(DisReliefInfo)ds.getRecord(i).toBean(DisReliefInfo.class);
				dataBean.setAuditPeopleName(auditPeopleName);
				dataBean.setAuditOrganName(BspUtil.getOrganName());
				dataBean.setAuditDate(auditDate);
				dataBean.setAuditOrganCode(BspUtil.getOrganCode());
				dataBean.setWorkflowStatus(state);
				infoservice.update(dataBean);
			}
		}
		setBatchFlag(batchDetailId);
	}
	/**
	 * 修改BatchDetail状态
	 * @param batchDetailId
	 */
	@Trans
	public void setBatchFlag(String batchDetailId){
		ParameterSet pset = new ParameterSet();
		pset.setParameter("BATCH_DETAIL_ID@=", batchDetailId);
		pset.setParameter("WORKFLOW_STATUS@=", DisReliefInfo.STATUS_DSP);
		DataSet ds1 = infoservice.queryTaskInfo(pset);
		
		pset.clear();
		pset.setParameter("BATCH_DETAIL_ID", batchDetailId);
		DataSet detailds = detailservice.query(pset);
		if(detailds.getCount()>0){
			DisReliefBatchDetail detailBean=(DisReliefBatchDetail)detailds.getRecord(0).toBean(DisReliefBatchDetail.class);
			if(ds1.getCount()==0){//查看是否全部审批
				pset.clear();
				pset.setParameter("BATCH_DETAIL_ID@=", batchDetailId);
				pset.setParameter("WORKFLOW_STATUS@=", DisReliefInfo.STATUS_BQBZ);
				DataSet ds2 = infoservice.queryTaskInfo(pset);
				if(ds2.getCount()>0){//全部审批完是否有退回的
					detailBean.setFillState(DisReliefBatchDetail.FILL_STATE_TH);
				}else{
					detailBean.setFillState(DisReliefBatchDetail.FILL_STATE_END);
				}
			}else{
				detailBean.setFillState(DisReliefBatchDetail.FILL_STATE_WC);
			}
			detailservice.update(detailBean);
		}
	}
	/**
	 * 发放物资
	 * 
	 */
	@Trans
	public void grant(){
		//String state = (String) getParameter("state");
		String grantPeopleName = (String) getParameter("grantPeopleName");
		String grantTime = (String) getParameter("grantTime");
		String batchDetailId = (String) getParameter("batchDetailId");
		ParameterSet pset = new ParameterSet();
		/*if("31".equals(state)){
			state=DisReliefInfo.STATUS_FFJS;
		}else{
			state=DisReliefInfo.STATUS_SPBTY;
		}*/
		pset.clear();
		pset.setParameter("BATCH_DETAIL_ID",batchDetailId);
		pset.setParameter("WORKFLOW_STATUS",DisReliefInfo.STATUS_FFJS);
		DataSet ds = infoservice.query(pset);
		for (int i=0;i<ds.getCount();i++) {
			DisReliefInfo dataBean=(DisReliefInfo)ds.getRecord(i).toBean(DisReliefInfo.class);
			dataBean.setWorkflowStatus(DisReliefInfo.STATUS_DFF);
			dataBean.setGrantOrganCode(BspUtil.getOrganCode());
			dataBean.setGrantOrganName(BspUtil.getOrganName());
			dataBean.setGrantPeopleName(grantPeopleName);
			dataBean.setGrantTime(grantTime);
			infoservice.update(dataBean);
		}
		pset.clear();
		pset.setParameter("BATCH_DETAIL_ID", batchDetailId);
		DataSet detailds = detailservice.query(pset);
		if(detailds.getCount()>0){
			DisReliefBatchDetail detailBean=(DisReliefBatchDetail)detailds.getRecord(0).toBean(DisReliefBatchDetail.class);
			detailBean.setFillState(DisReliefBatchDetail.FILL_STATE_FF);
			detailservice.update(detailBean);
		}
	}
}
