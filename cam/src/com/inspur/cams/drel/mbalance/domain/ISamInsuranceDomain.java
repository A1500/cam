package com.inspur.cams.drel.mbalance.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.mbalance.data.SamMBalance;

/**
 * 一站式救助domain接口
 * @author luguosui
 *
 */
public interface ISamInsuranceDomain {
	/**
	 * 查询医院一站式结算信息
	 * @param pset
	 * @return
	 */
	public List getInsuranceData(ParameterSet pset);
	public DataSet getInsuranceDataSet(ParameterSet pset);
	
}
