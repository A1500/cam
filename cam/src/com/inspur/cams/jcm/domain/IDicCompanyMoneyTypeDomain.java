package com.inspur.cams.jcm.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.jcm.data.DicCompanyMoneyType;

/**
 * 单位经费类别domain
 * @author 
 * @date 2014-05-21
 */
public interface IDicCompanyMoneyTypeDomain {

	/**
	 * 查询 单位经费类别
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 单位经费类别
	 * @param pset
	 * @return
	 */
	public DicCompanyMoneyType get(String code);

	/**
	 * 增加 单位经费类别
	 * @param dicCompanyMoneyType
	 */
	@Trans
	public void insert(DicCompanyMoneyType dicCompanyMoneyType);
	
	/**
	 * 修改 单位经费类别
	 * @param dicCompanyMoneyType
	 */
	@Trans
	public void update(DicCompanyMoneyType dicCompanyMoneyType);
	
	/**
	 * 删除 单位经费类别
	 * @param code
	 */
	@Trans
	public void delete(String code);

}