package com.inspur.cams.comm.brief.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.brief.data.CamsReportWork;

/**
 * 填报期数配置表domain
 * @author 
 * @date 2014-04-23
 */
public interface ICamsReportWorkDomain {

	/**
	 * 查询 填报期数配置表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 填报期数配置表
	 * @param pset
	 * @return
	 */
	public CamsReportWork get(String workId);

	/**
	 * 增加 填报期数配置表
	 * @param camsReportWork
	 */
	@Trans
	public void insert(CamsReportWork camsReportWork);
	
	/**
	 * 修改 填报期数配置表
	 * @param camsReportWork
	 */
	@Trans
	public void update(CamsReportWork camsReportWork);
	
	/**
	 * 删除 填报期数配置表
	 * @param workId
	 */
	@Trans
	public void delete(String workId);
	
	@Trans
	public void unlock(String workId);
	@Trans
	public void lock(String workId);

}