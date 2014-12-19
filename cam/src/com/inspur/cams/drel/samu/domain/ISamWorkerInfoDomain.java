package com.inspur.cams.drel.samu.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.samu.data.SamWorkerInfo;

/**
 * 工作人员信息domain
 * @author 
 * @date 2012-09-26
 */
public interface ISamWorkerInfoDomain {

	/**
	 * 查询 工作人员信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 工作人员信息
	 * @param pset
	 * @return
	 */
	public SamWorkerInfo get(String workerId);

	/**
	 * 增加 工作人员信息
	 * @param samWorkerInfo
	 */
	@Trans
	public void insert(SamWorkerInfo samWorkerInfo);
	
	/**
	 * 修改 工作人员信息
	 * @param samWorkerInfo
	 */
	@Trans
	public void update(SamWorkerInfo samWorkerInfo);
	
	/**
	 * 删除 工作人员信息
	 * @param workerId
	 */
	@Trans
	public void delete(String workerId);
	//统计-敬老院工作员工
	public DataSet reportWorkerInfo(ParameterSet pset);
}