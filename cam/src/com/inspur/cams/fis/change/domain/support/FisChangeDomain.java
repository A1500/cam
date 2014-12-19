package com.inspur.cams.fis.change.domain.support;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.CommandContext;
import org.loushang.workflow.api.WfQuery;
import org.loushang.workflow.api.WfTaskRequestWrapper;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.fis.base.data.FisCemeApplyInfo;
import com.inspur.cams.fis.base.data.FisCemeChange;
import com.inspur.cams.fis.base.data.FisCemeChangeDetail;
import com.inspur.cams.fis.base.data.FisCemeInfo;
import com.inspur.cams.fis.base.domain.IFisCemeApplyInfoDomain;
import com.inspur.cams.fis.base.domain.IFisCemeChangeDetailDomain;
import com.inspur.cams.fis.base.domain.IFisCemeChangeDomain;
import com.inspur.cams.fis.base.domain.IFisCemeInfoDomain;
import com.inspur.cams.fis.change.domain.IFisChangeDomain;
import com.inspur.cams.welfare.base.data.WealUnitStatus;

/**
 * 经营性公墓变更
 * 
 * @author liuxin
 * @date 2013-08-13
 */
public class FisChangeDomain implements IFisChangeDomain {
	@Reference
	private IFisCemeApplyInfoDomain fisCemeApplyInfoDomain;
	@Reference
	private IFisCemeChangeDomain fisCemeChangeDomain;
	@Reference
	private IFisCemeChangeDetailDomain fisCemeChangeDetailDomain;
	@Reference
	private IFisCemeInfoDomain fisCemeInfoDomain;

	/**
	 * 经营性公墓变更数据保存
	 */
	public void saveChange(Record changeRecord, Record[] changeRecordDetail) {
		// 维护企业变更备案表
		FisCemeChange changeBean = (FisCemeChange) changeRecord
				.toBean(FisCemeChange.class);
		ParameterSet pset = new ParameterSet();
		pset.setParameter("CHANGE_ID@=", changeBean.getChangeId());
		DataSet changeRecordDs = fisCemeChangeDomain.query(pset);
		changeBean.setIfConfirm("0");
		if (changeRecordDs.getCount() < 1) {
			fisCemeChangeDomain.insert(changeBean);
		} else {
			fisCemeChangeDomain.update(changeBean);
		}
		// 维护经营性公墓变更明细表
		Map map = new HashMap();
		ParameterSet pset2 = new ParameterSet();
		pset2.setParameter("CHANGE_ID@=", changeBean.getChangeId());
		DataSet changeRecordDetailDs = fisCemeChangeDetailDomain.query(pset2);
		for (int i = 0; i < changeRecordDetailDs.getCount(); i++) {
			Record record = changeRecordDetailDs.getRecord(i);
			fisCemeChangeDetailDomain.delete((String) record.get("detailId"));
		}
		if (changeRecordDetail != null) {
			for (int i = 0; i < changeRecordDetail.length; i++) {
				FisCemeChangeDetail changeRecordDetailBean = (FisCemeChangeDetail) changeRecordDetail[i]
						.toBean(FisCemeChangeDetail.class);
				changeRecordDetailBean.setChangeId(changeBean.getChangeId());
				map.put(changeRecordDetailBean.getItemCode(),
						changeRecordDetailBean.getItemAfter());
				changeRecordDetailBean.setDetailId(IdHelp.getUUID32());
				fisCemeChangeDetailDomain.insert(changeRecordDetailBean);
			}
		}
	}

	// 维护企业业务表
	public void submitChange(Record changeRecord) {
		FisCemeChange changeBean = (FisCemeChange) changeRecord
				.toBean(FisCemeChange.class);
		ParameterSet applyPset = new ParameterSet();
		applyPset.setParameter("CEME_APPLY_ID@=", changeBean.getCemeApplyId());
		DataSet dsApply = fisCemeApplyInfoDomain.query(applyPset);
		FisCemeApplyInfo applyBean = (FisCemeApplyInfo) dsApply.getRecord(0)
				.toBean(FisCemeApplyInfo.class);
		applyBean.setIsReport("0");
		fisCemeApplyInfoDomain.update(applyBean);
		changeBean.setIfConfirm("1");
		fisCemeChangeDomain.update(changeBean);
	}

	public void createAndSendQualification(ParameterSet pset) {
		Record record = (Record) pset.getParameter("record");
		String cemeApplyId = (String) record.get("CEME_APPLY_ID");
		String serviceName="";
		String procDefUniqueId="";
		String actName="";
		
		pset.clear();
		pset.setParameter("CEME_APPLY_ID@=", cemeApplyId);
		DataSet dsApply = fisCemeApplyInfoDomain.query(pset);
		FisCemeApplyInfo applyBean = (FisCemeApplyInfo) dsApply.getRecord(0).toBean(FisCemeApplyInfo.class);
		
		if("14".equals(BspUtil.getOrganType())){
			serviceName = "公益性公墓变更";
			actName="县级审批";
			procDefUniqueId = "8a898ca2410fbb0f01410fde0fb5000a";
			applyBean.setIsReport("6");

		}else{
			serviceName = "经营性公墓变更";
			actName="市级审核";
			procDefUniqueId = "8a898c9a40665123014066bc8ce90004";
			applyBean.setIsReport("0");

			
		}
		
		applyBean.setRecTime(DateUtil.getTime());
		applyBean.setComTime(DateUtil.getTime());
		applyBean.setCurActivity(actName);
		applyBean.setCurOrgan(BspUtil.getParentOrgan().getOrganName());
		applyBean.setCurOrganCode(BspUtil.getParentOrgan().getOrganCode());
		fisCemeApplyInfoDomain.update(applyBean);

		
		// 通过流程唯一ID获得流程第一个环节ID
		String startActDefUniqueId = (String) WfQuery
				.getActDefInfoByProcDefUniqueIdAndActDefId(procDefUniqueId, "act1").get("actDefUniqueId");
		// String startActDefUniqueId ="8a898bd33e4f0ac3013e4fa35dcc03fe";
		// 调用创建并发送流程接口
		CommandContext.setContextParameter("procDefUniqueId", procDefUniqueId);
		CommandContext.setContextParameter("startActDefUniqueId",
				startActDefUniqueId);

		Map<String, String> context = new HashMap<String, String>();
		String organId = BspUtil.getParentStrId();
		String currentOrganName = BspUtil.getCorpOrgan().getOrganName();
		context.put("ORGANID", organId);
		context.put("CONDITION", "PAST");
		Map<String, String> map = WfTaskRequestWrapper.getInstance().createAndSend(cemeApplyId, currentOrganName + serviceName,	context);
	}

