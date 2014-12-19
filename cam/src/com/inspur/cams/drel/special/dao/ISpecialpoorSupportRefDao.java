package com.inspur.cams.drel.special.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.special.data.SpecialpoorSupportRef;

/**
 * 帮扶关系表dao
 * @author 
 * @date 2013-08-12
 */
public interface ISpecialpoorSupportRefDao extends BaseCURD<SpecialpoorSupportRef> {

	/**
	 * 查询帮扶单位与帮扶村的关系数据
	 * @author xuexzh
	 */
	DataSet querySpecialpoorSupportRef(ParameterSet pset);

	/**
	 * 查询帮扶单位指定的帮扶村数据
	 * @author xuexzh
	 */
	DataSet querySpecialpoorHelpVillage(ParameterSet pset);
}