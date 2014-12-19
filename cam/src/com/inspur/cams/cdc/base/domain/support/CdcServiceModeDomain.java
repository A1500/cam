package com.inspur.cams.cdc.base.domain.support;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcServiceModeDao;
import com.inspur.cams.cdc.base.data.CdcServiceMode;
import com.inspur.cams.cdc.base.domain.ICdcServiceModeDomain;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 基础信息社区服务方式信息�?Domain�???�类
 * @author 
 * @date [Tue Dec 20 07:56:23 GMT 2011]
 */
public class CdcServiceModeDomain implements ICdcServiceModeDomain {

	@Reference
	private ICdcServiceModeDao cdcServiceModeDao;

	/**
	 * ??��??基础信息社区服务方式信息�?
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcServiceModeDao.query(pset);
	}

	/**
	 * �????基础信息社区服务方式信息�?
	 * @param cdcServiceMode
	 */
	public void insert(CdcServiceMode cdcServiceMode) {
		cdcServiceMode.setModeId(cdcServiceMode.getOrganCode()+IdHelp.getUUID32());
		cdcServiceMode.setStatus("0");
		cdcServiceMode.setCreateTime(DateUtil.getTime());
		cdcServiceModeDao.insert(cdcServiceMode);
	}
	
	/**
	 * �????基础信息社区服务方式信息�?
	 * @param cdcServiceMode
	 */
	public void update(CdcServiceMode cdcServiceMode) {
		cdcServiceModeDao.update(cdcServiceMode);
	}
	
	/**
	 * ??????基础信息社区服务方式信息�?
	 * @param modeId
	 */
	public void delete(String modeId) {
		cdcServiceModeDao.delete(modeId);
	}

	public DataSet queryList(ParameterSet pset) {
		return cdcServiceModeDao.queryList(pset);
	}

	public void report(String id) {
		CdcServiceMode mode = cdcServiceModeDao.get(id);
		if(mode!=null){
			mode.setStatus("1");
			DateFormat f = new SimpleDateFormat("yyyy-MM-dd");
			mode.setSubmitDate(f.format(new Date()));
			cdcServiceModeDao.update(mode);
		}
	}

	public void audit(String id) {
		CdcServiceMode mode = cdcServiceModeDao.get(id);
		if(mode!=null){
			mode.setStatus("2");
			cdcServiceModeDao.update(mode);
		}
		
	}

	public void sum(CdcServiceMode cdcServiceMode) {
		// 查询本单位下级数据
		ParameterSet ps = new ParameterSet();
		ps.setParameter("PARENT_CODE@=", cdcServiceMode.getOrganCode());
		ps.setParameter("STATUS@=","1");
		ps.setParameter("REPORT_DATE@=", cdcServiceMode.getReportDate());
		DataSet childDataSet = cdcServiceModeDao.query(ps);
		
		// 数据合计并保存
		cdcServiceMode.setCommerceAddress("----");
		cdcServiceMode.setCommerceContent("----");
		cdcServiceMode.setCommerceName("----");
		cdcServiceMode.setIfService("-");
		cdcServiceMode.setPublicContent("----");
		cdcServiceMode.setPublicPeopleNum(childDataSet.sum("publicPeopleNum"));
		cdcServiceMode.setServicePhone("----");
		cdcServiceMode.setServiceWeb("----");
		cdcServiceMode.setVoluntContent("----");
		cdcServiceMode.setVoluntPeopleNum(childDataSet.sum("voluntPeopleNum"));
		insert(cdcServiceMode);
	}

}