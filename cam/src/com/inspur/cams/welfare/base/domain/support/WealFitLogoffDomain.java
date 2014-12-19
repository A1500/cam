package com.inspur.cams.welfare.base.domain.support;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.welfare.base.dao.support.WealFitLogoffDao;
import com.inspur.cams.welfare.base.data.WealFitApply;
import com.inspur.cams.welfare.base.data.WealFitLogoff;
import com.inspur.cams.welfare.base.data.WealFitStatus;
import com.inspur.cams.welfare.base.data.WealUnitApply;
import com.inspur.cams.welfare.base.data.WealUnitStatus;
import com.inspur.cams.welfare.base.domain.IWealFitApplyDomain;
import com.inspur.cams.welfare.base.domain.IWealFitLogoffDomain;
import com.inspur.cams.welfare.base.domain.IWealFitStatusDomain;
import com.inspur.cams.welfare.base.domain.IWealUnitApplyDomain;
import com.inspur.cams.welfare.base.domain.IWealUnitStatusDomain;

/**
 * 假矫装配企业注销备案信息domain
 * @author 
 * @date 2013-04-19
 */
public class WealFitLogoffDomain implements IWealFitLogoffDomain {

	private WealFitLogoffDao wealFitLogoffDao = (WealFitLogoffDao) DaoFactory
	.getDao("com.inspur.cams.welfare.base.dao.support.WealFitLogoffDao");
	
	private IWealFitApplyDomain wealFitApplyDomain = ScaComponentFactory
	.getService(IWealFitApplyDomain.class, "wealFitApplysDomain/wealFitApplysDomain");
	
	private IWealFitStatusDomain wealFitStatusDomain = ScaComponentFactory
			.getService(IWealFitStatusDomain.class, "wealFitStatusDomain/wealFitStatusDomain");
	
	private IWealUnitApplyDomain wealUnitApplyDomain = ScaComponentFactory
	.getService(IWealUnitApplyDomain.class, "wealUnitApplysDomain/wealUnitApplysDomain");
	
	private IWealUnitStatusDomain wealUnitStatusDomain = ScaComponentFactory
			.getService(IWealUnitStatusDomain.class, "wealUnitStatusDomain/wealUnitStatusDomain");
	
	/**
	 * 查询 假矫装配企业注销备案信息信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return wealFitLogoffDao.query(pset);
	}


	/**
	 * 增加 假矫装配企业注销备案信息信息
	 * @param wealFitLogoff
	 */
	public void insert(WealFitLogoff wealFitLogoff) {
		//wealFitApply.setTaskCode(IdHelp.getUUID32());
		wealFitLogoffDao.insert(wealFitLogoff);
	}
	
	/**
	 * 修改 假矫装配企业注销备案信息信息
	 * @param wealFitLogoff
	 */
	public void update(WealFitLogoff wealFitLogoff) {
		wealFitLogoffDao.update(wealFitLogoff);
	}
	
	/**
	 * 删除 假矫装配企业注销备案信息信息
	 * @param peopleId
	 */
	public void delete(String taskCode) {
		wealFitLogoffDao.delete(taskCode);
	}
	
