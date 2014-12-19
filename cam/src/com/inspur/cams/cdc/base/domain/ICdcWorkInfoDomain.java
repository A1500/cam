package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcWorkInfo;

/**
 * 基层民主与社区建设工作交流domain
 * @author shgtch
 * @date 2012-3-1
 */
public interface ICdcWorkInfoDomain {

	/**
	 * 查询基层民主与社区建设工作交流
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加基层民主与社区建设工作交流
	 * @param cdcWorkInfo
	 */
	@Trans
	public void insert(CdcWorkInfo cdcWorkInfo);
	
	/**
	 * 修改基层民主与社区建设工作交流
	 * @param cdcWorkInfo
	 */
	@Trans
	public void update(CdcWorkInfo cdcWorkInfo);
	
	/**
	 * 删除基层民主与社区建设工作交流
	 * @param workId
	 */
	@Trans
	public void delete(String workId);

	public DataSet queryList(ParameterSet pset);

}