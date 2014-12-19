package com.inspur.cams.welfare.base.domain.support;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.welfare.base.dao.support.WealFitDeviceDao;
import com.inspur.cams.welfare.base.data.WealFitDevice;
import com.inspur.cams.welfare.base.domain.IWealFitDeviceDomain;

/**
 * 假矫装配企业设施信息表domain
 * @author 
 * @date 2013-04-19
 */
public class WealFitDeviceDomain implements IWealFitDeviceDomain {

	private WealFitDeviceDao wealFitDeviceDao = (WealFitDeviceDao) DaoFactory
	.getDao("com.inspur.cams.welfare.base.dao.support.WealFitDeviceDao");

	/**
	 * 查询 假矫装配企业设施信息表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return wealFitDeviceDao.query(pset);
	}


	/**
	 * 增加 假矫装配企业设施信息表
	 * @param wealFitDevice
	 */
	public void insert(WealFitDevice wealFitDevice) {
		wealFitDevice.setDeviceId(IdHelp.getUUID32());
		wealFitDeviceDao.insert(wealFitDevice);
	}
	
	/**
	 * 修改 假矫装配企业设施信息表
	 * @param wealFitDevice
	 */
	public void update(WealFitDevice wealFitDevice) {
		wealFitDeviceDao.update(wealFitDevice);
	}
	
	/**
	 * 删除 假矫装配企业设施信息表
	 * @param deviceId
	 */
	public void delete(String deviceId) {
		wealFitDeviceDao.delete(deviceId);
	}

	/**
	 * 假矫设施基本情况统计
	 * @param pset
	 * @return
	 */
	public DataSet reportDeviceInfo(ParameterSet pset) {
		return wealFitDeviceDao.reportDeviceInfo(pset);
	}
}