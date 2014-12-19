package com.inspur.cams.welfare.welfarecorp.history.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.welfare.base.dao.IWealFitProductivepowerDao;
import com.inspur.cams.welfare.base.dao.IWealWorkerDao;
import com.inspur.cams.welfare.base.data.WealCert;
import com.inspur.cams.welfare.base.data.WealFitProductivepower;
import com.inspur.cams.welfare.base.data.WealUnitApply;
import com.inspur.cams.welfare.base.data.WealUnitInfo;
import com.inspur.cams.welfare.base.data.WealUnitStatus;
import com.inspur.cams.welfare.base.data.WealWorker;
import com.inspur.cams.welfare.base.domain.IWealCertDomain;
import com.inspur.cams.welfare.base.domain.IWealUnitApplyDomain;
import com.inspur.cams.welfare.base.domain.IWealUnitInfoDomain;
import com.inspur.cams.welfare.base.domain.IWealUnitStatusDomain;
import com.inspur.cams.welfare.welfarecorp.history.domain.IUnitHistoryDomain;

/**
 * 社会福利企业历史数据采集
 * 
 * @author liuxin
 * @date 2013-06-19
 */
public class UnitHistoryDomain implements IUnitHistoryDomain {
	@Reference
	private IWealUnitApplyDomain wealUnitApplysDomain;
	@Reference
	private IWealUnitInfoDomain wealUnitInfoDomain;
	@Reference
	private IWealUnitStatusDomain wealUnitStatusDomain;
	@Reference
	private IWealWorkerDao wealWorkerDao;
	@Reference
	private IWealFitProductivepowerDao wealFitProductivepowerDao;
	@Reference
	private IWealCertDomain wealCertDomain;

