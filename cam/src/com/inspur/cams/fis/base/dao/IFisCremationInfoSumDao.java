package com.inspur.cams.fis.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.fis.base.data.FisCremationInfoSum;

/**
 * @title:IFisCremationInfoSumDao
 * @description:
 * @author:douyn
 * @since:2012-11-13
 * @version:1.0
*/
 public interface IFisCremationInfoSumDao extends BaseCURD<FisCremationInfoSum>{

	DataSet queyDeadInfo(ParameterSet pset);

	/**
	 * @Description: 查询统计信息
	 * @author xuexzh
	 */
	DataSet queyAllSum(ParameterSet pset);
}

