package com.inspur.cams.welfare.welfarecorp.change.domain.support;

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
import com.inspur.cams.welfare.base.data.WealFitChangerecord;
import com.inspur.cams.welfare.base.data.WealFitChangerecordDetail;
import com.inspur.cams.welfare.base.data.WealUnitApply;
import com.inspur.cams.welfare.base.data.WealUnitStatus;
import com.inspur.cams.welfare.base.domain.IWealCertDomain;
import com.inspur.cams.welfare.base.domain.IWealFitChangerecordDetailDomain;
import com.inspur.cams.welfare.base.domain.IWealFitChangerecordDomain;
import com.inspur.cams.welfare.base.domain.IWealUnitApplyDomain;
import com.inspur.cams.welfare.base.domain.IWealUnitStatusDomain;
import com.inspur.cams.welfare.welfarecorp.change.domain.IUnitChangeDomain;

/**
 * 社会福利企业变更
 * 
 * @author liuxin
 * @date 2013-06-26
 */
public class UnitChangeDomain implements IUnitChangeDomain {
	@Reference
	private IWealUnitStatusDomain wealUnitStatusDomain;
	@Reference
	private IWealUnitApplyDomain wealUnitApplysDomain;
	@Reference
	private IWealFitChangerecordDomain wealFitChangerecordDomain;
	@Reference
	private IWealFitChangerecordDetailDomain wealFitChangerecordDetailDomain;
	@Reference
	private IWealCertDomain wealCertDomain;
	/**
	 * 福利企业变更数据保存
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
		DataSet dsStatus = wealUnitStatusDomain.query(psStatus);
		WealUnitStatus statusBean = (WealUnitStatus) dsStatus.getRecord(0)
				.toBean(WealUnitStatus.class);
		ParameterSet psApply = new ParameterSet();
		psApply.setParameter("TASK_CODE@=", changeRecordBean.getTaskCode());
		DataSet dsApply = wealUnitApplysDomain.query(psApply);
		WealUnitApply applyBean = null;
		if (dsApply.getCount() < 1) {
			applyBean = new WealUnitApply();
			applyBean.setTaskCode(changeRecordBean.getTaskCode());
			applyBean.setApplyType("4");
			applyBean.setUnitId(statusBean.getUnitId());
			applyBean.setDataSource("LOCAL");
			applyBean.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
			applyBean.setMorgName(BspUtil.getCorpOrgan().getOrganName());
			applyBean.setRegDate((new SimpleDateFormat("yyyy-MM-dd"))
					.format(new Date()));
			wealUnitApplysDomain.insert(applyBean);
		} else {
			applyBean = (WealUnitApply) dsApply.getRecord(0).toBean(
					WealUnitApply.class);
			wealUnitApplysDomain.update(applyBean);
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
		DataSet dsStatus = wealUnitStatusDomain.query(psStatus);
		WealUnitStatus statusBean = (WealUnitStatus) dsStatus.getRecord(0)
				.toBean(WealUnitStatus.class);
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
		wealUnitStatusDomain.update(statusBean);
		changeRecordBean.setIfConfirm("1");
		wealFitChangerecordDomain.update(changeRecordBean);
		//插入证书信息
		WealCert wealCert = new WealCert();
		wealCert.setTaskCode((String)changeRecordBean.getTaskCode());
		wealCert.setCompanyType("2");
		wealCert.setCertType("5");
		wealCert.setSerialNum(statusBean.getSerialNum());
		wealCert.setCompanyName(statusBean.getCompanyName());
		wealCert.setCompanyAddress(statusBean.getAddress());
		wealCert.setLegalPeople(statusBean.getLegalPeople());
		wealCert.setOrganType(statusBean.getEconomicNatureCode());
		wealCert.setCertStatus("1");
		wealCert.setBusinessScope(statusBean.getFirstScope());
		wealCert.setApproveDate(statusBean.getApproveDate());
		wealCertDomain.insert(wealCert);
	}
}
