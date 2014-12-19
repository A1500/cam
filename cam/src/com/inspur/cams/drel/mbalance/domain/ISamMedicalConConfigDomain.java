package com.inspur.cams.drel.mbalance.domain;

import java.util.List;
import java.util.Map;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.mbalance.data.SamMedicalConConfig;

/***
 * 一站结算_医保连接Domain接口
 * @author 路国隋
 * @date 2011-10-28
 */
public interface ISamMedicalConConfigDomain {
	/**
	 * 医保连接查询
	 * @param pset
	 * @return 
	 */
	public DataSet query(ParameterSet pset);
	/**
	 * 医保连接的插入
	 * @param samMedicalDetailExpense
	 * @return
	 */
	@Trans
	public void insert(SamMedicalConConfig samMedicalConConfig);
	/**
	 * 医保连接的修改
	 * @param samMedicalConConfig
	 */
	@Trans
	public void update(SamMedicalConConfig samMedicalConConfig);

	/**
	 * 医保连接批量保存
	 * @param list
	 */
	
	public void save(List<SamMedicalConConfig> list);

	public void batchDelete(String[] delIds);
	
	public Map queryConConfig(String organId,String insuranceType);
}