	/*
	 * 注销备案信息表保存同时更新业务表.
	 * */
	public void saveCancel(Record record){
		//注销备案表信息保存
		WealFitLogoff wealFitLogoff =(WealFitLogoff) record.toBean(WealFitLogoff.class);
		ParameterSet pset=new ParameterSet();
		pset.setParameter("TASK_CODE@=", wealFitLogoff.getTaskCode());
		DataSet ds=this.query(pset);
		if(ds.getCount()<1){
			wealFitLogoffDao.insert(wealFitLogoff);
		}else{
			wealFitLogoffDao.update(wealFitLogoff);
		}
		//更新业务表信息
		WealFitApply wealFitApply = new WealFitApply();
		
		wealFitApply.setTaskCode(wealFitLogoff.getTaskCode());
		wealFitApply.setApplyType("5");
		wealFitApply.setApplyStauts("0");
		ParameterSet pset1=new ParameterSet();
		pset1.setParameter("SERIAL_NUM@=", wealFitLogoff.getSerialNum());
		DataSet statusDs=wealFitStatusDomain.query(pset1);
		if(statusDs.getCount()>0){
			//wealFitApply.setFitId(IdHelp.getUUID32());
			wealFitApply.setFitId((String)statusDs.getRecord(0).get("fitId"));
		}
		wealFitApply.setDataSource("LOCAL");
		wealFitApply.setRegDate(wealFitLogoff.getRegDate().substring(0, 10));
		wealFitApply.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
		wealFitApply.setMorgName(BspUtil.getCorpOrgan().getOrganName());
		
		DataSet applyDs=wealFitApplyDomain.query(pset);
		if(applyDs.getCount()<1){
			wealFitApplyDomain.insert(wealFitApply);
		}else{
			wealFitApplyDomain.update(wealFitApply);
		}
		
	}
	//假肢企业注销
	public void prosthesisCancel(Record record){
		WealFitLogoff wealFitLogoff =(WealFitLogoff) record.toBean(WealFitLogoff.class);
		//更新注销备案表注销状态
		wealFitLogoff.setIfConfirm("1");
		wealFitLogoffDao.update(wealFitLogoff);
		//更新状态表信息
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SERIAL_NUM@=",wealFitLogoff.getSerialNum());
		DataSet statusDs=wealFitStatusDomain.query(pset);
		WealFitStatus wealFitStatus=(WealFitStatus)statusDs.getRecord(0).toBean(WealFitStatus.class);
		wealFitStatus.setStatus("0");//注销
		wealFitStatusDomain.update(wealFitStatus);
	}
	
	
	/*
	 * 福利企业注销备案信息表保存同时更新业务表.
	 * */
	public void welfarecorpSaveCancel(Record record){
		//注销备案表信息保存
		WealFitLogoff wealFitLogoff =(WealFitLogoff) record.toBean(WealFitLogoff.class);
		ParameterSet pset=new ParameterSet();
		pset.setParameter("TASK_CODE@=", wealFitLogoff.getTaskCode());
		DataSet ds=this.query(pset);
		if(ds.getCount()<1){
			wealFitLogoffDao.insert(wealFitLogoff);
		}else{
			wealFitLogoffDao.update(wealFitLogoff);
		}
		//更新业务表信息
		WealUnitApply wealUnitApply = new WealUnitApply();
		wealUnitApply.setTaskCode(wealFitLogoff.getTaskCode());
		wealUnitApply.setApplyType("5");
		wealUnitApply.setApplyStauts("0");
		ParameterSet pset1=new ParameterSet();
		pset1.setParameter("SERIAL_NUM@=", wealFitLogoff.getSerialNum());
		DataSet statusDs=wealUnitStatusDomain.query(pset1);
		if(statusDs.getCount()>0){
			//wealUnitApply.setFitId(IdHelp.getUUID32());
			wealUnitApply.setUnitId((String)statusDs.getRecord(0).get("unitId"));
		}
		wealUnitApply.setDataSource("LOCAL");
		wealUnitApply.setRegDate(wealFitLogoff.getRegDate().substring(0, 10));
		wealUnitApply.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
		wealUnitApply.setMorgName(BspUtil.getCorpOrgan().getOrganName());
		DataSet applyDs=wealUnitApplyDomain.query(pset);
		if(applyDs.getCount()<1){
			wealUnitApplyDomain.insert(wealUnitApply);
		}else{
			wealUnitApplyDomain.update(wealUnitApply);
		}
		
	}
	
	//福利企业注销
	public void wealfarecorpCancel(Record record){
		WealFitLogoff wealFitLogoff =(WealFitLogoff) record.toBean(WealFitLogoff.class);
		//更新注销备案表注销状态
		wealFitLogoff.setIfConfirm("1");
		wealFitLogoffDao.update(wealFitLogoff);
		//更新状态表信息
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SERIAL_NUM@=",wealFitLogoff.getSerialNum());
		DataSet statusDs=wealUnitStatusDomain.query(pset);
		WealUnitStatus wealUnitStatus=(WealUnitStatus)statusDs.getRecord(0).toBean(WealUnitStatus.class);
		wealUnitStatus.setStatus("0");//注销
		wealUnitStatusDomain.update(wealUnitStatus);
	}


}