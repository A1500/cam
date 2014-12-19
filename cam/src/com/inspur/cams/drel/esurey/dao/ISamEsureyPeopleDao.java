package com.inspur.cams.drel.esurey.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.esurey.data.SamEsureyPeople;

/**
 * @title:ISamEsureyPeopleDao
 * @description:
 * @author:
 * @since:2011-06-29
 * @version:1.0
*/
 public interface ISamEsureyPeopleDao extends BaseCURD<SamEsureyPeople>{
	public void save(List<SamEsureyPeople> list);
	public void delete(String delId);
	
	/**
	 * 根据familyId查询赡养人员
	 */
	public DataSet querySupportPeople(ParameterSet pset);
	/**
	 * 根据peopleId查询信息
	 */
	public DataSet queryPeopleById(ParameterSet pset);
	/**
	 * 检查家庭成员中身份证的唯一性
	 */
	public String queryUnqiue(ParameterSet pset);
}

