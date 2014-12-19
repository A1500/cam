package com.inspur.cams.dis.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.dis.base.data.DisFundsSource;
import com.inspur.cams.dis.base.data.DisFundsSourceDetail;
import com.inspur.cams.dis.base.domain.IDisFundsSourceDomain;

/**
 * 资金拨付表cmd
 * @author 
 * @date 2013-01-04
 */
public class DisFundsSourceCmd extends BaseAjaxCommand {

	private IDisFundsSourceDomain disFundsSourceDomain = ScaComponentFactory
			.getService(IDisFundsSourceDomain.class, "disFundsSourceDomain/disFundsSourceDomain");
	
	// 增加
	public void insert() {
		String isUp = (String) getParameter("isUp");
		String sourceType = (String) getParameter("sourceType");
		Record source = (Record) getParameter("source");
		Record[] sourceDetails = (Record[]) getParameter("sourceDetails");
		String peopleName = GetBspInfo.getBspInfo().getUserName();
		String times = DateUtil.getTime();

		DisFundsSource disFundsSource = (DisFundsSource) source.toBean(DisFundsSource.class);
		String sourceId = IdHelp.getUUID32();
		disFundsSource.setSourceId(sourceId);
		disFundsSource.setSourceType(sourceType);
		disFundsSource.setReceiveOrganCode(BspUtil.getOrganCode());
		disFundsSource.setReceiveOrganName(BspUtil.getOrganName());
		disFundsSource.setFillPeopleName(peopleName);
		disFundsSource.setFillTime(times);
		disFundsSource.setUpdatePeopleName(peopleName);
		disFundsSource.setUpdateTime(times);
		disFundsSource.setAmountBalance(disFundsSource.getAmount());
		disFundsSource.setMeterialBalance(disFundsSource.getMeterial());
		disFundsSource.setInUse("0");
		if("T".equals(isUp)) {
			//部级发放
			disFundsSource.setFillOrganCode("000000000000");
			disFundsSource.setFillOrganName("民政部");
			disFundsSource.setFundsType("0"); //此为中央级拨款
		}else {
			disFundsSource.setFillOrganCode(BspUtil.getOrganCode());
			disFundsSource.setFillOrganName(BspUtil.getOrganName());
			
//			String organType = BspUtil.getOrganType();
//			if("11".endsWith(organType)) {
//				disFundsSource.setFundsType("1"); //省民政厅
//			}else if("12".endsWith(organType)) {
//				disFundsSource.setFundsType("2"); //市民政局
//			}else if("13".endsWith(organType)) {
//				disFundsSource.setFundsType("3"); //区县民政局
//			}else if("14".endsWith(organType)) {
//				disFundsSource.setFundsType("4"); //镇/街道办事处
//			}
		}
		
		List<DisFundsSourceDetail> disFundsSourceDetailsList = new ArrayList<DisFundsSourceDetail>();
		if(sourceDetails!=null && sourceDetails.length > 0) {
			for(int i=0;i<sourceDetails.length;i++) {
				DisFundsSourceDetail disFundsSourceDetail = (DisFundsSourceDetail) sourceDetails[i].toBean(DisFundsSourceDetail.class);
				disFundsSourceDetail.setAllocationDetailId(IdHelp.getUUID32());
				disFundsSourceDetail.setSourceId(sourceId);
				disFundsSourceDetail.setAllocationType(sourceType);
				disFundsSourceDetail.setMeterialNumBalance(disFundsSourceDetail.getMeterialNum());
				disFundsSourceDetail.setMeterialAccountBalance(disFundsSourceDetail.getMeterialAccount());
				disFundsSourceDetail.setFundsType(disFundsSource.getFundsType());
				disFundsSourceDetail.setState(Record.STATE_NEW);
				disFundsSourceDetailsList.add(disFundsSourceDetail);
			}
		}
		disFundsSource.setDisFundsSourceDetailList(disFundsSourceDetailsList);
		
		disFundsSourceDomain.insert(disFundsSource);
	}

	// 修改
	public void update() {
		String isUp = (String) getParameter("isUp");
		String sourceType = (String) getParameter("sourceType");
		Record source = (Record) getParameter("source");
		Record[] sourceDetails = (Record[]) getParameter("sourceDetails");
		
		DisFundsSource disFundsSource = (DisFundsSource) source.toBean(DisFundsSource.class);
		disFundsSource.setSourceType(sourceType);
		disFundsSource.setReceiveOrganCode(BspUtil.getOrganCode());
		disFundsSource.setReceiveOrganName(BspUtil.getOrganName());
		disFundsSource.setUpdatePeopleName(GetBspInfo.getBspInfo().getUserName());
		disFundsSource.setUpdateTime(DateUtil.getTime());
		disFundsSource.setAmountBalance(disFundsSource.getAmount());
		disFundsSource.setMeterialBalance(disFundsSource.getMeterial());
		disFundsSource.setInUse("0");
		
		if("T".equals(isUp)) {
			//部级发放
			disFundsSource.setFillOrganCode("000000000000");
			disFundsSource.setFillOrganName("民政部");
		}else {
			disFundsSource.setFillOrganCode(BspUtil.getOrganCode());
			disFundsSource.setFillOrganName(BspUtil.getOrganName());
		}
		
		List<DisFundsSourceDetail> disFundsSourceDetailsList = new ArrayList<DisFundsSourceDetail>();
		if(sourceDetails!=null && sourceDetails.length > 0) {
			for(int i=0;i<sourceDetails.length;i++) {
				DisFundsSourceDetail disFundsSourceDetail = (DisFundsSourceDetail) sourceDetails[i].toBean(DisFundsSourceDetail.class);
				if(disFundsSourceDetail.getState() == Record.STATE_NEW) {
					disFundsSourceDetail.setAllocationDetailId(IdHelp.getUUID32());
				}
				disFundsSourceDetail.setSourceId(disFundsSource.getSourceId());
				disFundsSourceDetail.setAllocationType(sourceType);
				disFundsSourceDetail.setMeterialNumBalance(disFundsSourceDetail.getMeterialNum());
				disFundsSourceDetail.setMeterialAccountBalance(disFundsSourceDetail.getMeterialAccount());
				disFundsSourceDetail.setFundsType(disFundsSource.getFundsType());
				disFundsSourceDetailsList.add(disFundsSourceDetail);
			}
		}
		disFundsSource.setDisFundsSourceDetailList(disFundsSourceDetailsList);
		disFundsSourceDomain.update(disFundsSource);
	}
	
	// 删除
	public void delete() {
		String sourceId = (String) getParameter("sourceId");
		disFundsSourceDomain.delete(sourceId);
	}
	// 获取本地投入总和与预算总和
	public void queryFundsAndBudget() {
		String moneys = disFundsSourceDomain.queryFundsAndBudget(getParameterSet());
		setReturn("money", moneys);
	}
}