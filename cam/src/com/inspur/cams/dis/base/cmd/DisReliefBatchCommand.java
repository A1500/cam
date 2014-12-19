package com.inspur.cams.dis.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.diccity.data.DicCity;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.dis.base.data.DisReliefBatch;
import com.inspur.cams.dis.base.data.DisReliefBatchDetail;
import com.inspur.cams.dis.base.domain.IDisReliefBatchDetailDomain;
import com.inspur.cams.dis.base.domain.IDisReliefBatchDomain;
/**
 * @title:DisReliefInfoCommand
 * @description:
 * @author:
 * @since:2012-10-12
 * @version:1.0
*/
public class DisReliefBatchCommand extends BaseAjaxCommand{
	
	private IDisReliefBatchDomain service = ScaComponentFactory.getService(IDisReliefBatchDomain.class,
			"disReliefBatchDomain/disReliefBatchDomain");
	private IDisReliefBatchDetailDomain detailservice = ScaComponentFactory.getService(IDisReliefBatchDetailDomain.class,
		"disReliefBatchDetailDomain/disReliefBatchDetailDomain");
	EntityDao<DicCity> dao = (EntityDao<DicCity>)DaoFactory.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
	//添加
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		DisReliefBatch dataBean=(DisReliefBatch)record.toBean(DisReliefBatch.class);
		dataBean.setBatchId(IdHelp.getUUID32());
		dataBean.setCreateOrganCode(BspUtil.getOrganCode());
		dataBean.setCreateTime(DateUtil.getDay());
		String[] area = dataBean.getAreaCode().split(",");
		ParameterSet pset = getParameterSet();
		for (String a : area) {//创建批次明细
			DisReliefBatchDetail detailbean=(DisReliefBatchDetail)record.toBean(DisReliefBatchDetail.class);
			detailbean.setBatchDetailId(IdHelp.getUUID32());
			detailbean.setBatchId(dataBean.getBatchId());
			detailbean.setRequiredOrganCode(a);
			pset.clear();
			pset.setParameter("ID", a);
			DataSet CodeDataSet = dao.query(pset);
			if(CodeDataSet.getCount()>0){
				Record apanageCodeRecord = CodeDataSet.getRecord(0);
				detailbean.setRequiredOrganName((String)apanageCodeRecord.get("fullName"));
			}
			
			detailbean.setFillState("0");//填报状态为0:刚创建了批次明细
			detailservice.insert(detailbean);
		}
		service.insert(dataBean);
	}
	//更新
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		DisReliefBatch dataBean=(DisReliefBatch)record.toBean(DisReliefBatch.class);
		service.update(dataBean);
		String addBatchs = (String) getParameter("addBatch");
		String delBatchs = (String) getParameter("delBatch");
		ParameterSet pset = getParameterSet();
		if(!"".equals(addBatchs)){//添加新的批次明细
			String[] addBatch = addBatchs.split(",");
			for (String a : addBatch) {//创建批次明细
				DisReliefBatchDetail detailbean=(DisReliefBatchDetail)record.toBean(DisReliefBatchDetail.class);
				detailbean.setBatchDetailId(IdHelp.getUUID32());
				detailbean.setBatchId(dataBean.getBatchId());
				detailbean.setRequiredOrganCode(a);
				pset.clear();
				pset.setParameter("ID", a);
				DataSet CodeDataSet = dao.query(pset);
				if(CodeDataSet.getCount()>0){
					Record apanageCodeRecord = CodeDataSet.getRecord(0);
					detailbean.setRequiredOrganName((String)apanageCodeRecord.get("fullName"));
				}
				detailbean.setFillState("0");//填报状态为0:刚创建了批次明细
				detailservice.insert(detailbean);
			}
		}
		if(!"".equals(delBatchs)){//删除明细
			String[] delBatch = delBatchs.split(",");
			for (String a : delBatch) {
				detailservice.deleteByDetailIdOrganCode(dataBean.getBatchId(), a);
			}
		}
		
	}
	//更新
	@Trans
	public void save() {
		Record[] records = (Record[]) getParameter("records");
		List<DisReliefBatch> list = new ArrayList<DisReliefBatch>();
		service.save(list);
	}
	//删除
	@Trans
	public void delete(){
		Record record = (Record) getParameter("record");
		String dataBeanId= (String)record.get("batchId");
		service.delete(dataBeanId);
	}
	//批量删除
	@Trans
	public void batchDelete(){
		StringBuffer info = new StringBuffer();
		ParameterSet pset = new ParameterSet();
		Record[] records = (Record[]) getParameter("records");
		for (int i = 0; i < records.length; i++) {
			Record record = records[i];
			pset.setParameter("batchId", (String)record.get("batchId"));
			DataSet ds = detailservice.queryBatchDetailByDetailId(pset);
			Boolean b=true;
			for (int j = 0; j < ds.getCount(); j++) {
				if(!"0".equals(ds.getRecord(j).get("FILL_STATE"))){
					b=false;
					break;
				}
				
			}
			if(b){
				//DisReliefBatch dataBean=(DisReliefBatch)record.toBean(DisReliefBatch.class);
				String dataBeanId= (String)record.get("batchId");
				service.delete(dataBeanId);
				detailservice.deleteByBatchId(dataBeanId);
			}else{
				info.append((String)record.get("batchName")+",");
			}
		}
		this.setReturn("info",info.toString() );
	}
}
