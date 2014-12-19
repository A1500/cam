package com.inspur.cams.cdc.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcUnderGovemnsInfo;


/**
 */
public interface ICdcUnderGovemnsInfoDomain {

	/**
	 * 
	 * @param dataBean
	 */
	@Trans
	void insert(CdcUnderGovemnsInfo dataBean);

	/**
	 * 
	 * @param dataBean
	 */
	@Trans
	void update(CdcUnderGovemnsInfo dataBean);
	
	@Trans
	void delete(String id);

	@Trans
	void batchDelete(String[] ids);

	DataSet query(ParameterSet pset);

	/**
	 * 查询某下辖村的历史选举信息
	 * @param userId
	 */
	String getSelections(String userId);
	
	//查询下辖村
	public DataSet queryUnder(ParameterSet pset);
	
	//保存下辖村
	public void saveVillage(List list);
}