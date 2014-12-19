package com.inspur.cams.drel.esurey.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.esurey.data.SamEsureyRelation;

/**
 * @title:ISamEsureyRelationDao
 * @description:
 * @author:
 * @since:2011-06-29
 * @version:1.0
*/
 public interface ISamEsureyRelationDao extends BaseCURD<SamEsureyRelation>{
	public void save(List<SamEsureyRelation> list);
	public void delete(String supportId);
	public void deleteByPeopleId(String peopleId);
	public void deleteSupFamily(String supFamId,String famId);
	/**
	 * 根据家庭Id查找赡养家庭Id及人口数
	 * @param pset
	 * @return
	 */
	public DataSet queryRelFamiyIdNum(ParameterSet pset);
}

