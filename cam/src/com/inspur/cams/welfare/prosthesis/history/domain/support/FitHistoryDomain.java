package com.inspur.cams.welfare.prosthesis.history.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.welfare.base.dao.IWealFitDeviceDao;
import com.inspur.cams.welfare.base.dao.IWealFitProductivepowerDao;
import com.inspur.cams.welfare.base.dao.IWealWorkerDao;
import com.inspur.cams.welfare.base.data.WealCert;
import com.inspur.cams.welfare.base.data.WealFitApply;
import com.inspur.cams.welfare.base.data.WealFitDevice;
import com.inspur.cams.welfare.base.data.WealFitInfo;
import com.inspur.cams.welfare.base.data.WealFitProductivepower;
import com.inspur.cams.welfare.base.data.WealFitStatus;
import com.inspur.cams.welfare.base.data.WealWorker;
import com.inspur.cams.welfare.base.domain.IWealCertDomain;
import com.inspur.cams.welfare.base.domain.IWealFitApplyDomain;
import com.inspur.cams.welfare.base.domain.IWealFitInfoDomain;
import com.inspur.cams.welfare.base.domain.IWealFitStatusDomain;
import com.inspur.cams.welfare.prosthesis.history.domain.IFitHistoryDomain;

public class FitHistoryDomain implements IFitHistoryDomain {
	@Reference
	private IWealFitApplyDomain wealFitApplysDomain;
	@Reference
	private IWealFitInfoDomain wealFitInfoDomain;
	@Reference
	private IWealFitStatusDomain wealFitStatusDomain;
	@Reference
	private IWealWorkerDao wealWorkerDao;
	@Reference
	private IWealFitDeviceDao wealFitDeviceDao;
	@Reference
	private IWealFitProductivepowerDao wealFitProductivepowerDao;
	@Reference
	private IWealCertDomain wealCertDomain;
	/**
	 * 假矫历史数据采集__保存
	 */
	public void saveHistory(Record infoRecord,Record[] recordWorker,Record[] recordDevice,Record[] recordProduct){
		//维护信息表
		WealFitInfo infoBean=(WealFitInfo)infoRecord.toBean(WealFitInfo.class);
		infoBean.setApplyType("1");//业务类别维护为1：认定
		infoBean.setRegDate(DateUtil.getDay());
		infoBean.setCognizanceDate((String)infoRecord.get("approveDate"));
		ParameterSet pset=new ParameterSet();
		pset.setParameter("TASK_CODE@=", infoBean.getTaskCode());
		DataSet infoDs=wealFitInfoDomain.query(pset);
		if(infoDs.getCount()<1){
			wealFitInfoDomain.insert(infoBean);
		}else{
			wealFitInfoDomain.update(infoBean);
		}
		//维护员工信息
		if (recordWorker != null) {
			for (int i = 0; i < recordWorker.length; i++) {
				WealWorker workerBean=(WealWorker) recordWorker[i].toBean(WealWorker.class);
				if(recordWorker[i].getState() == Record.STATE_MODIFIED){
					wealWorkerDao.update(workerBean);
				}else if(recordWorker[i].getState() == Record.STATE_NEW){
					wealWorkerDao.insert(workerBean);
				}else if(recordWorker[i].getState() == Record.STATE_DELETED){
					wealWorkerDao.delete(workerBean.getWorkerId());
				}
			}
		}
		//维护设施信息
		if (recordDevice != null) {
			for (int i = 0; i < recordDevice.length; i++) {
				WealFitDevice deviceBean=(WealFitDevice) recordDevice[i].toBean(WealFitDevice.class);
				if(recordDevice[i].getState() == Record.STATE_MODIFIED){
					wealFitDeviceDao.update(deviceBean);
				}else if(recordDevice[i].getState() == Record.STATE_NEW){
					wealFitDeviceDao.insert(deviceBean);
				}else if(recordDevice[i].getState() == Record.STATE_DELETED){
					wealFitDeviceDao.delete(deviceBean.getDeviceId());
				}
			}
		}
		//维护生产能力信息
		if (recordProduct != null) {
			for (int i = 0; i < recordProduct.length; i++) {
				WealFitProductivepower productBean=(WealFitProductivepower) recordProduct[i].toBean(WealFitProductivepower.class);
				if(recordProduct[i].getState() == Record.STATE_MODIFIED){
					wealFitProductivepowerDao.update(productBean);
				}else if(recordProduct[i].getState() == Record.STATE_NEW){
					wealFitProductivepowerDao.insert(productBean);
				}else if(recordProduct[i].getState() == Record.STATE_DELETED){
					wealFitProductivepowerDao.delete(productBean.getProduceId());
				}
			}
		}
		//维护业务表
		WealFitApply applyBean=new WealFitApply();
		DataSet applyDs=wealFitApplysDomain.query(pset);
		if(applyDs.getCount()<1){
			applyBean.setTaskCode(infoBean.getTaskCode());
			applyBean.setApplyType(infoBean.getApplyType());
			applyBean.setFitId(IdHelp.getUUID32());
			applyBean.setDataSource("HISTORY");
			applyBean.setApplyStauts("4");//采集默认为4：通过
			applyBean.setApproveDate((String)infoRecord.get("approveDate"));
			applyBean.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
			applyBean.setMorgName(BspUtil.getCorpOrgan().getOrganName());
			applyBean.setRegDate(DateUtil.getDay());
			wealFitApplysDomain.insert(applyBean);
		}else{
			applyBean=(WealFitApply)applyDs.getRecord(0).toBean(WealFitApply.class);
			applyBean.setApproveDate((String)infoRecord.get("approveDate"));
			wealFitApplysDomain.update(applyBean);
		}
		//维护状态表
		WealFitStatus statusBean=(WealFitStatus)infoRecord.toBean(WealFitStatus.class);
		DataSet statusDs=wealFitStatusDomain.query(pset);
		if(statusDs.getCount()<1){
			statusBean.setFitId(applyBean.getFitId());
			statusBean.setTaskCode(infoBean.getTaskCode());
			statusBean.setStatus("1");
			statusBean.setSerialNum(infoBean.getSerialNum());
			statusBean.setNextChagneCert((String)infoRecord.get("nextChagneCert"));
			statusBean.setNextCheck((String)infoRecord.get("nextCheck"));
			statusBean.setCognizanceDate((String)infoRecord.get("approveDate"));
			statusBean.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
			statusBean.setMorgName(BspUtil.getCorpOrgan().getOrganName());
			wealFitStatusDomain.insert(statusBean);
		}else{
			statusBean.setFitId((String)statusDs.getRecord(0).get("fitId"));
			statusBean.setTaskCode((String)statusDs.getRecord(0).get("taskCode"));
			statusBean.setStatus("1");
			statusBean.setNextChagneCert((String)infoRecord.get("nextChagneCert"));
			statusBean.setNextCheck((String)infoRecord.get("nextCheck"));
			statusBean.setCognizanceDate((String)infoRecord.get("approveDate"));
			statusBean.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
			statusBean.setMorgName(BspUtil.getCorpOrgan().getOrganName());
			wealFitStatusDomain.update(statusBean);
		}
		//维护证书信息
		WealCert wealCert = new WealCert();
		DataSet certDs=wealCertDomain.query(pset);
		wealCert.setCompanyType("1");
		wealCert.setCertType("1");
		wealCert.setSerialNum(infoBean.getSerialNum());
		wealCert.setCompanyName(infoBean.getCompanyName());
		wealCert.setCompanyAddress(infoBean.getAddress());
		wealCert.setLegalPeople(infoBean.getLegalPeople());
		wealCert.setOrganType(infoBean.getEconomicNatureCode());
		wealCert.setSiteArea(infoBean.getOperateArea());
		wealCert.setCertStatus("1");
		wealCert.setBusinessScope(infoBean.getBusinessScope());
		wealCert.setApproveDate((String)infoRecord.get("approveDate"));
		if(certDs.getCount()<1){
			wealCert.setTaskCode(infoBean.getTaskCode());
			wealCert.setFitId(statusBean.getFitId());
			wealCertDomain.insert(wealCert);
		}else{
			wealCert.setTaskCode((String)certDs.getRecord(0).get("taskCode"));
			wealCert.setFitId((String)certDs.getRecord(0).get("fitId"));
			wealCertDomain.update(wealCert);
		}
	}
	/**
	 * 假矫历史数据采集__删除
	 */
	public void deleteFitHistory(String taskCode,String fitId){
		//删除员工表
		ParameterSet pset=new ParameterSet();
		pset.setParameter("TASK_CODE@=", taskCode);
		DataSet workerDs= wealWorkerDao.query(pset);
		for (int i = 0; i < workerDs.getCount(); i++) {
			WealWorker workerBean=(WealWorker) workerDs.getRecord(i).toBean(WealWorker.class);
			wealWorkerDao.delete(workerBean.getWorkerId());
		}
		//删除设施表
		DataSet deviceDs= wealFitDeviceDao.query(pset);
		for (int i = 0; i < deviceDs.getCount(); i++) {
			WealFitDevice workerBean=(WealFitDevice) deviceDs.getRecord(i).toBean(WealFitDevice.class);
			wealFitDeviceDao.delete(workerBean.getDeviceId());
		}
		//删除生产能力表
		DataSet productDs= wealFitProductivepowerDao.query(pset);
		for (int i = 0; i < productDs.getCount(); i++) {
			WealFitProductivepower workerBean=(WealFitProductivepower) productDs.getRecord(i).toBean(WealFitProductivepower.class);
			wealFitProductivepowerDao.delete(workerBean.getProduceId());
		}
		//删除业务表
		wealFitApplysDomain.delete(taskCode);
		//删除信息表
		wealFitInfoDomain.delete(taskCode);
		//删除证书表
		wealCertDomain.delete(taskCode);
		//删除状态表
		wealFitStatusDomain.delete(fitId);
	}
}
