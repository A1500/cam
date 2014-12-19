package com.inspur.cams.jcm.domain;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import com.inspur.cams.jcm.data.JcmAllUnitQuery;
/**
 * 所有单位表domain
 * @author 陈寿业
 * @date 2014-12-15
 */
public interface IJcmAllUnitQueryDomain {
//	/**
//	 * 查询 单位
//	 * @param pset
//	 * @return DataSet
//	 */
//	public DataSet query(ParameterSet pset);
/**
 * 查询 基础单位信息
 * @param pset
 * @return DataSet
 */
	public DataSet queryCompany(ParameterSet pset);
	
}
