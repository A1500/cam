package com.inspur.cams.drel.esurey.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.esurey.data.SamEsureySurvey;

/**
 * @title:ISamEsureySurveyDao
 * @description:
 * @author:
 * @since:2011-06-29
 * @version:1.0
*/
 public interface ISamEsureySurveyDao extends BaseCURD<SamEsureySurvey>{
	public void save(List<SamEsureySurvey> list);
	public void delete(String peopleId);
	/**
	 * 查询家庭核对流水
	 * @return
	 */
	public DataSet queryForEsureyList(ParameterSet pset);
}

