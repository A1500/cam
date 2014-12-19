package com.inspur.cams.cdc.base.domain.support;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcFinanceInfoDao;
import com.inspur.cams.cdc.base.data.CdcFinanceInfo;
import com.inspur.cams.cdc.base.domain.ICdcFinanceInfoDomain;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

public class CdcFinanceInfoDomain implements ICdcFinanceInfoDomain {
	
	@Reference
	private ICdcFinanceInfoDao cdcFinanceInfoDao;

	public void setCdcFinanceInfoDao(ICdcFinanceInfoDao cdcFinanceInfoDao) {
		this.cdcFinanceInfoDao = cdcFinanceInfoDao;
	}

	public DataSet query(ParameterSet pset) {
		return cdcFinanceInfoDao.query(pset);
	}

	public void insert(CdcFinanceInfo info) {
		info.setFinanceid(info.getOrganCode()+IdHelp.getUUID32());
		info.setStatus("0");
		info.setCreateTime(DateUtil.getTime());
		cdcFinanceInfoDao.insert(info);
	}

	public void update(CdcFinanceInfo info) {
		cdcFinanceInfoDao.update(info);
	}

	public DataSet queryList(ParameterSet pset) {
		return cdcFinanceInfoDao.queryList(pset);
	}

	public void report(String id) {
		CdcFinanceInfo info = cdcFinanceInfoDao.get(id);
		if(info!=null){
			info.setStatus("1");
			DateFormat f = new SimpleDateFormat("yyyy-MM-dd");
			info.setSubmitDate(f.format(new Date()));
			cdcFinanceInfoDao.update(info);
		}
	}

	public void audit(String id) {
		CdcFinanceInfo info = cdcFinanceInfoDao.get(id);
		if(info!=null){
			info.setStatus("2");
			cdcFinanceInfoDao.update(info);
		}	
	}

	public void sum(CdcFinanceInfo dataBean) {
		// 查询本单位下级数据
		ParameterSet ps = new ParameterSet();
		ps.setParameter("PARENT_CODE@=", dataBean.getOrganCode());
		ps.setParameter("STATUS@=","1");
		ps.setParameter("REPORT_DATE@=", dataBean.getReportDate());
		DataSet childDataSet = cdcFinanceInfoDao.query(ps);
		
		// 数据合计并保存
		dataBean.setAgricultureMon(childDataSet.sum("agricultureMon"));
		dataBean.setFinanceMon(childDataSet.sum("financeMon"));
		dataBean.setGdpMon(childDataSet.sum("gdpMon"));
		
		BigDecimal personMon =childDataSet.sum("personMon").divide(new BigDecimal(childDataSet.getCount()),2, BigDecimal.ROUND_HALF_EVEN);
		dataBean.setPersonMon(personMon);//人均纯收入取平均数
		insert(dataBean);
	}

	public void delete(String id) {
		cdcFinanceInfoDao.delete(id);
	}
}
