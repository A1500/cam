package com.inspur.cams.drel.samu.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.samu.data.SamGeroKeptPerson;

/**
 * 供养对象信息表dao
 * @author 
 * @date 2012-10-24
 */
public interface ISamGeroKeptPersonDao extends BaseCURD<SamGeroKeptPerson> {
	/**
	 * 维护查体名册时，增加时查询不在查体名册的人员
	 * @param pset
	 * @return
	 */
	public DataSet queryInsertPerson(ParameterSet pset);
	//查询入出院供养对象列表
	public DataSet queryInoutList(ParameterSet pset);
	//统计五保供养对象信息表
	public DataSet reportSupportInfo(ParameterSet pset);
	//入出院记录信息查询
	public DataSet queryInoutRecord(ParameterSet pset);
}