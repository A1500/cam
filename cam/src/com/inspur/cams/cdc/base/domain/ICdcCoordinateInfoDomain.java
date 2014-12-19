package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcCoordinateInfo;

/**
 * 社区建设领导协调机制信息表domain
 * @author shgtch
 * @date 2012-2-24
 */
public interface ICdcCoordinateInfoDomain {

	/**
	 * 查询社区建设领导协调机制信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加社区建设领导协调机制信息
	 * @param cdcCoordinateInfo
	 */
	@Trans
	public void insert(CdcCoordinateInfo cdcCoordinateInfo);
	
	/**
	 * 修改社区建设领导协调机制信息
	 * @param cdcCoordinateInfo
	 */
	@Trans
	public void update(CdcCoordinateInfo cdcCoordinateInfo);
	
	/**
	 * 删除社区建设领导协调机制信息
	 * @param coordinateId
	 */
	@Trans
	public void delete(String coordinateId);

	public DataSet queryList(ParameterSet pset);

	@Trans
	public void report(String id);
	
	// 驳回
		public void audit(String id);

}