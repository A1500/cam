package com.inspur.cams.sorg.assess.assessconfig.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.assess.assessconfig.data.SomAssessConfig;

/**
 * @title:ISomAssessConfigDao
 * @description:
 * @author:
 * @since:2011-12-03
 * @version:1.0
*/
 public interface ISomAssessConfigDao extends BaseCURD<SomAssessConfig>{
	@Trans
	public void save(List<SomAssessConfig> list);
}

