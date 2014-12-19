package com.inspur.cams.drel.esurey.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.esurey.data.SamEsureySurvey;


/**
 * @title:ISamEsureySurveyDomain
 * @description:经济核对_核对流水domain接口
 * @author:luguosui
 * @since:2011-06-29
 * @version:1.0
*/
public interface ISamEsureySurveyDomain {

	public DataSet query(ParameterSet pset);

	public void batchDelete(String[] delIds);

	public void update(SamEsureySurvey dataBean);
	@Trans
	public void insert(ParameterSet pset);

	public void save(List<SamEsureySurvey> list);
	
	public void delete(String peopleId);
	/**
	 * 查询家庭核对流水
	 * @return
	 */
	public DataSet queryForEsureyList(ParameterSet pset);
	
}
