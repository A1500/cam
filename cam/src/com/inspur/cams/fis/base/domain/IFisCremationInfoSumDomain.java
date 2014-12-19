package com.inspur.cams.fis.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

public interface IFisCremationInfoSumDomain {

	/**
	 * 查询
	 * @param pset
	 * @return
	 */
	DataSet query(ParameterSet pset);

	/**
	 * 
	 * @param pset
	 * @return
	 */
	DataSet queyDeadInfo(ParameterSet pset);

	/**
	 * @Description: 查询统计信息
	 * @author xuexzh
	 */
	DataSet queyAllSum(ParameterSet pset);

}
