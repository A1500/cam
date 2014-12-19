package com.inspur.cams.drel.surey.assistance.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.surey.assistance.data.SamSureyWfAssistanceHis;


/**
 * @title:ISamSureyWfAssitanceHisDao
 * @description:
 * @author:
 * @since:2011-09-29
 * @version:1.0
*/
 public interface ISamSureyWfAssistanceHisDao extends BaseCURD<SamSureyWfAssistanceHis>{
	public void save(List<SamSureyWfAssistanceHis> list);
	
	public DataSet queryByFlowId(ParameterSet pset);
}

