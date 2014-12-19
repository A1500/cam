package com.inspur.cams.welfare.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.welfare.base.data.WealFitLogoff;

/**
 * 假矫装配企业注销备案信息domain
 * @author 
 * @date 2013-04-19
 */
public interface IWealFitLogoffDomain {

	/**
	 * 查询 假矫装配企业注销备案信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);


	/**
	 * 增加 假矫装配企业注销备案信息
	 * @param wealFitLogoff
	 */
	@Trans
	public void insert(WealFitLogoff wealFitLogoff);
	
	/**
	 * 修改 假矫装配企业注销备案信息
	 * @param wealFitLogoff
	 */
	@Trans
	public void update(WealFitLogoff wealFitLogoff);
	
	/**
	 * 删除 假矫装配企业注销备案信息
	 * @param taskCode
	 */
	@Trans
	public void delete(String taskCode);
	
	/*
	 * 假肢企业注销备案信息表保存同时更新业务表.
	 * */
	public void saveCancel(Record record);
	
	/*
	 * 福利企业注销备案信息表保存同时更新业务表.
	 * */
	public void welfarecorpSaveCancel(Record record);
	
	//假肢企业注销
	public void prosthesisCancel(Record record);
	
	//福利企业注销
	public void wealfarecorpCancel(Record record);


}