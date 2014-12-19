package com.inspur.cams.dis.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.dis.base.data.DisFundsSource;
import com.inspur.cams.dis.base.data.DisFundsSourceBatch;
import com.inspur.cams.dis.base.domain.IDisFundsSourceBatchDomain;

/**
 * 资金拨付批次表cmd
 * @author 
 * @date 2013-01-04
 */
public class DisFundsSourceBatchCmd extends BaseAjaxCommand {

	private IDisFundsSourceBatchDomain disFundsSourceBatchDomain = ScaComponentFactory
			.getService(IDisFundsSourceBatchDomain.class, "disFundsSourceBatchDomain/disFundsSourceBatchDomain");
	
	// 增加基本
	public void insertInit() {
		Record record = (Record) getParameter("disFundsSourceBatch");
		Record[] disFundsSources = (Record[]) getParameter("disFundsSources");
		String peopleName = GetBspInfo.getBspInfo().getUserName();
		String times = DateUtil.getTime();
		
		DisFundsSourceBatch disFundsSourceBatch = (DisFundsSourceBatch) record.toBean(DisFundsSourceBatch.class);
		disFundsSourceBatch.setFillPeopleName(peopleName);
		disFundsSourceBatch.setFillTime(times);
		disFundsSourceBatch.setUpdatePeopleName(peopleName);
		disFundsSourceBatch.setUpdateTime(times);
		disFundsSourceBatch.setState(Record.STATE_NEW);
		
		List<DisFundsSource> disFundsSourceList = new ArrayList<DisFundsSource>();
		if(disFundsSources!=null && disFundsSources.length > 0) {
			for(int i=0; i<disFundsSources.length; i++) {
				DisFundsSource disFundsSource = (DisFundsSource)disFundsSources[i].toBean(DisFundsSource.class);
				disFundsSource.setDisYear(disFundsSourceBatch.getDisYear());
				disFundsSource.setSourceType(disFundsSourceBatch.getSourceType());
				disFundsSource.setUpAllocationNum(disFundsSourceBatch.getUpAllocationNum());
				disFundsSource.setUpAllocationType(disFundsSourceBatch.getUpAllocationType());
				disFundsSource.setUpAllocationPurpose(disFundsSourceBatch.getUpAllocationPurpose());
				disFundsSource.setFillPeopleName(peopleName);
				disFundsSource.setFillTime(times);
				disFundsSource.setUpdatePeopleName(peopleName);
				disFundsSource.setUpdateTime(times);
				disFundsSource.setState(Record.STATE_NEW);
				disFundsSourceList.add(disFundsSource);
			}
		}
		
		disFundsSourceBatch.setDisFundsSourceList(disFundsSourceList);
		disFundsSourceBatchDomain.insertInit(disFundsSourceBatch);
	}
	
	//修改基本
	public void updateInit() {
		Record record = (Record) getParameter("disFundsSourceBatch");
		DisFundsSourceBatch disFundsSourceBatch = (DisFundsSourceBatch) record.toBean(DisFundsSourceBatch.class);
		disFundsSourceBatch.setUpdatePeopleName(GetBspInfo.getBspInfo().getUserName());
		disFundsSourceBatch.setUpdateTime(DateUtil.getTime());
		disFundsSourceBatch.setState(Record.STATE_MODIFIED);
		
		disFundsSourceBatchDomain.updateInit(disFundsSourceBatch);
	}
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		DisFundsSourceBatch disFundsSourceBatch = (DisFundsSourceBatch) record.toBean(DisFundsSourceBatch.class);
		disFundsSourceBatchDomain.insert(disFundsSourceBatch);
	}
	
	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		DisFundsSourceBatch disFundsSourceBatch = (DisFundsSourceBatch) record.toBean(DisFundsSourceBatch.class);
		disFundsSourceBatchDomain.update(disFundsSourceBatch);
	}
	
	// 删除
	public void delete() {
		String batchId = (String) getParameter("batchId");
		disFundsSourceBatchDomain.delete(batchId);
	}
	
	//拨付
	public void allocation() {
		disFundsSourceBatchDomain.allocation(getParameterSet());
	}
	//拨付-市县
	public void allocationSingle() {
		disFundsSourceBatchDomain.allocationSingle(getParameterSet());
	}
	//确认拨付
	public void confirmAllocation() {
		String batchId = (String)getParameter("batchId");
		String peopleName = GetBspInfo.getBspInfo().getUserName();
		String times = DateUtil.getTime();
		DisFundsSourceBatch disFundsSourceBatch = new DisFundsSourceBatch();
		disFundsSourceBatch.setBatchId(batchId);
		disFundsSourceBatch.setFillOrganCode(BspUtil.getOrganCode());
		disFundsSourceBatch.setFillOrganName(BspUtil.getOrganName());
		disFundsSourceBatch.setUpdatePeopleName(peopleName);
		disFundsSourceBatch.setUpdateTime(times);
		disFundsSourceBatch.setConfirmPeopleName(peopleName);
		disFundsSourceBatch.setConfirmTime(times);
		disFundsSourceBatch.setInConfirm("1");
		disFundsSourceBatchDomain.confirmAllocation(disFundsSourceBatch);
	}
	//删除批次
	public void deleteAllocation() {
		String batchId = (String)getParameter("batchId");
		DisFundsSourceBatch disFundsSourceBatch = new DisFundsSourceBatch();
		disFundsSourceBatch.setBatchId(batchId);
		disFundsSourceBatchDomain.deleteAllocation(disFundsSourceBatch);
	}
	
	//置换物资
	public void swapMeterial() {
		disFundsSourceBatchDomain.swapMeterial(getParameterSet());
	}
}