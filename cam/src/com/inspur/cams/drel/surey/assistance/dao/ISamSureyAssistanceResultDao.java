package com.inspur.cams.drel.surey.assistance.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.surey.assistance.data.SamSureyAssistanceResult;


/**
 * @title:ISamSureyAssitanceResultDao
 * @description:
 * @author:
 * @since:2011-09-29
 * @version:1.0
*/
 public interface ISamSureyAssistanceResultDao extends BaseCURD<SamSureyAssistanceResult>{
	public void save(List<SamSureyAssistanceResult> list);
}

