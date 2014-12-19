package com.inspur.cams.cdc.base.domain.support;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcCoordinateInfoDao;
import com.inspur.cams.cdc.base.data.CdcCoordinateInfo;
import com.inspur.cams.cdc.base.data.CdcFinanceInfo;
import com.inspur.cams.cdc.base.domain.ICdcCoordinateInfoDomain;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 社区建设领导协调机制信息�?Domain�???�类
 * @author 
 * @date [Tue Dec 20 07:56:23 GMT 2011]
 */
public class CdcCoordinateInfoDomain implements ICdcCoordinateInfoDomain {

	@Reference
	private ICdcCoordinateInfoDao cdcCoordinateInfoDao;

	/**
	 * ??��??社区建设领导协调机制信息�?
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcCoordinateInfoDao.query(pset);
	}

	/**
	 * �????社区建设领导协调机制信息�?
	 * @param cdcCoordinateInfo
	 */
	public void insert(CdcCoordinateInfo cdcCoordinateInfo) {
		cdcCoordinateInfo.setCoordinateId(cdcCoordinateInfo.getOrganCode()+IdHelp.getUUID32());
		cdcCoordinateInfo.setStatus("0");
		cdcCoordinateInfo.setCreateTime(DateUtil.getTime());
		cdcCoordinateInfoDao.insert(cdcCoordinateInfo);
	}
	
	/**
	 * �????社区建设领导协调机制信息�?
	 * @param cdcCoordinateInfo
	 */
	public void update(CdcCoordinateInfo cdcCoordinateInfo) {
		cdcCoordinateInfoDao.update(cdcCoordinateInfo);
	}
	
	/**
	 * ??????社区建设领导协调机制信息�?
	 * @param coordinateId
	 */
	public void delete(String coordinateId) {
		cdcCoordinateInfoDao.delete(coordinateId);
	}

	public DataSet queryList(ParameterSet pset) {
		return cdcCoordinateInfoDao. queryList(pset);
	}

	public void report(String id) {
		CdcCoordinateInfo info = cdcCoordinateInfoDao.get(id);
		if(info!=null){
			info.setStatus("1");
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			info.setSubmitDate(format.format(new Date()));
			cdcCoordinateInfoDao.update(info);
		}
	}
	
	// 驳回
		public void audit(String id) {
			CdcCoordinateInfo info = cdcCoordinateInfoDao.get(id);
			if(info!=null){
				info.setStatus("2");
				cdcCoordinateInfoDao.update(info);
			}	
		}
	

}