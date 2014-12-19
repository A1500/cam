package com.inspur.cams.drel.esurey.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.esurey.data.SamEsureyPeopleEstate;

/**
 * @title:ISamEsureyPeopleEstateDao
 * @description:财产收入状况
 * @author:路国隋
 * @since:2011-06-29
 * @version:1.0
*/
 public interface ISamEsureyPeopleEstateDao extends BaseCURD<SamEsureyPeopleEstate>{
	public void save(List<SamEsureyPeopleEstate> list);
	public void deleteById(String id);
	public void delete(String peopleId);
	
	public void upadetPeopleEstate(SamEsureyPeopleEstate samEsureyPeopleEstate);
	/**
	 * 查询家庭成员的收入
	 * @param paramSet
	 * @return
	 */
	public DataSet queryPeopleIncom(ParameterSet paramSet);
	/**
	 * 查询家庭财产
	 * @param paramSet
	 * @return
	 */
	public DataSet queryFamilyWorth(ParameterSet paramSet);
	/**
	 * 查询家庭收入
	 * @param pset
	 * @return
	 */
	public DataSet queryFamilyIncome(ParameterSet pset);
}

