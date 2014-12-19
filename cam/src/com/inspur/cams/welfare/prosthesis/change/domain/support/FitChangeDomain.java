package com.inspur.cams.welfare.prosthesis.change.domain.support;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.welfare.base.data.WealCert;
import com.inspur.cams.welfare.base.data.WealFitApply;
import com.inspur.cams.welfare.base.data.WealFitChangerecord;
import com.inspur.cams.welfare.base.data.WealFitChangerecordDetail;
import com.inspur.cams.welfare.base.data.WealFitStatus;
import com.inspur.cams.welfare.base.data.WealUnitApply;
import com.inspur.cams.welfare.base.data.WealUnitStatus;
import com.inspur.cams.welfare.base.domain.IWealCertDomain;
import com.inspur.cams.welfare.base.domain.IWealFitApplyDomain;
import com.inspur.cams.welfare.base.domain.IWealFitChangerecordDetailDomain;
import com.inspur.cams.welfare.base.domain.IWealFitChangerecordDomain;
import com.inspur.cams.welfare.base.domain.IWealFitStatusDomain;
import com.inspur.cams.welfare.prosthesis.change.domain.IFitChangeDomain;

/**
 * 假矫企业变更
 * 
 * @author liuxin
 * @date 2013-07-04
 */
public class FitChangeDomain implements IFitChangeDomain {
	@Reference
	private IWealFitStatusDomain wealFitStatusDomain;
	@Reference
	private IWealFitApplyDomain wealFitApplysDomain;
	@Reference
	private IWealFitChangerecordDomain wealFitChangerecordDomain;
	@Reference
	private IWealFitChangerecordDetailDomain wealFitChangerecordDetailDomain;
	@Reference
	private IWealCertDomain wealCertDomain;
	/**
	 * 假矫企业变更数据保存
	 */
	public void saveChange(Record changeRecord, Record[] changeRecordDetail,
			Record statusRecord) {
		// 维护企业变更备案表
		WealFitChangerecord changeRecordBean = (WealFitChangerecord) changeRecord
				.toBean(WealFitChangerecord.class);
		ParameterSet pset = new ParameterSet();
		pset.setParameter("TASK_CODE@=", changeRecordBean.getTaskCode());
		DataSet changeRecordDs = wealFitChangerecordDomain.query(pset);
		changeRecordBean.setIfConfirm("0");
		if (changeRecordDs.getCount() < 1) {
			wealFitChangerecordDomain.insert(changeRecordBean);
		} else {
			wealFitChangerecordDomain.update(changeRecordBean);
		}
		// 维护企业变更备案明细表
		Map map = new HashMap();
		ParameterSet pset2 = new ParameterSet();
		pset2.setParameter("CHANG_ID@=", changeRecordBean.getChangId());
		DataSet changeRecordDetailDs = wealFitChangerecordDetailDomain
				.query(pset2);
		for (int i = 0; i < changeRecordDetailDs.getCount(); i++) {
			Record record = changeRecordDetailDs.getRecord(i);
			wealFitChangerecordDetailDomain.delete((String) record
					.get("detailId"));
		}
		if (changeRecordDetail != null) {
			for (int i = 0; i < changeRecordDetail.length; i++) {
				WealFitChangerecordDetail changeRecordDetailBean = (WealFitChangerecordDetail) changeRecordDetail[i]
						.toBean(WealFitChangerecordDetail.class);
				changeRecordDetailBean
						.setChangId(changeRecordBean.getChangId());
				map.put(changeRecordDetailBean.getItemCode(),
						changeRecordDetailBean.getItemAfter());
				wealFitChangerecordDetailDomain.insert(changeRecordDetailBean);
			}
		}
		// 维护福利企业业务表
		ParameterSet psStatus = new ParameterSet();
		psStatus.setParameter("SERIAL_NUM@=", changeRecordBean.getSerialNum());
		DataSet dsStatus = wealFitStatusDomain.query(psStatus);
		WealFitStatus statusBean = (WealFitStatus) dsStatus.getRecord(0)
				.toBean(WealFitStatus.class);
		ParameterSet psApply = new ParameterSet();
		psApply.setParameter("TASK_CODE@=", changeRecordBean.getTaskCode());
		DataSet dsApply = wealFitApplysDomain.query(psApply);
		WealFitApply applyBean = null;
		if (dsApply.getCount() < 1) {
			applyBean = new WealFitApply();
			applyBean.setTaskCode(changeRecordBean.getTaskCode());
			applyBean.setApplyType("4");
			applyBean.setFitId(statusBean.getFitId());
			applyBean.setDataSource("LOCAL");
			applyBean.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
			applyBean.setMorgName(BspUtil.getCorpOrgan().getOrganName());
			applyBean.setRegDate((new SimpleDateFormat("yyyy-MM-dd"))
					.format(new Date()));
			wealFitApplysDomain.insert(applyBean);
		} else {
			applyBean = (WealFitApply) dsApply.getRecord(0).toBean(
					WealFitApply.class);
			wealFitApplysDomain.update(applyBean);
		}
	}

