package com.inspur.cams.drel.rpt.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.rpt.data.RptCountrymedicalassistance;

/**
 * @title:农村医疗救助工作情况dao接口
 * @description:
 * @author:yangliangliang
 * @since:2011-06-22
 * @version:1.0
*/
 public interface IRptCountrymedicalassistanceDao extends BaseCURD<RptCountrymedicalassistance>{
	public void save(List<RptCountrymedicalassistance> list);
}