	public void saveChangeRecord(Record changeRecord,
			Record[] changeRecordDetail, Record applyInfoRecord) {
		// 维护企业变更备案表
		FisCemeChange changeBean = (FisCemeChange) changeRecord
				.toBean(FisCemeChange.class);
		ParameterSet pset = new ParameterSet();
		pset.setParameter("CHANGE_ID@=", changeBean.getChangeId());
		DataSet changeRecordDs = fisCemeChangeDomain.query(pset);
		changeBean.setIfConfirm("0");
		if (changeRecordDs.getCount() < 1) {
			fisCemeChangeDomain.insert(changeBean);
		} else {
			fisCemeChangeDomain.update(changeBean);
		}
		// 维护经营性公墓变更明细表
		Map map = new HashMap();
		ParameterSet pset2 = new ParameterSet();
		pset2.setParameter("CHANGE_ID@=", changeBean.getChangeId());
		DataSet changeRecordDetailDs = fisCemeChangeDetailDomain.query(pset2);
		for (int i = 0; i < changeRecordDetailDs.getCount(); i++) {
			Record record = changeRecordDetailDs.getRecord(i);
			fisCemeChangeDetailDomain.delete((String) record.get("detailId"));
		}
		if (changeRecordDetail != null) {
			for (int i = 0; i < changeRecordDetail.length; i++) {
				FisCemeChangeDetail changeRecordDetailBean = (FisCemeChangeDetail) changeRecordDetail[i]
						.toBean(FisCemeChangeDetail.class);
				changeRecordDetailBean.setChangeId(changeBean.getChangeId());
				map.put(changeRecordDetailBean.getItemCode(),
						changeRecordDetailBean.getItemAfter());
				changeRecordDetailBean.setDetailId(IdHelp.getUUID32());
				fisCemeChangeDetailDomain.insert(changeRecordDetailBean);
			}
		}
		// 维护公墓审批业务表
		FisCemeApplyInfo applyInfoBean = (FisCemeApplyInfo) applyInfoRecord
				.toBean(FisCemeApplyInfo.class);
		pset.clear();
		pset.setParameter("CEME_APPLY_ID@=", applyInfoBean.getCemeApplyId());
		DataSet applyInfoRecordDs = fisCemeApplyInfoDomain.query(pset);
		applyInfoBean.setRecTime(DateUtil.getTime());
		applyInfoBean.setComTime(DateUtil.getTime());
		if (applyInfoRecordDs.getCount() < 1) {
			fisCemeApplyInfoDomain.insert(applyInfoBean);
		} else {
			fisCemeApplyInfoDomain.update(applyInfoBean);
		}
	}

	public void submitChangeRecord(Record changeRecord) {
		FisCemeChange changeBean = (FisCemeChange) changeRecord
				.toBean(FisCemeChange.class);
		ParameterSet pset = new ParameterSet();
		pset.setParameter("CHANGE_ID@=", changeBean.getChangeId());
		DataSet changeRecordDetailDs = fisCemeChangeDetailDomain.query(pset);
		Map map = new HashMap();
		for (int i = 0; i < changeRecordDetailDs.getCount(); i++) {
			Record record = changeRecordDetailDs.getRecord(i);
			map.put(record.get("itemCode"), record.get("itemAfter"));
		}
		pset.clear();
		pset.setParameter("RECORD_ID@=", changeBean.getRecordId());
		DataSet dsStatus = fisCemeInfoDomain.query(pset);
		FisCemeInfo infoBean = (FisCemeInfo) dsStatus.getRecord(0).toBean(FisCemeInfo.class);
		
		Iterator it = map.entrySet().iterator();
		while (it.hasNext()) {
			Entry obj = (Entry) it.next();
			if (((String) obj.getKey()).equals("0")) {
				infoBean.setName((String) obj.getValue());
			} else if (((String) obj.getKey()).equals("1")) {
				infoBean.setLegalPeople((String) obj.getValue());
			} else if (((String) obj.getKey()).equals("2")) {
				infoBean.setDirector((String) obj.getValue());
			} else if (((String) obj.getKey()).equals("3")) {
				infoBean.setCoOrganizer((String) obj.getValue());
			}
		}
		fisCemeChangeDomain.update(changeBean);
		fisCemeInfoDomain.update(infoBean);
		pset.clear();
		pset.setParameter("CEME_APPLY_ID@=", changeBean.getCemeApplyId());
		DataSet fisCemeApplyInfoDs = fisCemeApplyInfoDomain.query(pset);
		FisCemeApplyInfo fisCemeApplyInfo = (FisCemeApplyInfo) fisCemeApplyInfoDs.getRecord(0).toBean(FisCemeApplyInfo.class);
		fisCemeApplyInfo.setApplyState("3");
		fisCemeApplyInfoDomain.update(fisCemeApplyInfo);
	}
}
