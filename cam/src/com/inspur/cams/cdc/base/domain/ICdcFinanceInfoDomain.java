package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcFinanceInfo;

/**
 * 街道经济基本情况
 * @author 
 * @since 
 */
public interface ICdcFinanceInfoDomain {

	DataSet query(ParameterSet pset);

	@Trans
	void insert(CdcFinanceInfo dataBean);

	@Trans
	void update(CdcFinanceInfo dataBean);

	DataSet queryList(ParameterSet pset);

	@Trans
	void report(String id);

	@Trans
	void audit(String id);
	
	@Trans
	void sum(CdcFinanceInfo dataBean);

	@Trans
	void delete(String id);

}