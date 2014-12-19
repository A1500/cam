package com.inspur.cams.welfare.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.welfare.base.data.WealFitDevice;

/**
 * 假矫装配企业设施信息表domain
 * @author 
 * @date 2013-04-19
 */
public interface IWealFitDeviceDomain {

	/**
	 * 查询 假矫装配企业设施信息表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);


	/**
	 * 增加 假矫装配企业设施信息表
	 * @param wealFitDevice
	 */
	@Trans
	public void insert(WealFitDevice wealFitDevice);
	
	/**
	 * 修改 假矫装配企业设施信息表
	 * @param wealFitDevice
	 */
	@Trans
	public void update(WealFitDevice wealFitDevice);
	
	/**
	 * 删除 假矫装配企业设施信息表
	 * @param deviceId
	 */
	@Trans
	public void delete(String deviceId);

	/**
	 * 假矫设施基本情况统计
	 * @param pset
	 * @return
	 */
	public DataSet reportDeviceInfo(ParameterSet pset);
}