package com.inspur.cams.comm.diccityChange.cmd;


import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.diccityChange.data.DicCityChangeBatch;
import com.inspur.cams.comm.diccityChange.domain.IDicCityChangeBatchAttachDomain;
import com.inspur.cams.comm.diccityChange.domain.IDicCityChangeBatchDomain;
import com.inspur.cams.comm.diccityChange.domain.IDicCityChangeDomain;
import com.inspur.cams.comm.diccityChange.domain.IDicCityDataTransDomain;

/**
 * 变更批次表cmd
 * @author 
 * @date 2014-01-02
 */
public class DicCityChangeBatchCmd extends BaseAjaxCommand {

	private IDicCityChangeBatchDomain dicCityChangeBatchDomain = ScaComponentFactory
			.getService(IDicCityChangeBatchDomain.class, "dicCityChangeBatchDomain/dicCityChangeBatchDomain");
	
	private IDicCityChangeDomain dicCityChangeDomain = ScaComponentFactory
		.getService(IDicCityChangeDomain.class, "dicCityChangeDomain/dicCityChangeDomain");
	//区划撤销时的从表domian
	private IDicCityDataTransDomain dicCityDataTransDomain = ScaComponentFactory
		.getService(IDicCityDataTransDomain.class, "dicCityDataTransDomain/dicCityDataTransDomain");
	//文件上传的domain
	private IDicCityChangeBatchAttachDomain dicCityChangeBatchAttachDomain = ScaComponentFactory
		.getService(IDicCityChangeBatchAttachDomain.class, "dicCityChangeBatchAttachDomain/dicCityChangeBatchAttachDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		DicCityChangeBatch dicCityChangeBatch = (DicCityChangeBatch) record.toBean(DicCityChangeBatch.class);
		dicCityChangeBatchDomain.insert(dicCityChangeBatch);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		DicCityChangeBatch dicCityChangeBatch = (DicCityChangeBatch) record.toBean(DicCityChangeBatch.class);
		dicCityChangeBatchDomain.update(dicCityChangeBatch);
	}
	
	// 删除
	public void delete() {
		String batchId = (String) getParameter("batchId");
		dicCityChangeBatchDomain.delete(batchId);
	}
	
	// 删除
	public void deleteAll() {
		String batchId = (String) getParameter("batchId");
		dicCityChangeBatchDomain.delete(batchId);
		
		//删除批次中的调整内容
		ParameterSet pset = new ParameterSet();
		pset.setParameter("BATCH_ID@=", batchId);
		DataSet ds = dicCityChangeDomain.query(pset);
		for(int i=0;i<ds.getCount();i++){
			String delId =(String) ds.getRecord(i).get("changeId");
			dicCityChangeDomain.delete(delId);
		}
		//批次中区划撤销从表的删除
		DataSet transDs = dicCityDataTransDomain.query(pset);
		for(int i=0;i<transDs.getCount();i++){
			String delId =(String) transDs.getRecord(i).get("transId");
			dicCityDataTransDomain.delete(delId);
		}
		
		//批次中附件表删除.
		DataSet attachDs = dicCityChangeBatchAttachDomain.query(pset);
		for(int i=0;i<attachDs.getCount();i++){
			String delId =(String) attachDs.getRecord(i).get("attachId");
			dicCityChangeBatchAttachDomain.delete(delId);
		}
		
	}
	
}