	/**
	 * 福利企业历史数据采集__保存
	 */
	public void saveHistory(Record infoRecord, Record[] recordWorker,
			Record[] recordProduct) {
		// 维护信息表
		WealUnitInfo infoBean = (WealUnitInfo) infoRecord
				.toBean(WealUnitInfo.class);
		infoBean.setApplyType("1");// 业务类别维护为1：认定
		infoBean.setRegDate(DateUtil.getDay());
		// infoBean.setCognizanceDate((String)infoRecord.get("approveDate"));
		ParameterSet pset = new ParameterSet();
		pset.setParameter("TASK_CODE@=", infoBean.getTaskCode());
		DataSet infoDs = wealUnitInfoDomain.query(pset);
		if (infoDs.getCount() < 1) {
			wealUnitInfoDomain.insert(infoBean);
		} else {
			wealUnitInfoDomain.update(infoBean);
		}
		// 维护员工信息
		if (recordWorker != null) {
			for (int i = 0; i < recordWorker.length; i++) {
				WealWorker workerBean = (WealWorker) recordWorker[i]
						.toBean(WealWorker.class);
				if (recordWorker[i].getState() == Record.STATE_MODIFIED) {
					wealWorkerDao.update(workerBean);
				} else if (recordWorker[i].getState() == Record.STATE_NEW) {
					wealWorkerDao.insert(workerBean);
				} else if (recordWorker[i].getState() == Record.STATE_DELETED) {
					wealWorkerDao.delete(workerBean.getWorkerId());
				}
			}
		}
		// 维护主要产品信息
		if (recordProduct != null) {
			for (int i = 0; i < recordProduct.length; i++) {
				WealFitProductivepower productBean = (WealFitProductivepower) recordProduct[i]
						.toBean(WealFitProductivepower.class);
				if (recordProduct[i].getState() == Record.STATE_MODIFIED) {
					wealFitProductivepowerDao.update(productBean);
				} else if (recordProduct[i].getState() == Record.STATE_NEW) {
					wealFitProductivepowerDao.insert(productBean);
				} else if (recordProduct[i].getState() == Record.STATE_DELETED) {
					wealFitProductivepowerDao.delete(productBean
							.getProduceId());
				}
			}
		}
		// 维护业务表
		WealUnitApply applyBean = new WealUnitApply();
		DataSet applyDs = wealUnitApplysDomain.query(pset);
		if (applyDs.getCount() < 1) {
			applyBean.setTaskCode(infoBean.getTaskCode());
			applyBean.setApplyType(infoBean.getApplyType());
			applyBean.setUnitId(IdHelp.getUUID32());
			applyBean.setDataSource("HISTORY");
			applyBean.setApplyStauts("4");// 采集默认为4：通过
			// applyBean.setApproveDate((String) infoRecord.get("approveDate"));
			applyBean.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
			applyBean.setMorgName(BspUtil.getCorpOrgan().getOrganName());
			applyBean.setRegDate(DateUtil.getDay());
			wealUnitApplysDomain.insert(applyBean);
		} else {
			applyBean = (WealUnitApply) applyDs.getRecord(0).toBean(
					WealUnitApply.class);
			wealUnitApplysDomain.update(applyBean);
		}
		// 维护状态表
		WealUnitStatus statusBean = (WealUnitStatus) infoRecord
				.toBean(WealUnitStatus.class);
		DataSet statusDs = wealUnitStatusDomain.query(pset);
		if (statusDs.getCount() < 1) {
			statusBean.setUnitId(applyBean.getUnitId());
			statusBean.setAddress(infoBean.getAddress());
			statusBean.setCompanyName(infoBean.getCompanyName());
			statusBean.setTaskCode(infoBean.getTaskCode());
			statusBean.setStatus("1");
			statusBean.setSerialNum(infoBean.getSerialNum());
			statusBean.setNextCheck((String) infoRecord.get("nextCheck"));
			statusBean.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
			statusBean.setMorgName(BspUtil.getCorpOrgan().getOrganName());
			wealUnitStatusDomain.insert(statusBean);
		} else {
			statusBean.setUnitId((String) statusDs.getRecord(0).get("unitId"));
			statusBean.setTaskCode((String) statusDs.getRecord(0).get("taskCode"));
			statusBean.setStatus("1");
			statusBean.setNextCheck((String) infoRecord.get("nextCheck"));
			statusBean.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
			statusBean.setMorgName(BspUtil.getCorpOrgan().getOrganName());
			wealUnitStatusDomain.update(statusBean);
		}
		//维护证书信息
		WealCert wealCert = new WealCert();
		DataSet certDs=wealCertDomain.query(pset);
		wealCert.setCompanyType("2");
		wealCert.setCertType("1");
		wealCert.setSerialNum(infoBean.getSerialNum());
		wealCert.setCompanyName(infoBean.getCompanyName());
		wealCert.setCompanyAddress(infoBean.getAddress());
		wealCert.setLegalPeople(infoBean.getLegalPeople());
		wealCert.setOrganType(infoBean.getEconomicNatureCode());
		//wealCert.setSiteArea(infoBean.getOperateArea());
		wealCert.setCertStatus("1");
		wealCert.setBusinessScope(infoBean.getFirstScope());
		wealCert.setApproveDate(statusBean.getApproveDate());
		if(certDs.getCount()<1){
			wealCert.setTaskCode(infoBean.getTaskCode());
			wealCert.setFitId(statusBean.getUnitId());
			wealCertDomain.insert(wealCert);
		}else{
			wealCert.setTaskCode((String)certDs.getRecord(0).get("taskCode"));
			wealCert.setFitId((String)certDs.getRecord(0).get("fitId"));
			wealCertDomain.update(wealCert);
		}
	}

	/**
	 * 福利企业历史数据采集__删除
	 */
	public void deleteUnitHistory(String taskCode, String unitId) {
		// 删除员工表
		ParameterSet pset = new ParameterSet();
		pset.setParameter("TASK_CODE@=", taskCode);
		DataSet workerDs = wealWorkerDao.query(pset);
		for (int i = 0; i < workerDs.getCount(); i++) {
			WealWorker workerBean = (WealWorker) workerDs.getRecord(i).toBean(
					WealWorker.class);
			wealWorkerDao.delete(workerBean.getWorkerId());
		}
		// 删除业务表
		wealUnitApplysDomain.delete(taskCode);
		// 删除信息表
		wealUnitInfoDomain.delete(taskCode);
		// 删除状态表
		wealUnitStatusDomain.delete(unitId);
		//删除产品
		wealFitProductivepowerDao.deleteByTaskCode(taskCode);
	}

}
