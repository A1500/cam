package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcPopulateInfo;

/**
 * 基础信息人口状况信息表domain接口
 * @author shgtch
 * @date 2011-12-30
 */
public interface ICdcPopulateInfoDomain {

	/**
	 * 查询基础信息人口状况信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加基础信息人口状况信息
	 * @param cdcPopulateInfo
	 */
	@Trans
	public void insert(CdcPopulateInfo cdcPopulateInfo);
	
	/**
	 * 修改基础信息人口状况信息
	 * @param cdcPopulateInfo
	 */
	@Trans
	public void update(CdcPopulateInfo cdcPopulateInfo);
	
	/**
	 * 删除基础信息人口状况信息
	 * @param populateId
	 */
	@Trans
	public void delete(String recordId);

	/**
	 * 对本单位数据进行汇总
	 * @param cdcPopulateInfo
	 */
	@Trans
	public void sum(CdcPopulateInfo cdcPopulateInfo);
	
}