	// 维护企业业务表
	public void submitChange(Record changeRecord) {
		WealFitChangerecord changeRecordBean = (WealFitChangerecord) changeRecord
				.toBean(WealFitChangerecord.class);
		ParameterSet pset1 = new ParameterSet();
		pset1.setParameter("CHANG_ID@=", changeRecordBean.getChangId());
		DataSet changeRecordDetailDs = wealFitChangerecordDetailDomain
				.query(pset1);
		Map map = new HashMap();
		for (int i = 0; i < changeRecordDetailDs.getCount(); i++) {
			Record record = changeRecordDetailDs.getRecord(i);
			map.put(record.get("itemCode"), record.get("itemAfter"));
		}
		ParameterSet psStatus = new ParameterSet();
		psStatus.setParameter("SERIAL_NUM@=", changeRecordBean.getSerialNum());
		DataSet dsStatus = wealFitStatusDomain.query(psStatus);
		WealFitStatus statusBean = (WealFitStatus) dsStatus.getRecord(0)
				.toBean(WealFitStatus.class);
		Iterator it = map.entrySet().iterator();
		while (it.hasNext()) {
			Entry obj = (Entry) it.next();
			if (((String) obj.getKey()).equals("0")) {
				statusBean.setCompanyName((String) obj.getValue());
			} else if (((String) obj.getKey()).equals("1")) {
				statusBean.setLegalPeople((String) obj.getValue());
			} else if (((String) obj.getKey()).equals("2")) {
				statusBean.setAddress((String) obj.getValue());
			} 
			/*else if (((String) obj.getKey()).equals("3")) {
				statusBean.setRegFund(new BigDecimal((String) obj.getValue()));
			}*/
		}
		statusBean.setStatus("1");
		wealFitStatusDomain.update(statusBean);
		changeRecordBean.setIfConfirm("1");
		wealFitChangerecordDomain.update(changeRecordBean);
		//插入证书信息
		WealCert wealCert = new WealCert();
		wealCert.setTaskCode((String)changeRecordBean.getTaskCode());
		wealCert.setCompanyType("1");
		wealCert.setCertType("5");
		wealCert.setSerialNum(statusBean.getSerialNum());
		wealCert.setCompanyName(statusBean.getCompanyName());
		wealCert.setCompanyAddress(statusBean.getAddress());
		wealCert.setLegalPeople(statusBean.getLegalPeople());
		wealCert.setOrganType(statusBean.getEconomicNatureCode());
		wealCert.setCertStatus("1");
		wealCert.setBusinessScope(statusBean.getBusinessScope());
		wealCert.setApproveDate(statusBean.getCognizanceDate());
		wealCertDomain.insert(wealCert);
	}
}
