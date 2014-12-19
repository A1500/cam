package com.inspur.cams.drel.sam.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.sam.data.SamApplySurvey;

/**
 * @title:入户调查Dao
 * @description:
 * @author: yanll
 * @since:2012-05-03
 * @version:1.0
*/
 public interface ISamApplySurveyDao extends BaseCURD<SamApplySurvey>{
	public void save(List<SamApplySurvey> list);
}

